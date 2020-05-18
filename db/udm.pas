unit udm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset,  ZConnection, ZSqlUpdate, pqconnection,
  sqldb, db;

type

  TID = class(TObject)
    id: Integer;
  end;

  { Tdm }

  Tdm = class(TDataModule)
    Conndb: TPQConnection;
    QueryMain: TSQLQuery;
    SQLQRead: TSQLQuery;
    SQLQExec: TSQLQuery;
    TrandbExec: TSQLTransaction;
    Trandb: TSQLTransaction;
    ZConndb: TZConnection;
    ZQExec: TZQuery;
    ZReadOnlyQ: TZReadOnlyQuery;
    ZTDic: TZTable;
    function ConnectDb(): boolean;
    procedure DataModuleCreate(Sender: TObject);
    function OpenTbl____(a_sql: String): TSQLQuery;
    function Read(a_sql: String): TZReadOnlyQuery;
    function ReadSQL____(a_sql: String): TSQLQuery;
    function GetDataSet____(a_sql: String): TSQLQuery;
    function ExecSQL____(a_sql: String): Boolean;
    function GetDataSetZ(a_sql: String): TZQuery;
    function SQLExecZ(a_sql: String): Boolean;
    function FillingList(a_list: TStrings; a_tablename, a_fieldid, a_fieldname: String; a_addempty: Boolean = false): Boolean;
  private

  public

  end;

var
  dm: Tdm;

implementation

uses ufunctions, uerr;

{$R *.lfm}


function Tdm.ConnectDb(): boolean;
var
  _host: String;
  _port: String;
  _dbname: String;
  _user: String;
  _passw: String;
begin
  if InitINI('ldc') then begin
    _host := ReadStrINI('pgdb','host');
    _port := ReadStrINI('pgdb','port');
    _dbname := ReadStrINI('pgdb','dbname');
    _user := ReadStrINI('pgdb','user');
    _passw := ReadStrINI('pgdb','passw');
    CloseIni();
// create db connection
    try
      Conndb.HostName := _host;
      Conndb.UserName := _user;
      Conndb.Password := _passw;
      Conndb.DatabaseName := _dbname;
      Conndb.Params.Text := 'port=' + _port;
// connecting
      Conndb.Connected := True;
      Trandb.Active := True;
      Conndb.Connected := False;
      Result := true;

// setting connect to Zdb
      ZConndb.HostName := _host;
      ZConndb.Port := StrToInt(_port);
      ZConndb.Database := _dbname;
      ZConndb.User := _user;
      ZConndb.Password := _passw;
      ZConndb.Connect;

    except  On e: Exception do
      err('{A3E92F88-AB87-4765-B1A6-1626AA47FF25}', 'Ошибка открытмя базы данных.',e.Message);
    end;
  end;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
//  ZConndb.Connect;
//  ZTDic.Active := true ;
end;


function Tdm.OpenTbl____(a_sql: String): TSQLQuery;
begin
  try
    QueryMain.SQL.Text:=a_sql;
    QueryMain.Open;
    Result := QueryMain;
  except  On e: Exception do
    err('{A0A19EF2-44EE-4B92-84D9-1DD7E08EDA0B}', 'Ошибка работы с базой данных.',e.Message);
  end;
end;


function Tdm.Read(a_sql: String): TZReadOnlyQuery;
begin
  Result := nil;
  try
    ZReadOnlyQ.SQL.Text:=a_sql;
    ZReadOnlyQ.Open;
    Result := ZReadOnlyQ;
  except  On e: Exception do
    err('{8CE2C57E-ABA7-49DC-A981-75B372346904}', 'Ошибка работы с базой данных.',e.Message);
  end;
end;

function Tdm.ReadSQL____(a_sql: String): TSQLQuery;
begin
  Result := nil;
  try
    SQLQRead.SQL.Text:=a_sql;
    SQLQRead.Open;
    Result := SQLQRead;
  except  On e: Exception do
    err('{6891697D-C77C-4648-99D8-CC610585A128}', 'Ошибка работы с базой данных.',e.Message);
  end;
end;

function Tdm.GetDataSet____(a_sql: String): TSQLQuery;
var
  _q: TSQLQuery;
begin
  Result := nil;
  try
    _q := TSQLQuery.Create(nil);
    _q.SQLConnection := Conndb;
    _q.Transaction := Trandb;
    _q.SQL.Text:=a_sql;
    _q.Open;
    Result := _q;
  except  On e: Exception do
    err('{88CBFCF5-D5BE-4BAC-BEE8-8ABBE3CA9F86}', 'Ошибка работы с базой данных.',e.Message);
  end;
end;

function Tdm.GetDataSetZ(a_sql: String): TZQuery;
var
  _q: TZQuery;
begin
  Result := nil;
  try
    _q := TZQuery.Create(nil);
    _q.Connection := ZConndb;
    _q.SQL.Text:=a_sql;
    _q.Open;
    Result := _q;
  except  On e: Exception do
    err('{009DD857-E040-46A2-99FB-EA2F81767657}', 'Ошибка работы с базой данных.',e.Message);
  end;
end;

function Tdm.ExecSQL____(a_sql: String): Boolean;
begin
  Result := false;
  try
    SQLQExec.Close;
    SQLQExec.SQL.Clear;
    SQLQExec.SQL.Text := a_sql;
    SQLQExec.ExecSQL;
    (SQLQExec.Transaction as TSQLTransaction).Commit;
    Result := True;
  except  On e: Exception do
    err('{290E02D4-3E5F-4B5B-8E03-DA326723B549}', 'Ошибка работы с базой данных.',e.Message);
  end;
end;

function Tdm.SQLExecZ(a_sql: String): Boolean;
begin
  Result := false;
  try
    ZQExec.Close;
    ZQExec.SQL.Clear;
    ZQExec.SQL.Text := a_sql;
    ZQExec.ExecSQL;
//    ZQExec.CachedUpdates := true;
//    ZQExec.Connection.Commit;
//    ZQExec.CommitUpdates;
    Result := True;
  except  On e: Exception do begin
    if ZQExec.Active then ZQExec.Close;
    err('{850EB7C1-7D25-4B86-B598-80EE7DD16260}', 'Ошибка работы с базой данных.',e.Message);
  end;
  end;
end;

function Tdm.FillingList(a_list: TStrings; a_tablename, a_fieldid, a_fieldname: String; a_addempty: Boolean = false): Boolean;
var
  _i: Integer;
  _cid: TID;
begin
  Result := false;
  try
    if not Assigned(a_list) then exit;
    a_list.Clear;
    if a_addempty then begin
      _cid := TID.Create();
      _cid.id := -1;
      a_list.AddObject('- ПУСТО -', _cid);
    end;
    ZReadOnlyQ.Close;
    ZReadOnlyQ.SQL.Clear;
    ZReadOnlyQ.SQL.Text := ('select ' + a_fieldid + ', ' + a_fieldname + ' from ' + a_tablename);
    ZReadOnlyQ.Open;
    for _i := 0 to ZReadOnlyQ.RecordCount - 1 do begin
      _cid := TID.Create();
      _cid.id:=ZReadOnlyQ.Fields[0].AsInteger;
      a_list.AddObject(ZReadOnlyQ.Fields[1].AsString, _cid);
      ZReadOnlyQ.Next;
    end;
    ZReadOnlyQ.Close();
    Result := True;
  except  On e: Exception do
    err('{0245BDBD-374D-4F1A-BFA3-30500032FF8A}', 'Ошибка работы с базой данных.',e.Message);
  end;

end;

end.


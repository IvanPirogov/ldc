unit udm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset,  ZConnection, pqconnection,
  sqldb, db;

type

  { Tdm }

  Tdm = class(TDataModule)
    Conndb: TPQConnection;
    DataSdic: TDataSource;
    QueryMain: TSQLQuery;
    SQLQRead: TSQLQuery;
    SQLQExec: TSQLQuery;
    TrandbExec: TSQLTransaction;
    Trandb: TSQLTransaction;
    ZConndb: TZConnection;
    ZReadOnlyQ: TZReadOnlyQuery;
    ZTDic: TZTable;
    function ConnectDb(): boolean;
    procedure DataModuleCreate(Sender: TObject);
    function OpenTbl(a_sql: String): TSQLQuery;
    function Read(a_sql: String): TZReadOnlyQuery;
    function ReadSQL(a_sql: String): TSQLQuery;
    function GetDataSet(a_sql: String): TSQLQuery;
    function ExecSQL(a_sql: String): Boolean;
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
    except  On e: Exception do
      err('{A3E92F88-AB87-4765-B1A6-1626AA47FF25}', 'Ошибка открытмя базы данных.',e.Message);
    end;
  end;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  ZConndb.Connect;
  ZTDic.Active := true ;
end;


function Tdm.OpenTbl(a_sql: String): TSQLQuery;
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

function Tdm.ReadSQL(a_sql: String): TSQLQuery;
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

function Tdm.GetDataSet(a_sql: String): TSQLQuery;
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

function Tdm.ExecSQL(a_sql: String): Boolean;
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
end.


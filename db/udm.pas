unit udm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, pqconnection, sqldb;

type

  { Tdm }

  Tdm = class(TDataModule)
    Conndb: TPQConnection;
    QueryMain: TSQLQuery;
    Trandb: TSQLTransaction;
    function ConnectDb(): boolean;
    function OpenTbl(a_sql: String): TSQLQuery;
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

end.


unit udb;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, pqconnection, sqldb, ufunctions, Dialogs;

function ConnectDb(): boolean;
function OpenTbl(a_sql: String): TSQLQuery;

implementation

var
  conndb: TPQConnection;
  trandb: TSQLTransaction;
  query: TSQLQuery;

function ConnectDb(): boolean;
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
  conndb := TPQConnection.Create(nil);
  conndb.HostName := _host;
  conndb.UserName := _user;
  conndb.Password := _passw;
  conndb.DatabaseName := _dbname;
  conndb.LoginPrompt := False;
  conndb.KeepConnection := False;
  dbConn.Params.Text := 'port=' + _port;
// create sql transaction
  trandb := TSQLTransaction.Create(conndb);
  conndb.Transaction := trandb;
  trandb.DataBase := conndb;
// create sql query
  query := TSQLQuery.Create(conndb);
  query.DataBase := conndb;
  query.Transaction := trandb;
// connecting
  conndb.Connected := True;
  trandb.Active:=true;
  conndb.Connected := False;
  Result := true;
  end;
end;

function OpenTbl(a_sql: String): TSQLQuery;
begin
  query.Close;
  query.SQL.Text:=a_sql;
  query.Open;
  Result := query;
end;

end.


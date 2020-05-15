unit cuser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, udm, db;

type


  { TUser }

  TUser = class(TObject)
  private
    Faccess_menu: string;
    Fdescr: String;
    Fid: Integer;
    Flogin: String;
    Fpassw: String;
    Fname: String;
    Frole_id: Integer;
    Fsaved: Boolean;
    Fstaff_id: Integer;
    Fstatus: Integer;
    procedure Setaccess_menu(AValue: string);
    procedure Setdescr(AValue: String);
    procedure Setid(AValue: Integer);
    procedure Setlogin(AValue: String);
    procedure Setpassw(AValue: String);
    procedure Setname(AValue: String);
    procedure Setrole_id(AValue: Integer);
    procedure Setsaved(AValue: Boolean);
    procedure Setstaff_id(AValue: Integer);
    procedure Setstatus(AValue: Integer);
  published
    property saved: Boolean read Fsaved write Setsaved;
    property id: Integer read Fid write Setid;
    property login: String read Flogin write Setlogin;
    property passw: String read Fpassw write Setpassw;
    property name: String read Fname write Setname;
    property status: Integer read Fstatus write Setstatus;
    property access_menu: string read Faccess_menu write Setaccess_menu;
    property staff_id: Integer read Fstaff_id write Setstaff_id;
    property role_id: Integer read Frole_id write Setrole_id;
    property descr: String read Fdescr write Setdescr;
  public
    procedure Read(a_id: Integer);
    procedure Save();
    procedure Delete();

  end;


implementation



{ TUser }

procedure TUser.Setpassw(AValue: String);
begin
  if Fpassw=AValue then Exit;
  Fpassw:=AValue;
end;

procedure TUser.Setaccess_menu(AValue: string);
begin
  if Faccess_menu=AValue then Exit;
  Faccess_menu:=AValue;
end;

procedure TUser.Setdescr(AValue: String);
begin
  if Fdescr=AValue then Exit;
  Fdescr:=AValue;
end;

procedure TUser.Setid(AValue: Integer);
begin
  if Fid=AValue then Exit;
  Fid:=AValue;
end;

procedure TUser.Setlogin(AValue: String);
begin
  if Flogin=AValue then Exit;
  Flogin:=AValue;
end;

procedure TUser.Setname(AValue: String);
begin
  if Fname=AValue then Exit;
  Fname:=AValue;
end;

procedure TUser.Setrole_id(AValue: Integer);
begin
  if Frole_id=AValue then Exit;
  Frole_id:=AValue;
end;

procedure TUser.Setsaved(AValue: Boolean);
begin
  if Fsaved=AValue then Exit;
  Fsaved:=AValue;
end;

procedure TUser.Setstaff_id(AValue: Integer);
begin
  if Fstaff_id=AValue then Exit;
  Fstaff_id:=AValue;
end;

procedure TUser.Setstatus(AValue: Integer);
begin
  if Fstatus=AValue then Exit;
  Fstatus:=AValue;
end;

procedure TUser.Read(a_id: Integer);
var
  _sql: String;
  _q: TDataSet;
begin
  if a_id = -1 then begin
    id := a_id;
    exit;
  end;
  _sql := 'select u.*, s.lastname || '' '' || s.firstname as nam, r.access_menu from users u ' +
          ' join staff s on s.id = u.staff_id ' +
          ' join uroles r on r.id = u.role_id ' +
          ' where u.id = ' + IntToStr(a_id);
  _q := dm.Read(_sql);
  if not Assigned(_q) then exit;
  if _q.RecordCount > 0 then begin
     id := _q.FieldByName('id').AsInteger;
     staff_id := _q.FieldByName('staff_id').AsInteger;
     role_id := _q.FieldByName('role_id').AsInteger;
     login := _q.FieldByName('login').AsString;
     passw := _q.FieldByName('passw').AsString;
     descr := _q.FieldByName('descr').AsString;
     status := _q.FieldByName('status').AsInteger;
     name := _q.FieldByName('nam').AsString;
     access_menu := _q.FieldByName('access_menu').AsString;
  end;
  _q.Close;
end;

procedure TUser.Save();
var
  _sql: String;
begin
  if id = -1 then begin
    _sql := 'insert into users(staff_id, role_id, login, passw, descr, status) values(';
    _sql := _sql + intToStr(staff_id) + ', ';
    _sql := _sql + intToStr(role_id) + ', ';
    _sql := _sql +  QuotedStr(login) + ', ';
    _sql := _sql + QuotedStr(passw) + ', ';
    _sql := _sql + QuotedStr(descr) + ', ';
    _sql := _sql + intToStr(status) + ')';
  end else begin
    _sql := 'update users set staff_id = ' + intToStr(staff_id) + ', ';
    _sql := _sql + ' role_id = ' + intToStr(role_id) + ', ';
    _sql := _sql + ' login = ' +  QuotedStr(login) + ', ';
    _sql := _sql + ' passw = ' + QuotedStr(passw) + ', ';
    _sql := _sql + ' descr = ' + QuotedStr(descr) + ', ';
    _sql := _sql + ' status = ' + intToStr(status) ;
    _sql := _sql + ' where  id = ' + intToStr(id);
  end;
  saved := dm.SQLExecZ(_sql);
end;

procedure TUser.Delete();
var
  _sql: String;
begin
  if id = -1 then begin
    _sql := 'delete from users where id = ' + IntToStr(id);
    saved := dm.SQLExecZ(_sql);
  end;
end;

end.


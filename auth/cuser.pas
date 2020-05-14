unit cuser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, udm, ZDataset;

type


  { TUser }

  TUser = class(TObject)
  private
    Faccess_menu: string;
    Fdescr: String;
    Fid: Integer;
    Flogin: String;
    Fname: String;
    Frole_id: Integer;
    Fstaff_id: Integer;
    Fstatus: Integer;
    procedure Setaccess_menu(AValue: string);
    procedure Setdescr(AValue: String);
    procedure Setid(AValue: Integer);
    procedure Setlogin(AValue: String);
    procedure Setname(AValue: String);
    procedure Setrole_id(AValue: Integer);
    procedure Setstaff_id(AValue: Integer);
    procedure Setstatus(AValue: Integer);
  published
    property id: Integer read Fid write Setid;
    property login: String read Flogin write Setlogin;
    property name: String read Fname write Setname;
    property status: Integer read Fstatus write Setstatus;
    property access_menu: string read Faccess_menu write Setaccess_menu;
    property staff_id: Integer read Fstaff_id write Setstaff_id;
    property role_id: Integer read Frole_id write Setrole_id;
    property descr: String read Fdescr write Setdescr;
  public
    procedure ReadData(a_id: Integer);




  end;


implementation



{ TUser }

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

procedure TUser.ReadData(a_id: Integer);
var
  _sql: String;
  _q: TZReadOnlyQuery;
begin
  if a_id = -1 then exit;
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
     descr := _q.FieldByName('descr').AsString;
     status := _q.FieldByName('status').AsInteger;
     name := _q.FieldByName('nam').AsString;
     access_menu := _q.FieldByName('access_menu').AsString;
  end;
  _q.Close;
end;

end.


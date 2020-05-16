unit cstaff;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, udm, db;

type

  { TStaff }

  TStaff = class(TObject)
  private
    Faddress: String;
    Fdob: TDate;
    Fedication: String;
    Fedication_id: Integer;
    Ffirstname: String;
    Fid: Integer;
    Flastname: String;
    Fmiddlename: String;
    Fphone: Int64;
    Fsaved: Boolean;
    Fsex: String;
    Fuser_id: Integer;
    procedure Setaddress(Value: String);
    procedure Setdob(Value: TDate);
    procedure Setedication(Value: String);
    procedure Setedication_id(Value: Integer);
    procedure Setfirstname(Value: String);
    procedure Setid(Value: Integer);
    procedure Setlastname(Value: String);
    procedure Setmiddlename(Value: String);
    procedure Setphone(Value: Int64);
    procedure Setsaved(Value: Boolean);
    procedure Setsex(Value: String);
    procedure Setuser_id(Value: Integer);
  published
    property id: Integer read Fid write Setid;
    property lastname: String read Flastname write Setlastname;
    property firstname: String read Ffirstname write Setfirstname;
    property middlename: String read Fmiddlename write Setmiddlename;
    property sex: String read Fsex write Setsex;
    property dob: TDate read Fdob write Setdob;
    property phone: Int64 read Fphone write Setphone;
    property edication_id: Integer read Fedication_id write Setedication_id;
    property edication: String read Fedication write Setedication ;
    property address: String read Faddress write Setaddress;
    property saved: Boolean read Fsaved write Setsaved;
    property user_id: Integer read Fuser_id write Setuser_id;
  public
    procedure Read(a_id: Integer);
    procedure Save();
    procedure Delete();

  end;


implementation

{ TStaff }

procedure TStaff.Setaddress(Value: String);
begin
  if Faddress = Value then Exit;
  Faddress := Value;
end;

procedure TStaff.Setdob(Value: TDate);
begin
  if Fdob = Value then Exit;
  Fdob := Value;
end;

procedure TStaff.Setedication(Value: String);
begin
  if Fedication = Value then Exit;
  Fedication := Value;
end;

procedure TStaff.Setedication_id(Value: Integer);
begin
  if Fedication_id = Value then Exit;
  Fedication_id := Value;
end;

procedure TStaff.Setfirstname(Value: String);
begin
  if Ffirstname = Value then Exit;
  Ffirstname := Value;
end;

procedure TStaff.Setid(Value: Integer);
begin
  if Fid = Value then Exit;
  Fid := Value;
end;

procedure TStaff.Setlastname(Value: String);
begin
  if Flastname = Value then Exit;
  Flastname := Value;
end;

procedure TStaff.Setmiddlename(Value: String);
begin
  if Fmiddlename = Value then Exit;
  Fmiddlename := Value;
end;

procedure TStaff.Setphone(Value: Int64);
begin
  if Fphone = Value then Exit;
  Fphone := Value;
end;

procedure TStaff.Setsaved(Value: Boolean);
begin
  if Fsaved = Value then Exit;
  Fsaved := Value;
end;

procedure TStaff.Setsex(Value: String);
begin
  if Fsex = Value then Exit;
  Fsex := Value;
end;

procedure TStaff.Setuser_id(Value: Integer);
begin
  if Fuser_id = Value then Exit;
  Fuser_id := Value;
end;

procedure TStaff.Read(a_id: Integer);
var
  _sql: String;
  _q: TDataSet;
begin
  if a_id = -1 then begin
    id := a_id;
    exit;
  end;
  _sql := 'select s.*, COALESCE(e.nam, '''') as edication from staff s ' +
          ' left join dc_edication e on e.id = s.edication_id ' +
          ' where s.id = ' + IntToStr(a_id);
  _q := dm.Read(_sql);
  if not Assigned(_q) then exit;
  if _q.RecordCount > 0 then begin
     id := _q.FieldByName('id').AsInteger;
     edication_id := _q.FieldByName('edication_id').AsInteger;
     edication := _q.FieldByName('edication').AsString;
     lastname := _q.FieldByName('lastname').AsString;
     firstname := _q.FieldByName('firstname').AsString;
     middlename := _q.FieldByName('middlename').AsString;
     phone := _q.FieldByName('contact_phone').AsLargeInt;
     sex := _q.FieldByName('sex').AsString;
     dob := _q.FieldByName('dob').AsDateTime;
     address := _q.FieldByName('address').AsString;
//     access_menu := _q.FieldByName('access_menu').AsString;
  end;
  _q.Close;
end;

procedure TStaff.Save();
var
  _sql: String;
begin
  if id = -1 then begin
    _sql := 'insert into staff(edication_id, lastname, firstname, middlename, sex,contact_phone, dob, address, user_id) values(';
    if edication_id = -1 then _sql := _sql + 'NULL,'
    else _sql := _sql + intToStr(edication_id) + ', ';
    _sql := _sql + QuotedStr(lastname) + ', ';
    _sql := _sql +  QuotedStr(firstname) + ', ';
    _sql := _sql + QuotedStr(middlename) + ', ';
    _sql := _sql + QuotedStr(sex) + ', ';
    _sql := _sql + intToStr(phone) + ', ';
    _sql := _sql + QuotedStr(FormatDateTime('yyyy-mm-dd',dob)) + ', ';
    _sql := _sql + QuotedStr(address) + ', ';
    _sql := _sql + IntToStr(user_id) + ')';
  end else begin
    _sql := 'update staff set lastname = ' + QuotedStr(lastname) + ', ';
    if edication_id = -1 then _sql := _sql + ' edication_id = NULL, '
    else _sql := _sql + ' edication_id = ' + intToStr(edication_id) + ', ';
    _sql := _sql + ' firstname = ' +  QuotedStr(firstname) + ', ';
    _sql := _sql + ' middlename = ' + QuotedStr(middlename) + ', ';
    _sql := _sql + ' sex = ' + QuotedStr(sex) + ', ';
    _sql := _sql + ' contact_phone = ' + intToStr(phone) + ', ';
    _sql := _sql + ' address = ' + QuotedStr(address) + ' , ' ;
    _sql := _sql + ' user_id = ' + IntToStr(user_id) + ' , ' ;
    _sql := _sql + ' dob = ' + QuotedStr(FormatDateTime('yyyy-mm-dd',dob))  + ' , ' ;
    _sql := _sql + ' updated_at = GetDate() where  id = ' + intToStr(id);
  end;
  saved := dm.SQLExecZ(_sql);
end;

procedure TStaff.Delete();
var
  _sql: String;
begin
  if id = -1 then begin
    _sql := 'delete from staff where id = ' + IntToStr(id);
    saved := dm.SQLExecZ(_sql);
  end;
end;

end.


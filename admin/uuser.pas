unit uuser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Buttons,
  ECEditBtns, BCComboBox, cuser, udm, sqldb, Dialogs;

type

  TID = class(TObject)
    id: Integer;
  end;

  { TfrmUser }

  TfrmUser = class(TFrame)
    BitBOk: TBitBtn;
    BitBApply: TBitBtn;
    BitBCancel: TBitBtn;
    ComboBRole: TComboBox;
    ComboBStatus: TComboBox;
    ComboBStaff: TComboBox;
    EED: TEdit;
    ELogin: TEdit;
    EPassw: TEdit;
    LDescr: TLabel;
    LID: TLabel;
    LRole: TLabel;
    LStatus: TLabel;
    LPassw: TLabel;
    LStaff: TLabel;
    LLogin: TLabel;
    MDescr: TMemo;
    function CheckFilling(): Boolean;
    procedure BitBCancelClick(Sender: TObject);
    procedure BitBOkClick(Sender: TObject);
    procedure CreateFRM(a_user_id: Integer);
    procedure FillinForm();
    procedure InitForm();
    procedure DestroyFRM();
  private
    user: TUser;
  public

  end;

implementation

{$R *.lfm}

{ TfrmUser }

function TfrmUser.CheckFilling(): Boolean;
begin
  Result := true;
  if ComboBStaff.ItemIndex = -1 then begin
    result := false;
    showMessage('Не выбран сотрудник.');
    ComboBStaff.SetFocus;
  end else if ELogin.text = '' then begin
    result := false;
    showMessage('Не не введен Логин.');
    ELogin.SetFocus;
  end else if Pos( ' ',ELogin.text) > 0 then begin
    result := false;
    showMessage('Логин содержит пробелы.');
    ELogin.SetFocus;
  end else if EPassw.text = '' then begin
    result := false;
    showMessage('Не не введен Пароль.');
    EPassw.SetFocus;
  end else if Pos( ' ',EPassw.text) > 0 then begin
    result := false;
    showMessage('Пароль содержит пробелы.');
    EPassw.SetFocus;
  end else if ComboBStatus.ItemIndex = -1 then begin
    result := false;
    showMessage('Не выбран статус.');
    ComboBStatus.SetFocus;
  end else if ComboBRole.ItemIndex = -1 then begin
    result := false;
    showMessage('Не выбрана роль.');
    ComboBRole.SetFocus;
  end;
end;

procedure TfrmUser.BitBCancelClick(Sender: TObject);
begin
  (parent as TForm).Close();
end;

procedure TfrmUser.BitBOkClick(Sender: TObject);
begin
 if CheckFilling() then (parent as TForm).Close();
end;

procedure TfrmUser.InitForm();
var
  _q: TSQLQuery;
  _i: integer;
  _cid: TID;
begin
  _q := dm.ReadSQL('select s.id, (s.lastname || '' '' || s.firstname  || '' '' || ' +
                   ' s.middlename)::varchar(255) as nam from staff s ' +
                   ' order by s.lastname,s.firstname, s.middlename');
  for _i := 0 to _q.RecordCount - 1 do begin
    _cid := TID.Create();
    _cid.id:=_q.FieldByName('id').AsInteger;
    ComboBStaff.Items.AddObject(_q.FieldByName('nam').AsString, _cid);
    _q.Next;
  end;
  _q.Close();
  ComboBStaff.ItemIndex:=-1;
  _q := dm.ReadSQL('select id, nam from uroles order by nam');
  for _i := 0 to _q.RecordCount - 1 do begin
    _cid := TID.Create();
    _cid.id:=_q.FieldByName('id').AsInteger;
    ComboBRole.Items.AddObject(_q.FieldByName('nam').AsString, _cid);
    _q.Next;
  end;
  _q.Close();
  ComboBRole.ItemIndex:=-1;
end;

procedure TfrmUser.CreateFRM(a_user_id: Integer);
begin
  InitForm();
  user := TUser.Create();
  user.ReadData(a_user_id);
  FillinForm();
end;

procedure TfrmUser.FillinForm();
begin

end;

procedure TfrmUser.DestroyFRM();
var
  _i: Integer;
begin
  if Assigned(user) then user.Free;
  for _i := 0 to ComboBStaff.Items.Count -1 do
    ComboBStaff.Items.Objects[_i].Free;
  for _i := 0 to ComboBRole.Items.Count -1 do
    ComboBRole.Items.Objects[_i].Free;
end;

end.


unit uuser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Buttons,
  cuser, udm, sqldb, Dialogs,uerr;

type
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
    procedure FormSave();
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
    showMessage('Не введен Логин.');
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
 if CheckFilling() then begin
   FormSave();
   user.Save();
   if user.saved then (parent as TForm).Close();
 end;
end;

procedure TfrmUser.InitForm();
begin
  dm.FillingList(ComboBStaff.Items,'staff', 'id', 'cast(lastname || '' '' || firstname  || '' '' || middlename as varchar(255)) as nam ');
  dm.FillingList(ComboBRole.Items,'uroles', 'id', 'nam');
end;

procedure TfrmUser.CreateFRM(a_user_id: Integer);
begin
  InitForm();
  user := TUser.Create();
  user.Read(a_user_id);
  FillinForm();
end;

procedure TfrmUser.FillinForm();
var
  _i: Integer;
begin
  try
    if user.id > 0 then begin
      EED.Text := intToStr(user.id);
      ELogin.Text := user.login;
      EPassw.Text := user.passw;
      MDescr.Text := user.descr;
      ComboBStatus.ItemIndex := user.status - 1;
      for _i := 0 to ComboBRole.Items.Count - 1 do
        if (ComboBRole.Items.Objects[_i] as TID).id = user.role_id then begin
          ComboBRole.ItemIndex := _i;
          break;
        end;
      for _i := 0 to ComboBStaff.Items.Count - 1 do
        if (ComboBStaff.Items.Objects[_i] as TID).id = user.staff_id then begin
          ComboBStaff.ItemIndex := _i;
          break;
        end;
    end;
  except  On e: Exception do
    err('{2CD0CFE0-4A7D-41C7-8F44-3030F3688683}', 'Ошибка загрузки пользователя.',e.Message);
  end;
end;

procedure TfrmUser.FormSave();
begin
  try
    user.login := ELogin.Text;
    user.passw := EPassw.Text;
    user.descr := MDescr.Text;
    user.status := ComboBStatus.ItemIndex+ 1;
    user.role_id := (ComboBRole.Items.Objects[ComboBRole.ItemIndex] as TID).id;
    user.staff_id := (ComboBStaff.Items.Objects[ComboBStaff.ItemIndex] as TID).id;
  except  On e: Exception do
    err('{BEF9DEE7-411C-4131-8854-BFA791125516}', 'Ошибка сохранения пользователя.',e.Message);
  end;
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


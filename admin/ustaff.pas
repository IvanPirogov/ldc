unit ustaff;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, EditBtn, Buttons,
  udm, uerr, cstaff, dialogs;

type

  { TfrmStaff }

  TfrmStaff = class(TFrame)
    BitBOk: TBitBtn;
    BitBRefresh: TBitBtn;
    BitBClose: TBitBtn;
    ComboBEdication: TComboBox;
    DateEDob: TDateEdit;
    EPhone: TEdit;
    EID: TEdit;
    ELastname: TEdit;
    EFirstname: TEdit;
    EMiddlename: TEdit;
    EAddress: TEdit;
    GroupBPersonal: TGroupBox;
    LID: TLabel;
    LDob: TLabel;
    LPhone: TLabel;
    LSex: TLabel;
    LLastname: TLabel;
    LFirstname: TLabel;
    LMiddlename: TLabel;
    LAddress: TLabel;
    LEdication: TLabel;
    RadioBMale: TRadioButton;
    RadioBFemali: TRadioButton;
    SpeedBAddress: TSpeedButton;
    procedure BitBCloseClick(Sender: TObject);
    procedure BitBOkClick(Sender: TObject);
    procedure CreateFRM(a_user_id : Integer; a_staff_id: Integer = -1);
    procedure InitForm();
    procedure DestroyFRM();
    procedure FillinForm();
    procedure FormSave();
    function CheckFilling(): Boolean;
  private
    staff: TStaff;
    user_id: Integer;

  public

  end;

implementation

{$R *.lfm}

function TfrmStaff.CheckFilling(): Boolean;
begin
  Result := true;
  if Trim(ELastname.text) = ''  then begin
    result := false;
    showMessage('Не введено фамилия.');
    ELastname.SetFocus;
  end else if EFirstname.text = '' then begin
    result := false;
    showMessage('Не введено имя.');
    EFirstname.SetFocus;
  end;
end;

procedure TfrmStaff.InitForm();
begin
  dm.FillingList(ComboBEdication.Items,'dc_edication', 'id', 'nam', true);
  ComboBEdication.ItemIndex := 0;
end;

procedure TfrmStaff.CreateFRM(a_user_id : Integer; a_staff_id: Integer = -1);
begin
  DateEDob.DateFormat := 'dd.mm.yyyy';
  user_id := a_user_id;
  InitForm();
  staff := TStaff.Create();
  staff.Read(a_staff_id);
  staff.user_id := user_id;
  FillinForm();
end;

procedure TfrmStaff.BitBCloseClick(Sender: TObject);
begin
  (parent as TForm).Close();
end;

procedure TfrmStaff.BitBOkClick(Sender: TObject);
begin
  if CheckFilling() then begin
   FormSave();
   staff.Save();
   if staff.saved then (parent as TForm).Close();
 end;
end;

procedure TfrmStaff.DestroyFRM();
var
  _i: Integer;
begin
  if Assigned(staff) then staff.Free;
  for _i := 0 to ComboBEdication.Items.Count -1 do
    ComboBEdication.Items.Objects[_i].Free;

end;

procedure TfrmStaff.FillinForm();
var
  _i: Integer;
begin
  try
    if staff.id > 0 then begin
      EID.Text := intToStr(staff.id);
      ELastname.Text := staff.lastname;
      EFirstname.Text := staff.firstname;
      EMiddlename.Text := staff.middlename;
      EAddress.Text := staff.Address;
      DateEDob.Date := staff.dob;
      EPhone.Text := IntToStr(staff.phone);
      if staff.sex = 'муж' then RadioBMale.Checked := true
      else RadioBFemali.Checked := true;
      for _i := 0 to ComboBEdication.Items.Count - 1 do
        if (ComboBEdication.Items.Objects[_i] as TID).id = staff.edication_id then begin
          ComboBEdication.ItemIndex := _i;
          break;
        end;
    end;
  except  On e: Exception do
    err('{189CC7C3-A117-49DD-B84B-43C372AE5BF5}', 'Ошибка загрузки сотрудника.',e.Message);
  end;
end;

procedure TfrmStaff.FormSave();
begin
  try
    staff.user_id := user_id;
    staff.lastname := Trim(ELastname.Text);
    staff.firstname := Trim(EFirstname.Text);
    staff.middlename := Trim(EMiddlename.Text);
    staff.Address := Trim(EAddress.Text);
    staff.phone := StrToInt64(Trim(EPhone.Text));
    staff.dob := DateEDob.Date;
    if RadioBMale.Checked then staff.sex := 'муж'
    else staff.sex := 'жен';
    staff.edication_id := (ComboBEdication.Items.Objects[ComboBEdication.ItemIndex] as TID).id;
  except  On e: Exception do
    err('{997A628A-6318-4045-979A-D40D13ED78D6}', 'Ошибка сохранения сохранения.',e.Message);
  end;
end;



end.


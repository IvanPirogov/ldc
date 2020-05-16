unit ustaff;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, EditBtn, MaskEdit, Buttons,
  udm, uerr, cstaff, ATSynEdit_Edits;

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
    procedure CreateFRM(a_staff_id: Integer = -1);
    procedure InitForm();
    procedure DestroyFRM();
    procedure FillinForm();
    procedure FormSave();
    procedure MaskEPhoneChange(Sender: TObject);
  private
    staff: TStaff;

  public

  end;

implementation

{$R *.lfm}

procedure TfrmStaff.InitForm();
begin
  dm.FillingList(ComboBEdication.Items,'dc_edication', 'id', 'nam', true);
end;

procedure TfrmStaff.CreateFRM(a_staff_id: Integer = -1);
begin
  DateEDob.DateFormat := 'dd.mm.yyyy';
  InitForm();
  staff := TStaff.Create();
  staff.Read(a_staff_id);
  FillinForm();
end;

procedure TfrmStaff.BitBCloseClick(Sender: TObject);
begin
  (parent as TForm).Close();
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
    staff.lastname := ELastname.Text;
    staff.firstname := EFirstname.Text;
    staff.middlename := EMiddlename.Text;
    staff.Address := EAddress.Text;
    if RadioBMale.Checked then staff.sex := 'муж'
    else staff.sex := 'жен';
    staff.phone := StrToInt64(EPhone.Text);
    staff.edication_id := (ComboBEdication.Items.Objects[ComboBEdication.ItemIndex] as TID).id;
  except  On e: Exception do
    err('{997A628A-6318-4045-979A-D40D13ED78D6}', 'Ошибка сохранения сохранения.',e.Message);
  end;
end;

procedure TfrmStaff.MaskEPhoneChange(Sender: TObject);
begin

end;


end.


unit upatient;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, EditBtn, Buttons, udm, uerr;

type

  { TfrmPatient }

  TfrmPatient = class(TFrame)
    BitBClose: TBitBtn;
    BitBOk: TBitBtn;
    BitBRefresh: TBitBtn;
    ComboBDocType: TComboBox;
    ComboBEdication: TComboBox;
    ComboBArea: TComboBox;
    ComboBEdication1: TComboBox;
    ComboBEBenefit: TComboBox;
    ComboBMaritalStatus: TComboBox;
    ComboBEmployment: TComboBox;
    ComboBJob: TComboBox;
    ComboBDisabilityType: TComboBox;
    ComboBDisabilityGroup: TComboBox;
    ComboBPosition: TComboBox;
    DateECreatedDate: TDateEdit;
    DateEDob: TDateEdit;
    DateEDisabilityDate: TDateEdit;
    EAddress: TEdit;
    EDocNumber: TEdit;
    EOMCSeria: TEdit;
    EOMCNumber: TEdit;
    EFirstname: TEdit;
    ELastname: TEdit;
    EMiddlename: TEdit;
    ECardNumder: TEdit;
    EDocSeria: TEdit;
    ESNILS: TEdit;
    EPhone: TEdit;
    Label1: TLabel;
    LDisabilityDate: TLabel;
    LJob: TLabel;
    LPosition: TLabel;
    LDisability: TLabel;
    LEmployment: TLabel;
    LMaritalStatus: TLabel;
    LDocType: TLabel;
    LBenefit: TLabel;
    LInsurenceCompny: TLabel;
    LDocNumber: TLabel;
    LOMCSeria: TLabel;
    LOMCNumber: TLabel;
    Ldob: TLabel;
    LCardNumber: TLabel;
    LCreatedDate: TLabel;
    LArea: TLabel;
    LAddress: TLabel;
    LEdication: TLabel;
    LFirstname: TLabel;
    LLastname: TLabel;
    LMiddlename: TLabel;
    LDocSeria: TLabel;
    LSNILS: TLabel;
    LPhone: TLabel;
    LSex: TLabel;
    RadioBFemali: TRadioButton;
    RadioBMale: TRadioButton;
    SpeedBAddress: TSpeedButton;
    procedure FrameClick(Sender: TObject);
    procedure InitForm();
    procedure CreateFRM(a_user_id : Integer; a_patient_id: Integer = -1);
    procedure DestroyFRM();
  private
    user_id: integer;
//    patient:
  public

  end;

implementation

{$R *.lfm}

procedure TfrmPatient.InitForm();
begin
  dm.FillingList(ComboBEdication.Items,'dc_edication', 'id', 'nam', true);
  ComboBEdication.ItemIndex := 0;
end;

procedure TfrmPatient.FrameClick(Sender: TObject);
begin

end;

procedure TfrmPatient.CreateFRM(a_user_id : Integer; a_patient_id: Integer = -1);
begin
  DateEDob.DateFormat := 'dd.mm.yyyy';
  user_id := a_user_id;
  InitForm();
//  staff := TStaff.Create();
//  staff.Read(a_staff_id);
//  staff.user_id := user_id;
//  FillinForm();
end;

procedure TfrmPatient.DestroyFRM();
var
  _i: Integer;
begin
//  if Assigned(staff) then staff.Free;
  for _i := 0 to ComboBEdication.Items.Count -1 do
    ComboBEdication.Items.Objects[_i].Free;

end;

end.


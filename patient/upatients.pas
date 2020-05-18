unit upatients;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ComCtrls, RxDBGrid, DB, udm,uerr,
  umodal_form, upatient, dialogs;

type

  { TfrmPatients }

  TfrmPatients = class(TFrame)
    DataSPatients: TDataSource;
    ImageLPatientsMenu: TImageList;
    RxDBGPatients: TRxDBGrid;
    ToolBpatients: TToolBar;
    ToolBPatientAdd: TToolButton;
    ToolBPatientEdit: TToolButton;
    ToolBPatientDel: TToolButton;
    procedure CraeteFRM(a_user_id: Integer);
    procedure ToolBPatientAddClick(Sender: TObject);
    procedure ToolBPatientDelClick(Sender: TObject);
    procedure ToolBPatientEditClick(Sender: TObject);
  private
    user_id: Integer;
  public

  end;

implementation

{$R *.lfm}

procedure TfrmPatients.CraeteFRM(a_user_id: Integer);
var
  _sql: String;
begin
  user_id := a_user_id;
  _sql := 'select p.* ' +
          ', cast(ar.code || '' - '' || ar.nam as varchar(255)) as area ' +
          ', cast(ms.code || '' - '' || ms.nam as varchar(255)) as marital_status ' +
          ', cast(e.code || '' - '' || e.nam as varchar(255)) as edication ' +
          ', cast(dt.code || '' - '' || dt.nam as varchar(255)) as document_type ' +
          ', cast(b.code || '' - '' || b.nam as varchar(255)) as benefit ' +
          ', cast(ic.nam as varchar(255)) as insurance_company ' +
          ', cast(emp.code || '' - '' || emp.nam as varchar(255)) as employment ' +
          ', cast(da.code || '' - '' || da.nam as varchar(255)) as disability ' +
          ', cast(jc.nam as varchar(255)) as job_company ' +
          ', cast(jp.nam as varchar(255)) as job_position ' +
          ', cast(bt.category || '' - '' || bt.factor as varchar(255)) as blood_type ' +
          ' from patients p ' +
          ' join dc_area ar on ar.id = p.area_id ' +
          ' join dc_document_type dt on dt.id = p.document_type_id ' +
          ' left join dc_benefit b on b.id = p.benefit_id ' +
          ' left join dc_insurance_company ic on ic.id = p.insurance_company_id ' +
          ' left join dc_employment emp on emp.id = p.employment_id ' +
          ' left join dc_marital_status ms on ms.id = p.marital_status_id ' +
          ' left join dc_edication e on e.id = p.edication_id ' +
          ' left join dc_job_company jc on jc.id = p.job_company_id ' +
          ' left join dc_job_position jp on jp.id = p.job_position_id ' +
          ' left join dc_disability da on da.id = p.disability_id ' +
          ' left join dc_blood_type bt on bt.id = p.blood_type_id';
  DataSPatients.DataSet := dm.GetDataSetZ(_sql) ;
end;

procedure TfrmPatients.ToolBPatientAddClick(Sender: TObject);
var
  _form: TFModalForm;
  _frm: TfrmPatient;
begin
  _form := TFModalForm.Create(self);
  _frm := TfrmPatient.Create(_form);
  _frm.Parent := _form;
  _frm.CreateFRM(user_id);
  _form.ShowModal();
  _frm.DestroyFRM();
  _frm.Free;
  _form.Free;
  DataSPatients.DataSet.Refresh;
end;

procedure TfrmPatients.ToolBPatientDelClick(Sender: TObject);
var
  _sql: String;
begin
  if DataSPatients.DataSet.RecNo  < 0 then exit;
  if MessageDlg('Удалить ' + DataSPatients.DataSet.FieldByName('lastname').AsString +
                ' ' + DataSPatients.DataSet.FieldByName('firstname').AsString +
                ' ' + DataSPatients.DataSet.FieldByName('middlename').AsString +
                ' ( ' + DataSPatients.DataSet.FieldByName('dob').AsString + ' ) ' +
                '?',mtConfirmation, [mbNo, mbYes], 0) = mrYes then begin
    _sql := 'update patients set deleted_at = now(), isdelete = true where id = ' +
            DataSPatients.DataSet.FieldByName('id').AsString;
    if  dm.SQLExecZ(_sql) then  DataSPatients.DataSet.Refresh;
  end;

end;

procedure TfrmPatients.ToolBPatientEditClick(Sender: TObject);
var
  _form: TFModalForm;
  _frm: TfrmPatient;
begin
  if DataSPatients.DataSet.RecNo  < 0 then exit;
  _form := TFModalForm.Create(self);
  _frm := TfrmPatient.Create(_form);
  _frm.Parent := _form;
  _frm.CreateFRM(user_id,DataSPatients.DataSet.FieldByName('id').AsInteger);
  _form.ShowModal();
  _frm.DestroyFRM();
  _frm.Free;
  _form.Free;
  DataSPatients.DataSet.Refresh;
end;

end.


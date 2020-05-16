unit ustaffs;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ComCtrls, RxDBGrid, DB, dialogs,udm,uerr,
  ustaff, umodal_form;

type

  { TfrmStaffs }

  TfrmStaffs = class(TFrame)
    DataSStaff: TDataSource;
    ImageLStaffMenu: TImageList;
    RxDBGStaffs: TRxDBGrid;
    ToolBStaffAdd: TToolButton;
    ToolBStaffEdit: TToolButton;
    ToolBStaffDel: TToolButton;
    ToolButton4: TToolButton;
    ToolStaffMenu: TToolBar;
    procedure ToolBStaffAddClick(Sender: TObject);
    procedure ToolBStaffDelClick(Sender: TObject);
    procedure CraeteFRM();
    procedure ToolBStaffEditClick(Sender: TObject);
  private

  public

  end;

implementation

{$R *.lfm}

{ TfrmStaffs }

procedure TfrmStaffs.CraeteFRM();
var
  _sql: String;
begin
  _sql := 'select * from staff order by lastname, firstname, middlename';
  DataSStaff.DataSet := dm.GetDataSetZ(_sql) ;
end;

procedure TfrmStaffs.ToolBStaffEditClick(Sender: TObject);
var
  _form: TFModalForm;
  _frm_staff: TfrmStaff;
begin
  if DataSStaff.DataSet.RecNo  < 0 then exit;
  _form := TFModalForm.Create(self);
  _frm_staff := TfrmStaff.Create(_form);
  _frm_staff.Parent := _form;
  _frm_staff.CreateFRM(DataSStaff.DataSet.FieldByName('id').AsInteger);
  _form.ShowModal();
  _frm_staff.DestroyFRM();
  _frm_staff.Free;
  _form.Free;
  DataSStaff.DataSet.Refresh;
end;

procedure TfrmStaffs.ToolBStaffDelClick(Sender: TObject);
var
  _sql: String;
begin
  if DataSStaff.DataSet.RecNo  < 0 then exit;
  if MessageDlg('Удалить ' + DataSStaff.DataSet.FieldByName('lastname').AsString +
                ' ' + DataSStaff.DataSet.FieldByName('firstname').AsString +
                ' ' + DataSStaff.DataSet.FieldByName('middlename').AsString +
                ' ( ' + DataSStaff.DataSet.FieldByName('dob').AsString + ' ) ' +
                '?',mtConfirmation, [mbNo, mbYes], 0) = mrYes then begin
    _sql := 'delete from staff where id = ' + DataSStaff.DataSet.FieldByName('id').AsString;
    if  dm.SQLExecZ(_sql) then  DataSStaff.DataSet.Refresh;
  end;
end;

procedure TfrmStaffs.ToolBStaffAddClick(Sender: TObject);
var
  _form: TFModalForm;
  _frm_staff: TfrmStaff;
begin
  _form := TFModalForm.Create(self);
  _frm_staff := TfrmStaff.Create(_form);
  _frm_staff.Parent := _form;
  _frm_staff.CreateFRM(-1);
  _form.ShowModal();
  _frm_staff.DestroyFRM();
  _frm_staff.Free;
  _form.Free;
  DataSstaff.DataSet.Refresh;
end;



end.


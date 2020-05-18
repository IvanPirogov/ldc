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
    procedure CraeteFRM(a_user_id: Integer);
    procedure ToolBStaffEditClick(Sender: TObject);
  private
    user_id: integer;
  public

  end;

implementation

{$R *.lfm}

{ TfrmStaffs }

procedure TfrmStaffs.CraeteFRM(a_user_id: Integer);
var
  _sql: String;
begin
  user_id := a_user_id;
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
  _frm_staff.CreateFRM(user_id,DataSStaff.DataSet.FieldByName('id').AsInteger);
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
    _sql := 'update staff set deleted_at = now(), isdelete = true where id = ' +
            DataSStaff.DataSet.FieldByName('id').AsString;
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
  _frm_staff.CreateFRM(user_id);
  _form.ShowModal();
  _frm_staff.DestroyFRM();
  _frm_staff.Free;
  _form.Free;
  DataSstaff.DataSet.Refresh;
end;



end.


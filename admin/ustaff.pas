unit ustaff;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ComCtrls, RxDBGrid, DB, dialogs,udm,uerr;

type

  { TfrmStaff }

  TfrmStaff = class(TFrame)
    DataSStaff: TDataSource;
    ImageLStaffMenu: TImageList;
    RxDBGStaff: TRxDBGrid;
    ToolBStaffAdd: TToolButton;
    ToolBStaffEdit: TToolButton;
    ToolBStaffDel: TToolButton;
    ToolButton4: TToolButton;
    ToolStaffMenu: TToolBar;
    procedure ToolBStaffDelClick(Sender: TObject);
    procedure CraeteFRM();
  private

  public

  end;

implementation

{$R *.lfm}

{ TfrmStaff }

procedure TfrmStaff.CraeteFRM();
var
  _sql: String;
begin
  _sql := 'select * from staff order by lastname, firstname, middlename';
  DataSStaff.DataSet := dm.GetDataSetZ(_sql) ;
end;

procedure TfrmStaff.ToolBStaffDelClick(Sender: TObject);
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

end.


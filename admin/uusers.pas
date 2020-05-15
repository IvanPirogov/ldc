unit uusers;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, ComCtrls,  rxdbgrid,
  sqldb, udm, umodal_form, uuser, dialogs;

type

  { TfrmUsers }

  TfrmUsers = class(TFrame)
    DataSUsers: TDataSource;
    ImageLUsersMenu: TImageList;
    RxDBGrid1: TRxDBGrid;
    ToolBar1: TToolBar;
    ToolBAdd: TToolButton;
    ToolBDel: TToolButton;
    ToolBClose: TToolButton;
    procedure CraeteFRM();
    procedure DataSUsersDataChange(Sender: TObject; Field: TField);
    procedure ToolBAddClick(Sender: TObject);
    procedure ToolBCloseClick(Sender: TObject);
    procedure DestroyFRM();
    procedure ToolBDelClick(Sender: TObject);
  private

  public

  end;

implementation

{$R *.lfm}

procedure TfrmUsers.CraeteFRM();
var
  _sql: String;
begin
  _sql := 'select u.*, cast(s.lastname || '' '' || s.firstname  || '' '' || s.middlename as varchar(255))  as nam, r.nam as role_nam from users u ' +
                ' join staff s on s.id = u.staff_id ' +
                ' join uroles r on r.id = u.role_id ' +
                ' order by u.id';
  DataSUsers.DataSet := dm.GetDataSetZ(_sql) ;
end;

procedure TfrmUsers.DataSUsersDataChange(Sender: TObject; Field: TField);
begin

end;

procedure TfrmUsers.ToolBAddClick(Sender: TObject);
var
  _form: TFModalForm;
  _frm_user: TfrmUser;
begin
  _form := TFModalForm.Create(self);
  _frm_user := TfrmUser.Create(_form);
  _frm_user.Parent := _form;
  _frm_user.CreateFRM(-1);
  _form.ShowModal();
  _frm_user.DestroyFRM();
  _frm_user.Free;
  _form.Free;
  DataSUsers.DataSet.Refresh;
end;

procedure TfrmUsers.ToolBCloseClick(Sender: TObject);
var
  _form: TFModalForm;
  _frm_user: TfrmUser;
begin
  if DataSUsers.DataSet.RecNo  < 0 then exit;
  _form := TFModalForm.Create(self);
  _frm_user := TfrmUser.Create(_form);
  _frm_user.Parent := _form;
  _frm_user.CreateFRM(DataSUsers.DataSet.FieldByName('id').AsInteger);
  _form.ShowModal();
  _frm_user.DestroyFRM();
  _frm_user.Free;
  _form.Free;
  DataSUsers.DataSet.Refresh;
end;

procedure TfrmUsers.DestroyFRM();
begin
  DataSUsers.DataSet.DataSource.Free;
end;

procedure TfrmUsers.ToolBDelClick(Sender: TObject);
var
  _sql: String;
begin
  if DataSUsers.DataSet.RecNo  < 0 then exit;
  if MessageDlg('Удалить пользователя ' + DataSUsers.DataSet.FieldByName('login').AsString +
                '?',mtConfirmation, [mbNo, mbYes], 0) = mrYes then begin
    _sql := 'delete from users where id = ' + DataSUsers.DataSet.FieldByName('id').AsString;
    if  dm.SQLExecZ(_sql) then  DataSUsers.DataSet.Refresh;
  end;
end;

end.


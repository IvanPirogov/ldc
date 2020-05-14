unit uusers;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, Forms, Controls, ComCtrls, RxDBColorBox, rxdbgrid,
  sqldb, udm, umodal_form, uuser;

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
  private

  public

  end;

implementation

{$R *.lfm}

procedure TfrmUsers.CraeteFRM();
var
  _q: TSQLQuery;
begin
  _q := dm.ReadSQL('select u.*, (s.lastname || '' '' || s.firstname  || '' '' || s.middlename)::varchar(255)  as nam, r.nam as role_nam from users u ' +
                ' join staff s on s.id = u.staff_id ' +
                ' join uroles r on r.id = u.role_id ' +
                ' order by u.id');
  DataSUsers.DataSet := _q ;
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

end;


end.


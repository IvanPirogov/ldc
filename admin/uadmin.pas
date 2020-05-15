unit uadmin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ComCtrls, ExtCtrls, dialogs, DBGrids,
  rxdbgrid, udic, uusers, ustaff;

type

  { TfrmAdmin }

  TfrmAdmin = class(TFrame)
    PageCClient: TPageControl;
    PTitle: TPanel;
    PClient: TPanel;
    SMenuClient: TSplitter;
    TabSheet1: TTabSheet;
    TabShStaff: TTabSheet;
    TabShUsers: TTabSheet;
    TabShDic: TTabSheet;
    TabSheet5: TTabSheet;
    TreeVMenu: TTreeView;
    procedure TreeVMenuClick(Sender: TObject);
  private
    current_tab: TTabSheet;
    frm_dic: TfrmDic;
    frm_users: TfrmUsers;
    frm_staff: TfrmStaff;
  public

  end;

implementation



{$R *.lfm}

{ TfrmAdmin }

procedure TfrmAdmin.TreeVMenuClick(Sender: TObject);
begin
  PTitle.Caption:=TreeVMenu.Selected.Text;
  if (TreeVMenu.Selected.Parent.Index > -1) and (TreeVMenu.Selected.Parent.Text = 'Справочники') then begin
    if not (current_tab = TabShDic) then begin
      PageCClient.ActivePage := TabShDic;
      current_tab := TabShDic;
      if not Assigned(frm_dic) then begin
        frm_dic := TfrmDic.Create(TabShDic);
        frm_dic.Parent := TabShDic;
        frm_dic.Align := alClient;
      end;
    end;
    PTitle.Caption:= TreeVMenu.Selected.Parent.Text + ' / ' + TreeVMenu.Selected.Text;
    frm_dic.ChangeDic(TreeVMenu.Selected.Text);
  end;
  if (TreeVMenu.Selected.Text = 'Пользователи') then
    if not (current_tab = TabShUsers) then begin
      PageCClient.ActivePage := TabShUsers;
      current_tab := TabShUsers;
      if not Assigned(frm_users) then begin
        frm_users := TfrmUsers.Create(TabShUsers);
        frm_users.Parent := TabShUsers;
        frm_users.Align := alClient;
        frm_users.CraeteFRM();
      end;
    end;
  if (TreeVMenu.Selected.Text = 'Сотрудники') then
    if not (current_tab = TabShStaff) then begin
      PageCClient.ActivePage := TabShStaff;
      current_tab := TabShStaff;
      if not Assigned(frm_staff) then begin
        frm_staff := TfrmStaff.Create(TabShStaff);
        frm_staff.Parent := TabShStaff;
        frm_staff.Align := alClient;
        frm_staff.CraeteFRM();
      end;
    end;
end;

end.


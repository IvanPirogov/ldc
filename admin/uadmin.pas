unit uadmin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ComCtrls, ExtCtrls, dialogs, DBGrids,
  rxdbgrid, udic, uusers;

type

  { TfrmAdmin }

  TfrmAdmin = class(TFrame)
    PageCClient: TPageControl;
    PTitle: TPanel;
    PClient: TPanel;
    SMenuClient: TSplitter;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabShUsers: TTabSheet;
    TabShDic: TTabSheet;
    TabSheet5: TTabSheet;
    TreeVMenu: TTreeView;
    procedure TreeVMenuClick(Sender: TObject);
  private
    current_tab: TTabSheet;
    frm_dic: TfrmDic;
    frm_users: TfrmUsers;
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
end;

end.


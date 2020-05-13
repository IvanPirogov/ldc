unit uadmin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ComCtrls, ExtCtrls, dialogs, DBGrids,
  rxdbgrid, udm, udic, uusers;

type

  { TfrmAdmin }

  TfrmAdmin = class(TFrame)
    PageCClient: TPageControl;
    PTitle: TPanel;
    PClient: TPanel;
    SMenuClient: TSplitter;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabShDic: TTabSheet;
    TabSheet5: TTabSheet;
    TreeVMenu: TTreeView;
    procedure TreeVMenuClick(Sender: TObject);
  private
    current_tab: TTabSheet;
    frm_dic: TfrmDic;
  public

  end;

implementation



{$R *.lfm}

{ TfrmAdmin }

procedure TfrmAdmin.TreeVMenuClick(Sender: TObject);
begin
  PTitle.Caption:=TreeVMenu.Selected.Text;
  if (TreeVMenu.Selected.Parent.Index > -1) and (TreeVMenu.Items[TreeVMenu.Selected.Parent.Index].Text = 'Справочники') then begin
    if not (current_tab = TabShDic) then begin
      PageCClient.ActivePage := TabShDic;
      current_tab := TabShDic;
      if not Assigned(frm_dic) then begin
        frm_dic := TfrmDic.Create(TabShDic);
        frm_dic.Parent := TabShDic;
        frm_dic.Align := alClient;
      end;
    end;
    frm_dic.ChangeDic(TreeVMenu.Selected.Text);
  end;

end;

end.


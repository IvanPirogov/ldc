unit uadmin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ComCtrls, ExtCtrls, dialogs, udic;

type

  { TfrmAdmin }

  TfrmAdmin = class(TFrame)
    frmDic1: TfrmDic;
    PageCClient: TPageControl;
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
  public

  end;

implementation


{$R *.lfm}

{ TfrmAdmin }

procedure TfrmAdmin.TreeVMenuClick(Sender: TObject);
begin
  if current_tab = TabShDic then exit;
  if (TreeVMenu.Selected.Parent.Index > -1) and (TreeVMenu.Items[TreeVMenu.Selected.Parent.Index].Text = 'Справочники') then begin
     PageCClient.ActivePage := TabShDic;
     current_tab := TabShDic;
  end;
end;

end.


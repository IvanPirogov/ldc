unit uadmin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ComCtrls, ExtCtrls, dialogs, DBGrids,
  rxdbgrid, udic, uusers;

type

  { TfrmAdmin }

  TfrmAdmin = class(TFrame)
    frmDic: TfrmDic;
    frmDic1: TfrmDic;
    frmUsers1: TfrmUsers;
    PageCClient: TPageControl;
    PTitle: TPanel;
    PClient: TPanel;
    RxDBGrid1: TRxDBGrid;
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

uses udm;


{$R *.lfm}

{ TfrmAdmin }

procedure TfrmAdmin.TreeVMenuClick(Sender: TObject);
begin
  PTitle.Caption:=TreeVMenu.Selected.Text;
  if (TreeVMenu.Selected.Parent.Index > -1) and (TreeVMenu.Items[TreeVMenu.Selected.Parent.Index].Text = 'Справочники') then begin
     if not (current_tab = TabShDic) then begin
       PageCClient.ActivePage := TabShDic;
       current_tab := TabShDic;
     end;
     frmDic.ChangeDic(TreeVMenu.Selected.Text);
  end;
  dm.ZTable1.Active := false;
  dm.ZTable1.TableName := 'dc_area';
  dm.ZTable1.Active := True;
  RxDBGrid1.Columns[0].ReadOnly:=true;
end;

end.


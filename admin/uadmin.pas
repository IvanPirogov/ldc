unit uadmin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ComCtrls, ExtCtrls, RxViewsPanel,
  rxDateRangeEditUnit, rxlogin, rxdbverticalgrid, rxdbgrid, VirtualTrees;

type

  { TfrmAdmin }

  TfrmAdmin = class(TFrame)
    PageCClient: TPageControl;
    SMenuClient: TSplitter;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabShDic: TTabSheet;
    TabSheet5: TTabSheet;
    TreeVMenu: TTreeView;
    procedure TreeVMenuChange(Sender: TObject; Node: TTreeNode);
    procedure TreeVMenuClick(Sender: TObject);
  private

  public

  end;

implementation

{$R *.lfm}

{ TfrmAdmin }

procedure TfrmAdmin.TreeVMenuChange(Sender: TObject; Node: TTreeNode);
begin

end;

procedure TfrmAdmin.TreeVMenuClick(Sender: TObject);
begin

end;

end.


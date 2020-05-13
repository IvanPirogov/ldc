unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, pqconnection, sqldb, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, uadmin;

type

  { TFMain }

  TFMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    IMenuReg: TImage;
    IMenuDoc: TImage;
    IMenuDiag: TImage;
    IMenuLab: TImage;
    IMenuAdmin: TImage;
    IMenuExit: TImage;
    IMenuStat: TImage;
    PageCMain: TPageControl;
    PMenu: TPanel;
    StatusBMain: TStatusBar;
    TabShReg: TTabSheet;
    TabShDoc: TTabSheet;
    TabShDiag: TTabSheet;
    TabShLab: TTabSheet;
    TabShAdmin: TTabSheet;
    TabShstat: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure IMenuAdminClick(Sender: TObject);
    procedure IMenuAdminMouseEnter(Sender: TObject);
    procedure IMenuAdminMouseLeave(Sender: TObject);
    procedure IMenuDiagClick(Sender: TObject);
    procedure IMenuDiagMouseEnter(Sender: TObject);
    procedure IMenuDiagMouseLeave(Sender: TObject);
    procedure IMenuExitClick(Sender: TObject);
    procedure IMenuLabClick(Sender: TObject);
    procedure IMenuLabMouseEnter(Sender: TObject);
    procedure IMenuLabMouseLeave(Sender: TObject);
    procedure IMenuStatClick(Sender: TObject);
    procedure IMenuStatMouseEnter(Sender: TObject);
    procedure IMenuStatMouseLeave(Sender: TObject);
    procedure RefreshMenuButton();
    procedure IMenuDocClick(Sender: TObject);
    procedure IMenuDocMouseEnter(Sender: TObject);
    procedure IMenuDocMouseLeave(Sender: TObject);
    procedure IMenuRegClick(Sender: TObject);
    procedure IMenuRegMouseEnter(Sender: TObject);
    procedure IMenuRegMouseLeave(Sender: TObject);
  private
    current_menu: integer;
    frm_admin: TFrame;
    is_hide: Boolean;
  public

  end;

var
  FMain: TFMain;

implementation

uses UAuth, uerr;

{$R *.lfm}

{ TFMain }

procedure TFMain.RefreshMenuButton();
begin
  IMenuReg.Picture.LoadFromFile('res/admin1.png');
  IMenuDoc.Picture.LoadFromFile('res/admin1.png');
  IMenuDiag.Picture.LoadFromFile('res/admin1.png');
  IMenuLab.Picture.LoadFromFile('res/admin1.png');
  IMenuAdmin.Picture.LoadFromFile('res/admin1.png');
  IMenuStat.Picture.LoadFromFile('res/admin1.png');

end;

procedure TFMain.IMenuDiagClick(Sender: TObject);
begin
  if current_menu = 3 then Exit;
  RefreshMenuButton();
  IMenuDiag.Picture.LoadFromFile('res/admin3.png');
  PageCMain.ActivePage := TabShDiag;
  current_menu := 3;
end;

procedure TFMain.IMenuDiagMouseEnter(Sender: TObject);
begin
  if current_menu <> 3 then IMenuDiag.Picture.LoadFromFile('res/admin2.png');
end;

procedure TFMain.IMenuDiagMouseLeave(Sender: TObject);
begin
  if current_menu <> 3 then IMenuDiag.Picture.LoadFromFile('res/admin1.png');
end;

procedure TFMain.IMenuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFMain.IMenuAdminClick(Sender: TObject);
begin
  if current_menu = 5 then Exit;
  RefreshMenuButton();
  IMenuAdmin.Picture.LoadFromFile('res/admin3.png');
  PageCMain.ActivePage := TabShAdmin;
  if not Assigned(frm_admin) then begin
    frm_admin := TfrmAdmin.Create(TabShAdmin);
    frm_admin.Parent := TabShAdmin;
    frm_admin.Align := alClient;
  end;
  current_menu := 5;
end;

procedure TFMain.Button1Click(Sender: TObject);
begin
  //
  err('{8C91B519-869F-447F-9C65-8DF9D28CC58E}','Test','Test {8C91B519-869F-447F-9C65-8DF9D28CC58E}') ;


end;

procedure TFMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if is_hide then CanClose := True
  else if MessageDlg('Вы хотите выйти из программы?',mtConfirmation, [mbNo, mbYes], 0) = mrYes then
    CanClose := True
  else CanClose := False;
end;


procedure TFMain.FormShow(Sender: TObject);
begin
  if not Assigned(FAuth) then exit;
  Hide();
  is_hide:= true;
  FAuth.ShowModal;
  if FAuth.ModalResult = mrOK then begin
    FreeAndNil(FAuth);
    Show();
    is_hide:= false;
    frm_admin := nil;
  end
  else Close();
end;


procedure TFMain.IMenuAdminMouseEnter(Sender: TObject);
begin
  if current_menu <> 5 then IMenuAdmin.Picture.LoadFromFile('res/admin2.png');
end;

procedure TFMain.IMenuAdminMouseLeave(Sender: TObject);
begin
  if current_menu <> 5 then IMenuAdmin.Picture.LoadFromFile('res/admin1.png');
end;

procedure TFMain.IMenuLabClick(Sender: TObject);
begin
  if current_menu = 4 then Exit;
  RefreshMenuButton();
  IMenuLab.Picture.LoadFromFile('res/admin3.png');
  PageCMain.ActivePage := TabShLab;
  current_menu := 4;
end;

procedure TFMain.IMenuLabMouseEnter(Sender: TObject);
begin
  if current_menu <> 4 then IMenuLab.Picture.LoadFromFile('res/admin2.png');
end;

procedure TFMain.IMenuLabMouseLeave(Sender: TObject);
begin
  if current_menu <> 4 then IMenuLab.Picture.LoadFromFile('res/admin1.png');
end;

procedure TFMain.IMenuStatClick(Sender: TObject);
begin
  if current_menu = 6 then Exit;
  RefreshMenuButton();
  IMenuStat.Picture.LoadFromFile('res/admin3.png');
  PageCMain.ActivePage := TabShStat;
  current_menu := 6;
end;

procedure TFMain.IMenuStatMouseEnter(Sender: TObject);
begin
  if current_menu <> 6 then IMenuStat.Picture.LoadFromFile('res/admin2.png');
end;

procedure TFMain.IMenuStatMouseLeave(Sender: TObject);
begin
  if current_menu <> 6 then IMenuStat.Picture.LoadFromFile('res/admin1.png');
end;

procedure TFMain.IMenuRegClick(Sender: TObject);
begin
  if current_menu = 1 then Exit;
  RefreshMenuButton();
  IMenuReg.Picture.LoadFromFile('res/admin3.png');
  PageCMain.ActivePage := TabShReg;
  current_menu := 1;
end;

procedure TFMain.IMenuDocClick(Sender: TObject);
begin
  if current_menu = 2 then Exit;
  RefreshMenuButton();
  IMenuDoc.Picture.LoadFromFile('res/admin3.png');
  PageCMain.ActivePage := TabShDoc;
  current_menu := 2;
end;

procedure TFMain.IMenuDocMouseEnter(Sender: TObject);
begin
  if current_menu <> 2 then IMenuDoc.Picture.LoadFromFile('res/admin2.png');
end;

procedure TFMain.IMenuDocMouseLeave(Sender: TObject);
begin
  if current_menu <> 2 then IMenuDoc.Picture.LoadFromFile('res/admin1.png');
end;

procedure TFMain.IMenuRegMouseEnter(Sender: TObject);
begin
  if current_menu <> 1 then IMenuReg.Picture.LoadFromFile('res/admin2.png');
end;

procedure TFMain.IMenuRegMouseLeave(Sender: TObject);
begin
  if current_menu <> 1 then IMenuReg.Picture.LoadFromFile('res/admin1.png');
end;



end.


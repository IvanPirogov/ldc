unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, pqconnection, sqldb, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type

  { TFMain }

  TFMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    IMenuReg: TImage;
    IMenuDoc: TImage;
    IMenuDiag: TImage;
    IMenuLab: TImage;
    IMenuAdmin: TImage;
    IMenuStat: TImage;
    PageCMain: TPageControl;
    PMenu: TPanel;
    ConnPqSQL: TPQConnection;
    SQLTransaction1: TSQLTransaction;
    StatusBMain: TStatusBar;
    TabShReg: TTabSheet;
    TabShDoc: TTabSheet;
    TabShDiag: TTabSheet;
    TabShLab: TTabSheet;
    TabShAdmin: TTabSheet;
    TabShstat: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure IMenuAdminClick(Sender: TObject);
    procedure IMenuAdminMouseEnter(Sender: TObject);
    procedure IMenuAdminMouseLeave(Sender: TObject);
    procedure IMenuDiagClick(Sender: TObject);
    procedure IMenuDiagMouseEnter(Sender: TObject);
    procedure IMenuDiagMouseLeave(Sender: TObject);
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
  public

  end;

var
  FMain: TFMain;

implementation

uses UAuth;

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

procedure TFMain.IMenuAdminClick(Sender: TObject);
begin
  if current_menu = 5 then Exit;
  RefreshMenuButton();
  IMenuAdmin.Picture.LoadFromFile('res/admin3.png');
  PageCMain.ActivePage := TabShAdmin;
  current_menu := 5;
end;

procedure TFMain.Button1Click(Sender: TObject);
var
  _str: String;
begin
  _str := extractfilepath(paramstr(0));

end;

procedure TFMain.FormActivate(Sender: TObject);
begin
  Hide();
  FAuth.ShowModal;
  if FAuth.ModalResult = mrOK then Show()
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

unit uauth;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, sqldb;

type

  { TFAuth }

  TFAuth = class(TForm)
    BitBExit: TBitBtn;
    BitBEnter: TBitBtn;
    ELogin: TEdit;
    EPassw: TEdit;
    Image1: TImage;
    LLogin: TLabel;
    LPassw: TLabel;
    SpeedBShowPassw: TSpeedButton;
    procedure BitBEnterClick(Sender: TObject);
    procedure BitBExitClick(Sender: TObject);
    procedure SpeedBShowPasswClick(Sender: TObject);
  private

  public

  end;

var
  FAuth: TFAuth;

implementation

uses udm;

{$R *.lfm}

{ TFAuth }

procedure TFAuth.BitBExitClick(Sender: TObject);
begin
   if MessageDlg('Вы хотите выйти из программы?',mtConfirmation, [mbYes,mbNo], 0) = mrYes then begin
      close();
   end;
end;

procedure TFAuth.BitBEnterClick(Sender: TObject);
var
  q: TSQLQuery;
begin
  if dm.ConnectDb() then begin
    q := dm.OpenTbl('select id, status from users where login = ''' + trim(ELogin.Text) + ''' and passw = ''' + Trim(EPassw.Text) + '''');
    if q.RecordCount = 0 then begin
      ShowMessage('Введен на верный логин или пароль!');
      q.Close();
    end else begin
    q.Close();
     ModalResult := mrOK;
    end;
  end;

end;

procedure TFAuth.SpeedBShowPasswClick(Sender: TObject);
begin
  if EPassw.PasswordChar = #0 then begin
    EPassw.PasswordChar := '*';
    SpeedBShowPassw.Glyph.LoadFromFile('res/passw_hide.bmp');
  end else begin
    EPassw.PasswordChar := #0;
    SpeedBShowPassw.Glyph.LoadFromFile('res/passw_show.bmp');
  end;
end;

end.


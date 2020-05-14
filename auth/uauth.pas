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
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure SpeedBShowPasswClick(Sender: TObject);
  private
    ok: Boolean;
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
     ModalResult := -1;
   end;
end;

procedure TFAuth.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if ok then ModalResult := ModalResult
  else ModalResult := -1;
end;

procedure TFAuth.BitBEnterClick(Sender: TObject);
var
  _q: TSQLQuery;
begin
  if dm.ConnectDb() then begin
    _q := dm.OpenTbl('select id, status from users where login = ''' + trim(ELogin.Text) + ''' and passw = ''' + Trim(EPassw.Text) + '''');
    if _q.RecordCount = 0 then begin
      ShowMessage('Введен на верный логин или пароль!');
      _q.Close();
    end else begin
      ok:=True;
      ModalResult := _q.FieldByName('id').AsInteger;
      _q.Close();
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


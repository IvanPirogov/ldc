unit uerr;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TFError }

  TFError = class(TForm)
    BitBDetail: TBitBtn;
    BitBClose: TBitBtn;
    EGuid: TEdit;
    IPic: TImage;
    MErrorText: TMemo;
    MErrorDitail: TMemo;
    procedure BitBCloseClick(Sender: TObject);
    procedure BitBDetailClick(Sender: TObject);
    procedure show_error(a_guid, a_text, a_deatail: String);
  private

  public

  end;

var
  FError: TFError;

procedure err(a_guid, a_text, a_deatail: String; a_show_form: Boolean = True; a_write_log: Boolean = True);

implementation

{$R *.lfm}

{ TFError }

procedure TFError.BitBDetailClick(Sender: TObject);
begin
  if FError.Height > 200 then FError.Height := 140
  else FError.Height := 280;
end;


procedure TFError.BitBCloseClick(Sender: TObject);
begin
  Close();
end;


procedure TFError.show_error(a_guid, a_text, a_deatail: String);
begin
  try
    FError := TFError.Create(nil);
    FError.EGuid.Text := a_guid;
    FError.MErrorText.Text := a_text;
    FError.MErrorDitail.Text := a_deatail;
    FError.ShowModal();
    FreeAndNil(FError);
  except
    ShowMessage('Ошибка открытия окно сообщения');
  end;
end;

procedure check_file(a_file_name: String);
var
  _f:  File Of byte;
begin
  try
    if FileExists(a_file_name) then begin
      AssignFile(_f, a_file_name);
      Reset(_f);
      if FileSize(_f) > 1049000 then begin
        Close(_f);
        RenameFile(a_file_name, a_file_name + '.' + FormatDateTime('YYYYMMDDhhmm',Now()));
        FileCreate(a_file_name);
      end else
        Close(_f);
    end else FileCreate(a_file_name);
  except
    ShowMessage('Ошибка записи в лог');
  end;
end;

procedure write_log(a_guid, a_text, a_deatail: String);
var
  _f: TextFile;
begin
  try
    check_file('ldc.err');
    AssignFile(_f,'ldc.err');
    Append(_f);
    writeln(_f, FormatDateTime('YYYY-MM-DD hh:mm:ss.zzz',Now()) + ' | ' + a_guid + ' | ' + a_text + ' -> ' + a_deatail);
    CloseFile(_f);
  except
    ShowMessage('Ошибка записи в лог');
  end;
end;

procedure err(a_guid, a_text, a_deatail: String; a_show_form: Boolean = True; a_write_log: Boolean = True);
begin
  if a_write_log then write_log(a_guid, a_text, a_deatail);
  if a_show_form then FError.show_error(a_guid, a_text, a_deatail);
end;

end.


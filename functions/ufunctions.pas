unit ufunctions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IniFiles, uerr;

var
  file_ini: TIniFile;

function InitINI(a_appname: String): Boolean;
function WriteStrINI(a_section, a_option, a_value: string): boolean;
function ReadStrINI(a_section, a_option: string): String;
function CloseIni(): boolean;

implementation

function InitINI(a_appname: String): Boolean;
var
  _filename: String;
begin
  _filename := extractfilepath(paramstr(0)) + a_appname + '.ini';
  try
    file_ini := TiniFile.Create(_filename);
    Result := true;
  except  On e: Exception do
    err('{DFB561B0-486E-46CC-A0B1-38666777DFEF}', 'Ошибка открытмя INI файла.',e.Message);
  end;
end;

function WriteStrINI(a_section, a_option, a_value: string): boolean;
begin
  try
    file_ini.WriteString(a_section,a_option,a_value);
    Result := true;
  except  On e: Exception do
    err('{87591CF0-82AC-4F51-9C2B-49847D33B42A}', 'Ошибка записи INI файла.',e.Message);
  end;
end;


function ReadStrINI(a_section, a_option: string): String;
begin
  try
    Result := file_ini.ReadString(a_section,a_option,'');
  except  On e: Exception do
    err('{01C33AAF-BBDE-4239-9B27-FD380658068A}', 'Ошибка чтения INI файла.',e.Message);
  end;
end;


function CloseIni(): boolean;
begin
  try
    FreeAndNil(file_ini);
    Result := true;
  except  On e: Exception do
    err('{0C0EF71B-65EE-4A8B-A8FC-575D91EBFA0A}', 'Ошибка INI файла.',e.Message);
  end;
end;

end.


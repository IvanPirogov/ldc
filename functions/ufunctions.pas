unit ufunctions;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IniFiles;

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
  except
  end;
end;

function WriteIntINI(a_section, a_option: string; a_value: Integer): boolean;
begin
  try
    file_ini.WriteInteger(a_section,a_option,a_value);
    Result := true;
  finally
  end;
end;

function WriteStrINI(a_section, a_option, a_value: string): boolean;
begin
  try
    file_ini.WriteString(a_section,a_option,a_value);
    Result := true;
  finally
  end;
end;

function WriteDtINI(a_section, a_option: string; a_value: TDateTime): boolean;
begin
  try
    file_ini.WriteDateTime(a_section,a_option,a_value);
    Result := true;
  finally
  end;
end;

function ReadIntINI(a_section, a_option: string): Integer;
begin
  try
    Result := file_ini.ReadInteger(a_section,a_option,-1);
  finally
  end;
end;

function ReadStrINI(a_section, a_option: string): String;
begin
  try
    Result := file_ini.ReadString(a_section,a_option,'');
  finally
  end;
end;

function ReadDtINI(a_section, a_option: string): TDateTime;
begin
  try
    Result := file_ini.ReadDatetime(a_section,a_option,Now());
  finally
  end;
end;

function CloseIni(): boolean;
begin
  try
    FreeAndNil(file_ini);
    Result := true;
  finally

  end;
end;

end.


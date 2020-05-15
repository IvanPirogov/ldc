program ldc;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, umain, uauth, ufunctions, uerr, udm, uusers, udic, cuser,
  uuser, umodal_form, ustaff
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFAuth, FAuth);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.


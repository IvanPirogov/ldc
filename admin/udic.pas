unit udic;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ComCtrls, rxdbgrid;

type

  { TFDic }

  TFDic = class(TFrame)
    ImageLMenu35: TImageList;
    RxDBGDic: TRxDBGrid;
    ToolBDic: TToolBar;
    ToolBDicAdd: TToolButton;
    ToolBDicCansel: TToolButton;
    ToolBDicDel: TToolButton;
    ToolBDicSave: TToolButton;
  private

  public

  end;

implementation

{$R *.lfm}

end.


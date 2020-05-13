unit udic;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ComCtrls, rxdbgrid, RxDBColorBox, DBGrids;

type

  { TfrmDic }

  TfrmDic = class(TFrame)
    ImageLMenu35: TImageList;
    RxDBGDic: TRxDBGrid;
    ToolBDic: TToolBar;
    ToolBDicAdd: TToolButton;
    ToolBDicCansel: TToolButton;
    ToolBDicDel: TToolButton;
    ToolBDicSave: TToolButton;
    procedure ChangeDic(a_name_dic: String);
  private

  public

  end;

implementation

uses udm, uerr;

{$R *.lfm}

{ TfrmDic }

procedure TfrmDic.ChangeDic(a_name_dic: String);
var
  _tablename: String;
begin
  if a_name_dic = 'Местность' then _tablename := 'dc_area';
  if a_name_dic = 'Документ' then _tablename := 'dc_document_type';
  if a_name_dic = 'Местность' then _tablename := 'dc_area';
  if a_name_dic = 'Местность' then _tablename := 'dc_area';
  if a_name_dic = 'Местность' then _tablename := 'dc_area';
  if a_name_dic = 'Местность' then _tablename := 'dc_area';
  if a_name_dic = 'Местность' then _tablename := 'dc_area';
  if _tablename <> '' then begin
    dm.ZTable1.Active := false;
    dm.ZTable1.TableName := _tablename;
    dm.ZTable1.Active := True;
//    RxDBGDic.Columns[0].ReadOnly:=true;
  end;
end;

end.


unit udic;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, ComCtrls, rxdbgrid,  ZDataset,
  dialogs, Grids, DBGrids, db,udm;

type

  { TfrmDic }

  TfrmDic = class(TFrame)
    RxDBGDic: TRxDBGrid;
    ToolBDic: TToolBar;
    ToolButton1: TToolButton;
    procedure ChangeDic(a_name_dic: String);
    procedure RxDBGDicDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure RxDBGDicSizeConstraintsChange(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private

  public

  end;

implementation

{$R *.lfm}

procedure TfrmDic.ChangeDic(a_name_dic: String);
var
  _tablename: String;
  _i: Integer;
begin
  if a_name_dic = 'Местность' then _tablename := 'dc_area';
  if a_name_dic = 'Документ' then _tablename := 'dc_document_type';
  if a_name_dic = 'Код категории льготы' then _tablename := 'dc_benefit';
  if a_name_dic = 'Семейное положение' then _tablename := 'dc_marital_status';
  if a_name_dic = 'Образование' then _tablename := 'dc_edication';
  if a_name_dic = 'Занятость' then _tablename := 'dc_employment';
  if a_name_dic = 'Группа крови' then _tablename := 'dc_blood_type';
  if a_name_dic = 'Инвалидность' then _tablename := 'dc_disability';
  if a_name_dic = 'Страховая медицинская организация' then _tablename := 'dc_insurance_company';
  if a_name_dic = 'Место работы' then _tablename := 'dc_job_company';
  if a_name_dic = 'Должность' then _tablename := 'dc_job_position';
  if _tablename <> '' then begin
    (RxDBGDic.DataSource.DataSet as TZTable).Active := false;
    (RxDBGDic.DataSource.DataSet as TZTable).TableName := _tablename;
    (RxDBGDic.DataSource.DataSet as TZTable).Active := True;
    // := True;
    for _i := 0 to RxDBGDic.Columns.Count -1 do
        if RxDBGDic.Columns[_i].Width > 300 then RxDBGDic.Columns[_i].Width := 300;
    RxDBGDic.ColumnByFieldName('id').ReadOnly:=true;
    //(RxDBGDic.DataSource.DataSet as TZTable).Edit;
    dm.zTdic.Edit;
  end;
end;


procedure TfrmDic.RxDBGDicDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.FieldName = 'id' then begin
    Column.Color := $00EEEEEE;
  end;

  RxDBGDic.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmDic.RxDBGDicSizeConstraintsChange(Sender: TObject);
begin

end;

procedure TfrmDic.ToolButton1Click(Sender: TObject);
begin
//  (RxDBGDic.DataSource.DataSet as TZTable).State := dsEdit;
  //(RxDBGDic.DataSource.DataSet as TZTable).Post;
  dm.zTdic.Edit;
  dm.zTdic.Post;
end;

end.


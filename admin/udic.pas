unit udic;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, ExtCtrls, ComCtrls, rxdbgrid,  ZDataset,
  dialogs, Grids, DBGrids, db, sqldb, ZAbstractDataset;

type

  { TfrmDic }

  TfrmDic = class(TFrame)
    DataSDic: TDataSource;
    ImageLDicMenu: TImageList;
    RxDBGDic: TRxDBGrid;
    ToolBDic: TToolBar;
    ToolBDicSave: TToolButton;
    ToolBDicAdd: TToolButton;
    ToolBDicDel: TToolButton;
    ToolBDicCancel: TToolButton;
    procedure ChangeDic(a_name_dic: String);
    procedure DataSDicUpdateData(Sender: TObject);
    procedure RxDBGDicDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ToolBDicAddClick(Sender: TObject);
    procedure ToolBDicCancelClick(Sender: TObject);
    procedure ToolBDicDelClick(Sender: TObject);
    procedure ToolBDicSaveClick(Sender: TObject);
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
  if a_name_dic = 'Роли' then _tablename := 'uroles';
  if _tablename <> '' then begin

    (RxDBGDic.DataSource.DataSet as TZTable).Active := false;
    (RxDBGDic.DataSource.DataSet as TZTable).TableName := _tablename;
    (RxDBGDic.DataSource.DataSet as TZTable).Active := True;
    ToolBDicCancel.Enabled := false;
    ToolBDicSave.Enabled := false;
    // := True;
{
    (RxDBGDic.DataSource.DataSet as TSQLQuery).Close;
    (RxDBGDic.DataSource.DataSet as TSQLQuery).SQL.Text := 'select * from ' + _tablename + ' order by id';
    (RxDBGDic.DataSource.DataSet as TSQLQuery).Open;
}
    for _i := 0 to RxDBGDic.Columns.Count -1 do
        if RxDBGDic.Columns[_i].Width > 300 then RxDBGDic.Columns[_i].Width := 300;
    RxDBGDic.ColumnByFieldName('id').ReadOnly:=true;
    //(RxDBGDic.DataSource.DataSet as TZTable).Edit;
  end;
end;

procedure TfrmDic.DataSDicUpdateData(Sender: TObject);
begin
  ToolBDicCancel.Enabled := true;
  ToolBDicSave.Enabled := true;
end;



procedure TfrmDic.RxDBGDicDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if RxDBGDic.DataSource.DataSet.Active then begin
    if Column.FieldName = 'id' then begin
      Column.Color := $00EEEEEE;
    end;
    RxDBGDic.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  end;
end;


procedure TfrmDic.ToolBDicAddClick(Sender: TObject);
begin
  (RxDBGDic.DataSource.DataSet as TZTable).Append;
end;

procedure TfrmDic.ToolBDicCancelClick(Sender: TObject);
begin
  (RxDBGDic.DataSource.DataSet as TZTable).Refresh;
  ToolBDicCancel.Enabled := false;
  ToolBDicSave.Enabled := false;
end;

procedure TfrmDic.ToolBDicDelClick(Sender: TObject);
begin
  (RxDBGDic.DataSource.DataSet as TZTable).Delete;
  ToolBDicCancel.Enabled := true;
  ToolBDicSave.Enabled := true;
end;

procedure TfrmDic.ToolBDicSaveClick(Sender: TObject);
begin
  (RxDBGDic.DataSource.DataSet as TZTable).ApplyUpdates;
  (RxDBGDic.DataSource.DataSet as TZTable).Refresh;
  ToolBDicCancel.Enabled := false;
  ToolBDicSave.Enabled := false;
end;



end.


unit cpatient;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db,udm,uerr;

type

  { TPatient }

  TPatient = class(TObject)
  private
    Faddress: String;
    Farea: String;
    Farea_id: integer;
    Fbenefit: String;
    Fbenefit_id: Integer;
    Fblood_type: String;
    Fblood_type_id: Integer;
    Fcreated_at: TDatetime;
    Fcreated_date: TDate;
    Fdeleted_at: TDatetime;
    Fdisability: String;
    Fdisability_id: Integer;
    Fdob: TDate;
    Fdocument_number: String;
    Fdocument_seria: String;
    Fdocument_type: String;
    Fdocument_type_id: Integer;
    Fedication: String;
    Fedication_id: Integer;
    Femployment: String;
    Femployment_id: Integer;
    Ffirstname: String;
    Fid: Int64;
    Finsurance_company: String;
    Finsurance_company_id: Integer;
    Fisdelete: Boolean;
    Fjob_company: String;
    Fjob_company_id: Integer;
    Fjob_position: String;
    Fjob_position_id: Integer;
    Flastname: String;
    Fmarital_status: String;
    Fmarital_status_id: Integer;
    Fmiddlename: String;
    Foms: String;
    Fphone: Int64;
    Fsaved: Boolean;
    Fsex: String;
    Fsnils: String;
    Fupdated_at: TDatetime;
    Fuser_id: Integer;
    procedure Setaddress(Value: String);
    procedure Setarea(Value: String);
    procedure Setarea_id(Value: integer);
    procedure Setbenefit(Value: String);
    procedure Setbenefit_id(Value: Integer);
    procedure Setblood_type(Value: String);
    procedure Setblood_type_id(Value: Integer);
    procedure Setcreated_at(Value: TDatetime);
    procedure Setcreated_date(Value: TDate);
    procedure Setdeleted_at(Value: TDatetime);
    procedure Setdisability(Value: String);
    procedure Setdisability_id(Value: Integer);
    procedure Setdob(Value: TDate);
    procedure Setdocument_number(Value: String);
    procedure Setdocument_seria(Value: String);
    procedure Setdocument_type(Value: String);
    procedure Setdocument_type_id(Value: Integer);
    procedure Setedication(Value: String);
    procedure Setedication_id(Value: Integer);
    procedure Setemployment(Value: String);
    procedure Setemployment_id(Value: Integer);
    procedure Setfirstname(Value: String);
    procedure Setid(Value: Int64);
    procedure Setinsurance_company(Value: String);
    procedure Setinsurance_company_id(Value: Integer);
    procedure Setisdelete(Value: Boolean);
    procedure Setjob_company(Value: String);
    procedure Setjob_company_id(Value: Integer);
    procedure Setjob_position(Value: String);
    procedure Setjob_position_id(Value: Integer);
    procedure Setlastname(Value: String);
    procedure Setmarital_status(Value: String);
    procedure Setmarital_status_id(Value: Integer);
    procedure Setmiddlename(Value: String);
    procedure Setoms(Value: String);
    procedure Setphone(Value: Int64);
    procedure Setsaved(Value: Boolean);
    procedure Setsex(Value: String);
    procedure Setsnils(Value: String);
    procedure Setupdated_at(Value: TDatetime);
    procedure Setuser_id(Value: Integer);
  published
    property id: Int64 read Fid write Setid;
    property created_date: TDate read Fcreated_date write Setcreated_date;
    property firstname: String read Ffirstname write Setfirstname;
    property lastname: String read Flastname write Setlastname;
    property middlename: String read Fmiddlename write Setmiddlename;
    property dob: TDate read Fdob write Setdob;
    property address: String read Faddress write Setaddress;
    property area_id: integer read Farea_id write Setarea_id;
    property oms: String read Foms write Setoms;
    property snils: String read Fsnils write Setsnils;
    property marital_status_id: Integer read Fmarital_status_id write Setmarital_status_id;
    property edication_id: Integer read Fedication_id write Setedication_id;
    property insurance_company_id: Integer read Finsurance_company_id write Setinsurance_company_id;
    property benefit_id: Integer read Fbenefit_id write Setbenefit_id;
    property document_type_id: Integer read Fdocument_type_id write Setdocument_type_id;
    property document_seria: String read Fdocument_seria write Setdocument_seria;
    property document_number: String read Fdocument_number write Setdocument_number;
    property employment_id: Integer read Femployment_id write Setemployment_id;
    property disability_id: Integer read Fdisability_id write Setdisability_id;
    property job_company_id: Integer read Fjob_company_id write Setjob_company_id;
    property job_position_id: Integer read Fjob_position_id write Setjob_position_id;
    property blood_type_id: Integer read Fblood_type_id write Setblood_type_id;
    property phone: Int64 read Fphone write Setphone;
    property created_at: TDatetime read Fcreated_at write Setcreated_at;
    property updated_at: TDatetime read Fupdated_at write Setupdated_at;
    property user_id: Integer read Fuser_id write Setuser_id;
    property deleted_at: TDatetime read Fdeleted_at write Setdeleted_at;
    property isdelete: Boolean read Fisdelete write Setisdelete;
    property sex: String read Fsex write Setsex;
    property area: String read Farea write Setarea;
    property marital_status: String read Fmarital_status write Setmarital_status;
    property edication: String read Fedication write Setedication;
    property document_type: String read Fdocument_type write Setdocument_type;
    property benefit: String read Fbenefit write Setbenefit;
    property insurance_company: String read Finsurance_company write Setinsurance_company;
    property employment: String read Femployment write Setemployment;
    property disability: String read Fdisability write Setdisability;
    property job_company: String read Fjob_company write Setjob_company;
    property job_position: String read Fjob_position write Setjob_position;
    property blood_type: String read Fblood_type write Setblood_type;
    property saved: Boolean read Fsaved write Setsaved;
  public
    function Read(a_id: Integer): Boolean;
    function Write(): Boolean;
    function Delete(): Boolean;

  end;

implementation

{ TPatient }

procedure TPatient.Setaddress(Value: String);
begin
  if Faddress = Value then Exit;
  Faddress := Value;
end;

procedure TPatient.Setarea(Value: String);
begin
  if Farea = Value then Exit;
  Farea := Value;
end;

procedure TPatient.Setarea_id(Value: integer);
begin
  if Farea_id = Value then Exit;
  Farea_id := Value;
end;

procedure TPatient.Setbenefit(Value: String);
begin
  if Fbenefit = Value then Exit;
  Fbenefit := Value;
end;

procedure TPatient.Setbenefit_id(Value: Integer);
begin
  if Fbenefit_id = Value then Exit;
  Fbenefit_id := Value;
end;

procedure TPatient.Setblood_type(Value: String);
begin
  if Fblood_type = Value then Exit;
  Fblood_type := Value;
end;

procedure TPatient.Setblood_type_id(Value: Integer);
begin
  if Fblood_type_id = Value then Exit;
  Fblood_type_id := Value;
end;

procedure TPatient.Setcreated_at(Value: TDatetime);
begin
  if Fcreated_at = Value then Exit;
  Fcreated_at := Value;
end;

procedure TPatient.Setcreated_date(Value: TDate);
begin
  if Fcreated_date = Value then Exit;
  Fcreated_date := Value;
end;

procedure TPatient.Setdeleted_at(Value: TDatetime);
begin
  if Fdeleted_at = Value then Exit;
  Fdeleted_at := Value;
end;

procedure TPatient.Setdisability(Value: String);
begin
  if Fdisability = Value then Exit;
  Fdisability := Value;
end;

procedure TPatient.Setdisability_id(Value: Integer);
begin
  if Fdisability_id = Value then Exit;
  Fdisability_id := Value;
end;

procedure TPatient.Setdob(Value: TDate);
begin
  if Fdob = Value then Exit;
  Fdob := Value;
end;

procedure TPatient.Setdocument_number(Value: String);
begin
  if Fdocument_number = Value then Exit;
  Fdocument_number := Value;
end;

procedure TPatient.Setdocument_seria(Value: String);
begin
  if Fdocument_seria = Value then Exit;
  Fdocument_seria := Value;
end;

procedure TPatient.Setdocument_type(Value: String);
begin
  if Fdocument_type = Value then Exit;
  Fdocument_type := Value;
end;

procedure TPatient.Setdocument_type_id(Value: Integer);
begin
  if Fdocument_type_id = Value then Exit;
  Fdocument_type_id := Value;
end;

procedure TPatient.Setedication(Value: String);
begin
  if Fedication = Value then Exit;
  Fedication := Value;
end;

procedure TPatient.Setedication_id(Value: Integer);
begin
  if Fedication_id = Value then Exit;
  Fedication_id := Value;
end;

procedure TPatient.Setemployment(Value: String);
begin
  if Femployment = Value then Exit;
  Femployment := Value;
end;

procedure TPatient.Setemployment_id(Value: Integer);
begin
  if Femployment_id = Value then Exit;
  Femployment_id := Value;
end;

procedure TPatient.Setfirstname(Value: String);
begin
  if Ffirstname = Value then Exit;
  Ffirstname := Value;
end;

procedure TPatient.Setid(Value: Int64);
begin
  if Fid = Value then Exit;
  Fid := Value;
end;

procedure TPatient.Setinsurance_company(Value: String);
begin
  if Finsurance_company = Value then Exit;
  Finsurance_company := Value;
end;

procedure TPatient.Setinsurance_company_id(Value: Integer);
begin
  if Finsurance_company_id = Value then Exit;
  Finsurance_company_id := Value;
end;

procedure TPatient.Setisdelete(Value: Boolean);
begin
  if Fisdelete = Value then Exit;
  Fisdelete := Value;
end;

procedure TPatient.Setjob_company(Value: String);
begin
  if Fjob_company = Value then Exit;
  Fjob_company := Value;
end;

procedure TPatient.Setjob_company_id(Value: Integer);
begin
  if Fjob_company_id = Value then Exit;
  Fjob_company_id := Value;
end;

procedure TPatient.Setjob_position(Value: String);
begin
  if Fjob_position = Value then Exit;
  Fjob_position := Value;
end;

procedure TPatient.Setjob_position_id(Value: Integer);
begin
  if Fjob_position_id = Value then Exit;
  Fjob_position_id := Value;
end;

procedure TPatient.Setlastname(Value: String);
begin
  if Flastname = Value then Exit;
  Flastname := Value;
end;

procedure TPatient.Setmarital_status(Value: String);
begin
  if Fmarital_status = Value then Exit;
  Fmarital_status := Value;
end;

procedure TPatient.Setmarital_status_id(Value: Integer);
begin
  if Fmarital_status_id = Value then Exit;
  Fmarital_status_id := Value;
end;

procedure TPatient.Setmiddlename(Value: String);
begin
  if Fmiddlename = Value then Exit;
  Fmiddlename := Value;
end;

procedure TPatient.Setoms(Value: String);
begin
  if Foms = Value then Exit;
  Foms := Value;
end;

procedure TPatient.Setphone(Value: Int64);
begin
  if Fphone = Value then Exit;
  Fphone := Value;
end;

procedure TPatient.Setsaved(Value: Boolean);
begin
  if Fsaved = Value then Exit;
  Fsaved := Value;
end;

procedure TPatient.Setsex(Value: String);
begin
  if Fsex = Value then Exit;
  Fsex := Value;
end;

procedure TPatient.Setsnils(Value: String);
begin
  if Fsnils = Value then Exit;
  Fsnils := Value;
end;

procedure TPatient.Setupdated_at(Value: TDatetime);
begin
  if Fupdated_at = Value then Exit;
  Fupdated_at := Value;
end;

procedure TPatient.Setuser_id(Value: Integer);
begin
  if Fuser_id = Value then Exit;
  Fuser_id := Value;
end;

function TPatient.Read(a_id: Integer): Boolean;
var
  _sql: String;
  _q: TDataSet;
begin
  result := true;
  id := a_id;
  if a_id = -1 then exit;
  _sql := 'select p.* ' +
          ', cast(ar.code || '' - '' || ar.nam as varchar(255)) as area ' +
          ', cast(ms.code || '' - '' || ms.nam as varchar(255)) as marital_status ' +
          ', cast(e.code || '' - '' || e.nam as varchar(255)) as edication ' +
          ', cast(dt.code || '' - '' || dt.nam as varchar(255)) as document_type ' +
          ', cast(b.code || '' - '' || b.nam as varchar(255)) as benefit ' +
          ', cast(ic.nam as varchar(255)) as insurance_company ' +
          ', cast(emp.code || '' - '' || emp.nam as varchar(255)) as employment ' +
          ', cast(da.code || '' - '' || da.nam as varchar(255)) as disability ' +
          ', cast(jc.nam as varchar(255)) as job_company ' +
          ', cast(jp.nam as varchar(255)) as job_position ' +
          ', cast(bt.category || '' - '' || bt.factor as varchar(255)) as blood_type ' +
          ' from patients p ' +
          ' join dc_area ar on ar.id = p.area_id ' +
          ' join dc_document_type dt on dt.id = p.document_type_id ' +
          ' left join dc_benefit b on b.id = p.benefit_id ' +
          ' left join dc_insurance_company ic on ic.id = p.insurance_company_id ' +
          ' left join dc_employment emp on emp.id = p.employment_id ' +
          ' left join dc_marital_status ms on ms.id = p.marital_status_id ' +
          ' left join dc_edication e on e.id = p.edication_id ' +
          ' left join dc_job_company jc on jc.id = p.job_company_id ' +
          ' left join dc_job_position jp on jp.id = p.job_position_id ' +
          ' left join dc_disability da on da.id = p.disability_id ' +
          ' left join dc_blood_type bt on bt.id = p.blood_type_id ' +
          ' where id = ' + IntToStr(id);
  _q := dm.Read(_sql);
  if not Assigned(_q) then exit;
  if _q.RecordCount > 0 then begin
    id := _q.FieldByName('id').AsInteger;
    address := _q.FieldByName('address').AsString;
    area := _q.FieldByName('area').AsString;
    area_id := _q.FieldByName('area_id').AsInteger;
    benefit := _q.FieldByName('benefit').AsString;
    benefit_id := _q.FieldByName('benefit_id').AsInteger;
    blood_type := _q.FieldByName('blood_type').AsString;
    blood_type_id := _q.FieldByName('blood_type_id').AsInteger;
    created_at := _q.FieldByName('created_at').AsDateTime;
    created_date := _q.FieldByName('created_date').AsDateTime;
    deleted_at := _q.FieldByName('deleted_at').AsDateTime;
    disability := _q.FieldByName('disability').AsString;
    disability_id := _q.FieldByName('disability_id').AsInteger;
    dob := _q.FieldByName('dob').AsDateTime;
    document_number := _q.FieldByName('document_number').AsString;
    document_seria := _q.FieldByName('document_seria').AsString;
    document_type := _q.FieldByName('document_type').AsString;
    document_type_id := _q.FieldByName('document_type_id').AsInteger;
    edication := _q.FieldByName('edication').AsString;
    edication_id := _q.FieldByName('edication_id').AsInteger;
    employment := _q.FieldByName('employment').AsString;
    employment_id := _q.FieldByName('employment_id').AsInteger;
    firstname := _q.FieldByName('firstname').AsString;
    insurance_company := _q.FieldByName('insurance_company').AsString;
    insurance_company_id := _q.FieldByName('insurance_company_id').AsInteger;
    isdelete := _q.FieldByName('isdelete').AsBoolean;
    job_company := _q.FieldByName('job_company').AsString;
    job_company_id := _q.FieldByName('job_company_id').AsInteger;
    job_position := _q.FieldByName('job_position').AsString;
    job_position_id := _q.FieldByName('job_position_id').AsInteger;
    lastname := _q.FieldByName('lastname').AsString;
    marital_status := _q.FieldByName('marital_status').AsString;
    marital_status_id := _q.FieldByName('marital_status_id').AsInteger;
    middlename := _q.FieldByName('middlename').AsString;
    oms := _q.FieldByName('oms').AsString;
    phone := _q.FieldByName('phone').AsInteger;
    sex := _q.FieldByName('sex').AsString;
    snils := _q.FieldByName('snils').AsString;
    updated_at := _q.FieldByName('updated_at').AsDateTime;
    user_id := _q.FieldByName('user_id').AsInteger;
  end;
  _q.Close;
end;

function TPatient.Write(): Boolean;
var
  _sql: String;
begin
  if id = -1 then begin
    _sql := 'INSERT INTO public.patients(created_date, firstname, lastname, ' +
            'middlename, sex, dob, address, area_id, oms, snils, marital_status_id, ' +
            'edication_id, insurance_company_id, benefit_id, document_type_id, ' +
            'document_seria, document_number, employment_id, disability_id, ' +
            'job_company_id, job_position_id, blood_type_id, phone, user_id)	VALUES (';

  end;
end;

function TPatient.Delete(): Boolean;
var
  _sql: String;
begin
  if id  < 0 then exit;
  _sql := 'update patients set deleted_at = now(), isdelete = true where id = ' + IntToStr(id);
  saved := dm.SQLExecZ(_sql) ;
end;

end.


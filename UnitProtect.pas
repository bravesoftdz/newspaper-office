unit UnitProtect;

interface

uses
  SysUtils, Classes, BoldSubscription, BoldHandles, BoldRootedHandles,
  BoldExpressionHandle;

type
  TProtectDM = class(TDataModule)
    behACount: TBoldExpressionHandle;
    behSectCount: TBoldExpressionHandle;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetDisableDEMO: Boolean;
    function CheckProtect: Boolean;
  end;

var
  ProtectDM: TProtectDM;
  DEMOCaption: string='���� ������ - ����� ���������� ���������� �� 50! ����� �������� �� 20 - ��! ���� ��������� ��������� �����������!';
  EnableProtect: Boolean=False;
  EnableDatesProtect: Boolean=False;
  StartProtectDate: string='03.06.2006';
  EndProtectDate: string='07.06.2006';

implementation

{$R *.dfm}

uses ModelDM, DateUtils, Dialogs;

function TProtectDM.GetDisableDEMO: Boolean;
var res: Boolean;
begin
  res:=False;
  if EnableProtect then
    begin
      if (((Today>StrToDate(EndProtectDate)) or (Today<StrToDate(StartProtectDate))) and EnableDatesProtect)
        or (Integer(behACount.Value.GetAsVariant)>50)
        or (Integer(behSectCount.Value.GetAsVariant)>20)
        then
          begin
            res:=True;
          end;
    end;
   Result:=
     res;
end;

function TProtectDM.CheckProtect: Boolean;
var res: Boolean;
begin
  res:=False;
  if ModelDM.BoldModelDM.bsh.Active then
   if GetDisableDEMO then
    begin
      res:=True;
      ShowMessage('���� ������ DEMO-������ ����!'+DEMOCaption);
    end;
  Result:=
    res;
end;

end.

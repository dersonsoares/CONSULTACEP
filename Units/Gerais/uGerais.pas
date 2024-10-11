unit uGerais;

interface

uses
  System.SysUtils, FMX.Edit;

const
  cLOGRADOURO = 0;
  cBAIRRO     = 1;
  cLOCALIDADE = 2;
  cESTADO     = 3;

function SomenteNumero(str: string): string;
function ValidaCEP(pCEP: String): Boolean;
procedure Formatar(Obj: TObject);
function Mask(Mascara, Str : string) : string;

implementation

function SomenteNumero(str: string): string;
var
  x : integer;
begin
  Result := '';
  for x := 0 to Length(str) - 1 do
    if (str.Chars[x] In ['0'..'9']) then
      Result := Result + str.Chars[x];
end;

function ValidaCEP(pCEP: String): Boolean;
const
  INVALID_CHARACTER = -1;
begin
  Result := True;
  if pCEP.Trim.Length <> 8 then
    Exit(False);
  if StrToIntDef(pCEP, INVALID_CHARACTER) = INVALID_CHARACTER then
    Exit(False);
end;

procedure Formatar(Obj: TObject);
var
  texto : string;
begin
  if obj is TEdit then
    texto := TEdit(obj).Text;

  texto := Mask('##.###-###', SomenteNumero(texto));

  if obj is TEdit then
  begin
    TEdit(obj).Text := texto;
    TEdit(obj).CaretPosition := TEdit(obj).Text.Length;
  end;
end;

function Mask(Mascara, Str: string): string;
var
  x, p : integer;
begin
  p := 0;
  Result := '';

  if Str.IsEmpty then
    exit;

  for x := 0 to Length(Mascara) - 1 do
  begin
    if Mascara.Chars[x] = '#' then
    begin
      Result := Result + Str.Chars[p];
      inc(p);
    end
    else
      Result := Result + Mascara.Chars[x];

    if p = Length(Str) then
      break;
  end;
end;

end.

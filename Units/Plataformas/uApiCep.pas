unit uApiCep;

interface

uses uBuscaCep_Geral, uEnderecoGeral, System.SysUtils;

type
  TApiCepDados = class

    private
      Fdistrict: String;
      Fok: Boolean;
      Fcode: String;
      FMessage: String;
      Fstate: String;
      FstatusText: String;
      Fstatus: Integer;
      Faddress: String;
      Fcity: String;

    public
      property status     : Integer read Fstatus     write Fstatus;
      property ok         : Boolean read Fok         write Fok;
      property code       : String  read Fcode       write Fcode;
      property state      : String  read Fstate      write Fstate;
      property city       : String  read Fcity       write Fcity;
      property district   : String  read Fdistrict   write Fdistrict;
      property address    : String  read Faddress    write Faddress;
      property statusText : String  read FstatusText write FstatusText;
      property Message    : String  read FMessage    write FMessage;
  end;


type
  TApiCep = class(TBuscaCEP_Geral)
    public
      function GetCep(pCep: string) : TEnderecoGeral; override;
      constructor Create;
  end;

implementation

{ TApiCep }

constructor TApiCep.Create;
begin
  FUrl := 'https://ws.apicep.com/cep/';
end;

function TApiCep.GetCep(pCep: string): TEnderecoGeral;
var
  vdadosApi : TApiCepDados;
begin
  Result    := nil;
  pCep      := StringReplace(Trim(pCep), '.', '', [rfReplaceAll, rfIgnoreCase]);
  FUrl := FUrl + pCep + '.json';

  try
    vdadosApi := BuscaDadosCep<TApiCepDados>();

    if (vdadosApi <> nil) then
    begin
      if (vdadosApi.status = 200) then
      begin
        Result            := TEnderecoGeral.Create;
        Result.Cep        := vdadosApi.Fcode;
        Result.Logradouro := vdadosApi.address;
        Result.Bairro     := vdadosApi.district;
        Result.Localidade := vdadosApi.city;
        Result.Estado     := vdadosApi.state;
      end
      else if (vdadosApi.status = 404) then
        raise Exception.Create(vdadosApi.message);
    end;
  except
    on E : Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.

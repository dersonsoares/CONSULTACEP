unit uAwesome;

interface

uses uBuscaCEP_Geral, uEnderecoGeral, System.SysUtils;

type
  TAwesomeDados = class

    private
      Fdistrict: String;
      Faddress_type: String;
      Fcode: String;
      Fddd: String;
      Fmessage: String;
      Fstate: String;
      Flat: String;
      Faddress_name: String;
      FCEP: String;
      Fcity_ibge: String;
      Fstatus: Integer;
      Flng: String;
      Fcity: String;
      Faddress: String;

    public
      property CEP          : String  read FCEP          write FCEP;
      property address_type : String  read Faddress_type write Faddress_type;
      property address_name : String  read Faddress_name write Faddress_name;
      property address      : String  read Faddress      write Faddress;
      property state        : String  read Fstate        write Fstate;
      property district     : String  read Fdistrict     write Fdistrict;
      property lat          : String  read Flat          write Flat;
      property lng          : String  read Flng          write Flng;
      property city         : String  read Fcity         write Fcity;
      property city_ibge    : String  read Fcity_ibge    write Fcity_ibge;
      property ddd          : String  read Fddd          write Fddd;
      property status       : Integer read Fstatus       write Fstatus;
      property code         : String  read Fcode         write Fcode;
      property message      : String  read Fmessage      write Fmessage;
  end;


type
  TAwesome = class(TBuscaCEP_Geral)

    private

    protected

    public
      function GetCep(pCep: string) : TEnderecoGeral; override;

      constructor Create;
  end;

implementation

{ TAwesomeApi }

constructor TAwesome.Create;
begin
  FUrl := 'https://cep.awesomeapi.com.br/json/';
end;

function TAwesome.GetCep(pCep: string): TEnderecoGeral;
var
  vdadosApi : TAwesomeDados;
  vCep      : String;
begin
  Result    := nil;
  vCep      := StringReplace(Trim(pCep), '-', '', [rfReplaceAll, rfIgnoreCase]);
  vCep      := StringReplace(Trim(vCep), '.', '', [rfReplaceAll, rfIgnoreCase]);
  self.FUrl := self.FUrl + vCep;

  try
    vdadosApi := self.BuscaDadosCep<TAwesomeDados>();

    if (vdadosApi <> nil) then
    begin
      if (self.Status = 200) then
      begin
        Result            := TEnderecoGeral.Create;
        Result.Cep        := vdadosApi.cep;
        Result.Logradouro := vdadosApi.address;
        Result.Bairro     := vdadosApi.district;
        Result.Localidade := vdadosApi.city;
        Result.Estado     := vdadosApi.state;
      end
      else if (self.Status = 404) then
        raise Exception.Create(vdadosApi.message);
    end;
  except
    on E : Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.

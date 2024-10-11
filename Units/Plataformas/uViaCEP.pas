unit uViaCEP;

interface

uses uBuscaCEP_Geral, uEnderecoGeral, System.SysUtils;

type
  TViaCepDados = class

    private
      FLogradouro: string;
      FBairro: string;
      FUF: string;
      FCEP: string;
      FLocalidade: string;
      FCodIBGE: string;
      FErro: Boolean;

    protected

    public
      property CEP         : string  read FCEP         write FCEP;
      property Logradouro  : string  read FLogradouro  write FLogradouro;
      property Bairro      : string  read FBairro      write FBairro;
      property Localidade  : string  read FLocalidade  write FLocalidade;
      property UF          : string  read FUF          write FUF;
      property CodIBGE     : string  read FCodIBGE     write FCodIBGE;
      property Erro        : Boolean read FErro        write FErro;
    end;

type
  TViaCep = class(TBuscaCEP_Geral)
    public
      function GetCep(pCep: string) : TEnderecoGeral; override;
      constructor Create;
  end;

implementation

{ TViaCep }

constructor TViaCep.Create;
begin
  FURL := 'https://viacep.com.br/ws/';
end;

function TViaCep.GetCep(pCep: string): TEnderecoGeral;
var
  vDados : TViaCepDados;
  vCep   : String;
begin
  Result     := nil;
  vCep       := StringReplace(Trim(pCep), '-', '', [rfReplaceAll, rfIgnoreCase]);
  vCep       := StringReplace(Trim(vCep), '.', '', [rfReplaceAll, rfIgnoreCase]);
  self.FUrl  := self.FUrl + vCep + '/json/';

  try
    vDados  := BuscaDadosCep<TViaCepDados>();

    if (vDados <> nil) then
    begin
      if (not vDados.Erro) then
      begin
        Result            := TEnderecoGeral.Create;
        Result.Cep        := vDados.cep;
        Result.Logradouro := vDados.logradouro;
        Result.Bairro     := vDados.bairro;
        Result.Localidade := vDados.localidade;
        Result.Estado     := vDados.uf;
      end
      else
        raise Exception.Create('CEP não encontrado.');
    end;
  except
    on E : Exception do
      raise Exception.Create(E.Message);
  end;
end;

end.

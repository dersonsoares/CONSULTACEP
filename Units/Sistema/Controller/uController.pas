unit uController;

interface

uses System.SysUtils, System.Classes, uGerais,
     uEnderecoGeral, uBuscarCEPService, Vcl.Forms, Winapi.Windows;

type
  TEnderecoController = class

    private
      FEndereco         : TEnderecoGeral;
      FBuscarCEPService : TBuscarCEPService;
    protected

    public
      procedure PesquisarCEP(pCep : string; Endereco: TStringList);

  end;

implementation

{ TEnderecoController }

procedure TEnderecoController.PesquisarCEP(pCep: string; Endereco: TStringList);
begin
  try
    try
      FBuscarCEPService := TBuscarCEPService.Create;

      FEndereco := FBuscarCEPService.getCepDados(pCep);

      if (FEndereco <> nil) then
      begin
        Endereco.Add(FEndereco.Logradouro);
        Endereco.Add(FEndereco.Bairro);
        Endereco.Add(FEndereco.Localidade);
        Endereco.Add(FEndereco.Estado);
      end;
    except
      on E : Exception do
        Application.MessageBox(PWideChar(E.Message), PWideChar(Application.Title), MB_OK + MB_ICONWARNING);
    end;
  finally
    FreeAndNil(FBuscarCEPService);
    FreeAndNil(FEndereco);
  end;
end;

end.

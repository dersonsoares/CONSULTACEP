unit uBuscarCEPService;

interface

uses System.SysUtils, uEnderecoGeral, uICep, uService;

type
   TBuscarCEPService = class
   private
     FApiCep   : ICep;
     FService  : TService;
   public
     function getCepDados(pCep : string) : TEnderecoGeral;
   end;

implementation

{ TBuscarCEPService }

function TBuscarCEPService.getCepDados(pCep: string): TEnderecoGeral;
begin
  Result := nil;
  FService := TService.Create;

  {  ========================================
              Busca primeiro na ViaCEP
     ======================================== }
  FApiCep  := FService.getService(taViaCep);

  try
    try
      Result := FApiCep.GetCep(pCep);

      if (Result = nil) then
      begin
        {  ========================================
              Caso não retorne, Busca na APICEP
           ======================================== }
        if Assigned(FApiCep) then
          FApiCep := nil;

        FApiCep := FService.getService(taApiCep);
        Result  := FApiCep.GetCep(pCep);
      end;

      if (Result = nil) then
      begin
        {  ========================================
              Caso não retorne, Busca na Awesome
           ======================================== }
        if Assigned(self.FApiCep) then
          self.FApiCep := nil;

        self.FApiCep := FService.getService(taAwesomeApi);
        Result       := FApiCep.GetCep(pCep);
      end;
    except
      on E : Exception do
        raise Exception.Create(e.Message);
    end;
  finally
    FApiCep := nil;
    FreeAndNil(FService);
  end;
end;

end.

unit uBuscaCEP_Geral;

interface

uses
  UICEP, uEnderecoGeral, REST.Client, REST.JSON, Generics.Collections, JSON,
  System.SysUtils, System.Variants;

type
  TBuscaCEP_Geral = class abstract(TInterfacedObject, ICep)

    private

    protected
      FRESTClient   : TRESTClient;
      FRESTRequest  : TRESTRequest;
      FRESTResponse : TRESTResponse;

      FURL          : string;
      FStatus       : Integer;

      function BuscaDadosCep<A: class, constructor>() : A;
      function GetCep(pCep: string) : TEnderecoGeral; virtual; abstract;
    public
      property Status : integer read FStatus;
  end;

implementation

{ TBuscaCEP_Geral }

function TBuscaCEP_Geral.BuscaDadosCep<A>: A;
var
  vJSONValue : TJSONValue;
begin
  FRESTClient   := TRESTClient.Create(nil);
  FRESTRequest  := TRESTRequest.Create(nil);
  FRESTResponse := TRESTResponse.Create(nil);

  FRESTRequest.Client   := FRESTClient;
  FRESTRequest.Response := FRESTResponse;
  FRESTClient.BaseURL   := FURL;

  try
    try
      FRESTRequest.Execute;
      FStatus     := FRESTResponse.StatusCode;
      vJSONValue  := FRESTResponse.JSONValue;
      Result      := TJSON.JsonToObject<A>(vJSONValue.ToString);
    except
      on E : Exception do
      begin
        FStatus    := FRESTResponse.StatusCode;
        vJSONValue := FRESTResponse.JSONValue;

        if not Assigned(vJSONValue) then
          Result := nil
        else
          Result := TJSON.JsonToObject<A>(vJSONValue.ToString);
      end;
    end;
  finally
    FreeAndNil(FRESTClient);
    FreeAndNil(FRESTRequest);
    FreeAndNil(FRESTResponse);
  end;
end;

end.

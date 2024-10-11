unit uEnderecoGeral;

interface

  type
    TEnderecoGeral = class
      private
        FCep        : String;
        FLogradouro : String;
        FBairro     : String;
        FLocalidade : String;
        FEstado     : String;
        FCodIBGE    : String;

        function getBairro: String;
        function getCEP: String;
        function getCodIBGE: String;
        function getEstado: String;
        function getLocalidade: String;
        function getLogradouro: String;

        procedure setBairro(const Value: String);
        procedure setCEP(const Value: String);
        procedure setCodIBGE(const Value: String);
        procedure setEstado(const Value: String);
        procedure setLocalidade(const Value: String);
        procedure setLogradouro(const Value: String);

      public
        property CEP        : String read getCEP        write setCEP;
        property Logradouro : String read getLogradouro write setLogradouro;
        property Bairro     : String read getBairro     write setBairro;
        property Localidade : String read getLocalidade write setLocalidade;
        property Estado     : String read getEstado     write setEstado;
        property CodIBGE    : String read getCodIBGE    write setCodIBGE;
    end;

implementation

{ TEndereco }

function TEnderecoGeral.getBairro: String;
begin
  Result := FBairro;
end;

function TEnderecoGeral.getCEP: String;
begin
  Result := FCep;
end;

function TEnderecoGeral.getCodIBGE: String;
begin
  Result := FCodIBGE;
end;

function TEnderecoGeral.getEstado: String;
begin
  Result := FEstado;
end;

function TEnderecoGeral.getLocalidade: String;
begin
  Result := FLocalidade;
end;

function TEnderecoGeral.getLogradouro: String;
begin
  Result := FLogradouro;
end;

procedure TEnderecoGeral.setBairro(const Value: String);
begin
  FBairro := value;
end;

procedure TEnderecoGeral.setCEP(const Value: String);
begin
  FCep := value;
end;

procedure TEnderecoGeral.setCodIBGE(const Value: String);
begin
  FCodIBGE := value;
end;

procedure TEnderecoGeral.setEstado(const Value: String);
begin
  FEstado := value;
end;

procedure TEnderecoGeral.setLocalidade(const Value: String);
begin
  FLocalidade := value;
end;

procedure TEnderecoGeral.setLogradouro(const Value: String);
begin
  FLogradouro := value;
end;

end.

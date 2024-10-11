unit uService;

interface

uses uICEP, uViaCep, uApiCep, uAwesome, System.SysUtils;

type
  TTipoAPI = (taViaCep, taApiCep, taAwesomeApi);

type
  TService = class

    private
      FViaCepApi  : TViaCep;
      FApiCepApi  : TApiCep;
      FAwesomeApi : TAwesome;
    public
      function getService(pTipoApi : TTipoAPI) : ICep;
  end;

implementation

{ TFactoryApiCep }

function TService.getService(pTipoApi: TTipoAPI): ICep;
begin
  case Ord(pTipoApi) of
    0: begin
       self.FViaCepApi := TViaCep.Create;
       Result          := self.FViaCepApi;
    end;
    1: begin
       self.FApiCepApi := TApiCep.Create;
       Result          := self.FApiCepApi;
    end;
    2: begin
       self.FAwesomeApi := TAwesome.Create;
       Result           := self.FAwesomeApi;
    end;
  end;
end;

end.

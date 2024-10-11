unit uICEP;

interface

uses uEnderecoGeral;

type
  ICep = interface
  ['{95C86DC3-E223-4F27-9322-AE31A02EBC2D}']

    function GetCep(pCep: string) : TEnderecoGeral;
  end;

implementation

end.

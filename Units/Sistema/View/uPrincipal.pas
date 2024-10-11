unit uPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, IdHTTP, IdSSLOpenSSL,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts, uController;

type
  TfrmPrincipal = class(TForm)
    Rectangle3: TRectangle;
    Image1: TImage;
    Layout1: TLayout;
    Layout5: TLayout;
    Rectangle1: TRectangle;
    Image2: TImage;
    Rectangle2: TRectangle;
    Label2: TLabel;
    edtCep: TEdit;
    lblEndereco: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure rectBuscaClick(Sender: TObject);
    procedure edtCepTyping(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    Controller : TEnderecoController;
    ListaEndereco : TStringList;
    FRetorno: String;
    procedure SetCEP;
    procedure AbrirQuestao(pQuestao: Integer);
    { Private declarations }
  public
    { Public declarations }
    property Retorno : String read FRetorno write FRetorno;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uGerais, uQuestoes;

{$R *.fmx}

procedure TfrmPrincipal.AbrirQuestao(pQuestao: Integer);
begin
  frmQuestoes := TfrmQuestoes.Create(nil);
  try
    frmQuestoes.Questao:= IntToStr(pQuestao);
    frmQuestoes.ShowModal;
  finally
    FreeAndNil(frmQuestoes);
  end;
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  AbrirQuestao(TButton(Sender).Tag);
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
  AbrirQuestao(TButton(Sender).Tag);
end;

procedure TfrmPrincipal.edtCepTyping(Sender: TObject);
begin
  Formatar(edtCEP);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Controller := TEnderecoController.Create;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  edtCep.SetFocus;
end;


procedure TfrmPrincipal.rectBuscaClick(Sender: TObject);
begin
  try
    ListaEndereco := TStringList.Create;
    Controller.PesquisarCEP(edtCep.Text, ListaEndereco);
    if ListaEndereco.Count > 0 then
      SetCEP;
  finally
    FreeAndNil(ListaEndereco);
  end;
end;

procedure TfrmPrincipal.SetCEP;
begin
  lblEndereco.Text := 'End: '       + ListaEndereco[cLOGRADOURO] + sLineBreak +
                      'Bairro: '    + ListaEndereco[cBAIRRO] + sLineBreak +
                      'Cidade: '    + ListaEndereco[cLOCALIDADE] + sLineBreak +
                      'UF: '        + ListaEndereco[cESTADO];
end;

end.

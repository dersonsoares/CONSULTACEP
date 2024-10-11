unit uQuestoes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.WebBrowser,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TfrmQuestoes = class(TForm)
    lblTitulo: TLabel;
    wbrRespostas: TWebBrowser;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FQuestao: String;
    { Private declarations }
    procedure CarregaQuestao(nQuestao : Integer);
  public
    { Public declarations }
    property Questao : String read FQuestao write FQuestao;
  end;

var
  frmQuestoes: TfrmQuestoes;

implementation

{$R *.fmx}

procedure TfrmQuestoes.CarregaQuestao(nQuestao: Integer);
var
  FilePath: String;
begin
  FilePath := ExtractFileDir(GetCurrentDir) + '\Questoes\Questao' + IntToStr(nQuestao) + '.html';
  if FileExists(FilePath) then
  begin
    wbrRespostas.Navigate(FilePath);
  end;
end;

procedure TfrmQuestoes.FormCreate(Sender: TObject);
var
  FormWidth: Integer;
begin
  FormWidth := Self.Width; // Acesso à largura do formulário
  ShowMessage('A largura do formulário é: ' + IntToStr(FormWidth));
end;

procedure TfrmQuestoes.FormShow(Sender: TObject);
begin
  lblTitulo.Text := 'Questão ' + FQuestao;
  CarregaQuestao(StrToInt(FQuestao));
end;

end.

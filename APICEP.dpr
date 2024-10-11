program APICEP;

uses
  System.StartUpCopy,
  FMX.Forms,
  uEnderecoGeral in 'Units\Sistema\Model\uEnderecoGeral.pas',
  uICEP in 'Units\Plataformas\uICEP.pas',
  uBuscaCEP_Geral in 'Units\Plataformas\uBuscaCEP_Geral.pas',
  uViaCEP in 'Units\Plataformas\uViaCEP.pas',
  uAwesome in 'Units\Plataformas\uAwesome.pas',
  uApiCep in 'Units\Plataformas\uApiCep.pas',
  uService in 'Units\Plataformas\Service\uService.pas',
  uBuscarCEPService in 'Units\Plataformas\uBuscarCEPService.pas',
  uController in 'Units\Sistema\Controller\uController.pas',
  uGerais in 'Units\Gerais\uGerais.pas',
  uPrincipal in 'Units\Sistema\View\uPrincipal.pas' {frmPrincipal},
  uQuestoes in 'Units\Sistema\View\uQuestoes.pas' {frmQuestoes};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

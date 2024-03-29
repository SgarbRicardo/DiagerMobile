program Server;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {frmPrincipal},
  UnitDM in 'UnitDM.pas' {dm: TDataModule},
  cUsuario in 'Classes\cUsuario.pas',
  cPerfil in 'Classes\cPerfil.pas',
  cEmprestimo in 'Classes\cEmprestimo.pas',
  cNotificacao in 'Classes\cNotificacao.pas',
  cSuporte in 'Classes\cSuporte.pas',
  cChat in 'Classes\cChat.pas',
  uFunctions in '..\Units\uFunctions.pas',
  cTask in 'Classes\cTask.pas',
  cCategoria in 'Classes\cCategoria.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

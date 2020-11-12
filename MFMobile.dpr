program MFMobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  unitLogin in 'unitLogin.pas' {frmLogin},
  uMD5 in 'Units\uMD5.pas',
  unitInventario in 'unitInventario.pas' {frmInventario},
  u99Permissions in 'u99Permissions.pas',
  unitInventarioCad in 'unitInventarioCad.pas' {frmInventarioCad},
  unitCategorias in 'unitCategorias.pas' {frmCategorias},
  unitPrincipal in 'unitPrincipal.pas' {frmMainscreen},
  uFunctions in 'Units\uFunctions.pas',
  untDM in 'untDM.pas' {dm: TDataModule},
  cCategoria in 'Classes\cCategoria.pas',
  unitCategoriasCad in 'unitCategoriasCad.pas' {frmCadastroCategoria},
  unitSincronizar in 'unitSincronizar.pas' {frmSincronizar},
  cEmprestimo in 'Classes\cEmprestimo.pas',
  unitCarregaEquipamento in 'unitCarregaEquipamento.pas' {frmCarregaEquipamento},
  cEquipamento in 'Classes\cEquipamento.pas',
  cUsuario in 'Classes\cUsuario.pas',
  unitCarregarUsuario in 'unitCarregarUsuario.pas' {frmCarregarUsuario},
  unitDadosUsuario in 'unitDadosUsuario.pas' {frmDadosUsuario},
  unitChat in 'unitChat.pas' {frmChat};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := FALSE;
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.

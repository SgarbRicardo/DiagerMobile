program MFMobile;

uses
  System.StartUpCopy,
  FMX.Forms,
  unitLogin in 'unitLogin.pas' {frmLogin},
  uMD5 in 'Units\uMD5.pas',
  unitInventarioCad in 'unitInventarioCad.pas' {frmInventarioCad},
  unitCategorias in 'unitCategorias.pas' {frmCategorias},
  unitPrincipal in 'unitPrincipal.pas' {frmMainscreen},
  untDM in 'untDM.pas' {dm: TDataModule},
  cCategoria in 'Classes\cCategoria.pas',
  cEmprestimo in 'Classes\cEmprestimo.pas',
  cEquipamento in 'Classes\cEquipamento.pas',
  cUsuario in 'Classes\cUsuario.pas',
  unitNotificacao in 'unitNotificacao.pas' {frmNotification},
  uFunctions in 'Units\uFunctions.pas',
  unitTestQuality in 'unitTestQuality.pas' {frmTestQuality},
  unitFrameCategory in 'unitFrameCategory.pas' {Frame_Categoria: TFrame},
  uLoading in 'Units\uLoading.pas',
  unitInventario in 'unitInventario.pas' {frmInventario},
  u99Permissions in '..\..\..\..\Downloads\FontesMarketplace29\Fontes\Units\u99Permissions.pas',
  uSuperChart in 'Units\uSuperChart.pas',
  unitDashBoard in 'unitDashBoard.pas' {frmDashBoard},
  unitFrameVehicles in 'unitFrameVehicles.pas' {frameVehicle: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := FALSE;
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.

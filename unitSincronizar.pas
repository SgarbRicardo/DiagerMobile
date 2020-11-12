unit unitSincronizar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TfrmSincronizar = class(TForm)
    lytMenuTop: TLayout;
    lblTitulo: TLabel;
    imgVoltar: TImage;
    rectMenuInferior: TRectangle;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    lblInventario: TLabel;
    Layout5: TLayout;
    Image4: TImage;
    lblSincronizaBtn: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    procedure imgVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSincronizar: TfrmSincronizar;

implementation

{$R *.fmx}

procedure TfrmSincronizar.imgVoltarClick(Sender: TObject);
begin
    Close;
end;

end.

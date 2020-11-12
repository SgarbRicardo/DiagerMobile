unit unitDadosUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TfrmDadosUsuario = class(TForm)
    lytMenuTop: TLayout;
    Label1: TLabel;
    CircleUser: TCircle;
    Image1: TImage;
    imgNotification: TImage;
    lytPrincipal: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDadosUsuario: TfrmDadosUsuario;

implementation

{$R *.fmx}

end.

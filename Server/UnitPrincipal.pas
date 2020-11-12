unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uDWAbout,
  uRESTDWBase, FMX.StdCtrls, FMX.Controls.Presentation, UnitDM;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Switch1: TSwitch;
    RESTServicePooler: TRESTServicePooler;
    procedure Switch1Switch(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
    RESTServicePooler.ServerMethodClass := Tdm;
    RESTServicePooler.Active := Switch1.IsChecked;
end;

procedure TForm1.Switch1Switch(Sender: TObject);
begin
      RESTServicePooler.Active := Switch1.IsChecked;
end;

end.

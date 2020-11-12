unit unitNotificacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ScrollBox, FMX.Memo,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TfrmNotification = class(TForm)
    lytMenuTop: TLayout;
    Label1: TLabel;
    Image1: TImage;
    rectContact: TRectangle;
    c_Foto: TCircle;
    Label2: TLabel;
    ListView1: TListView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNotification: TfrmNotification;

implementation

{$R *.fmx}

procedure TfrmNotification.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := TCloseAction.caFree;
     frmNotification := nil;
end;

end.

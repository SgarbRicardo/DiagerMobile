unit unitChat;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ScrollBox, FMX.Memo,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TfrmChat = class(TForm)
    lytMenuTop: TLayout;
    Label1: TLabel;
    CircleUser: TCircle;
    Image1: TImage;
    rectContact: TRectangle;
    c_Foto: TCircle;
    Label2: TLabel;
    rectMessage: TRectangle;
    imgSend: TImage;
    Rectangle1: TRectangle;
    Memo1: TMemo;
    ListView1: TListView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChat: TfrmChat;

implementation

{$R *.fmx}

procedure TfrmChat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := TCloseAction.caFree;
     frmChat := nil;
end;

end.

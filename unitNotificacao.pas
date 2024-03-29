unit unitNotificacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ScrollBox, FMX.Memo,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, unitPrincipal;

type
  TfrmNotification = class(TForm)
    lytMenuTop: TLayout;
    Label1: TLabel;
    imgCloseNotification: TImage;
    lv_notification: TListView;
    img_Refresh: TImage;
    img_delete: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lv_notificationUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure img_RefreshClick(Sender: TObject);
    procedure imgCloseNotificationClick(Sender: TObject);
  private
    procedure AddNotification(seq_notification: integer; foto64, name, dt,
      mensage: string);
    procedure ListarNotificacao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNotification: TfrmNotification;

implementation

{$R *.fmx}

uses uFunctions;

procedure TfrmNotification.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := TCloseAction.caFree;
     frmNotification := nil;
end;

procedure TfrmNotification.imgCloseNotificationClick(Sender: TObject);
begin
    close;
end;

procedure TfrmNotification.img_RefreshClick(Sender: TObject);
begin
    ListarNotificacao;
end;

procedure TfrmNotification.AddNotification(seq_notification : integer;
                                         foto64, name, dt, mensage: string);
begin
    with lv_notification.Items.Add do
    begin
        Tag := seq_notification;


        Height := 80;

        // Foto base64...
        if foto64 <> '' then
            TListItemImage(Objects.FindDrawable('ImgIcone')).Bitmap := tfunctions.BitmapFromBase64(foto64);
        //

        TListItemText(Objects.FindDrawable('TxtNome')).Text := name;
        TListItemText(Objects.FindDrawable('TxtMensagem')).Text := mensage;
        TListItemText(Objects.FindDrawable('TxtData')).Text := dt;
        TListItemImage(Objects.FindDrawable('ImgExcluir')).Bitmap := img_delete.Bitmap;
    end;
end;

procedure TfrmNotification.ListarNotificacao;
var
    x : integer;
begin
    // Buscar notificacaoes no servidor...

    lv_notification.Items.Clear;

    for x := 1 to 10 do
        AddNotification(x, '', 'Ricardo da Silva Sgarb', '20/10', 'Mensagem de teste Mensagem de teste Mensagem de teste ' + x.ToString);
end;

procedure TfrmNotification.lv_notificationUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
  var
    txt, txt_msg: TListItemText;
    img: TListItemImage;

begin
  // Calcula tamanho da descricao...
    txt := TListItemText(AItem.Objects.FindDrawable('TxtNome'));
    txt.Width := lv_notification.Width - 145;
    txt.Height := frmMainscreen.GetTextHeight(txt, txt.Width, txt.Text) - 15;

    // Calcula obejto texto da mensagem...
    txt_msg := TListItemText(AItem.Objects.FindDrawable('TxtMensagem'));
    txt_msg.Width := lv_notification.Width - 175;
    txt_msg.PlaceOffset.Y := txt.PlaceOffset.Y + txt.Height;
    txt_msg.Height := frmMainscreen.GetTextHeight(txt_msg, txt_msg.Width, txt_msg.Text);


    // Calcula altura do item da listview...
    Aitem.Height := Trunc(txt_msg.PlaceOffset.Y + txt_msg.Height + 20);

    if Aitem.Height < 95 then
        Aitem.Height := 95;

    // Botao excluir...
    img := TListItemImage(AItem.Objects.FindDrawable('ImgExcluir'));
    img.PlaceOffset.Y := Aitem.Height - 55;
end;

end.

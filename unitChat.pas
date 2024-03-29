unit unitChat;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ScrollBox, FMX.Memo,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Memo.Types, unitPrincipal, System.JSON;

type
  TfrmChat = class(TForm)
    lytMenuTop: TLayout;
    Label1: TLabel;
    img_BackChat: TImage;
    rectContact: TRectangle;
    c_Foto: TCircle;
    lblNome: TLabel;
    rectMessage: TRectangle;
    imgSend: TImage;
    Rectangle1: TRectangle;
    memo_msg: TMemo;
    lv_chat: TListView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgSendClick(Sender: TObject);
    procedure lv_chatUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormShow(Sender: TObject);
    procedure img_BackChatClick(Sender: TObject);
  private
    procedure AddChat(id_usuario_de, id_usuario_para: integer; msg, dt, ind_msg_minha: string);
    procedure ListarChat;
    procedure ProcessarEnvioChat;
    procedure ProcessarChatErro(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    id_usuario, id_usuario_destino,id_task : integer;
  end;

var
  frmChat: TfrmChat;

implementation

{$R *.fmx}

uses untDM, uFunctions, uLoading;

procedure TfrmChat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action := TCloseAction.caFree;
     frmChat := nil;
end;

procedure TfrmChat.FormShow(Sender: TObject);
begin
    ListarChat;
end;

procedure TfrmChat.imgSendClick(Sender: TObject);
begin
    try
        dm.RequestChatEnvia.Params.Clear;
        dm.RequestChatEnvia.AddParameter('id', '');
        dm.RequestChatEnvia.AddParameter('id_usuario_de', frmMainscreen.cod_usuario_logado.ToString);
        dm.RequestChatEnvia.AddParameter('id_usuario_para', id_usuario.ToString);
        dm.RequestChatEnvia.AddParameter('texto',  memo_msg.Text);
     //   dm.RequestChatEnvia.AddParameter('texto',  escape_chars(memo_msg.Text));
        dm.RequestChatEnvia.AddParameter('id_task_test', id_task.ToString);
        dm.RequestChatEnvia.Execute;

        AddChat(frmMainscreen.cod_usuario_logado,
                id_usuario_destino,
                memo_msg.Text,
                FormatDateTime('dd/mm/yyyy - hh:nn:ss', now) + 'h',
                'S');
        memo_msg.Lines.Clear;
        lv_chat.ScrollTo(lv_chat.ItemCount -1);
    except

    end;
end;

procedure TfrmChat.img_BackChatClick(Sender: TObject);
begin
    close;
end;

procedure TFrmChat.AddChat(id_usuario_de, id_usuario_para: integer;
                           msg, dt, ind_msg_minha: string);
begin
    with lv_chat.Items.Add do
    begin
        Tag := id_usuario_de;
        TagString := id_usuario_para.ToString;

        TListItemText(Objects.FindDrawable('TxtMensagem')).Text := msg;
        TListItemText(Objects.FindDrawable('TxtMensagem')).TagString := ind_msg_minha;
        TListItemText(Objects.FindDrawable('TxtData')).Text := Copy(Dt, 1, 5);
    end;

    lv_chat.RecalcSize;
end;

procedure TfrmChat.ProcessarEnvioChat;
var
    jsonArray : TJsonArray;
    json, retorno, id_usuario, ind_msg_minha: string;
    i : integer;
begin
    try
        json := dm.RequestChat.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONArray;

        // Se deu erro...
        if dm.RequestChat.Response.StatusCode <> 200 then
        begin
            showmessage(retorno);
            exit;
        end;

    except on ex:exception do
        begin
            showmessage(ex.Message);
            exit;
        end;
    end;

    try
        // Popular listview das mensagens...
        lv_chat.Items.Clear;
        lv_chat.BeginUpdate;

        for i := 0 to jsonArray.Size - 1 do
        begin
            // Verifica se eu enviei a mensagem...
            if jsonArray.Get(i).GetValue<integer>('ID_USER_FROM', 0) = frmMainscreen.cod_usuario_logado then
                ind_msg_minha := 'S'
            else
                ind_msg_minha := 'N';

            AddChat(jsonArray.Get(i).GetValue<integer>('ID_USER_FROM', 0),
                    jsonArray.Get(i).GetValue<integer>('ID_USER_TO', 0),
                    jsonArray.Get(i).GetValue<string>('TEXT', ''),
                    jsonArray.Get(i).GetValue<string>('DT_GENERATION', ''),
                    ind_msg_minha);
        end;

        jsonArray.DisposeOf;

    finally
        lv_chat.EndUpdate;
        lv_chat.RecalcSize;
    end;

end;

procedure TFrmChat.ProcessarChatErro(Sender: TObject);
begin
    if Assigned(Sender) and (Sender is Exception) then
        ShowMessage(Exception(Sender).Message);
end;

procedure TFrmChat.ListarChat;
var
    x : integer;
begin
    // Buscar no servidor...
      dm.RequestChat.Params.Clear;
      dm.RequestChat.AddParameter('id','');
      dm.RequestChat.AddParameter('id_task_test',id_task.ToString);
      dm.RequestChat.AddParameter('id_usuario',frmMainscreen.cod_usuario_logado.ToString);
      dm.RequestChat.ExecuteAsync(ProcessarEnvioChat, true, true, ProcessarChatErro);
end;

procedure TfrmChat.lv_chatUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
  var
   txt, txt_data: TListItemText;
begin
     // Calcula tamanho da mensagem...
    txt := TListItemText(AItem.Objects.FindDrawable('TxtMensagem'));
    txt.Width := lv_chat.Width * 0.60;
    txt.Height := frmMainscreen.GetTextHeight(txt, txt.Width, txt.Text) - 5;

    // Se mensagem � minha ou n�o...
    if txt.TagString = 'S' then
    begin
        txt.Align := TListItemAlign.Trailing;
        txt.PlaceOffset.X := -10;
        txt.TextColor := $FF343434;
    end
    else
        txt.TextColor := $FF1A72E2;


    // Calcula objeto data da mensagem...
    txt_data := TListItemText(AItem.Objects.FindDrawable('TxtData'));
    txt_data.Width := lv_chat.Width;
    txt_data.PlaceOffset.Y := txt.PlaceOffset.Y + txt.Height - 5;

    // Se mensagem � minha ou n�o...
    if txt.TagString = 'S' then
    begin
        txt_data.Align := TListItemAlign.Trailing;
        txt_data.PlaceOffset.X := -10;
        txt_data.TextAlign := TTextAlign.Trailing;
    end
    else
        txt_data.TextAlign := TTextAlign.Leading;

    // Calcula altura do item da listview...
    Aitem.Height := Trunc(txt_data.PlaceOffset.Y + txt_data.Height + 25);
end;
end.

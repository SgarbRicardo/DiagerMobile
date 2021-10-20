unit unitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.Layouts, FMX.ListBox,
  FMX.Edit, system.JSON, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, System.NetEncoding, FMX.TextLayout,
  FMX.TabControl, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, u99Permissions;

type
  TfrmMainscreen = class(TForm)
    lytBotaoMenu: TLayout;
    recMenu2: TRectangle;
    FloatAnimation2Opacity: TFloatAnimation;
    recMenu3: TRectangle;
    FloatAnimation3Width: TFloatAnimation;
    FloatAnimation3Rotate: TFloatAnimation;
    FloatAnimation3Margin: TFloatAnimation;
    recMenu1: TRectangle;
    FloatAnimation1Rotate: TFloatAnimation;
    FloatAnimation1Width: TFloatAnimation;
    FloatAnimation1Margin: TFloatAnimation;
    RecMenu: TRectangle;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    c_foto: TCircle;
    AnimationOpacity: TFloatAnimation;
    Layout5: TLayout;
    lblEmail: TLabel;
    lblUsuario: TLabel;
    Line3: TLine;
    Layout7: TLayout;
    Layout8: TLayout;
    Image5: TImage;
    Layout9: TLayout;
    Label5: TLabel;
    AnimationWidth9: TFloatAnimation;
    FloatAnimation1: TFloatAnimation;
    Line2: TLine;
    FloatAnimation3: TFloatAnimation;
    Layout10: TLayout;
    Layout11: TLayout;
    Image4: TImage;
    Layout12: TLayout;
    lblCustomer: TLabel;
    FloatAnimation4: TFloatAnimation;
    FloatAnimation5: TFloatAnimation;
    Line1: TLine;
    AnimationWidth: TFloatAnimation;
    lytPrincipal: TLayout;
    lytMenuTop: TLayout;
    Label2: TLabel;
    CircleUser: TCircle;
    imgNotification: TImage;
    rectInventarioList: TRectangle;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    img_inventario: TImage;
    img_sincronizar: TImage;
    img_Notification: TImage;
    Image7: TImage;
    Image8: TImage;
    img_Test: TImage;
    imgDashBoard: TImage;
    Image11: TImage;
    img_selecao: TImage;
    Layout1: TLayout;
    Layout13: TLayout;
    Image12: TImage;
    Layout14: TLayout;
    Label7: TLabel;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation6: TFloatAnimation;
    Line4: TLine;
    c_Notifica: TCircle;
    Circle2: TCircle;
    tabPrincipal: TTabControl;
    tbiPrincipal: TTabItem;
    tbiUsuario: TTabItem;
    Layout15: TLayout;
    Image2: TImage;
    Image3: TImage;
    lvUsuario: TListView;
    lblDepartamento: TLabel;
    ActionList1: TActionList;
    ActLibrary: TTakePhotoFromCameraAction;
    OpenDialog: TOpenDialog;
    tbiPerfil: TTabItem;
    Layout6: TLayout;
    Image1: TImage;
    Image6: TImage;
    rec_foto: TRectangle;
    c_fotoPerfil: TCircle;
    Label1: TLabel;
    StyleBook1: TStyleBook;
    lbPerfil: TListBox;
    lbiUsuario: TListBoxItem;
    lbiNome: TListBoxItem;
    lbiEmail: TListBoxItem;
    lbiDepartamento: TListBoxItem;
    lbiSenha: TListBoxItem;
    Layout16: TLayout;
    lbiCargo: TListBoxItem;
    Layout17: TLayout;
    Label4: TLabel;
    lblUsuarioPerfil: TLabel;
    Line5: TLine;
    Image9: TImage;
    Layout18: TLayout;
    Label3: TLabel;
    lblNomePerfil: TLabel;
    Line6: TLine;
    Layout19: TLayout;
    Label8: TLabel;
    lblEmailPerfil: TLabel;
    Line7: TLine;
    Layout20: TLayout;
    Label10: TLabel;
    lblDepartamentoPerfil: TLabel;
    Line8: TLine;
    Layout21: TLayout;
    Label12: TLabel;
    lblcargoPerfil: TLabel;
    Line9: TLine;
    Layout22: TLayout;
    Label14: TLabel;
    lblSenhaPerfil: TLabel;
    Line10: TLine;
    layout_detalhe: TLayout;
    rect_fundo: TRectangle;
    Rectangle2: TRectangle;
    lbl_nome: TLabel;
    img_fechar_detalhe: TImage;
    Layout23: TLayout;
    lbBundle: TListBox;
    lbiBundle: TListBoxItem;
    lbl_Bundle: TLabel;
    Line11: TLine;
    ActCamera: TTakePhotoFromCameraAction;
    lbiDataAcesso: TListBoxItem;
    Layout24: TLayout;
    lblData: TLabel;
    lblDataAcesso: TLabel;
    Layout25: TLayout;
    Image10: TImage;
    Layout26: TLayout;
    Image13: TImage;
    Layout27: TLayout;
    Image14: TImage;
    Layout28: TLayout;
    Image15: TImage;
    Layout29: TLayout;
    Image16: TImage;
    Layout30: TLayout;
    Image17: TImage;
    Layout31: TLayout;
    Image18: TImage;
    img_btn: TImage;
    procedure FormResize(Sender: TObject);
    procedure img_inventarioClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AnimationWidthFinish(Sender: TObject);
    procedure AnimationWidthProcess(Sender: TObject);
    procedure lytBotaoMenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Layout7Click(Sender: TObject);
    procedure img_sincronizarClick(Sender: TObject);
    procedure img_NotificationClick(Sender: TObject);
    procedure CircleUserClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure lvUsuarioItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure img_TestClick(Sender: TObject);
    procedure ActLibraryDidFinishTaking(Image: TBitmap);
    procedure c_fotoClick(Sender: TObject);
    procedure img_fechar_detalheClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbBundleItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure ActCameraDidFinishTaking(Image: TBitmap);
    procedure imgDashBoardClick(Sender: TObject);
  private
    permissao : T99Permissions;
    icone_selecionado: TBitmap;
    procedure OpenMenu;
    procedure CloseMenu;
    procedure selecionaIcone(img: TImage);
    procedure AddUsuario( idUsuario : integer; Nome,
              Departamento: string; Photo: TStream);
    procedure ProcessaDadosusuario;
    procedure processaDadosErro(Sender : Tobject);
    procedure NavegarAbas(pag: integer);
    procedure EditarFotoUsuario(foto: TBitmap);
    procedure AddBundle(bundle: string);
    procedure ProcessarBundle;
    procedure ProcessarBundleErro(Sender: TObject);
    procedure ListarBundle;
    procedure ErroPermissao(Sender: TObject);
    { Private declarations }
  public
   nome_usuario,Nome, Email_usuario, Departamento_usuario, nivel_acesso : string;
   cod_usuario_logado : integer;
   function GetTextHeight(const D: TListItemText; const Width: single;
                          const Text: string): Integer;

   procedure ListaUsuarios;
    { Public declarations }
  end;

var
  frmMainscreen: TfrmMainscreen;

implementation

{$R *.fmx}

uses unitInventario, unitSincronizar, unitLogin, untDM, cUsuario,
  unitNotificacao, unitChat, unitTestQuality, uFunctions,REST.Types, uLoading,
  unitDashBoard;

procedure TfrmMainscreen.NavegarAbas(pag: integer);
begin
    if (tabPrincipal.TabIndex = 0) and (pag <0) then
    exit;
    if (tabPrincipal.TabIndex = 1) and (pag >0) then
    exit;

    tabPrincipal.GotoVisibleTab(tabPrincipal.TabIndex + pag, TTabTransition.Slide);
end;

procedure TfrmMainscreen.EditarFotoUsuario(foto: TBitmap);
var
    json, retorno : string;
    jsonObj : TJSONObject;
begin
    // Salvar item...
    dm.Request_Perfil.Params.Clear;
    dm.Request_Perfil.AddParameter('id', '');
    dm.Request_Perfil.AddParameter('id_usuario', cod_usuario_logado.ToString);
    dm.Request_Perfil.AddParameter('campo', 'photo');
    dm.Request_Perfil.AddParameter('valor', TFunctions.Base64FromBitmap(foto), pkREQUESTBODY);
    dm.Request_Perfil.Execute;

    try
        json := dm.Request_Perfil.Response.JSONValue.ToString;
        jsonObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONObject;

        retorno := jsonObj.GetValue('retorno').Value;


        // Se deu erro...
        if dm.Request_Perfil.Response.StatusCode <> 200 then
        begin
            showmessage(retorno);
            exit;
        end;

    finally
        jsonObj.DisposeOf;
    end;
end;

function TfrmMainscreen.GetTextHeight(const D: TListItemText; const Width: single; const Text: string): Integer;
var
  Layout: TTextLayout;
begin
  // Create a TTextLayout to measure text dimensions
  Layout := TTextLayoutManager.DefaultTextLayout.Create;
  try
    Layout.BeginUpdate;
    try
      // Initialize layout parameters with those of the drawable
      Layout.Font.Assign(D.Font);
      Layout.VerticalAlign := D.TextVertAlign;
      Layout.HorizontalAlign := D.TextAlign;
      Layout.WordWrap := D.WordWrap;
      Layout.Trimming := D.Trimming;
      Layout.MaxSize := TPointF.Create(Width, TTextLayout.MaxLayoutSize.Y);
      Layout.Text := Text;
    finally
      Layout.EndUpdate;
    end;
    // Get layout height
    Result := Round(Layout.Height);
    // Add one em to the height
    Layout.Text := 'm';
    Result := Result + Round(Layout.Height);
  finally
    Layout.Free;
  end;
end;

procedure TfrmMainscreen.Image2Click(Sender: TObject);
begin
    NavegarAbas(-2);
    CircleUser.Fill.Bitmap.Bitmap := c_fotoPerfil.Fill.Bitmap.Bitmap;
    c_foto.Fill.Bitmap.Bitmap := c_fotoPerfil.Fill.Bitmap.Bitmap;
end;

procedure TfrmMainscreen.imgDashBoardClick(Sender: TObject);
begin
    SelecionaIcone(TImage(Sender));
    if not Assigned (frmDashBoard) then
       Application.CreateForm(TfrmDashBoard, frmDashBoard);

       frmDashBoard.Show;
end;

procedure TfrmMainscreen.img_fechar_detalheClick(Sender: TObject);
begin
    layout_detalhe.Visible := false;
end;

procedure TfrmMainscreen.img_inventarioClick(Sender: TObject);
begin
     SelecionaIcone(TImage(Sender));
     if not Assigned (frmInventario) then
       Application.CreateForm(TfrmInventario, frmInventario);

       frmInventario.Show;
end;

procedure TfrmMainscreen.img_sincronizarClick(Sender: TObject);
begin
    SelecionaIcone(TImage(Sender));
    if NOT Assigned(frmSincronizar) then
        Application.CreateForm(TFrmSincronizar, FrmSincronizar);

        FrmSincronizar.Show;
end;

procedure TfrmMainscreen.img_TestClick(Sender: TObject);
begin
     SelecionaIcone(TImage(Sender));
     layout_detalhe.Visible := true;
     ListarBundle;

end;

procedure TfrmMainscreen.Layout7Click(Sender: TObject);
begin
//    SelecionaIcone(TImage(Sender));
    if not Assigned (frmInventario) then
       Application.CreateForm(TfrmInventario, frmInventario);

       frmInventario.Show;
       CloseMenu;
end;

procedure TfrmMainscreen.lbBundleItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
     // ShowMessage('Você Selecionou a versão: ' + item.TagString);

     if not Assigned (frmTestQuality) then
       Application.CreateForm(TfrmTestQuality, frmTestQuality);
       frmTestQuality.bundle := item.TagString;

       frmTestQuality.Show;
       layout_detalhe.Visible := false;
end;

procedure TfrmMainscreen.lvUsuarioItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
    if not Assigned (frmChat) then
       Application.CreateForm(tfrmchat, frmChat);

       frmChat.id_usuario := TListView(sender).Items[ItemIndex].Tag;
       frmChat.lblNome.text := TListItemText(TlistView(sender).Items[ItemIndex].Objects.FindDrawable('txtNome')).text;
       frmChat.Show;
end;

procedure TfrmMainscreen.lytBotaoMenuClick(Sender: TObject);
begin
     if recMenu1.Tag = 0 then
      OpenMenu
    else
      CloseMenu;
end;

procedure TfrmMainscreen.selecionaIcone(img : TImage);
begin
     icone_selecionado := img.Bitmap; // salvei o icone selecionado;

     img_selecao.Parent := img.Parent; // pega o parent da imagem de seleção e move para o item selecionado
end;

procedure TfrmMainscreen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    permissao.DisposeOf;
    Action := TCloseAction.caFree;
    frmMainscreen := nil;
    close;
end;

procedure TfrmMainscreen.FormCreate(Sender: TObject);
begin
    recmenu.Margins.left := -260;
    recmenu.Align:= TAlignLayout.Left;
    recMenu.visible := true;
    lblUsuario.Text := frmLogin.usuario;
    lblEmail.Text := frmLogin.email;
    lblDepartamento.Text := frmLogin.departamento;
    tabPrincipal.ActiveTab := tbiPrincipal;

    permissao := T99Permissions.Create;
end;

procedure TfrmMainscreen.FormResize(Sender: TObject);
begin
      // redimenciona os icones dentro da tela
   ListBox1.Columns := Trunc(ListBox1.Width / 250);
end;

procedure TfrmMainscreen.FormShow(Sender: TObject);
begin
    layout_detalhe.Visible := false;
    ListBoxItem2.Visible := false;
    ListBoxItem3.Visible := false;
    ListBoxItem4.Visible := false;
    ListBoxItem5.Visible := false;
    ListBoxItem8.Visible := false;
end;

procedure TfrmMainscreen.img_NotificationClick(Sender: TObject);
begin
    if not Assigned(frmNotification) then
        Application.CreateForm(TfrmNotification, frmNotification);

        frmNotification.Show;
end;

procedure TfrmMainscreen.OpenMenu;
begin
    // menu Hamburguer
    FloatAnimation1Margin.inverse := False;
    FloatAnimation1Rotate.Inverse := False;
    FloatAnimation1Width.Inverse := False;
    FloatAnimation2Opacity.Inverse := False;
    FloatAnimation3Margin.inverse := False;
    FloatAnimation3Rotate.Inverse := False;
    FloatAnimation3Width.Inverse := False;

    FloatAnimation2Opacity.Start;
    FloatAnimation1Width.Start;
    FloatAnimation1Margin.Start;
    FloatAnimation1Rotate.Start;

    FloatAnimation3Width.Start;
    FloatAnimation3Margin.Start;
    FloatAnimation3Rotate.Start;

    recMenu1.Tag := 1;

    //Menu Slide..
    FloatAnimation1.Inverse := false;
    AnimationOpacity.Inverse := false;
    AnimationOpacity.Start;
    AnimationWidth.Start;

    FloatAnimation1.start;
end;

procedure CarregaUsuarioerro(sender: TObject);
begin
  if assigned (Sender) and (sender is Exception) then
      ShowMessage(Exception(sender).Message);
end;

procedure TfrmMainscreen.AnimationWidthFinish(Sender: TObject);
begin
    lytPrincipal.Enabled := AnimationWidth.Inverse;
    AnimationWidth.Inverse := NOT AnimationWidth.Inverse;
end;

procedure TfrmMainscreen.AnimationWidthProcess(Sender: TObject);
begin
    lytPrincipal.Margins.right := -260 - RecMenu.Margins.Left;
end;

procedure TfrmMainscreen.CircleUserClick(Sender: TObject);
begin
    NavegarAbas(2);
end;

procedure TfrmMainscreen.CloseMenu;
begin
    //menu hambuguer
    FloatAnimation1Margin.inverse := true;
    FloatAnimation1Rotate.Inverse := true;
    FloatAnimation1Width.Inverse := true;
    FloatAnimation2Opacity.Inverse := true;
    FloatAnimation3Margin.inverse := true;
    FloatAnimation3Rotate.Inverse := true;
    FloatAnimation3Width.Inverse := true;

    FloatAnimation2Opacity.Start;
    FloatAnimation1Width.Start;
    FloatAnimation1Margin.Start;
    FloatAnimation1Rotate.Start;

    FloatAnimation3Width.Start;
    FloatAnimation3Margin.Start;
    FloatAnimation3Rotate.Start;

    recMenu1.Tag := 0;

    //menu slide
    AnimationOpacity.Inverse := true;
    FloatAnimation1.Inverse := true;
    AnimationOpacity.Start;
    AnimationWidth.start;
    FloatAnimation1.start;
end;

procedure TfrmMainscreen.c_fotoClick(Sender: TObject);
begin
    {$IFDEF MSWINDOWS}
    if OpenDialog.Execute then
    begin
        c_fotoPerfil.Fill.Bitmap.Bitmap.LoadFromFile(OpenDialog.FileName);
        EditarFotoUsuario(c_fotoPerfil.Fill.Bitmap.Bitmap);
    end;
    {$ELSE}
        permissao.camera(ActCamera,erroPermissao);
    {$ENDIF}
end;

procedure TfrmMainscreen.ActCameraDidFinishTaking(Image: TBitmap);
begin
      c_fotoPerfil.Fill.Bitmap.Bitmap := Image;
      EditarFotoUsuario(Image);
end;

procedure TfrmMainscreen.ErroPermissao(Sender: TObject);
begin
    showmessage('Você não possui permissao para esse recurso ');
end;

procedure TfrmMainscreen.ActLibraryDidFinishTaking(Image: TBitmap);
begin
     c_fotoPerfil.Fill.Bitmap.Bitmap := Image;
     EditarFotoUsuario(Image);
end;

procedure TfrmMainscreen.AddBundle(bundle : string);
var
    item : TListBoxItem;
    lbl_Bundle : TLabel;
    line : TLine;
    img_btn : TImage;
begin
    try
      lbl_nome.Margins.Bottom := 10;
      Layout23.Height := 150;
      lbBundle.Height := 125;

      item := TListBoxItem.Create(nil);
      item.Text := '';
      item.Height := 40;
      item.Padding.Bottom := 8;
      item.Width := 171;
      item.Align := TAlignLayout.Client;
      item.TagString := bundle;
      item.Selectable := false;

      lbl_Bundle := TLabel.Create(item);
      lbl_Bundle.Parent := item;
      lbl_Bundle.Align := TAlignLayout.Client;
      lbl_Bundle.StyledSettings := [];
      lbl_Bundle.FontColor := $FFD52121;
      lbl_Bundle.Font.Size := 28;
      lbl_bundle.TextSettings.HorzAlign := TTextAlign.Center;
      lbl_Bundle.Text := bundle;

      line := Tline.Create(item);
      line.Parent := item;
      line.Align := TAlignLayout.bottom;
      line.Margins.Left := 40;
      line.Margins.Right := 40;
      line.Height := 1;
      line.Opacity := 0.2;
      line.Stroke.Thickness := 0.5;

      img_btn := TImage.Create(item);
      img_btn.parent := item;
      img_btn.Align := TAlignLayout.Right;
      img_btn.Height := 15;
      img_btn.MultiResBitmap := img_btn.MultiResBitmap;

      lbBundle.AddObject(item);
    finally

    end;
end;

procedure TfrmMainscreen.ProcessarBundle;
var
    jsonArray : TJsonArray;
    json, retorno : string;
    i : integer;
begin
    try
        // Se deu erro...
        if dm.Request_Bundle.Response.StatusCode <> 200 then
        begin
            showmessage('Erro ao consultar Bundle');
            exit;
        end;

        TLoading.Hide;
        json := dm.Request_Bundle.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.ANSI.GetBytes(json), 0) as TJSONArray;

    except on ex:exception do
        begin
            TLoading.Hide;
            showmessage(ex.Message);
            exit;
        end;
    end;

    try
        lbBundle.Items.Clear;

        for i := 0 to jsonArray.Size - 1 do
        begin
            AddBundle(jsonArray.Get(i).GetValue<string>('bundle', ''));
        end;

    finally
        jsonArray.DisposeOf;

    end;
end;

procedure TfrmMainscreen.ProcessarBundleErro(Sender: TObject);
begin
    TLoading.Hide;
    if Assigned(Sender) and (Sender is Exception) then
        ShowMessage(Exception(Sender).Message);
end;

procedure TfrmMainscreen.ListarBundle();
begin
    TLoading.Show(frmMainscreen, 'Carregando...');
    try
      //dm.Request_Bundle.Params.Clear;
      dm.Request_Bundle.AddParameter('bundle','');
      dm.Request_Bundle.ExecuteAsync(ProcessarBundle, true, true, ProcessarBundleErro);

    except on ex:exception do
      begin
          TLoading.Hide;
          showmessage('Erro ao acessar o servidor: ' + ex.Message);
          exit;
      end;
    end;
end;

procedure TfrmMainscreen.AddUsuario( idUsuario : integer; Nome, Departamento: string; Photo: TStream);
var
  img : TListItemImage;
  txt : TListItemText;
  bmp : TBitmap;

begin
    try
       with lvUsuario.Items.Add do
       begin
            tag := idUsuario;

            txt := TListItemText(Objects.FindDrawable('txtNome'));
            txt.Text := Nome;
            TListItemText(Objects.FindDrawable('txtDepartamento')).Text := Departamento;

            img := TListItemImage(Objects.FindDrawable('imgUsuario'));
              if Photo <> nil then
              begin
                bmp := TBitmap.Create;
                bmp.LoadFromStream(Photo);

                img.OwnsBitmap := true; // só faz quando sta instaciando a imagem (bmp) em tempo de execução. se vier do banco nao precisa dela.
                img.Bitmap := bmp;
              end;
       end;
    finally

    end;
end;

procedure TfrmMainscreen.ProcessaDadosusuario;
var
      photo : TStream;
      erro, json,retorno, id_usuario: string;
      jsonArray : TjsonArray;
      i: integer;
begin
     try
        json := dm.Request_Perfil.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONArray;

        if dm.Request_Perfil.Response.StatusCode <> 200 then
        begin
          ShowMessage(erro);
          exit
        end;

        except on ex:Exception do
        begin
          ShowMessage(ex.Message);
          exit;
        end;
     end;

     try
        lvUsuario.Items.Clear;
        lvUsuario.BeginUpdate;

       for i := 0 to jsonArray.size -1 do
        begin
            { if qry.FieldByName('USU_FOTO').AsString <>'' then
                photo := qry.CreateBlobStream(qry.FieldByName('USU_FOTO'),TBlobStreamMode.bmRead)
             else
                photo := nil;   }
             AddUsuario(jsonArray.Get(i).getvalue<integer>('user_id',0),
                        jsonArray.Get(i).getvalue<string>('name', ''),
                        jsonArray.Get(i).getvalue<string>('Department', ''),
                                         Photo);
        end;
            photo.DisposeOf;
            jsonArray.DisposeOf;
     finally
            lvUsuario.EndUpdate;
            lvUsuario.RecalcSize;
     end;
end;

procedure TfrmMainscreen.processaDadosErro (Sender : Tobject);
begin
  if Assigned(Sender) and (sender is Exception) then
      ShowMessage(Exception(sender).message);
end;

procedure TfrmMainscreen.ListaUsuarios;
begin
    dm.Request_Perfil.Params.Clear;
    dm.Request_Perfil.AddParameter('id', '');
    dm.Request_Perfil.ExecuteAsync(ProcessaDadosusuario, true, true, processaDadosErro)
end;


end.


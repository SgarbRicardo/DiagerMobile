unit unitLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Ani,
  IPPeerClient, REST.Client, REST.Authenticator.Basic, Data.Bind.Components,
  Data.Bind.ObjectScope, system.JSON, REST.Types, FMX.TabControl,
  System.Actions, FMX.ActnList, FMX.MediaLibrary.Actions, u99Permissions, system.NetEncoding,
  uMD5, FMX.Media, FMX.Surfaces,System.Hash ,

  {$IFDEF ANDROID}
  FMX.VirtualKeyboard, FMX.Platform,
  {$ENDIF}

  FMX.StdActns, untDM;

type
  TfrmLogin = class(TForm)
    lyt_acesso: TLayout;
    rect_user: TRectangle;
    lyt_user: TLayout;
    img_user: TImage;
    edt_user: TEdit;
    StyleBook1: TStyleBook;
    lyt_pwd: TLayout;
    rect_pwd: TRectangle;
    img_pwd: TImage;
    edt_pwd: TEdit;
    rect_botao: TRectangle;
    lbl_botao: TLabel;
    lyt_criarConta: TLayout;
    lbl_criarConta: TLabel;
    lbl_esqueceu: TLabel;
    FloatAnimationAcesso: TFloatAnimation;
    img_loading: TImage;
    FloatAnimationOpacity: TFloatAnimation;
    FloatAnimationWidth: TFloatAnimation;
    TabControl1: TTabControl;
    tabLogin: TTabItem;
    tabNovaConta: TTabItem;
    lblLogin: TLabel;
    lblNovaConta: TLabel;
    lytNovaConta: TLayout;
    lytEdtUser: TLayout;
    Rectangle1: TRectangle;
    Image2: TImage;
    edt_cadUser: TEdit;
    lytEdtPwd: TLayout;
    Rectangle2: TRectangle;
    Image3: TImage;
    edtCadPwd: TEdit;
    recBotaoCriarConta: TRectangle;
    lbCriarConta: TLabel;
    lytLbFazerLogin: TLayout;
    Label2: TLabel;
    FloatAnimation2: TFloatAnimation;
    cFoto: TCircle;
    Label3: TLabel;
    ActionList1: TActionList;
    Action1: TAction;
    actLogin: TChangeTabAction;
    actNovaConta: TChangeTabAction;
    tabFoto: TTabItem;
    Layout1: TLayout;
    lblCancelar: TLabel;
    img_camera: TImage;
    imgLibrary: TImage;
    actFoto: TChangeTabAction;
    actionLibrary: TTakePhotoFromLibraryAction;
    actionCamera: TTakePhotoFromCameraAction;
    lytBotaoMenu: TLayout;
    recMenu1: TRectangle;
    recMenu2: TRectangle;
    recMenu3: TRectangle;
    FloatAnimation1Rotate: TFloatAnimation;
    FloatAnimation1Width: TFloatAnimation;
    FloatAnimation2Opacity: TFloatAnimation;
    FloatAnimation3Width: TFloatAnimation;
    FloatAnimation3Rotate: TFloatAnimation;
    FloatAnimation1Margin: TFloatAnimation;
    FloatAnimation3Margin: TFloatAnimation;
    RecMenu: TRectangle;
    AnimationWidth: TFloatAnimation;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Circle1: TCircle;
    Image1: TImage;
    Label1: TLabel;
    Label4: TLabel;
    Line1: TLine;
    Layout7: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    Label5: TLabel;
    AnimationWidth9: TFloatAnimation;
    AnimationOpacity: TFloatAnimation;
    FloatAnimation1: TFloatAnimation;
    Line2: TLine;
    FloatAnimation3: TFloatAnimation;
    Layout10: TLayout;
    Layout11: TLayout;
    Layout12: TLayout;
    Label6: TLabel;
    FloatAnimation4: TFloatAnimation;
    FloatAnimation5: TFloatAnimation;
    Line3: TLine;
    lytEmail: TLayout;
    recEmail: TRectangle;
    imgEmail: TImage;
    edtEmail: TEdit;
    lytToolBar: TLayout;
    Image4: TImage;
    Image5: TImage;
    OpenDialog1: TOpenDialog;
    recPrincipal: TRectangle;
    lytLogo: TLayout;
    img_logo: TImage;
    Layout13: TLayout;
    lblLoginTitulo: TLabel;
    img_perfil: TImage;
    procedure FormCreate(Sender: TObject);
    procedure rect_botaoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rect_botaoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rect_botaoClick(Sender: TObject);
    procedure FloatAnimationAcessoFinish(Sender: TObject);
    procedure lbl_criarContaClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Layout7Click(Sender: TObject);
    procedure cFotoClick(Sender: TObject);
    procedure lblCancelarClick(Sender: TObject);
    procedure actionLibraryDidFinishTaking(Image: TBitmap);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure img_cameraClick(Sender: TObject);
    procedure imgLibraryClick(Sender: TObject);
    procedure recBotaoCriarContaClick(Sender: TObject);
    procedure lytBotaoMenuClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure AnimationWidthProcess(Sender: TObject);
    procedure AnimationWidthFinish(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
  private
    permissao : T99Permissions;
    { Private declarations }
    procedure ExibirCampos;
    procedure ErroPermissao(Sender: TObject);

    procedure OpenMenu;
    procedure CloseMenu;
    procedure ProcessaLogin;
    procedure abrirPrincipal;

  public
    { Public declarations }
    usuario, cod_usuario, nome, email, departamento, nivel_acesso,foto64, login_ate : string;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}

uses unitInventario, unitPrincipal, uFunctions;
{$R *.iPhone47in.fmx IOS}
{$R *.XLgXhdpiTb.fmx ANDROID}

procedure TfrmLogin.OpenMenu;
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

procedure tfrmLogin.CloseMenu;
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

procedure TfrmLogin.AnimationWidthFinish(Sender: TObject);
begin
     lyt_acesso.Enabled := AnimationWidth.Inverse;
     AnimationWidth.Inverse := NOT AnimationWidth.Inverse;
end;

procedure TfrmLogin.AnimationWidthProcess(Sender: TObject);
begin
     lyt_acesso.Margins.right := -260 - RecMenu.Margins.Left;
end;

procedure TfrmLogin.actionLibraryDidFinishTaking(Image: TBitmap);
begin
    cFoto.Fill.Bitmap.Bitmap := Image;
    actFoto.Execute;
    actNovaConta.Execute;
end;

procedure TfrmLogin.cFotoClick(Sender: TObject);
begin
    actFoto.Execute;
end;

procedure TfrmLogin.ErroPermissao(Sender: TObject);
begin
    showmessage('Voc� n�o possui permissao para esse recurso ');
end;

procedure TfrmLogin.ExibirCampos;
begin
    img_loading.visible := false;
    TabControl1.Visible := true;
    TabControl1.Opacity :=1;
end;

procedure TFrmLogin.abrirPrincipal;
begin
      if not assigned (frmMainscreen) then
        application.CreateForm(TfrmMainscreen, frmMainscreen);

      Application.MainForm := frmMainscreen;

      if foto64 = '' then
      begin
        frmMainscreen.c_fotoPerfil.Fill.Bitmap.Bitmap := img_perfil.Bitmap;
        frmMainscreen.c_foto.Fill.Bitmap.Bitmap:= img_perfil.Bitmap;
        frmMainscreen.CircleUser.Fill.Bitmap.Bitmap := img_perfil.Bitmap;
        frmMainscreen.cod_usuario_logado := cod_usuario.ToInteger;

        frmMainscreen.nome_usuario := usuario;
        frmMainscreen.lblUsuarioPerfil.Text :=  usuario;

        frmMainscreen.lblNomePerfil.Text := nome;

        frmMainscreen.Email_usuario := email;
        frmMainscreen.lblEmailPerfil.text := email;

        frmMainscreen.Departamento_usuario := departamento;
        frmMainscreen.lblDepartamentoPerfil.Text := departamento;

        frmMainscreen.nivel_acesso := nivel_acesso;
        frmMainscreen.lblcargoPerfil.Text := nivel_acesso;
        frmMainscreen.lblDataAcesso.Text := login_ate;
      end
      else
      begin
        frmMainscreen.c_fotoPerfil.Fill.Bitmap.Bitmap := TFunctions.BitmapFromBase64(foto64);
        frmMainscreen.c_foto.Fill.Bitmap.Bitmap := TFunctions.BitmapFromBase64(foto64);
        frmMainscreen.CircleUser.Fill.Bitmap.Bitmap := TFunctions.BitmapFromBase64(foto64);

        frmMainscreen.cod_usuario_logado := cod_usuario.ToInteger;

        frmMainscreen.nome_usuario := usuario;
        frmMainscreen.lblUsuarioPerfil.Text :=  usuario;

        frmMainscreen.lblNomePerfil.Text := nome;

        frmMainscreen.Email_usuario := email;
        frmMainscreen.lblEmailPerfil.text := email;

        frmMainscreen.Departamento_usuario := departamento;
        frmMainscreen.lblDepartamentoPerfil.Text := departamento;

        frmMainscreen.nivel_acesso := nivel_acesso;
        frmMainscreen.lblcargoPerfil.Text := nivel_acesso;
        frmMainscreen.lblDataAcesso.Text := login_ate;
      end;

      frmMainscreen.Show;
      frmLogin.close;
end;

procedure TfrmLogin.ProcessaLogin;
var
    jsonObj : TJsonObject;
    json, sucesso, erro : string;
begin
    frmLogin.FloatAnimationOpacity.Stop;
    frmLogin.FloatAnimationWidth.Stop;

    if dm.RequestLogin.Response.JSONValue = nil then
    begin
      frmLogin.ExibirCampos;
      ShowMessage('Erro ao validar login JSON login)');
      exit;
    end;

    try
      json := dm.RequestLogin.Response.JSONValue.ToString;
      jsonObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONObject;

      sucesso:= jsonObj.GetValue('Sucesso').Value;
      cod_usuario:= jsonObj.GetValue('codusuario').Value;
      usuario := jsonObj.GetValue('usuario').Value;

      if dm.RequestLogin.Response.StatusCode <> 200 then
      begin
          frmLogin.ExibirCampos;
          ShowMessage(sucesso);
          exit;
      end;

      nome := jsonObj.GetValue('name').Value;
      email := jsonObj.GetValue('email').Value;
      departamento := jsonObj.GetValue('department').Value;
      nivel_acesso := jsonObj.GetValue('access_level').value;
      login_ate := jsonObj.GetValue('login_until').value;
      foto64 := jsonObj.GetValue('foto').Value

    finally
        jsonObj.DisposeOf;
    end;
       FrmLogin.abrirPrincipal;
end;

procedure ProcessaConta;
var
    jsonObj : TJsonObject;
    json, sucesso, erro, cod_usuario, usuario : string;

begin
    //frmLogin.FloatAnimation1.stop;
    frmLogin.FloatAnimationOpacity.Stop;
    frmLogin.FloatAnimationWidth.Stop;

    if dm.RequestConta.Response.JSONValue = nil then
    begin
      frmLogin.ExibirCampos;
      ShowMessage('Erro ao Criar Conta(JSON Inv�lido)');
      exit;
    end;

    try
      json := dm.RequestConta.Response.JSONValue.ToString;
      jsonObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONObject;

      sucesso:= jsonObj.GetValue('Sucesso').Value;
      cod_usuario:= jsonObj.GetValue('codusuario').Value;
      usuario := jsonObj.GetValue('usuario').Value;

     if dm.RequestConta.Response.StatusCode <> 201 then
     begin
        frmLogin.ExibirCampos;
        ShowMessage(sucesso);
        exit;
     end;

    finally
      jsonObj.DisposeOf;
    end;

    ShowMessage('Usu�rio Criado '+ cod_usuario);
    //LimpaEdits(frmLogin);
    Frmlogin.abrirPrincipal;
    //frmLogin.actNovaConta.Execute;
end;

Procedure ProcessaLoginErro(Sender: TObject);
begin
  if Assigned(sender) and (sender is Exception) then
  begin
      frmLogin.ExibirCampos;
      showmessage(Exception(sender).Message);
  end;

end;

procedure TfrmLogin.FloatAnimationAcessoFinish(Sender: TObject);
var
  foto64 : string;
begin
    TabControl1.Visible := false;
    img_loading.Visible := true;
    FloatAnimationOpacity.Start;
    FloatAnimationWidth.Start;

  try
    //consumir web service de login

    if FloatAnimationAcesso.TagString= 'LOGIN' then
    begin
        dm.RequestLogin.Params.Clear;
        dm.RequestLogin.AddParameter('usuario',edt_user.Text);
        dm.RequestLogin.AddParameter('senha',edt_pwd.Text);
        dm.RequestLogin.ExecuteAsync(ProcessaLogin, true, true, ProcessaLoginErro);
    end
    else
    begin
    // consumir WS de cria��o de conta...
      foto64 := Tfunctions.Base64FromBitmap(cfoto.Fill.Bitmap.Bitmap);

      dm.RequestConta.Params.Clear;
      dm.RequestConta.AddParameter('email', edtEmail.Text);
      dm.RequestConta.AddParameter('usuario', edt_cadUser.Text);
      dm.RequestConta.AddParameter('senha', edtCadPwd.Text);
      dm.RequestConta.AddParameter('foto', foto64, pkREQUESTBODY);
      dm.RequestConta.ExecuteAsync(ProcessaConta, true, true, ProcessaLoginErro);
    end

  except on ex:exception do
      ShowMessage('Erro ao validar Login ' + ex.Message);
  end;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    permissao.DisposeOf;
    Action := TCloseAction.caFree;
    frmLogin := nil;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
    {$IFDEF DEBUG}
           dm.RESTClient.BaseURL := 'http://localhost:8082';
{obeya}  //dm.RESTClient.BaseURL := 'http://192.168.0.193:8082';
   //      dm.RESTClient.BaseURL := 'http://192.168.1.17:8082';
{ws074}  //dm.RESTClient.BaseURL := 'http://192.168.0.152:8082';
    {$ELSE}
          // dm.RESTClient.BaseURL := 'http://10.32.0.166:8082';
           dm.RESTClient.BaseURL := 'http://localhost:8082';
    {$ENDIF}

    {$IFDEF WINDOWS}
    edt_user.Margins.Top := 7;
    edt_pwd.Margins.Bottom := 7;
    edt_cadUser.Margins.Top := 7;
    edt_cadPwd.Margins.Bottom := 7;

    {$ENDIF}


    TabControl1.ActiveTab := tabLogin;
   // LimpaEdits(frmLogin);

    // classe de peirmiss�o
    permissao := T99Permissions.Create;
end;

procedure TfrmLogin.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
  {$IFDEF ANDROID}
  var
     Fservice :  IFMXVirtualKeyboardService;
  {$ENDIF}

begin
   {$IFDEF ANDROID}
    if (Key = vkHardwareBack) then
    begin
        TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService,
                                                          IInterface(FService));

        if (FService <> nil) and
           (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
        begin
            // Botao back pressionado e teclado visivel...
            // (apenas fecha o teclado)
        end
        else
        begin
            // Botao back pressionado e teclado NAO visivel...

            if TabControl1.ActiveTab = tabNovaConta then
            begin
                Key := 0;
                ActLogin.Execute
            end
            else if TabControl1.ActiveTab = TabFoto then
            begin
                Key := 0;
                ActNovaConta.Execute
            end
            else if TabControl1.ActiveTab = TabFoto then
            begin
                Key := 0;
                ActFoto.Execute;
            end;
        end;
    end;
    {$ENDIF}
end;

procedure TfrmLogin.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
    TabControl1.margins.Bottom := 0;
end;

procedure TfrmLogin.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
    TabControl1.Margins.Bottom := 160;
end;

procedure TfrmLogin.imgLibraryClick(Sender: TObject);
var bmp:fmx.graphics.tbitmap;
    astream:tmemorystream;
    surface:tbitmapsurface;
begin
   bmp := FMX.Graphics.TBitmap.Create;
   OpenDialog1.Filter := 'Supported formats | *.bmp;*.png';// fmx.Graphics.TBitmapCodecManager.GetFileTypes;
   if (OpenDialog1.Execute) then

    astream:=tmemorystream.Create;
    surface:=tbitmapsurface.Create;
    surface.Assign(bmp);
   try
    tbitmapcodecmanager.SaveToStream(astream,surface,'bmp');
    astream.Seek(0,tseekorigin.soBeginning);
    cFoto.Fill.Bitmap.bitmap.LoadFromStream(astream);
   finally
     astream.DisposeOf;
     bmp.DisposeOf;
     surface.DisposeOf;
end;
    actFoto.Execute;
    actNovaConta.Execute;

     {$IFDEF ANDROID}
     permissao.PhotoLibrary(actionLibrary, ErroPermissao);
     {$ENDIF}
end;

procedure TfrmLogin.img_cameraClick(Sender: TObject);
begin
    permissao.Camera(actionCamera, ErroPermissao);
end;

procedure TfrmLogin.Label2Click(Sender: TObject);
begin
    actLogin.Execute;
end;

procedure TfrmLogin.Layout7Click(Sender: TObject);
begin
     actNovaConta.Execute;
end;

procedure TfrmLogin.lblCancelarClick(Sender: TObject);
begin
    actNovaConta.Execute;
end;

procedure TfrmLogin.lbl_criarContaClick(Sender: TObject);
begin
    actNovaConta.Execute;
end;

procedure TfrmLogin.lytBotaoMenuClick(Sender: TObject);
begin
    if recMenu1.Tag = 0 then
      OpenMenu
    else
      CloseMenu;
end;

procedure TfrmLogin.recBotaoCriarContaClick(Sender: TObject);
begin
    FloatAnimationAcesso.TagString := 'NOVA-CONTA';
    FLOATanimationAcesso.start;
end;

procedure TfrmLogin.rect_botaoClick(Sender: TObject);
begin
     FloatAnimationAcesso.TagString := 'LOGIN';
     FloatAnimationAcesso.Start;
end;

procedure TfrmLogin.rect_botaoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
    TRectangle(sender).Opacity:= 0.6;
end;

procedure TfrmLogin.rect_botaoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
    TRectangle(sender).Opacity:= 1;
end;

end.

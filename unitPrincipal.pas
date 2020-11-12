unit unitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani, FMX.Layouts, FMX.ListBox,
  FMX.Edit, system.JSON, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView;

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
    Layout6: TLayout;
    Circle1: TCircle;
    Image1: TImage;
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
    Label6: TLabel;
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
    lytUltimasModificacoes: TLayout;
    Label3: TLabel;
    lblVerTodos: TLabel;
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
    Image9: TImage;
    Image10: TImage;
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
    lytDashBoard: TLayout;
    lvDashBoard: TListView;
    procedure FormResize(Sender: TObject);
    procedure img_inventarioClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AnimationWidthFinish(Sender: TObject);
    procedure AnimationWidthProcess(Sender: TObject);
    procedure   lytBotaoMenuClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Layout7Click(Sender: TObject);
    procedure img_sincronizarClick(Sender: TObject);
    procedure img_NotificationClick(Sender: TObject);
  private
    icone_selecionado: TBitmap;
    procedure OpenMenu;
    procedure CloseMenu;
    procedure selecionaIcone(img: TImage);
    { Private declarations }
  public
   cod_usuario : integer;
   nome_usuario, Email_usuario : string;

    { Public declarations }
  end;

var
  frmMainscreen: TfrmMainscreen;

implementation

{$R *.fmx}

uses unitInventario, unitSincronizar, unitLogin, untDM, cUsuario,
  unitNotificacao;


procedure TfrmMainscreen.img_inventarioClick(Sender: TObject);
begin
    //SelecionaIcone(TImage(Sender));
     if not Assigned (frmInventario) then
       Application.CreateForm(TfrmInventario, frmInventario);

       frmInventario.Show;
end;

procedure TfrmMainscreen.img_sincronizarClick(Sender: TObject);
begin
    if NOT Assigned(frmSincronizar) then
        Application.CreateForm(TFrmSincronizar, FrmSincronizar);

    FrmSincronizar.Show;
end;

procedure TfrmMainscreen.Layout7Click(Sender: TObject);
begin
        if not Assigned (frmInventario) then
       Application.CreateForm(TfrmInventario, frmInventario);

       frmInventario.Show;
       CloseMenu;
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
end;

procedure TfrmMainscreen.FormResize(Sender: TObject);
begin
      // redimenciona os icones dentro da tela
      ListBox1.Columns := Trunc(ListBox1.Width / 80);
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

end.

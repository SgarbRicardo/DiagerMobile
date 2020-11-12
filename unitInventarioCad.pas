unit unitInventarioCad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  FMX.DateTimeCtrls , FireDAC.Comp.Client, FireDAC.DApt,
  {$IFDEF ANDROID}
  FMX.VirtualKeyboard, FMX.Platform,
  {$ENDIF}
  FMX.StdActns, FMX.TabControl;

type
  TfrmInventarioCad = class(TForm)
    lytMenuTop: TLayout;
    lblTituloCad: TLabel;
    imgVoltar: TImage;
    imgAplicar: TImage;
    lytEquipment: TLayout;
    lbEquipment: TLabel;
    Line1: TLine;
    lytDateIn: TLayout;
    lblDateIn: TLabel;
    Line2: TLine;
    lytLocation: TLayout;
    lblLocation: TLabel;
    edtLocation: TEdit;
    Line3: TLine;
    lytAsset: TLayout;
    lblAsset: TLabel;
    edtAsset: TEdit;
    Line4: TLine;
    lytSerial: TLayout;
    lblSerial: TLabel;
    edtSerial: TEdit;
    Line5: TLine;
    lytBrand: TLayout;
    lblBrand: TLabel;
    edtBrand: TEdit;
    Line6: TLine;
    lytCategory: TLayout;
    lblCategory: TLabel;
    edtCategory: TEdit;
    Line7: TLine;
    lytVersion: TLayout;
    lblVersion: TLabel;
    edtVersion: TEdit;
    Line8: TLine;
    dt_empre_loc: TDateEdit;
    imgHoje: TImage;
    rectLixeira: TRectangle;
    imgLixeira: TImage;
    VertScrollBox1: TVertScrollBox;
    StyleBook1: TStyleBook;
    imgOpenCategory: TImage;
    Image1: TImage;
    TabControlInventarioioEdt: TTabControl;
    tbInventarioEdt: TTabItem;
    TbInventarioLoc: TTabItem;
    lblDescricao: TLabel;
    Image2: TImage;
    Layout1: TLayout;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgVoltarClick(Sender: TObject);
    procedure imgOpenCategoryClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgAplicarClick(Sender: TObject);
    procedure lblDescricaoClick(Sender: TObject);
  private
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    { Private declarations }
  public
      modo : string ;
      id_emp_pro, id_emp : integer; //ID do emprestimo a ser alterado

    { Public declarations }
  end;

var
  frmInventarioCad: TfrmInventarioCad;

implementation

{$R *.fmx}

uses untPrincipal, unitInventario, unitCategorias, cEmprestimo, untDM,
  unitCarregaEquipamento, unitCarregarUsuario;

procedure TfrmInventarioCad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      //..
      Action := TCloseAction.caFree;
      frmInventarioCad := nil;

    //  frmInventario.FloatAnimationTransicao.Start;
end;

procedure TfrmInventarioCad.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
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

                Key := 0;
                Close;
        end;
    end;
    {$ENDIF}
end;

procedure TfrmInventarioCad.FormShow(Sender: TObject);
 var
  empre : TEmprestimo;
  qry : TFDquery;
  erro : string;
begin
     if modo  ='I' then
     begin
        lblDescricao.Tag  := 0;
        lblDescricao.Text := '';
        edtLocation.Text  := '';
        edtAsset.Text := '';
        edtSerial.Text := '';
        edtBrand.Text := '';
        edtCategory.Text :='';
        edtVersion.Text :='';
        dt_empre_loc.Date := date;
        lblTituloCad.Text := ' New Asset';
        rectLixeira.Visible := false;
     end
     else
     begin
         try
          empre := TEmprestimo.Create(dm.Conn);
          empre.EMPRE_ID := id_emp;
          qry :=  empre.ListarEmprestimo(0,erro);

          if qry.RecordCount = 0 then
          begin
            ShowMessage('Ferramenta do inventario não encontrada ');
            exit
          end;
            lblDescricao.Text := qry.FieldByName('PROD_DESCRICAO').AsString;
            lblDescricao.Tag := qry.FieldByName('EMPRE_PROD_ID').AsInteger;
            edtLocation.Text := qry.FieldByName('USU_NOME').AsString;
            edtAsset.Text := qry.FieldByName('PROD_SNAP_TAG').AsString;
            //edtSerial.Text := qry.FieldByName('').AsString;
            edtBrand.Text := qry.FieldByName('PROD_MARCA').AsString;
            edtCategory.Text := qry.FieldByName('CAT_DESCRICAO').AsString;
            edtVersion.Text := qry.FieldByName('PROD_VERSAO').AsString;
            dt_empre_loc.Date := qry.FieldByName('EMPRE_DT_LOCACAO').AsDateTime;

            lblTituloCad.Text := ' Edit Asset';
         finally
           qry.DisposeOf;
           empre.DisposeOf;
         end;
     end;

end;

procedure TfrmInventarioCad.Image1Click(Sender: TObject);
begin
      if NOT Assigned (frmCarregarUsuario) then
        Application.CreateForm(TfrmCarregarUsuario, frmCarregarUsuario);

        frmCarregarUsuario.ShowModal(procedure(ModalResult: TModalResult)
    begin
        if frmCarregarUsuario.IdUsuarioSelecao > 0 then
        begin
            edtLocation.Text := frmCarregarUsuario.UsuarioSelecao;
            lblDescricao.Tag := frmCarregarUsuario.IdUsuarioSelecao;
        end;
    end);
end;

procedure TfrmInventarioCad.imgAplicarClick(Sender: TObject);
var
  empre : TEmprestimo;
  erro : string;
begin
     try
          empre := TEmprestimo.Create(dm.Conn);
          empre.EMPRE_PROD_ID := lblDescricao.Tag;
          empre.EMPRE_LOGIN_ID := frmCarregarUsuario.IdUsuarioSelecao;
          empre.EMPRE_DT_LOCACAO := dt_empre_loc.DateTime;
      //  empre.EMPRE_QTD := ed
          empre.EMPRE_SNAPON_TAG := edtAsset.toString;

            if modo  ='I' then
             empre.Inserir(erro)
            else
            begin
              empre.EMPRE_ID := id_emp;
              empre.Alterar(erro);
            end;
            if erro <> '' then
            begin
              ShowMessage(erro);
              exit
            end;

            close;
     finally
       empre.DisposeOf;
     end;

end;

procedure TfrmInventarioCad.imgOpenCategoryClick(Sender: TObject);
begin
    if NOT Assigned (frmCategorias) then
        Application.CreateForm(TfrmCategorias, frmCategorias);

        frmCategorias.show;
end;

procedure TfrmInventarioCad.imgVoltarClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmInventarioCad.lblDescricaoClick(Sender: TObject);
begin
    if NOT Assigned(frmCarregaEquipamento) then
        Application.CreateForm(TfrmCarregaEquipamento, frmCarregaEquipamento);

    frmCarregaEquipamento.ShowModal(procedure(ModalResult: TModalResult)
    begin
        if frmCarregaEquipamento.IdEquipamentoSelecao > 0 then
        begin
            lblDescricao.Text := frmCarregaEquipamento.EquipamentoSelecao;
            lblDescricao.Tag := frmCarregaEquipamento.IdEquipamentoSelecao;
        end;
    end);
end;

end.

unit unitInventarioCad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  FMX.DateTimeCtrls , FireDAC.Comp.Client, FireDAC.DApt , system.JSON,
  {$IFDEF ANDROID}
  FMX.VirtualKeyboard, FMX.Platform,
  {$ENDIF}
  FMX.StdActns, FMX.TabControl, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView;

type
  TCallBackInvenCad = Procedure of Object;

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
    rectLixeira: TRectangle;
    imgLixeira: TImage;
    VertScrollBox1: TVertScrollBox;
    StyleBook1: TStyleBook;
    imgOpenCategory: TImage;
    Image1: TImage;
    TabControlInventarioioEdt: TTabControl;
    tbInventarioEdt: TTabItem;
    lblDescricao: TLabel;
    Image2: TImage;
    Layout1: TLayout;
    tbiUsuario: TTabItem;
    lvUsuario: TListView;
    img_equip: TImage;
    img_semFoto: TImage;
    lblDateEntrada: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgVoltarClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgAplicarClick(Sender: TObject);
    procedure lblDescricaoClick(Sender: TObject);
    procedure lvUsuarioItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure imgAplicarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure imgAplicarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure AddUsuario(idUsuario : integer; Nome, Departamento: string{Photo: TStream});
    procedure ListaUsuarios;
    procedure processaDadosErro(Sender: Tobject);
    procedure ProcessaDadosusuario;
    function FormataData(dt: string): string;
    { Private declarations }
  public
      modo : string ;
      idUsuario,id_emp_pro, id_emp, Id_cat_global,Equip_Id : integer; //ID do emprestimo a ser alterado
      executeOnClose : TCallBackInvenCad;
    { Public declarations }
  end;

var
  frmInventarioCad: TfrmInventarioCad;

implementation

{$R *.fmx}

uses untPrincipal, unitCategorias, cEmprestimo, untDM,
  unitCarregaEquipamento, unitCarregarUsuario, unitPrincipal, REST.Types,
  uLoading, uFunctions;

procedure TfrmInventarioCad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      frmInventarioCad := nil;
      close;
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
begin
     TabControlInventarioioEdt.ActiveTab := tbInventarioEdt;

     if modo ='I' then
     begin
        lblDescricao.Tag  := 0;
        lblDescricao.Text := '';
        edtLocation.Text  := '';
        edtAsset.Text := '';
        edtSerial.Text := '';
        edtBrand.Text := '';
        edtCategory.Text :='';
        edtVersion.Text :='';
   //     lblDateEntrada.Text := FormatDateTime('dd/mm/yyyy hh:nn:ss',now );
        lblTituloCad.Text := ' New Asset';
        rectLixeira.Visible := false;
     end
     else
        lblTituloCad.Text := ' Edit Asset';
        //lblDateEntrada.Text := '';
        rectLixeira.Visible := false;
end;

// Entrada: dd/mm/yyyy hh:nn
// Saida: yyyy-mm-dd hh:nn
function TfrmInventarioCad.FormataData(dt: string): string;
begin
    Result := Copy(dt, 7, 4) + '-' + Copy(dt, 4, 2) + '-' + Copy(dt, 1, 2) + ' ' +
              Copy(dt, 12, 5) + ':00';
end;

procedure TfrmInventarioCad.Image1Click(Sender: TObject);
begin
    imgAplicar.Visible := false;
    TabControlInventarioioEdt.GotoVisibleTab(1,TTabTransition.Slide);
    ListaUsuarios;
    lblTituloCad.Text := 'User List';
end;

procedure TfrmInventarioCad.imgAplicarClick(Sender: TObject);
var
  jsonObj : TJSONObject;
  json, retorno: string;
begin
    try
      dm.Request_Inventario.Params.Clear;
      dm.Request_Inventario.AddParameter('id', '');
      if idUsuario > 0 then
      begin
        dm.Request_Inventario.Method := rmPATCH;
        dm.Request_Inventario.Resource := 'emprestimos/emprestimo';
        dm.Request_Inventario.AddParameter('Empre_ID',id_emp.ToString);
        dm.Request_Inventario.AddParameter('id_equip',Equip_Id.ToString);
        dm.Request_Inventario.AddParameter('Empre_Equip_Id', id_emp_pro.ToString);
        dm.Request_Inventario.AddParameter('Empre_Leasing', idusuario.ToString);
        dm.Request_Inventario.AddParameter('Empre_User_Id', idusuario.ToString);
      //  dm.request_inventario.addParameter('Empre_DT_Leasing',lblDateEntrada.Text);
        dm.Request_Inventario.Execute;
      end;

    except on ex:exception do
      begin
          showmessage('Erro ao acessar gravar: ' + ex.Message);
          exit;
      end;
    end;

    try
        json := dm.Request_Inventario.Response.JSONValue.ToString;
        jsonObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONObject;

        retorno := jsonObj.GetValue('retorno').Value;

        // Se deu erro...
        if ((dm.Request_Inventario.Response.StatusCode < 200) and
           (dm.Request_Inventario.Response.StatusCode > 201)) or (retorno <> 'OK') then
        begin
            showmessage(retorno);
            exit;
        end;

    finally

        if Assigned (executeOnClose) then
           executeOnClose;
        jsonObj.DisposeOf;
        close;
    end;
end;

procedure TfrmInventarioCad.imgAplicarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
    TImage(Sender).Opacity := 0.5;
end;

procedure TfrmInventarioCad.imgAplicarMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     TImage(Sender).Opacity := 1;
end;

procedure TfrmInventarioCad.imgVoltarClick(Sender: TObject);
begin
    if TabControlInventarioioEdt.ActiveTab.Index = 0 then
      close
    else
      TabControlInventarioioEdt.GotoVisibleTab(0,TTabTransition.Slide);
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

procedure TfrmInventarioCad.AddUsuario(idUsuario : integer;Nome, Departamento: string{ Photo: TStream});
var
  img : TListItemImage;
  txt : TListItemText;
  bmp : TBitmap;

begin
       with lvUsuario.Items.Add do
       begin
            tag := idUsuario;

            TListItemText(Objects.FindDrawable('txtNome')).Text := Nome;
            TListItemText(Objects.FindDrawable('txtDepartamento')).Text := Departamento;
          {  img := TListItemImage(Objects.FindDrawable('imgUsuario'));
            if Photo <> nil then
            begin
              bmp := TBitmap.Create;
              bmp.LoadFromStream(Photo);
              img.OwnsBitmap := true; // s� faz quando sta instaciando a imagem (bmp) em tempo de execu��o. se vier do banco nao precisa dela.
              img.Bitmap := bmp;
            end;   }
       end;
end;

procedure TfrmInventarioCad.ProcessaDadosusuario;
var
     // photo : TStream;
      erro, json: string;
      jsonArray : TjsonArray;
      i: integer;
begin
     try
        if dm.Request_Perfil.Response.StatusCode <> 200 then
        begin
          ShowMessage(erro);
          exit
        end;
        TLoading.Hide;
        json := dm.Request_Perfil.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONArray;

     except on ex:Exception do
        begin
          TLoading.Hide;
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
                        jsonArray.Get(i).getvalue<string>('Department', ''));
                                         //Photo);
        end;
    //   photo.DisposeOf;
       jsonArray.DisposeOf;
     finally
       lvUsuario.EndUpdate;
       lvUsuario.RecalcSize;
     end;
end;

procedure TfrmInventarioCad.processaDadosErro (Sender : Tobject);
begin
     TLoading.Hide;
  if Assigned(Sender) and (sender is Exception) then
     ShowMessage(Exception(sender).message);
end;

procedure TfrmInventarioCad.ListaUsuarios;
begin
    TLoading.Show(frmInventarioCad, 'Carregando...');
    try
    dm.Request_Perfil.Params.Clear;
    dm.Request_Perfil.Method := rmGET;
    dm.Request_Perfil.Resource := 'usuarios/DadosUsuario';
  //dm.Request_Perfil.AddParameter('id', '');
    dm.Request_Perfil.ExecuteAsync(ProcessaDadosusuario, true, true, processaDadosErro);
    except on ex:exception do
      begin
          TLoading.Hide;
          showmessage('Erro ao acessar o servidor: ' + ex.Message);
          exit;
      end;
    end;
end;

procedure TfrmInventarioCad.lvUsuarioItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
     edtLocation.Text := TListItemText(lvUsuario.Items[ItemIndex].Objects.FindDrawable('txtNome')).text;
     idUsuario := TListView(sender).Items[ItemIndex].tag;
     TabControlInventarioioEdt.GotoVisibleTab(0,TTabTransition.Slide);
     imgAplicar.Visible := true;
     lblTituloCad.Text := 'Edit location';
end;

end.

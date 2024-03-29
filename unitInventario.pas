unit unitInventario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Ani,
  FMX.Edit, data.DB, FireDAC.Comp.Client, FireDAC.DApt, FMX.TabControl, DateUtils, System.JSON,
  uFunctions, FMX.ListBox, unitFrameCategory, unitPrincipal,rest.client;

type
  TfrmInventario = class(TForm)
    lytMenuTop: TLayout;
    CircleUser: TCircle;
    Image1: TImage;
    imgNotification: TImage;
    lblTitulo_inventario: TLabel;
    rectInventarioList: TRectangle;
    lytMenuInferior: TLayout;
    rectMenuInferior: TRectangle;
    img_aba3: TImage;
    lytUltimasModificacoes: TLayout;
    lblEquip_user: TLabel;
    imgEquipment: TImage;
    rectTransi��o: TRectangle;
    Rectangle2: TRectangle;
    Layout1: TLayout;
    lblTituloCa: TLabel;
    imgVoltar: TImage;
    imgAplicar: TImage;
    FloatAnimationTransicao: TFloatAnimation;
    imgSinc: TImage;
    imgNaoSinc: TImage;
    TabControl1: TTabControl;
    tbiEquip: TTabItem;
    TabItem2: TTabItem;
    lvInventarioAll: TListView;
    lvInventario: TListView;
    imgCurrentLoc: TImage;
    imgPrevLoc: TImage;
    img_aba1: TImage;
    img_aba2: TImage;
    img_aba4: TImage;
    tbiCat: TTabItem;
    lbCategory: TListBox;
    rec_pesquisa: TRectangle;
    edt_buscar: TEdit;
    Image2: TImage;
    img_no_equip: TImage;
    Image3: TImage;
    Rectangle1: TRectangle;
    edt_busca_todos_equip: TEdit;
    Image4: TImage;
    Layout2: TLayout;
    lbl_all_equip: TLabel;
    img_No_cat: TImage;
    lv_inventario: TListView;
    Image5: TImage;
    Rectangle3: TRectangle;
    edt_buscaEquip: TEdit;
    imgBusca: TImage;
    Rectangle4: TRectangle;
    Layout3: TLayout;
    Rectangle5: TRectangle;
    Layout4: TLayout;
    lbMyEquips: TListBox;
    Image6: TImage;
    Layout5: TLayout;
    lblMyequip: TLabel;
    Rectangle6: TRectangle;
    procedure FormShow(Sender: TObject);
    procedure lvInventarioUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvInventarioItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure img_aba3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lbCategoryItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure lblVerTodosClick(Sender: TObject);
    procedure imgNotificationClick(Sender: TObject);
    procedure lv_inventarioItemClickEx(const Sender: TObject;
      ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure imgBuscaClick(Sender: TObject);
    procedure lbMyEquipsItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure lblMyequipClick(Sender: TObject);
  private
    dt_filtro : TDate;
    procedure TransitionForm(sender: TObject);
    procedure NavegarMes(num_mes: integer);
    procedure listarEmprestimosLocal(busca: string; ind_clear: boolean;
      pagina: integer);
    procedure ProcesseEmprestimoErro(Sender: TObject);
    //procedure processarEmprestimo(id_usuario, equipamento: string; cat_id: integer);
    procedure img_aba1Click(Sender: TObject);
    procedure ProcessarEquipamentos;
    procedure AddEquipamentos(Empre_Prod_ID, EMPRE_ID, Equipamento, Brand,
      Location, Serial, SnaponTag, Dte: string);
    procedure ListarQTDCateg;
    procedure processarQtdCateg;
    procedure processarQtdCategErro(Sender: TObject);
    procedure RefreshListaEquips;

    { Private declarations }
  public
    cod_usuario_logado_ : integer;
    id_cat_global, titulo_cat : string;
  // procedure listarTodosEmprestimos(busca: string; ind_clear: boolean;
      //pagina: integer);
    procedure carregarCategorias;
    procedure AddLancamentos(empre_id,Equip_Id, {Empre_Prod_ID,} Equipamento, Brand, Location, Serial, SnaponTag: string;
                             Dte: string);
                            // qtd: integer;
                           //  Photo: TStream);
    procedure listarEmprestimos(cod_usuario_logado: integer; id_cat_global, busca: string);
    procedure SetupLancamento(lv: TListView; Item: TListViewItem);
    procedure MudarAba(img: TImage);
    procedure ListarEquipamentos;
    { Public declarations }
  end;

var
  frmInventario: TfrmInventario;

implementation

{$R *.fmx}

uses untPrincipal, unitInventarioCad, untDM, cEmprestimo,
  unitCarregaEquipamento, unitCarregaUsuario, unitCarregarUsuario, unitLogin,
  uLoading,REST.Types;

procedure TfrmInventario.MudarAba(img: TImage);
begin
    img_aba1.Opacity := 0.3;
    img_aba2.Opacity := 0.3;
    img_aba3.Opacity := 0.3;
    img_aba4.Opacity := 0.3;

    img.Opacity := 1;
    TabControl1.GotoVisibleTab(img.Tag, TTabTransition.Slide);
end;

procedure TfrmInventario.imgBuscaClick(Sender: TObject);
var
  id_cat_vazio : integer;
begin
     id_cat_vazio :=0;
     id_cat_global := id_cat_vazio.ToString;
     frmMainscreen.cod_usuario_logado := 0;
     listarEmprestimos(frmMainscreen.cod_usuario_logado, id_cat_global, edt_buscaEquip.Text);
end;

procedure TfrmInventario.imgNotificationClick(Sender: TObject);
begin
   // listarEmprestimos(cod_usuario_logado, id_cat_global);
end;

procedure TfrmInventario.img_aba1Click(Sender: TObject);
begin
    MudarAba(TImage(Sender));
end;

procedure TfrmInventario.NavegarMes(num_mes : integer);
begin
    dt_filtro:= IncMonth(dt_filtro,num_mes);
end;

procedure TfrmInventario.AddLancamentos(EMPRE_ID,Equip_Id, {Empre_Prod_ID,} Equipamento, Brand, Location, Serial, SnaponTag: string;
                                        Dte: string);
                                        //Photo : TStream);
var
  img: TListItemImage;
  txt : TListItemText;
  bmp : TBitmap;
begin
    try
       with lv_Inventario.Items.Add do
       begin
            TagString := EMPRE_ID;
           // Tag := Empre_Prod_ID.ToInteger;
            Tag:= Equip_Id.ToInteger;

            TListItemText(Objects.FindDrawable('txtEquipment')).Text := Equipamento;
            TListItemText(Objects.FindDrawable('txtBrand')).Text := Brand;
            TListItemText(Objects.FindDrawable('txtLocation')).Text := Location;  // Name of user determine the location - Ricardo, Obeya....
            TListItemText(Objects.FindDrawable('txtSerial')).Text :=  Serial;
            TListItemText(Objects.FindDrawable('txtTag')).Text := SnaponTag;
            TListItemText(Objects.FindDrawable('txtData')).Text := Copy(Dte, 1, 5);
            TListItemimage(Objects.FindDrawable('imgCurrentLoc')).bitmap:= imgCurrentLoc.bitmap;
            TListItemimage(Objects.FindDrawable('imgPrevLoc')).bitmap:= imgPrevLoc.bitmap;

           { img := TListItemImage(Objects.FindDrawable('imgPhoto'));
              if Photo <> nil then
                begin
                  bmp := TBitmap.Create;
                  bmp.LoadFromStream(Photo);

                  img.OwnsBitmap := true; // s� faz quando sta instaciando a imagem (bmp) em tempo de execu��o. se vier do banco nao precisa dela.
                  img.Bitmap := bmp;
                end
              else
                TListItemimage(Objects.FindDrawable('imgPhoto')).bitmap:= imgEquipment.bitmap; }

          {  //icone sincronismo
         img := TListItemImage(Objects.FindDrawable('imgSinc'));
            if ind_sinc = 'S'  then      // S Sincronizado
               img.Bitmap := imgSinc.Bitmap
            else
               img.Bitmap := imgNaoSinc.Bitmap;  }
       end;
    finally
    end;
end;

Procedure TfrmInventario.ProcesseEmprestimoErro(Sender: TObject);
begin
  if Assigned(sender) and (sender is Exception) then
  begin
      showmessage(Exception(sender).Message);
  end;
end;

procedure TfrmInventario.listarEmprestimos(cod_usuario_logado: integer; id_cat_global, busca:string);
var
  i : integer;
  jsonArray: TJsonArray;
  erro: string;
begin
      img_no_equip.Visible := false;
    if NOT dm.ListarInventario(frmMainscreen.cod_usuario_logado.ToString, id_cat_global,edt_buscaEquip.Text , jsonArray, erro) then
    begin
      ShowMessage(erro);
      exit;
    end;
    try
      lv_Inventario.Items.Clear;
      lv_Inventario.BeginUpdate;
    for i := 0 to jsonArray.Size -1 do
      begin
        AddLancamentos(jsonArray.Get(i).GetValue<string>('Empre_Id', ''),
                      //jsonArray.Get(i).GetValue<string>('user_id', frmMainscreen.cod_usuario_logado.ToString),
                      jsonArray.Get(i).GetValue<string>('Equip_Id', ''),
                      jsonArray.Get(i).GetValue<string>('DESCRIPTION', ''),
                      jsonArray.Get(i).GetValue<string>('SUPPLIER', ''),
                      jsonArray.Get(i).GetValue<string>('name', ''),
                      jsonArray.Get(i).GetValue<string>('SERIAL_NUMBER', ''),
                      jsonArray.Get(i).GetValue<string>('SNAP_TAG', ''),
                      jsonArray.Get(i).GetValue<string>('Empre_DT_Leasing', '01/01/2000 00:00:00'));
      end;
      img_no_equip.Visible := jsonarray.size = 0;
      jsonArray.DisposeOf;
    finally
      lv_Inventario.EndUpdate;
      lv_Inventario.RecalcSize;
    end;
end;

procedure TfrmInventario.listarEmprestimosLocal(busca: string; ind_clear: boolean; // configured to get data from local DB
  pagina: integer);
  {var
      photo: TStream;
      qry : TFDQuery;
      empre : TEmprestimo;
      erro: string;}
begin
{     try
        empre := TEmprestimo.Create(dm.Conn);
        qry := empre.ListarEmprestimo(3,erro);

        if erro <> '' then
        begin
          ShowMessage(erro);
          exit
        end;

        if ind_clear then
        lvInventario.Items.Clear;

        lvInventario.BeginUpdate;
        while not qry.Eof do
        begin
             if qry.FieldByName('PROD_FOTO').AsString <>'' then
                photo := qry.CreateBlobStream(qry.FieldByName('PROD_FOTO'),TBlobStreamMode.bmRead)
             else
                photo := nil;

             AddLancamentos(lvInventario,
                         qry.FieldByName('EMPRE_ID').AsString,
                         qry.FieldByName('EMPRE_PROD_ID').AsString,
                         qry.FieldByName('PROD_DESCRICAO').AsString,
                         qry.FieldByName('PROD_MARCA').AsString,
                         qry.FieldByName('USU_NOME').AsString,
                         qry.FieldByName('EMPRE_IND_SINC').AsString,
                         //qry.FieldByName('PROD_VERSAO').asfloat,
                         qry.FieldByName('PROD_SNAP_TAG').AsInteger,
                         qry.FieldByName('EMPRE_DT_LOCACAO').AsDateTime,
                         qry.FieldByName('PROD_QTD').AsInteger,
                         Photo);
            qry.Next;
            photo.DisposeOf;
        end;
          lvInventario.EndUpdate;
     finally
         empre.DisposeOf;
     end;}
end;

procedure TfrmInventario.lbCategoryItemClick(const Sender: TCustomListBox;  const Item: TListBoxItem);
begin
    edt_buscaEquip.Text := '';
    id_cat_global := item.tag.ToString;
    frmMainscreen.cod_usuario_logado := 0;
    listarEmprestimos(frmMainscreen.cod_usuario_logado,id_cat_global, edt_buscaEquip.Text);
    lblTitulo_inventario.Text := '<<'+item.TagString+'>>';
    lblTitulo_inventario.Font.Size := 15;
end;

procedure TfrmInventario.lblMyequipClick(Sender: TObject);
begin
    MudarAba(img_aba2);
    lblTitulo_inventario.Text := 'My Equipments';
    ListarQTDCateg;
end;

procedure TfrmInventario.lblVerTodosClick(Sender: TObject);
begin
    MudarAba(img_aba1);
    lblTitulo_inventario.Text := 'All Equipments';
end;

procedure TfrmInventario.lbMyEquipsItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
    edt_buscaEquip.Text := '';
    id_cat_global := item.tag.ToString;
    ListarEquipamentos;
    lblTitulo_inventario.Text := '<<'+item.TagString+'>>';
    lblTitulo_inventario.Font.Size := 15;
end;

procedure TfrmInventario.SetupLancamento(lv: TListView;
                                        Item: TListViewItem);
var
 txt : TListItemText;
 img : TListItemImage;
 begin
        //ajusta o tamanho  da string equipment
       txt := TListItemText(Item.Objects.FindDrawable('txtEquipment'));
       txt.width := lv.Width - 160;
       txt.WordWrap := true;

       txt := TListItemText(Item.Objects.FindDrawable('txtBrand'));
       txt.Width := lv.Width - 170;

       if TListItemText(Item.Objects.FindDrawable('txtSerial')).text = '' then
       begin
          TListItemText(Item.Objects.FindDrawable('txtSerial')).Text := 'Serial N/A';
       end;

       if TListItemText(Item.Objects.FindDrawable('txtPrevLocation')).text = '' then
       begin
        TListItemText(Item.Objects.FindDrawable('txtPrevLocation')).Text := 'Location N/A';
       end;

       img := TListItemImage(Item.Objects.FindDrawable('imgPhoto'));
       //esconde a imagem a redimensiona os objetos na tela.
       if lv.Width < 300 then
       begin
         img.Visible := false;
         txt.PlaceOffset.X := 2;
       end;

     // calcula altura item da list view
      item.Height := Trunc(txt.PlaceOffset.Y + txt.Height + 70);
      if lv.width < 390 then
      item.height := Item.Height + 20;
end;

procedure TfrmInventario.TransitionForm(sender: TObject);
begin

end;

procedure TfrmInventario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    frmInventario := nil;
    Close;
end;

procedure TfrmInventario.FormCreate(Sender: TObject);
begin
     cod_usuario_logado_:= frmMainscreen.cod_usuario_logado;
     MudarAba(img_aba1);
end;

procedure TfrmInventario.FormShow(Sender: TObject);
begin
      carregarCategorias;
      lblTitulo_inventario.Text := 'All Equipments by Cat.';
end;

procedure TfrmInventario.carregarCategorias;
var
    i : integer;
    item : TListBoxItem;
    frame : TFrame_Categoria;
    jsonArray : TJsonArray;
    erro, icone64 : string;
begin
    lbCategory.Items.Clear;
    lbCategory.Align := TAlignLayout.Scale;

    if NOT dm.ListarCategoria(jsonArray,erro) then
    begin
      ShowMessage(erro);
      exit;
    end;

    for i := 0 to jsonArray.Size - 1 do
    begin
        item := TListBoxItem.Create(lbCategory);
        item.Text := '';
        item.Width := 95;
        item.Height := 70;
        item.TextAlign := TTextAlign.Center;
        item.Selectable := false;
        item.tag := jsonArray.Get(i).GetValue<integer>('Cat_Id', 0);
        item.tagstring := jsonArray.Get(i).GetValue<string>('CAT_DESCRIPTION', '');

        frame := TFrame_Categoria.Create(item);
        frame.Parent := item;
        frame.Align := TAlignLayout.client;
        frame.Margins.Top := 40;

        frame.lbl_desc.Text := jsonArray.Get(i).GetValue<string>('CAT_DESCRIPTION', '');
        frame.lbl_qtd.text := jsonArray.Get(i).GetValue<string>('qtd_Cate', '');
        icone64 := jsonArray.Get(i).GetValue<string>('CAT_PHOTO', '');

        try
            if icone64 <> '' then
                frame.img_cat.Bitmap := TFunctions.BitmapFromBase64(icone64)
            else
                img_No_cat.Visible := jsonarray.size = 0;
        except

        end;
        lbCategory.AddObject(item);
    end;
    jsonArray.DisposeOf;
end;

procedure TfrmInventario.Image1Click(Sender: TObject);
begin
      if TabControl1.ActiveTab.Index = 0 then
        close
      else
      if TabControl1.ActiveTab.Index = 1 then
      begin
        TabControl1.GotoVisibleTab(0,TTabTransition.Slide);
        edt_buscaEquip.Text := '';
        lblTitulo_inventario.Text := 'All Equipments';
        MudarAba(img_aba1);
        carregarCategorias;
      end
      else
      if TabControl1.ActiveTab.Index = 2 then
      begin
        TabControl1.GotoVisibleTab(1,TTabTransition.Slide);
        edt_buscar.Text :='';
        lblTitulo_inventario.Text := 'My Equipments';
        MudarAba(img_aba2);
        ListarQTDCateg;
      end;
end;

procedure TfrmInventario.img_aba3Click(Sender: TObject);
begin
     MudarAba(Timage(Sender));
     edt_buscar.Text :='';
     lblTitulo_inventario.Text := 'My Equipments';
     ListarQTDCateg;
end;

procedure TfrmInventario.RefreshListaEquips;
begin
    lblTitulo_inventario.Text := 'My Equipments';
    ListarEquipamentos;
    MudarAba(img_aba2);
end;

procedure TfrmInventario.lvInventarioItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
     if ItemObject <> nil then
     begin
      if assigned(ItemObject) then
        //if TListItemText(ItemObject).Text = TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtLocation')).Text then
        if ItemObject.Name = 'txtLocation' then
        begin
           if NOT Assigned(frmInventarioCad) then
              Application.CreateForm(TfrmInventarioCad, frmInventarioCad);

              frmInventarioCad.Id_cat_global := id_cat_global.ToInteger;
              frmInventarioCad.id_emp_pro := TListView(sender).Items[ItemIndex].Tag;
              frmInventarioCad.id_emp := TListView(sender).Items[ItemIndex].TagString.ToInteger;
              frmInventarioCad.edtAsset.Text := TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtTag')).Text;
              frmInventarioCad.lblDescricao.Text := TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtEquipment')).Text;
              frmInventarioCad.lblLocation.Tag := frmMainscreen.cod_usuario_logado;
              frmInventarioCad.edtLocation.Text := TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtLocation')).Text;
              frmInventarioCad.edtBrand.Text := TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtBrand')).Text;
              frmInventarioCad.lblDateEntrada.Text := TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtData')).Text;
              frmInventarioCad.executeOnClose := RefreshListaEquips;

              frmInventarioCad.Show;
        end;
     end;

end;

procedure TfrmInventario.lvInventarioUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
    SetupLancamento(frmInventario.lvInventario, AItem);
end;

procedure TfrmInventario.lv_inventarioItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
    if ItemObject <> nil then
    begin
        //if TListItemText(ItemObject).Text = TListItemText(lv_inventario.Items[ItemIndex].Objects.FindDrawable('txtLocation')).Text then
        if ItemObject.Name = 'txtLocation' then
        begin
           if NOT Assigned(frmInventarioCad) then
              Application.CreateForm(TfrmInventarioCad, frmInventarioCad);

              frmInventarioCad.Id_cat_global := id_cat_global.ToInteger;
              frmInventarioCad.Equip_Id := TListView(sender).Items[ItemIndex].Tag;
              //frmInventarioCad.id_emp := TListView(sender).Items[ItemIndex].TagString.ToInteger;
              frmInventarioCad.edtAsset.Text := TListItemText(lv_inventario.Items[ItemIndex].Objects.FindDrawable('txtTag')).Text;
              frmInventarioCad.lblDescricao.Text := TListItemText(lv_inventario.Items[ItemIndex].Objects.FindDrawable('txtEquipment')).Text;
              frmInventarioCad.lblLocation.Tag := frmMainscreen.cod_usuario_logado;
              frmInventarioCad.edtLocation.Text := TListItemText(lv_inventario.Items[ItemIndex].Objects.FindDrawable('txtLocation')).Text;
              frmInventarioCad.edtBrand.Text := TListItemText(lv_inventario.Items[ItemIndex].Objects.FindDrawable('txtBrand')).Text;
              frmInventarioCad.Show;
        end;
    end;
end;

procedure TfrmInventario.AddEquipamentos(Empre_Prod_ID, EMPRE_ID, Equipamento, Brand, Location, Serial, SnaponTag: string;
                                        Dte: string);
                                        //Photo : TStream);
var
  img: TListItemImage;
  txt : TListItemText;
  bmp : TBitmap;

begin
    try
       with lvinventario.Items.Add do
       begin
            Tag := Empre_Prod_ID.ToInteger;
            TagString := EMPRE_ID;

            TListItemText(Objects.FindDrawable('txtEquipment')).Text := Equipamento;
            TListItemText(Objects.FindDrawable('txtBrand')).Text := Brand;
            TListItemText(Objects.FindDrawable('txtLocation')).Text := Location;  // Name of user determine the location - Ricardo, Obeya....
            TListItemText(Objects.FindDrawable('txtSerial')).Text :=  Serial;
            TListItemText(Objects.FindDrawable('txtTag')).Text := SnaponTag;
            TListItemText(Objects.FindDrawable('txtData')).Text := Copy(Dte, 1, 5);
            TListItemimage(Objects.FindDrawable('imgCurrentLoc')).bitmap:= imgCurrentLoc.bitmap;
            TListItemimage(Objects.FindDrawable('imgPrevLoc')).bitmap:= imgPrevLoc.bitmap;

           { img := TListItemImage(Objects.FindDrawable('imgPhoto'));
              if Photo <> nil then
                begin
                  bmp := TBitmap.Create;
                  bmp.LoadFromStream(Photo);

                  img.OwnsBitmap := true; // s� faz quando sta instaciando a imagem (bmp) em tempo de execu��o. se vier do banco nao precisa dela.
                  img.Bitmap := bmp;
                end
              else
                TListItemimage(Objects.FindDrawable('imgPhoto')).bitmap:= imgEquipment.bitmap; }

          {  //icone sincronismo
         img := TListItemImage(Objects.FindDrawable('imgSinc'));
            if ind_sinc = 'S'  then      // S Sincronizado
               img.Bitmap := imgSinc.Bitmap
            else
               img.Bitmap := imgNaoSinc.Bitmap;  }
       end;
    finally
    end;
end;

procedure TfrmInventario.ListarEquipamentos();
begin
    TLoading.Show(frmInventario, 'Carregando...');
    try
      dm.Request_Inventario.Params.Clear;
      dm.Request_Inventario.Method := rmGET;
      dm.Request_Inventario.Resource := 'emprestimos/emprestimo';
      dm.Request_Inventario.AddParameter('busca',edt_buscar.Text);
      dm.Request_Inventario.AddParameter('id_usuario',cod_usuario_logado_.ToString);
      dm.Request_Inventario.AddParameter('Cat_Id', id_cat_global);
      dm.Request_Inventario.ExecuteAsync(ProcessarEquipamentos, true, true, ProcesseEmprestimoErro);
    except on ex:exception do
      begin
          TLoading.Hide;
          showmessage('Erro ao acessar o servidor: ' + ex.Message);
          exit;
      end;
    end;
end;

procedure TfrmInventario.ProcessarEquipamentos;
var
    jsonArray : TJsonArray;
    json, retorno : string;
    i : integer;
begin
    try
        img_no_equip.Visible := false;
        // Se deu erro...
        if dm.Request_Inventario.Response.StatusCode <> 200 then
        begin
            showmessage('Erro ao consultar os equipamentos do invent�rio');
            exit;
        end;

        TLoading.Hide;
        json := dm.Request_Inventario.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.ANSI.GetBytes(json), 0) as TJSONArray;

    except on ex:exception do
        begin
            TLoading.Hide;
            showmessage(ex.Message);
            exit;
        end;
    end;

     try
      lvinventario.ScrollTo(0);
      lvinventario.Items.Clear;
      lvinventario.BeginUpdate;

    for i := 0 to jsonArray.Size -1 do
      begin
      AddEquipamentos(jsonArray.Get(i).GetValue<string>('Empre_Equip_Id', ''),
                      jsonArray.Get(i).GetValue<string>('Empre_Id', ''),
                      jsonArray.Get(i).GetValue<string>('DESCRIPTION', ''),
                      jsonArray.Get(i).GetValue<string>('SUPPLIER', ''),
                      jsonArray.Get(i).GetValue<string>('name', ''),
                      jsonArray.Get(i).GetValue<string>('SERIAL_NUMBER', ''),
                      jsonArray.Get(i).GetValue<string>('SNAP_TAG', ''),
                      jsonArray.Get(i).GetValue<string>('Empre_DT_Leasing', '01/01/2000')
                      );
      end;
       img_no_equip.Visible := jsonarray.size = 0;
       jsonArray.DisposeOf;
    finally
      lvinventario.EndUpdate;
      lvinventario.RecalcSize;
    end;
end;

//lista as categorias com a qtd de equips vinculadas a ela, de acordo com o usuario logado
procedure TfrmInventario.ListarQTDCateg();
begin
    TLoading.Show(frmInventario, 'Carregando...');
    try
      dm.RequestCategory.Params.Clear;
      dm.RequestCategory.Resource := 'Categorias/ListarQtdCat';
      dm.RequestCategory.AddParameter('id_usuario',cod_usuario_logado_.ToString);
      dm.RequestCategory.ExecuteAsync(processarQtdCateg, true, true, processarQtdCategErro);

    except on ex:exception do
      begin
          TLoading.Hide;
          showmessage('Erro ao acessar o servidor: ' + ex.Message);
          exit;
      end;
    end;
end;

procedure TfrmInventario.processarQtdCategErro(Sender: TObject);
begin
    TLoading.Hide;
    if Assigned(Sender) and (Sender is Exception) then
       ShowMessage(Exception(Sender).Message);
end;

procedure TfrmInventario.processarQtdCateg;
var
    i : integer;
    item : TListBoxItem;
    frame : TFrame_Categoria;
    jsonArray : TJsonArray;
    erro,json : string;
begin
    lbMyEquips.Items.Clear;
    lbMyEquips.Align := TAlignLayout.Scale;

    try
        // Se deu erro...
        if dm.RequestCategory.Response.StatusCode <> 200 then
        begin
            showmessage('Erro ao consultar as qtds de categorias');
            exit;
        end;

        TLoading.Hide;
        json := dm.RequestCategory.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONArray;

    except on ex:exception do
        begin
            TLoading.Hide;
            showmessage(ex.Message);
            exit;
        end;
    end;

    for i := 0 to jsonArray.Size - 1 do
    begin
        item := TListBoxItem.Create(lbMyEquips);
        item.Text := '';
        item.Width := 95;
        item.Height := 80;
        item.Selectable := false;
        item.Margins.top := 7;
        item.tag := jsonArray.Get(i).GetValue<integer>('Cat_Id', 0);
        item.tagstring := jsonArray.Get(i).GetValue<string>('EQUIP_ID', '');

        frame := TFrame_Categoria.Create(item);
        frame.Parent := item;
        frame.Align := TAlignLayout.client;
        frame.Margins.Top := 30;

        frame.lbl_desc.Text := jsonArray.Get(i).GetValue<string>('CAT_DESCRIPTION', '');
        frame.lbl_qtd.text := jsonArray.Get(i).GetValue<string>('qtd_Cate', '');

        lbMyEquips.AddObject(item);
    end;
    jsonArray.DisposeOf;
end;

end.

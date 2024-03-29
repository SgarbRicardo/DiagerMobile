unit unitInventarioList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Ani,
  FMX.Edit, data.DB, FireDAC.Comp.Client, FireDAC.DApt, FMX.TabControl, DateUtils, System.JSON,
  uFunctions, FMX.ListBox, unitFrameCategory, unitPrincipal;

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
    lblVerTodos: TLabel;
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
    lytPesquisa: TLayout;
    recPesquisa: TRectangle;
    imgSearch: TImage;
    edt_Category: TEdit;
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
    procedure FormShow(Sender: TObject);
    procedure lvInventarioUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvInventarioItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure img_aba3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure lbCategoryItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure FormActivate(Sender: TObject);
    procedure lblVerTodosClick(Sender: TObject);
    procedure imgNotificationClick(Sender: TObject);
  private
    dt_filtro : TDate;
    procedure TransitionForm(sender: TObject);
    procedure NavegarMes(num_mes: integer);
    procedure listarEmprestimosLocal(busca: string; ind_clear: boolean;
      pagina: integer);
    procedure ProcesseEmprestimoErro(Sender: TObject);
    //procedure processarEmprestimo(id_usuario, equipamento: string; cat_id: integer);

    procedure MudarAba(img: TImage);
    procedure img_aba1Click(Sender: TObject);

    { Private declarations }
  public
    id_cat_global,cod_usuario_logado : integer;
  // procedure listarTodosEmprestimos(busca: string; ind_clear: boolean;
      //pagina: integer);
    procedure carregarCategorias;
    procedure AddLancamentos(empre_id, Empre_Prod_ID, Equipamento, Brand, Location, Serial, SnaponTag: string;
                             Dte: string);
                            // qtd: integer;
                           //  Photo: TStream);
    procedure listarEmprestimos(cod_usuario_logado, id_cat_global: integer);
    procedure SetupLancamento(lv: TListView; Item: TListViewItem);
    { Public declarations }
  end;

var
  frmInventario: TfrmInventario;

implementation

{$R *.fmx}

uses untPrincipal, unitInventarioCad, untDM, cEmprestimo,
  unitCarregaEquipamento, unitCarregaUsuario, unitCarregarUsuario, unitLogin,
  uLoading;

procedure TfrmInventario.MudarAba(img: TImage);
begin
    img_aba1.Opacity := 0.3;
    img_aba2.Opacity := 0.3;
    img_aba3.Opacity := 0.3;
    img_aba4.Opacity := 0.3;

    img.Opacity := 1;
    TabControl1.GotoVisibleTab(img.Tag, TTabTransition.Slide);
end;

procedure TfrmInventario.imgNotificationClick(Sender: TObject);
begin
    listarEmprestimos(cod_usuario_logado, id_cat_global);
end;

procedure TfrmInventario.img_aba1Click(Sender: TObject);
begin
    MudarAba(TImage(Sender));
end;

procedure TfrmInventario.NavegarMes(num_mes : integer);
begin
    dt_filtro:= IncMonth(dt_filtro,num_mes);

end;

procedure TfrmInventario.AddLancamentos(EMPRE_ID, Empre_Prod_ID, Equipamento, Brand, Location, Serial, SnaponTag: string;
                                        Dte: string);
                                        //Photo : TStream);
var
  img: TListItemImage;
  txt : TListItemText;
  bmp : TBitmap;

begin
    try
       with lvInventario.Items.Add do
       begin
            TagString := EMPRE_ID;
            Tag := Empre_Prod_ID.ToInteger;

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


procedure TfrmInventario.listarEmprestimos(cod_usuario_logado,id_cat_global: integer);
var
  i : integer;
  jsonArray: TJsonArray;
  erro: string;
begin
    img_no_equip.Visible := false;
    if NOT dm.ListarInventario(frmMainscreen.cod_usuario_logado.ToString, id_cat_global, jsonArray, erro) then
    begin
      ShowMessage(erro);
      exit;
    end;
    try
      lvInventario.Items.Clear;
      lvInventario.BeginUpdate;

    for i := 0 to jsonArray.Size -1 do
      begin
        AddLancamentos(jsonArray.Get(i).GetValue<string>('Empre_Id', ''),
                      //jsonArray.Get(i).GetValue<string>('user_id', frmMainscreen.cod_usuario_logado.ToString),
                      jsonArray.Get(i).GetValue<string>('Empre_Equip_Id', ''),
                      jsonArray.Get(i).GetValue<string>('EQUIP_DESCRIPTION', ''),
                      jsonArray.Get(i).GetValue<string>('EQUIP_Make', ''),
                      jsonArray.Get(i).GetValue<string>('name', ''),
                      jsonArray.Get(i).GetValue<string>('Equip_Serial', ''),
                      jsonArray.Get(i).GetValue<string>('EQUIP_SNAP_TAG', ''),
                      jsonArray.Get(i).GetValue<string>('Empre_DT_Leasing', '01/01/2000 00:00:00')
                      );
      end;
      img_no_equip.Visible := jsonarray.size = 0;
      jsonArray.DisposeOf;
    finally
      lvInventario.EndUpdate;
      lvInventario.RecalcSize;
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
var
cod_usuario_logado: integer;
begin
    id_cat_global := item.Tag;
    listarEmprestimos(frmMainscreen.cod_usuario_logado,id_cat_global);
    MudarAba(img_aba2);
    lblTitulo_inventario.Text := 'My Equipments';
end;

procedure TfrmInventario.lblVerTodosClick(Sender: TObject);
begin
    MudarAba(img_aba3);
    lblTitulo_inventario.Text := 'All Equipments';
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
      // txt.height := TFunctions.GetTextHeight(txt, txt.Width, txt.text);
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

procedure TfrmInventario.FormActivate(Sender: TObject);
begin
 //   MudarAba(img_aba1);
end;

procedure TfrmInventario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    frmInventario := nil;
    Close;
end;

procedure TfrmInventario.FormCreate(Sender: TObject);
begin
     MudarAba(img_aba1);
end;

procedure TfrmInventario.FormResize(Sender: TObject);
begin
     lbCategory.Columns := trunc(lbCategory.Width / 105);
end;

procedure TfrmInventario.FormShow(Sender: TObject);
var
  Photo : TStream;
begin
  //  TabControl1.ActiveTab := TabItem3;
//    Photo := TMemoryStream.Create;
//    imgEquipment.Bitmap.SaveToStream(Photo);
//    photo.Position := 0;
//
//    dt_filtro := Date;
//    listarEmprestimos();
//
//      photo.DisposeOf;

      carregarCategorias;
      lblTitulo_inventario.Text := 'Categories';

end;

procedure TfrmInventario.carregarCategorias;
var
    i : integer;
    item : TListBoxItem;
    frame : TFrame2;
    jsonArray : TJsonArray;
    erro, icone64 : string;
begin
    lbCategory.Items.Clear;

    if NOT dm.ListarCategoria(jsonArray,erro) then
    begin
      ShowMessage(erro);
      exit;
    end;

    for i := 0 to jsonArray.Size - 1 do
    begin
        item := TListBoxItem.Create(lbCategory);
        item.Text := '';
        item.Width := 105;
        item.Height := 150;
        item.Selectable := false;
        item.Tag := jsonArray.Get(i).GetValue<integer>('CAT_ID', 0);

        frame := TFrame2.Create(item);
        frame.Parent := item;
        frame.Align := TAlignLayout.Client;

        frame.lbl.Text := jsonArray.Get(i).GetValue<string>('CAT_DESCRIPTION', '');

        icone64 := jsonArray.Get(i).GetValue<string>('CAT_PHOTO', '');

        try
            if icone64 <> '' then
                frame.img_cat.Bitmap := TFunctions.BitmapFromBase64(icone64);
        except
            img_No_cat.Visible := jsonarray.size = 0;
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
        lblTitulo_inventario.Text := 'Categories';
        MudarAba(img_aba1);
      end
      else
      if TabControl1.ActiveTab.Index = 2 then
      begin
        TabControl1.GotoVisibleTab(1,TTabTransition.Slide);
        lblTitulo_inventario.Text := 'My Equipments';
        MudarAba(img_aba2);
      end;
end;

procedure TfrmInventario.img_aba3Click(Sender: TObject);
begin
     MudarAba(Timage(Sender));
end;

procedure TfrmInventario.lvInventarioItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
    if TListItemText(ItemObject).Text = TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtLocation')).Text then
    begin
       if NOT Assigned(frmInventarioCad) then
          Application.CreateForm(TfrmInventarioCad, frmInventarioCad);

          frmInventarioCad.Id_cat_global := id_cat_global;
          frmInventarioCad.id_emp_pro := TListView(sender).Items[ItemIndex].Tag;
          frmInventarioCad.id_emp := TListView(sender).Items[ItemIndex].TagString.ToInteger;
          frmInventarioCad.edtAsset.Text := TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtTag')).Text;
          frmInventarioCad.lblDescricao.Text := TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtEquipment')).Text;
          frmInventarioCad.lblLocation.Tag := frmMainscreen.cod_usuario_logado;
          frmInventarioCad.edtLocation.Text := TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtLocation')).Text;
          frmInventarioCad.edtBrand.Text := TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtBrand')).Text;
          frmInventarioCad.Show;
    end;
end;

procedure TfrmInventario.lvInventarioUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
    SetupLancamento(frmInventario.lvInventario, AItem);
end;

end.

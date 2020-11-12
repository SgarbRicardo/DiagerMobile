unit unitInventario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Ani,
  FMX.Edit, data.DB, FireDAC.Comp.Client, FireDAC.DApt, FMX.TabControl, DateUtils;

type
  TfrmInventario = class(TForm)
    lytMenuTop: TLayout;
    CircleUser: TCircle;
    Image1: TImage;
    imgNotification: TImage;
    Label1: TLabel;
    rectInventarioList: TRectangle;
    lytMenuInferior: TLayout;
    rectMenuInferior: TRectangle;
    imgAddBtn: TImage;
    lytUltimasModificacoes: TLayout;
    Label2: TLabel;
    lblVerTodos: TLabel;
    imgEquipment: TImage;
    lytPesquisa: TLayout;
    recPesquisa: TRectangle;
    imgSearch: TImage;
    rectTransição: TRectangle;
    Rectangle2: TRectangle;
    Layout1: TLayout;
    lblTituloCa: TLabel;
    imgVoltar: TImage;
    imgAplicar: TImage;
    FloatAnimationTransicao: TFloatAnimation;
    Edit1: TEdit;
    imgSinc: TImage;
    imgNaoSinc: TImage;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    lvInventarioAll: TListView;
    lvInventario: TListView;
    imgCurrentLoc: TImage;
    imgPrevLoc: TImage;
    procedure FormShow(Sender: TObject);
    procedure lvInventarioUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvInventarioItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure lvInventarioItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvInventarioPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure imgAddBtnClick(Sender: TObject);
    procedure FloatAnimationTransicaoFinish(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblVerTodosClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    dt_filtro : TDate;
    procedure TransitionForm(sender: TObject);
    procedure NavegarMes(num_mes: integer);

    { Private declarations }
  public
    IDProdutoSelecao : Integer;
    IDData_LocacaoSelecao :Integer;
    IDSnapTagSelecao :Integer;
   procedure listarTodosEmprestimos(busca: string; ind_clear: boolean;
      pagina: integer);
   procedure AddLancamentos(lvInventario: TListview;EMPRE_ID,Empre_Prod_ID, Equipamento, Brand, Location,ind_sinc: string;
                             SnaponTag: integer;
                             Dte: TDateTime;
                             qtd: integer;
                             Photo: TStream);
    procedure listarEmprestimos(busca :string; ind_clear: boolean; pagina: integer);
    procedure DetalharEmprestimo(EMPRE_ID: string);
    procedure SetupLancamento(lv: TListView; Item: TListViewItem);
    procedure AddCategory(lv: TListView; id_Category, Categoria: String;
      Photo: TStream);
    procedure SetupCategory(lv: TListView; Item: TListViewItem);
    { Public declarations }
  end;

var
  frmInventario: TfrmInventario;

implementation

{$R *.fmx}

uses untPrincipal, unitInventarioCad, untDM, cEmprestimo,
  unitCarregaEquipamento, unitCarregaUsuario, unitCarregarUsuario;

procedure TfrmInventario.NavegarMes(num_mes : integer);
begin
    dt_filtro:= IncMonth(dt_filtro,num_mes);
    listarEmprestimos('',TRUE,0);
end;

procedure TfrmInventario.AddLancamentos(lvInventario: TListview;
                                        EMPRE_ID, Empre_Prod_ID, Equipamento, Brand, Location, ind_sinc: string;
                                        SnaponTag : integer;
                                        Dte: TDateTime;
                                        qtd: integer;
                                        Photo : TStream);
var
  img: TListItemImage;
  txt : TListItemText;
  bmp : TBitmap;

begin
    try

       with lvInventario.Items.Add do
       begin
            TagString := EMPRE_ID;
            //Aqui manipula o item que é inserido no comando lvInventario.Items.Add
            txt := TListItemText(Objects.FindDrawable('txtEquipment'));
            txt.Text := Equipamento;
            TListItemText(Objects.FindDrawable('txtBrand')).Text := Brand;
            TListItemText(Objects.FindDrawable('txtLocation')).Text := Location;
           // TListItemText(Objects.FindDrawable('txtPrevLocation')).Text :=  FormatFloat('##.#00.0',Version);
            TListItemText(Objects.FindDrawable('txtTag')).Text := SnaponTag.ToString;
            TListItemText(Objects.FindDrawable('txtData')).Text := FormatDateTime('mm/dd/yyyy', Dte);
            TListItemText(Objects.FindDrawable('txtQtd')).Text := qtd.ToString;

            TListItemimage(Objects.FindDrawable('imgCurrentLoc')).bitmap:= imgCurrentLoc.bitmap;
            TListItemimage(Objects.FindDrawable('imgPrevLoc')).bitmap:= imgPrevLoc.bitmap;

            img := TListItemImage(Objects.FindDrawable('imgPhoto'));
              if Photo <> nil then
                begin
                  bmp := TBitmap.Create;
                  bmp.LoadFromStream(Photo);

                  img.OwnsBitmap := true; // só faz quando sta instaciando a imagem (bmp) em tempo de execução. se vier do banco nao precisa dela.
                  img.Bitmap := bmp;
                end
              else
                TListItemimage(Objects.FindDrawable('imgPhoto')).bitmap:= imgEquipment.bitmap;

            //icone sincronismo
            img := TListItemImage(Objects.FindDrawable('imgSinc'));
            if ind_sinc = 'S'  then      // S Sincronizado
               img.Bitmap := imgSinc.Bitmap
            else
               img.Bitmap := imgNaoSinc.Bitmap;
       end;
    finally
    end;
end;
procedure TfrmInventario.listarTodosEmprestimos(busca: string; ind_clear: boolean;
  pagina: integer);
  var
      photo : TStream;

      qry : TFDQuery;
      empre : TEmprestimo;
      erro:    string;
begin
     try
        empre := TEmprestimo.Create(dm.Conn);
        empre.DATA_DE := FormatDateTime('YYY-MM-DD', StartOfTheMonth(dt_filtro));
        empre.DATA_ATE := FormatDateTime('YYY-MM-DD', EndOfTheMonth(dt_filtro));
        qry := empre.ListarEmprestimo(0,erro);

        if erro <> '' then
        begin
          ShowMessage(erro);
          exit
        end;

        if ind_clear then
        lvInventarioAll.Items.Clear;

        lvInventarioAll.BeginUpdate;
        while not qry.Eof do
        begin
             if qry.FieldByName('PROD_FOTO').AsString <> '' then
                photo := qry.CreateBlobStream(qry.FieldByName('PROD_FOTO'),TBlobStreamMode.bmRead)
             else
                photo := nil;;

             AddLancamentos(lvInventarioAll,
                         qry.FieldByName('EMPRE_ID').AsString,
                         qry.FieldByName('Empre_Prod_ID').AsString,
                         qry.FieldByName('PROD_DESCRICAO').AsString,
                         qry.FieldByName('PROD_MARCA').AsString,
                         qry.FieldByName('EMPRE_LOCATARIO').AsString,
                         qry.FieldByName('EMPRE_IND_SINC').AsString,
                         //qry.FieldByName('PROD_VERSAO').asfloat,
                         qry.FieldByName('PROD_SNAP_TAG').AsInteger,
                         qry.FieldByName('EMPRE_DT_LOCACAO').AsInteger,
                         qry.FieldByName('PROD_QTD').AsInteger,
                         Photo);
            qry.Next;
            photo.DisposeOf;
        end;
          lvInventarioAll.EndUpdate;
     finally
         empre.DisposeOf;
     end;
end;

procedure TfrmInventario.lblVerTodosClick(Sender: TObject);
begin
    TabControl1.GotoVisibleTab(1,TTabTransition.Slide);
    listarTodosEmprestimos('',TRUE,0);
end;

procedure TfrmInventario.listarEmprestimos(busca: string; ind_clear: boolean;
  pagina: integer);
  var
      photo: TStream;
      qry : TFDQuery;
      empre : TEmprestimo;
      erro: string;
begin
     try
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
     end;
end;

procedure TfrmInventario.AddCategory(lv : TListView;
                                     id_Category, Categoria: String;
                                     Photo : TStream);
var
  img : TListItemImage;
  txt : TListItemText;
  bmp : TBitmap;

begin
     with lv.Items.Add do
     begin

          TagString := id_Category;
          //Aqui manipula o item que é inserido no comando lvInventario.Items.Add
          txt := TListItemText(Objects.FindDrawable('txtCategory'));
          txt.Text := Categoria;

          img := TListItemImage(Objects.FindDrawable('imgCategory'));

          if Photo <> nil then
          begin
            bmp := TBitmap.Create;
            bmp.LoadFromStream(Photo);

          //  img.OwnsBitmap := true; // só faz quando sta instaciando a imagem (bmp) em tempo de execução. se vier do banco nao precisa dela.
            img.Bitmap := bmp;

          end;
     end;
end;

procedure TfrmInventario.SetupLancamento(lv: TListView;
                                        Item: TListViewItem);
var
 txt : TListItemText;
 img : TListItemImage;
 begin
        //ajusta o tamanho  da string equipment
       txt := TListItemText(Item.Objects.FindDrawable('txtEquipment'));
       txt.width := lv.Width - txt.PlaceOffset.X - 230;

       img := TListItemImage(Item.Objects.FindDrawable('imgPhoto'));

       //esconde a imagem a redimensiona os objetos na tela.
       if lv.Width < 350 then
       begin
       img.Visible := false;
       txt.PlaceOffset.X := 2;
       end;
end;

procedure TfrmInventario.SetupCategory(lv: TListView;
                                        Item: TListViewItem);
var
 txt : TListItemText;
 img : TListItemImage;
 begin
        //ajusta o tamanho da da string equipment
       txt := TListItemText(Item.Objects.FindDrawable('txtCategory'));
       txt.width := lv.Width - txt.PlaceOffset.X - 20;

//       img := TListItemImage(Item.Objects.FindDrawable('imgCategory'));
//
//       //esconde a imagem a redimensiona os objetos na tela.
//       if lv.Width < 350 then
//       begin
//       img.Visible := false;
//       txt.PlaceOffset.X := 2;
//       end;
        img.DisposeOf
end;

procedure TfrmInventario.TransitionForm(sender: TObject);
begin
///
end;

procedure TfrmInventario.FloatAnimationTransicaoFinish(Sender: TObject);
begin
////....
end;

procedure TfrmInventario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Close;
end;

procedure TfrmInventario.FormCreate(Sender: TObject);
begin
     // rectTransição.Margins.Top := frmInventario.Height + 100;
end;

procedure TfrmInventario.FormShow(Sender: TObject);
var
  Photo : TStream;
begin
    TabControl1.ActiveTab := TabItem1;
    Photo := TMemoryStream.Create;
    imgEquipment.Bitmap.SaveToStream(Photo);
    photo.Position := 0;

    dt_filtro := Date;
    listarEmprestimos('',TRUE,0);

    photo.DisposeOf;
end;

procedure TfrmInventario.Image1Click(Sender: TObject);
begin
      if TabControl1.ActiveTab.Index = 0 then
          close
      else
      TabControl1.GotoVisibleTab(0,TTabTransition.Slide);
end;

procedure TfrmInventario.imgAddBtnClick(Sender: TObject);
begin
     DetalharEmprestimo('');
end;

procedure TfrmInventario.DetalharEmprestimo(EMPRE_ID : string);
begin
     if not Assigned (frmInventarioCad) then
        Application.CreateForm(TfrmInventarioCad, frmInventarioCad);

      if EMPRE_ID <> '' then
      begin
         frmInventarioCad.modo := 'A';
         frmInventarioCad.id_emp := EMPRE_ID.toInteger;
      end
      else
         begin
         frmInventarioCad.modo := 'I';
         frmInventarioCad.id_emp := 0;
      end;

      frmInventarioCad.Show;
end;

procedure TfrmInventario.lvInventarioItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
//      if AItem.height > 199 then
//        AItem.Height := 60
//      else
//         AItem.Height := 200;

    DetalharEmprestimo(AItem.TagString);
end;

procedure TfrmInventario.lvInventarioItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
    if TListItemText(ItemObject).Text = TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtLocation')).Text then
    begin
       if NOT Assigned(frmCarregarUsuario) then
          Application.CreateForm(TfrmCarregarUsuario, frmCarregarUsuario);

          frmCarregarUsuario.Show;

      {  frmCarregarUsuario.ShowModal(procedure(ModalResult: TModalResult)
        begin
            if frmCarregarUsuario.IdUsuarioSelecao > 0 then
            begin
                TListItemText(lvInventario.Items[ItemIndex].Objects.FindDrawable('txtLocation')).Text := frmCarregarUsuario.UsuarioSelecao;
                lvInventario.Items[ItemIndex].Tag := frmCarregarUsuario.IdUsuarioSelecao;
            end;
        end); }
    end;
end;

procedure TfrmInventario.lvInventarioPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
begin

//scroll infinito
//     if lvInventario.Items.Count > 0 then
//        if lvInventario.GetItemRect(lvInventario.Items.Count - 4).Bottom <= lvInventario.Height then
//        begin
//          AddLancamentos('0001','Modis Edge', 'Scanner', 'Snapon', 'Obeya','204','S',date, nil);
//          AddLancamentos('0001','Modis Edge', 'Scanner', 'Snapon', 'Obeya','204','S',date, nil);
//          AddLancamentos('0001','Modis Edge', 'Scanner', 'Snapon', 'Obeya','204','F',date, nil);
//        end;
end;

procedure TfrmInventario.lvInventarioUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
  ////....
    SetupLancamento(frmInventario.lvInventario, AItem);
end;

end.

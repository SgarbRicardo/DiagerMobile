unit unitCategorias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FireDAC.Comp.Client, FireDAC.DApt, Data.DB;

type
  TfrmCategorias = class(TForm)
    lytMenuTop: TLayout;
    lblTitulo: TLabel;
    imgVoltar: TImage;
    rectMenuInferior: TRectangle;
    imgLixeira: TImage;
    lvCategory: TListView;
    procedure imgVoltarDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lvCategoryUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvCategoryItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private

    { Private declarations }
  public
    { Public declarations }
    procedure cadCategoria(id_cat: string);
    procedure ListarCategorias;
  end;

var
  frmCategorias: TfrmCategorias;

implementation

{$R *.fmx}

uses  unitInventario, cCategoria, untDM, unitCategoriasCad;

procedure TfrmCategorias.cadCategoria(id_cat: string);

begin
    if not Assigned (frmCadastroCategoria) then
        Application.CreateForm(TfrmCadastroCategoria, frmCadastroCategoria);

        //inclusão
      if id_cat = '' then
      begin
          frmCadastroCategoria.id_cat := 0;
          frmCadastroCategoria.modo := 'I';
          frmCadastroCategoria.lblTituloCad.Text := 'New Category'
      End
      else

      //alteração
      begin
          frmCadastroCategoria.id_cat := id_cat.ToInteger;
          frmCadastroCategoria.modo := 'A';
          frmCadastroCategoria.lblTituloCad.Text := 'Edit Category';
      end;

      frmCadastroCategoria.Show;
end;

procedure TfrmCategorias.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    frmCategorias := nil;

end;

procedure TfrmCategorias.ListarCategorias;
var
   cat : TCategoria;
   qry : TFDQuery;
   erro : string;
   icone : TStream;
begin
    try
       cat := Tcategoria.create(Dm.conn);
       qry := cat.ListarCategoria(erro);

       while not qry.Eof do
       begin
          //icone
          if qry.FieldByName('ICONE').AsString <> '' then
            icone := qry.CreateBlobStream(qry.FieldByName('ICONE'), TBlobStreamMode.bmRead)
          else
             icone := nil;

         frmInventario.addCategory(lvCategory,
                                              qry.FieldByName('ID_CATEGORIA').AsString,
                                              qry.FieldByName('DESCRICAO').AsString, ICONE);
          if icone <> nil then
          icone.DisposeOf;

         qry.Next;
       end;

    finally
        qry.DisposeOf;
        cat.DisposeOf;
    end;
end;

procedure TfrmCategorias.FormShow(Sender: TObject);
//var
//  Photo : TStream;
//  x : integer;
begin

//    Photo := TMemoryStream.Create;
//    frmInventario.imgEquipment.Bitmap.SaveToStream(Photo);
//    photo.Position := 0;
//
//    lvCategory.BeginUpdate;
//    try
//      for x := 1 to 10 do
//        frmInventario.addCategory(lvCategory,'0001','OEM',Photo);
//    finally
//     lvCategory.EndUpdate;
//    end;
//
//    photo.DisposeOf;

    ListarCategorias;
end;
procedure TfrmCategorias.imgVoltarDblClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmCategorias.lvCategoryItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    cadCategoria(AItem.TagString);
end;

procedure TfrmCategorias.lvCategoryUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
    frmInventario.SetupCategory(lvCategory, AItem);
end;

end.

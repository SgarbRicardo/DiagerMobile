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
    procedure lvCategoryItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private

    { Private declarations }
  public
    { Public declarations }
    procedure cadCategoria(id_cat: string);
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


end.


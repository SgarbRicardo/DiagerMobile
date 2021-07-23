unit unitCategoriasCad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation, FMX.Edit, FMX.Objects,FireDAC.Comp.Client, FireDAC.DApt;

type
  TfrmCadastroCategoria = class(TForm)
    lytPrincipal: TLayout;
    lytPesquisa: TLayout;
    recPesquisa: TRectangle;
    imgSearch: TImage;
    edtCategoria: TEdit;
    rectInventarioList: TRectangle;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    img_selecao: TImage;
    img_inventario: TImage;
    ListBoxItem2: TListBoxItem;
    Image3: TImage;
    ListBoxItem3: TListBoxItem;
    Image6: TImage;
    ListBoxItem4: TListBoxItem;
    Image7: TImage;
    ListBoxItem5: TListBoxItem;
    Image8: TImage;
    ListBoxItem6: TListBoxItem;
    Image9: TImage;
    ListBoxItem7: TListBoxItem;
    Image10: TImage;
    ListBoxItem8: TListBoxItem;
    Image11: TImage;
    lytMenuTop: TLayout;
    lblTituloCad: TLabel;
    imgVoltar: TImage;
    imgAplicar: TImage;
    rectLixeira: TRectangle;
    imgLixeira: TImage;
    procedure FormResize(Sender: TObject);
    procedure img_inventarioClick(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgAplicarClick(Sender: TObject);
  private
    { Private declarations }
    icone_selecionado: TBitmap;
    procedure selecionaIcone(img: TImage);
  public
    { Public declarations }
    modo : string; // I para inclusão / A para Alteração
    id_cat : Integer;
  end;

var
  frmCadastroCategoria: TfrmCadastroCategoria;

implementation

{$R *.fmx}

uses unitCategorias, untDM, cCategoria;

{ TfrmCadastroCategoria }

procedure TfrmCadastroCategoria.FormResize(Sender: TObject);
begin
     ListBox1.Columns := Trunc(ListBox1.Width / 80);
end;

procedure TfrmCadastroCategoria.FormShow(Sender: TObject);
var
    cat : TCategoria;
    qry : TFDQuery;
    erro : string;
begin
  //ALTERAÇÃO
      if modo = 'A' then
      begin
        try
          cat := TCategoria.create(dm.conn);
          cat.ID_CATEGORIA := id_cat;
          qry := cat.ListarCategoria(erro);

          edtCategoria.Text := qry.FieldByName('DESCRICAO').AsString;

          //ICONE

        finally
          qry.DisposeOf;
          cat.DisposeOf;

        end;
      end;
end;

procedure TfrmCadastroCategoria.imgAplicarClick(Sender: TObject);
var
    cat : TCategoria;
    erro : string;
begin
  //INCLUSÃO
      try
          cat := TCategoria.create(dm.conn);
          cat.DESCRICAO := edtCategoria.Text;
          cat.ICONE      := icone_selecionado;

          if modo ='I' then
            cat.InserirCategoria(erro)
          else
          begin
            cat.ID_CATEGORIA := id_cat;
          end;

          begin

              cat.ID_CATEGORIA := id_cat;
              cat.AlterarCategoria(erro);
          end;

          if erro <> '' then
          begin
              ShowMessage(erro);
              exit;
          end;

         close;

      finally
            cat.DisposeOf;

      end;
end;


procedure TfrmCadastroCategoria.imgVoltarClick(Sender: TObject);
begin
    close;
end;

procedure TfrmCadastroCategoria.img_inventarioClick(Sender: TObject);
begin
    selecionaIcone(TImage(Sender));
end;

procedure TfrmCadastroCategoria.selecionaIcone(img: TImage);
begin
    icone_selecionado := img.Bitmap; // salvei o icone selecionado;

    img_selecao.Parent := img.Parent;
end;

end.

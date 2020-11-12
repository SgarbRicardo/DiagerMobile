unit unitCarregaEquipamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,data.DB, FireDAC.Comp.Client, FireDAC.DApt;

type
  TfrmCarregaEquipamento = class(TForm)
    lytMenuTop: TLayout;
    lblTituloCad: TLabel;
    imgVoltar: TImage;
    imgAplicar: TImage;
    lvEquipamento: TListView;
    imgEquipment: TImage;
    procedure lvEquipamentoItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormShow(Sender: TObject);
    procedure imgVoltarClick(Sender: TObject);
  private
    procedure AddEquipamento(lvEquipamento: TListview; idEquipamento, Descricao,Brand, Categoria: string;
                                            Version: double; SnaponTag, qtd : integer;
      Photo: TStream);
    procedure listarEquipamento(busca: string; ind_clear: boolean;
      pagina: integer);
    { Private declarations }
  public
    { Public declarations }
    EquipamentoSelecao: string;
    IdEquipamentoSelecao: Integer;
  end;

var
  frmCarregaEquipamento: TfrmCarregaEquipamento;

implementation

{$R *.fmx}

uses unitPrincipal, cEquipamento, untDM;

procedure TfrmCarregaEquipamento.AddEquipamento(lvEquipamento: TListview; idEquipamento, Descricao, Brand, Categoria: string;
                                        Version : double;
                                        SnaponTag, qtd  : integer;
                                        Photo : TStream);
var
  img : TListItemImage;
  txt : TListItemText;
  bmp : TBitmap;

begin
    try

       with lvEquipamento.Items.Add do
       begin
            TagString := idEquipamento;

            txt := TListItemText(Objects.FindDrawable('txtDescricao'));
            txt.Text := Descricao;
            TListItemText(Objects.FindDrawable('txtBrand')).Text := Brand;
            TListItemText(Objects.FindDrawable('txtVersion')).Text :=  FormatFloat('##.#00.0',Version);
            TListItemText(Objects.FindDrawable('txtTag')).Text := SnaponTag.ToString;
            TListItemText(Objects.FindDrawable('txtCategoria')).Text := Categoria;
            TListItemText(Objects.FindDrawable('txtQtd')).Text := qtd.ToString;

            img := TListItemImage(Objects.FindDrawable('imgPhoto'));
              if Photo <> nil then
              begin
                bmp := TBitmap.Create;
                bmp.LoadFromStream(Photo);

                img.OwnsBitmap := true; // só faz quando sta instaciando a imagem (bmp) em tempo de execução. se vier do banco nao precisa dela.
                img.Bitmap := bmp;
              end
              else
              TListItemimage(Objects.FindDrawable('imgPhoto')).bitmap:= imgEquipment.bitmap
       end;
    finally


    end;
end;

procedure TfrmCarregaEquipamento.FormShow(Sender: TObject);
begin
    listarEquipamento('',true,0);
end;

procedure TfrmCarregaEquipamento.imgVoltarClick(Sender: TObject);
begin
    IdEquipamentoSelecao := 0;
    EquipamentoSelecao := '';
    close;
end;

procedure TfrmCarregaEquipamento.listarEquipamento(busca: string; ind_clear: boolean;
  pagina: integer);
  var
      photo : TStream;
      qry : TFDQuery;
      equip : TEquipamento;
      erro: string;
begin
     try
        equip := TEquipamento.Create(dm.Conn);
        qry := equip.listarEquipamento(erro);

        if erro <> '' then
        begin
          ShowMessage(erro);
          exit
        end;

        if ind_clear then
        lvequipamento.Items.Clear;

        lvequipamento.BeginUpdate;
        while not qry.Eof do
        begin
             if qry.FieldByName('PROD_FOTO').AsString <>'' then
                photo := qry.CreateBlobStream(qry.FieldByName('PROD_FOTO'),TBlobStreamMode.bmRead)
             else
                photo := nil;

             AddEquipamento(lvequipamento,
                         qry.FieldByName('PROD_ID').AsString,
                         qry.FieldByName('PROD_DESCRICAO').AsString,
                         qry.FieldByName('PROD_MARCA').AsString,
                        // qry.FieldByName('EMPRE_IND_SINC').AsString,
                         qry.FieldByName('DESCRICAO_CATEGORIA').AsString,
                         qry.FieldByName('PROD_VERSAO').asfloat,
                         qry.FieldByName('PROD_SNAP_TAG').AsInteger,
                         qry.FieldByName('PROD_QTD').AsInteger,
                         Photo);
            qry.Next;
            photo.DisposeOf;
        end;
          lvEquipamento.EndUpdate;
     finally
         equip.DisposeOf;
     end;
end;
procedure TfrmCarregaEquipamento.lvEquipamentoItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    IdEquipamentoSelecao := AItem.TagString.ToInteger;
    EquipamentoSelecao := TListItemText(AItem.Objects.FindDrawable('txtEquipamento')).Text;
    close;
end;

end.

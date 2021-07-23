unit unitCarregaUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts, FireDAC.Comp.Client, FireDAC.DApt,data.DB;

type
  TfrmCarregaUsuario = class(TForm)
    lvUsuario: TListView;
    lytMenuTop: TLayout;
    lblTituloCad: TLabel;
    imgVoltar: TImage;
    imgAplicar: TImage;
    procedure lvUsuarioItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ap(Sender: TObject; var Action: TCloseAction);
  private
    procedure AddUsuario(lvUsuario: TListview; idUsuario, Nome, Departamento :String; Photo: TStream);
    procedure FormShow(Sender: TObject);

    { Private declarations }
  public
     IdUsuarioSelecao: integer;
     UsuarioSelecao: string;
     procedure listarUsuario;
  end;

var
  frmCarregaUsuario: TfrmCarregaUsuario;

implementation

{$R *.fmx}

uses cUsuario, untDM;

procedure TfrmCarregaUsuario.lvUsuarioItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    IdUsuarioSelecao := AItem.TagString.ToInteger;
    UsuarioSelecao := TListItemText(AItem.Objects.FindDrawable('txtNome')).Text;
    close;
end;

procedure TfrmCarregaUsuario.AddUsuario(lvUsuario: TListview; idUsuario, Nome, Departamento: string; Photo: TStream);
var
  img : TListItemImage;
  txt : TListItemText;
  bmp : TBitmap;

begin
    try

       with lvUsuario.Items.Add do
       begin
            TagString := idUsuario;

            txt := TListItemText(Objects.FindDrawable('txtNome'));
            txt.Text := Nome;
            TListItemText(Objects.FindDrawable('txtDepartamento')).Text := Departamento;

            img := TListItemImage(Objects.FindDrawable('imgUsuario'));
              if Photo <> nil then
              begin
                bmp := TBitmap.Create;
                bmp.LoadFromStream(Photo);

                img.OwnsBitmap := true; // só faz quando sta instaciando a imagem (bmp) em tempo de execução. se vier do banco nao precisa dela.
                img.Bitmap := bmp;
              end;
       end;
    finally

    end;
end;

procedure TfrmCarregaUsuario.ap(Sender: TObject;
  var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    frmCarregaUsuario := nil;
end;

procedure TfrmCarregaUsuario.FormShow(Sender: TObject);
begin

end;

procedure TfrmCarregaUsuario.listarUsuario;
  var
      photo : TStream;
      qry : TFDQuery;
      usu : TUsuario;
      erro: string;
begin
     try
        usu := TUsuario.Create(dm.Conn);
        qry := usu.listarUsuario(erro);

        if erro <> '' then
        begin
          ShowMessage(erro);
          exit
        end;

        lvUsuario.Items.Clear;

        lvUsuario.BeginUpdate;
        while not qry.Eof do
        begin
             if qry.FieldByName('USU_FOTO').AsString <>'' then
                photo := qry.CreateBlobStream(qry.FieldByName('USU_FOTO'),TBlobStreamMode.bmRead)
             else
                photo := nil;

             AddUsuario(lvUsuario,
                         qry.FieldByName('COD_USUARIO').AsString,
                         qry.FieldByName('USU_NOME').AsString,
                         qry.FieldByName('USU_DEPARTAMENTO').AsString,
                                         Photo);
            qry.Next;
            photo.DisposeOf;
        end;
          lvUsuario.EndUpdate;
     finally
         usu.DisposeOf;
     end;
end;

end.


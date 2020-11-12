unit unitCarregarUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, Data.db, FireDAC.Comp.Client, FireDAC.DApt;

type
  TfrmCarregarUsuario = class(TForm)
    Layout1: TLayout;
    Image1: TImage;
    Image2: TImage;
    lvUsuario: TListView;
    procedure Image1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AddUsuario(lvUsuario: TListview; idUsuario, Nome, Departamento :String; Photo: TStream);
    procedure lvUsuarioItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Image2Click(Sender: TObject);

  private
    { Private declarations }
  public
  { Public declarations }
     modo : string;
     id_emp_pro, id_emp : integer; //ID do emprestimo a ser alterado
     IDProdutoSelecao : Integer;
     IDData_LocacaoSelecao :Integer;
     IDSnapTagSelecao :Integer;
     IdUsuarioSelecao: integer;
     UsuarioSelecao: string;
     procedure listarUsuario;
  end;

var
  frmCarregarUsuario: TfrmCarregarUsuario;

implementation

{$R *.fmx}

uses untDM, cUsuario, cEmprestimo, unitInventario;


procedure TfrmCarregarUsuario.Image1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmCarregarUsuario.Image2Click(Sender: TObject);
var
  empre : TEmprestimo;
  erro : string;
begin
      id_emp := frmInventario.lvInventario.TagString.ToInteger;
     try
          empre := TEmprestimo.Create(dm.Conn);
          empre.EMPRE_LOGIN_ID := IdUsuarioSelecao;
         // empre.EMPRE_DT_LOCACAO := frmInventario.lvInventario.Items[Index].Objects.FindDrawable('txtData').ToString;
        //  empre.EMPRE_QTD := frmInventario.lvInventario.Items[Index].Objects.FindDrawable('txtQtd').ToString;
       //   empre.EMPRE_SNAPON_TAG := frmInventario.lvInventario.Items[Index].Objects.FindDrawable('txtTag').ToString;

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

procedure TfrmCarregarUsuario.lvUsuarioItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
    IdUsuarioSelecao := AItem.TagString.ToInteger;
    UsuarioSelecao := TListItemText(AItem.Objects.FindDrawable('txtNome')).Text;
    close;
end;

procedure TfrmCarregarUsuario.AddUsuario(lvUsuario: TListview; idUsuario, Nome, Departamento: string; Photo: TStream);
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

procedure TfrmCarregarUsuario.FormShow(Sender: TObject);
begin
    listarUsuario;
end;

procedure TfrmCarregarUsuario.listarUsuario;
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
         qry.DisposeOf;
     end;
end;

end.

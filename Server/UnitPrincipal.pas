unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uDWAbout,
  uRESTDWBase, FMX.StdCtrls, FMX.Controls.Presentation, UnitDM, FMX.Objects,
  FMX.Edit, FMX.Ani, FMX.TabControl;

type
  TfrmPrincipal = class(TForm)
    Label1: TLabel;
    Switch1: TSwitch;
    RESTServicePooler: TRESTServicePooler;
    TabControl: TTabControl;
    tbiCategoria: TTabItem;
    RectAnimation1: TRectAnimation;
    btn_foto_cat: TButton;
    btn_cat_update: TButton;
    edt_categoria_id: TEdit;
    img_categoria: TImage;
    Rectangle2: TRectangle;
    OpenDialog: TOpenDialog;
    tbiEquipamento: TTabItem;
    edt_equip_id: TEdit;
    Button1: TButton;
    Button2: TButton;
    Rectangle1: TRectangle;
    img_Equipamento: TImage;
    procedure Switch1Switch(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_foto_catClick(Sender: TObject);
    procedure btn_cat_updateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.btn_cat_updateClick(Sender: TObject);
begin
     try
        dm.qryCategoria.Active := false;
        dm.qryCategoria.SQL.Clear;
        dm.qryCategoria.SQL.Add('UPDATE [MF_Control].[mf_control_db].[CATEGORY]SET Cat_photo=:CAT_PHOTO WHERE CAT_ID=:ID_CATEGORIA');
        dm.qryCategoria.ParamByName('CAT_PHOTO').Assign(img_categoria.Bitmap);
        dm.qryCategoria.ParamByName('ID_CATEGORIA').Value := edt_categoria_id.text.ToInteger;
        dm.qryCategoria.ExecSQL;
    except on ex:exception do
        showmessage('Erro ao atualizar categoria: ' + ex.Message);
    end;
end;

procedure TfrmPrincipal.btn_foto_catClick(Sender: TObject);
begin
    if OpenDialog.Execute then
       img_categoria.Bitmap.LoadFromFile(OpenDialog.FileName);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
    RESTServicePooler.ServerMethodClass := Tdm;
    RESTServicePooler.Active := Switch1.IsChecked;
end;

procedure TfrmPrincipal.Switch1Switch(Sender: TObject);
begin
      RESTServicePooler.Active := Switch1.IsChecked;
end;

end.

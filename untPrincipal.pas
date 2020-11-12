unit untPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Ani,
  FMX.Edit;

type
  TfrmPrincipal = class(TForm)
    lytToolBar: TLayout;
    StyleBook1: TStyleBook;
    img_fundo: TImage;
    Layout2: TLayout;
    SpeedButton2: TSpeedButton;
    lytBotaoMenu: TLayout;
    recMenu2: TRectangle;
    FloatAnimation2Opacity: TFloatAnimation;
    recMenu3: TRectangle;
    FloatAnimation3Width: TFloatAnimation;
    FloatAnimation3Rotate: TFloatAnimation;
    FloatAnimation3Margin: TFloatAnimation;
    recMenu1: TRectangle;
    FloatAnimation1Rotate: TFloatAnimation;
    FloatAnimation1Width: TFloatAnimation;
    FloatAnimation1Margin: TFloatAnimation;
    VertScrollBox1: TVertScrollBox;
    rect_titulo: TRectangle;
    Label2: TLabel;
    procedure FormResize(Sender: TObject);
    procedure VertScrollBox1ViewportPositionChange(Sender: TObject;
      const OldViewportPosition, NewViewportPosition: TPointF;
      const ContentSizeChanged: Boolean);
    procedure FormCreate(Sender: TObject);
    //procedure lytBotaoMenuClick(Sender: TObject);
  private
    { Private declarations }
    procedure ResizeObjects;
    procedure AddDestaque(cod_item, titulo, descricao, icone, location,Brand: string;
                          Qtd, AssetTag: integer; Data_Input: integer);
    procedure AddItem(cod_item, descricao, icone, location, Brand: string;
                      Qtd, AssetTag: double; Data_Input: integer);
    procedure SelecionaItem(Sender: TObject);
    procedure SelecionaItemTap(Sender: TObject; const Point: TPointF);
  public
    { Public declarations }
    cod_usuario: string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses unitLogin;

procedure TfrmPrincipal.AddDestaque(cod_item, titulo, descricao, icone,
  location, Brand: string; Qtd, AssetTag, Data_Input: integer);

var
  rect, rect_barra, rect_icone: TRectangle;
  lbl: TLabel;
begin
 // Fundo...
    rect := TRectangle.Create(VertScrollBox1);
    with rect do
    begin
        Align := TAlignLayout.Top;
        Height := 130;
        Fill.Color := $FFFFFFFF;
        Stroke.Kind := TBrushKind.None;
        Margins.Top := 180  ;
        Margins.Left := 10;
        Margins.Right := 10;
        XRadius := 8;
        YRadius := 8;
        TagString := cod_item;

        {$IFDEF MSWINDOWS}
        OnClick := SelecionaItem;
        {$ELSE}
        OnTap := SelecionaItemTap;
        {$ENDIF}

    end;


    // Barra inferior...
    rect_barra := TRectangle.Create(rect);
    with rect_barra do
    begin
        Align := TAlignLayout.Bottom;
        Height := 55;
        Fill.Color := $FF685FEE;
        Stroke.Kind := TBrushKind.None;
        XRadius := 8;
        YRadius := 8;
        Corners := [TCorner.BottomLeft,TCorner.BottomRight];
        rect.AddObject(rect_barra);
        HitTest := false;
    end;


     // Label destaque...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        Align := TAlignLayout.Top;
        Height := 20;
        TextSettings.FontColor := $FF685FEE;
        Text := titulo;
        font.Size := 10;
        Margins.Left := 10;
        Margins.Right := 10;
        Margins.Top := 5;
        Font.Style := [TFontStyle.fsBold];
        rect.AddObject(lbl);
    end;


    // Caixa de Icone...
    rect_icone := TRectangle.Create(rect);
    with rect_icone do
    begin
        Height := 30;
        Width := 30;
        Fill.Color := $FF685FEE;
        Stroke.Kind := TBrushKind.None;
        XRadius := 4;
        YRadius := 4;
        Position.X := 10;
        Position.Y := 32;
        HitTest := false;
        rect.AddObject(rect_icone);
    end;


    // Label do icone...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        Align := TAlignLayout.Client;
        Height := 20;
        TextSettings.FontColor := $FFFFFFFF;
        TextSettings.VertAlign := TTextAlign.Center;
        TextSettings.HorzAlign := TTextAlign.Center;
        Text := icone;
        font.Size := 9;
        Font.Style := [TFontStyle.fsBold];
        rect_icone.AddObject(lbl);
    end;


    // Descricao...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FF333333;
        Text := descricao;
        font.Size := 12;
        Font.Style := [TFontStyle.fsBold];
        Position.X := 50;
        Position.Y := 40;
        rect.AddObject(lbl);
    end;


     //Resultado estimado...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        Anchors := [TAnchorKind.akTop,TAnchorKind.akRight];
        TextSettings.FontColor := $FFCCCCCC;
        TextSettings.HorzAlign := TTextAlign.Trailing;
        Text := Brand;
        font.Size := 10;
        Width := 150;
        Position.X := -160;
        Position.Y := 27;
        rect.AddObject(lbl);
    end;


    // Valor resultado estimado...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        Anchors := [TAnchorKind.akTop,TAnchorKind.akRight];
        TextSettings.FontColor := $FF333333;
        TextSettings.HorzAlign := TTextAlign.Trailing;
        Text := Brand;
        font.Size := 13;
        Width := 150;
        Position.X := -160;//VertScrollBox1.Width - 180;
        Position.Y := 43;
        Font.Style := [TFontStyle.fsBold];
        rect.AddObject(lbl);
    end;


    // Texto Valor minimo...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FFFFFFFF;
        Text := 'Quantidade';
        font.Size := 9;
        Width := 150;
        Position.X := 10;
        Position.Y := 7;
        rect_barra.AddObject(lbl);
    end;

    // Valor minimo...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FFFFFFFF;
        Text :=  Qtd.ToString;
        font.Size := 11;
        Width := 150;
        Position.X := 10;
        Position.Y := 23;
        Font.Style := [TFontStyle.fsBold];
        rect_barra.AddObject(lbl);
    end;

    // Texto rentabilidade...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FFFFFFFF;
        Text := 'Location';
        font.Size := 9;
        Width := 150;
        Position.X := 90;
        Position.Y := 7;
        rect_barra.AddObject(lbl);
    end;

    // Valor rentabilidade...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FFFFFFFF;
        Text := location;
        font.Size := 11;
        Width := 150;
        Position.X := 90;
        Position.Y := 23;
        Font.Style := [TFontStyle.fsBold];
        rect_barra.AddObject(lbl);
    end;

    // Texto prazo...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FFFFFFFF;
        Text := 'Asset Tag';
        font.Size := 9;
        Width := 150;
        Position.X := 170;
        Position.Y := 7;
        rect_barra.AddObject(lbl);
    end;

    // Valor prazo...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FFFFFFFF;
        Text := AssetTag.ToString;
        font.Size := 11;
        Width := 150;
        Position.X := 170;
        Position.Y := 23;
        Font.Style := [TFontStyle.fsBold];
        rect_barra.AddObject(lbl);
    end;

    VertScrollBox1.AddObject(rect);

end;

procedure TfrmPrincipal.AddItem(cod_item, descricao, icone, location,
  Brand: string; Qtd, AssetTag: double; Data_Input: integer);
var
    rect, rect_barra, rect_icone : TRectangle;
    lbl : TLabel;
begin
   // Fundo...
    rect := TRectangle.Create(VertScrollBox1);
    with rect do
    begin
        Align := TAlignLayout.Top;
        Height := 130;
        Fill.Color := $FFFFFFFF;
        Stroke.Kind := TBrushKind.Solid;
        Stroke.Color := $FFd4d5d7;
        Margins.Top := 10;
        Margins.Left := 10;
        Margins.Right := 10;
        XRadius := 8;
        YRadius := 8;
        TagString := cod_item;

        {$IFDEF MSWINDOWS}
        OnClick := SelecionaItem;
        {$ELSE}
        OnTap := SelecionaItemTap;
        {$ENDIF}
    end;


    // Barra inferior...
    rect_barra := TRectangle.Create(rect);
    with rect_barra do
    begin
        Align := TAlignLayout.Bottom;
        Height := 55;
        Fill.Color := $FFf4f4f4;
        Stroke.Kind := TBrushKind.Solid;
        Stroke.Color := $FFd4d5d7;
        Sides := [TSide.Left, TSide.Bottom, TSide.Right];
        XRadius := 8;
        YRadius := 8;
        Corners := [TCorner.BottomLeft,TCorner.BottomRight];
        HitTest := false;
        rect.AddObject(rect_barra);
    end;


    // Caixa de Icone...
    rect_icone := TRectangle.Create(rect);
    with rect_icone do
    begin
        Height := 30;
        Width := 30;
        Fill.Color := $FF08dabd;
        Stroke.Kind := TBrushKind.None;
        XRadius := 4;
        YRadius := 4;
        Position.X := 10;
        Position.Y := 12;
        HitTest := false;
        rect.AddObject(rect_icone);
    end;


    // Label do icone...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        Align := TAlignLayout.Client;
        Height := 20;
        TextSettings.FontColor := $FFFFFFFF;
        TextSettings.VertAlign := TTextAlign.Center;
        TextSettings.HorzAlign := TTextAlign.Center;
        Text := icone;
        font.Size := 9;
        Font.Style := [TFontStyle.fsBold];
        rect_icone.AddObject(lbl);
    end;


    // Descricao...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FF333333;
        Text := descricao;
        font.Size := 12;
        Font.Style := [TFontStyle.fsBold];
        Position.X := 50;
        Position.Y := 20;
        rect.AddObject(lbl);
    end;


    // Resultado estimado...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        Anchors := [TAnchorKind.akTop,TAnchorKind.akRight];
        TextSettings.FontColor := $FFCCCCCC;
        TextSettings.HorzAlign := TTextAlign.Trailing;
        Text := 'Brand';
        font.Size := 10;
        Width := 150;
        Position.X := -160;
        Position.Y := 7;
        rect.AddObject(lbl);
    end;


    // Valor resultado estimado...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        Anchors := [TAnchorKind.akTop,TAnchorKind.akRight];
        TextSettings.FontColor := $FF685FEE;
        TextSettings.HorzAlign := TTextAlign.Trailing;
        Text := Brand;
        font.Size := 13;
        Width := 150;
        Position.X := -160;//VertScrollBox1.Width - 180;
        Position.Y := 23;
        Font.Style := [TFontStyle.fsBold];
        rect.AddObject(lbl);
    end;


    // Texto Valor minimo...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FF666666;
        Text := 'Quantidade';
        font.Size := 9;
        Width := 150;
        Position.X := 10;
        Position.Y := 7;
        rect_barra.AddObject(lbl);
    end;

    // Valor minimo...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FF333333;
        Text := QTd.ToString;
        font.Size := 11;
        Width := 150;
        Position.X := 10;
        Position.Y := 23;
        Font.Style := [TFontStyle.fsBold];
        rect_barra.AddObject(lbl);
    end;

    // Texto rentabilidade...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FF666666;
        Text := 'Location';
        font.Size := 9;
        Width := 150;
        Position.X := 90;
        Position.Y := 7;
        rect_barra.AddObject(lbl);
    end;

    // Valor rentabilidade...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FF333333;
        Text := Location;
        font.Size := 11;
        Width := 150;
        Position.X := 90;
        Position.Y := 23;
        Font.Style := [TFontStyle.fsBold];
        rect_barra.AddObject(lbl);
    end;

    // Texto prazo...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FF666666;
        Text := 'Asset tag';
        font.Size := 9;
        Width := 150;
        Position.X := 170;
        Position.Y := 7;
        rect_barra.AddObject(lbl);
    end;

    // Valor prazo...
    lbl := TLabel.Create(rect);
    with lbl do
    begin
        StyledSettings := StyledSettings - [TStyledSetting.Size, TStyledSetting.FontColor, TStyledSetting.Style];
        TextSettings.FontColor := $FF333333;
        Text := Assettag.ToString;
        font.Size := 11;
        Width := 150;
        Position.X := 170;
        Position.Y := 23;
        Font.Style := [TFontStyle.fsBold];
        rect_barra.AddObject(lbl);
    end;

    VertScrollBox1.AddObject(rect);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
     ResizeObjects;

    AddDestaque('001', 'DESTAQUE DA SEMANA', 'PDL5500', 'PDL', 'Obeya','Snapon', 1 , 6345, 2);
    AddItem('002', 'IVECO', 'oem', 'Lucas','IVECO OEM', 1 , 6345, 2);
    AddItem('003', 'GEP2019', 'PDL', 'Ricardo HO','Snapon', 1 , 6345, 2);
    AddItem('004', 'PEAK ProFD', 'Peak', 'Obeya','Snapon', 1 , 6345, 2);
    AddItem('005', 'PDL5500', 'PDL', 'Obeya','Snapon', 1 , 6345, 2);
    AddItem('006', 'PDL5500', 'PDL', 'Obeya','Snapon', 1 , 6345, 2);
    AddItem('007', 'PDL5500', 'PDL', 'Obeya','Snapon', 1 , 6345, 2);
    AddItem('008', 'PDL5500', 'PDL', 'Obeya','Snapon', 1 , 6345, 2);
    AddItem('009', 'PDL5500', 'PDL', 'Obeya','Snapon', 1 , 6345, 2);
end;

procedure TfrmPrincipal.FormResize(Sender: TObject);
begin
    ResizeObjects;
end;

procedure TfrmPrincipal.ResizeObjects;
begin
    img_fundo.Position.X := -90;
    img_fundo.Width := VertScrollBox1.Width + 160;
    lytToolBar.Width := VertScrollBox1.Width;
    lytToolBar.Width := VertScrollBox1.Width;
end;

procedure TfrmPrincipal.SelecionaItem(Sender: TObject);
begin
  showmessage('Item Selecionado: ' + TRectangle(Sender).TagString);
end;

procedure TfrmPrincipal.SelecionaItemTap(Sender: TObject; const Point: TPointF);
begin
  showmessage('Item Selecionado: ' + TRectangle(Sender).TagString);
end;

procedure TfrmPrincipal.VertScrollBox1ViewportPositionChange(Sender: TObject;
  const OldViewportPosition, NewViewportPosition: TPointF;
  const ContentSizeChanged: Boolean);
begin

    if VertScrollBox1.ViewportPosition.Y < 100 then
        rect_titulo.Margins.Top := 85 - VertScrollBox1.ViewportPosition.Y
    else
        rect_titulo.Margins.Top := 0;

    if VertScrollBox1.ViewportPosition.Y < 65 then
        img_fundo.Position.Y := rect_titulo.Margins.Top - 65
    else
        img_fundo.Position.Y := -20;
       {

    rect_item.Margins.Left := trunc(rect_item.Margins.Top / 2);
    rect_item.Margins.Right := rect_item.Margins.Left;

    if rect_item.Margins.Top > 10 then
        rect_item.XRadius := 10
    else
        rect_item.XRadius := rect_item.Margins.Top;

    rect_item.YRadius := rect_item.XRadius;
    Label1.Opacity := (rect_item.Margins.Top / 100);
    }
end;

end.

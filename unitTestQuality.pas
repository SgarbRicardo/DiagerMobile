unit unitTestQuality;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.ListBox,System.JSON, FMX.Edit;

type
  TfrmTestQuality = class(TForm)
    lytMenuTop: TLayout;
    lblTitulo: TLabel;
    CircleUser: TCircle;
    Image1: TImage;
    imgNotification: TImage;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    lv_TaskDone: TListView;
    img_validar: TImage;
    img_dev: TImage;
    img_No_cat: TImage;
    lbMake: TListBox;
    ListBoxItem1: TListBoxItem;
    RoundRect1: TRoundRect;
    Label3: TLabel;
    lbiTodos: TListBoxItem;
    lblMake: TLabel;
    ListBoxItem3: TListBoxItem;
    Label5: TLabel;
    ListBoxItem4: TListBoxItem;
    Label6: TLabel;
    lv_TasksemTest: TListView;
    Image5: TImage;
    lytMenuInferior: TLayout;
    Rectangle1: TRectangle;
    img_aba3: TImage;
    img_aba1: TImage;
    img_aba2: TImage;
    img_aba4: TImage;
    img_barra_Fundo: TImage;
    img_barra_Progresso: TImage;
    lv_task_test: TListView;
    Image2: TImage;
    layout_detalhe: TLayout;
    rect_fundo: TRectangle;
    Rectangle2: TRectangle;
    img_fechar_detalhe: TImage;
    Layout23: TLayout;
    lbl_nome: TLabel;
    lbl_vehicleList: TListBox;
    StyleBook1: TStyleBook;
    Layout2: TLayout;
    layout_toolbar: TLayout;
    layout_busca: TLayout;
    lbl_canc_buscar: TLabel;
    Layout1: TLayout;
    rect_busca: TRectangle;
    edt_buscar: TEdit;
    rect_AutoComplete: TRectangle;
    lbAutoComplete: TListBox;
    ListBoxItem8: TListBoxItem;
    ListBoxItem9: TListBoxItem;
    ListBoxItem10: TListBoxItem;
    ListBoxItem11: TListBoxItem;
    layout_botoes: TLayout;
    img_busca: TImage;
    lytMakes: TLayout;
    lbMakes: TListBox;
    ListBoxItem2: TListBoxItem;
    RoundRect2: TRoundRect;
    Label1: TLabel;
    ListBoxItem5: TListBoxItem;
    Label2: TLabel;
    ListBoxItem6: TListBoxItem;
    Label4: TLabel;
    ListBoxItem7: TListBoxItem;
    Label7: TLabel;
    img_open: TImage;
    img_close: TImage;
    img_vehicle: TImage;
    procedure FormCreate(Sender: TObject);
    procedure lv_TaskDoneUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Image1Click(Sender: TObject);
    procedure lv_TaskDoneItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure lbMakeItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure img_aba1Click(Sender: TObject);
    procedure img_aba3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lv_task_testUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure img_aba2Click(Sender: TObject);
    procedure img_fechar_detalheClick(Sender: TObject);
    procedure lv_TaskDoneScrollViewChange(Sender: TObject);
    procedure img_buscaClick(Sender: TObject);
    procedure lbl_canc_buscarClick(Sender: TObject);
    procedure edt_buscarTyping(Sender: TObject);
    procedure lbAutoCompleteItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure edt_buscarExit(Sender: TObject);
    procedure lv_task_testItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
  private
    makeSel : string;
    procedure AddTaskDone(id_roadmap,id_testador: integer; make, model, range, system, functionality, progress,status,hours : string);
    procedure ListarTaskDone(busca,bundle: string);
    procedure ListarMake;
    procedure processarListaMake;
    procedure ProcessarListaMakeErro(Sender: TObject);
    procedure AddMake(make: string);
    procedure AddTaskSemTest(id_roadmap: integer; make, model, range, system, functionality, progress: string );
    procedure AddTask(id_roadmap, qtd_Test_realizado: integer; functionality, make, model, range, system,  progress: string );
    procedure ListarTaskSemTest;
    procedure processarTaskSemTest;
    procedure ProcessarTaskSemTestErro(Sender: TObject);
    procedure MudarAba(img: TImage);
    procedure processarTask;
    procedure ProcessarTaskErro(Sender: TObject);
    procedure ListarTask_;
    procedure carregarVeiculosdaTask;
    procedure ListarVeiculosTask;
    procedure OpenSearch;
    procedure HideAutoComplete;
    procedure ShowAutoComplete;
    procedure carregarVeiculosTestado;
    procedure ListarVeiculosTestado;

    { Private declarations }
  public
    { Public declarations }
    bundle: string;
    roadmap_id : integer;
  end;

var
  frmTestQuality: TfrmTestQuality;

implementation

{$R *.fmx}

uses untDM, unitPrincipal, unitLogin, unitChat, uFunctions, uLoading,
  unitFrameVehicles, unitFrameVehicles_Tested, unitFrameVehiclesTested;

procedure TfrmTestQuality.MudarAba(img: TImage);
begin
    img_aba1.Opacity := 0.3;
    img_aba2.Opacity := 0.3;
    img_aba3.Opacity := 0.3;
    img_aba4.Opacity := 0.3;

    img.Opacity := 1;
    TabControl1.GotoVisibleTab(img.Tag, TTabTransition.Slide);
end;

procedure CloseSearch();
begin
    with frmTestQuality do
    begin
        // Recolher a busca...
        rect_busca.AnimateFloat('Width', 50, 0.5, TAnimationType.InOut,
                               TInterpolationType.Circular);

        // Exibe o logo...
       // img_logo.AnimateFloatDelay('Opacity', 1, 0.5, 0.2, TAnimationType.InOut,
         //                      TInterpolationType.Circular);

        TThread.CreateAnonymousThread(procedure
        begin
            sleep(200);

            TThread.Synchronize(nil, procedure
            begin
                // Exibe os botoes de busca e msg...
                layout_botoes.Visible := true;

                // Esconde a busca...
                layout_busca.Visible := false;
            end);

        end).Start;

    end;
end;

procedure TfrmTestQuality.OpenSearch();
var
    largura : integer;
begin
    with frmTestQuality do
    begin
        // Esconder o layout de botoes...
        layout_botoes.Visible := false;
        rect_AutoComplete.Visible := false;

        // Exibir campos de busca...
        layout_busca.Visible := true;

        // Animar caixa de busca...
        largura := trunc(layout_busca.Width - lbl_canc_buscar.Width - 15);
        rect_busca.Width := 50;
        rect_busca.Fill.Color :=$FFE9E9E9;
        rect_busca.AnimateFloat('Width', largura, 0.5, TAnimationType.InOut,
                               TInterpolationType.Circular);

        // Esconder o logo do app...
        //img_logo.AnimateFloat('Opacity', 0, 0.5, TAnimationType.InOut,
          //                     TInterpolationType.Circular);

        // Foco no edit...
        edt_buscar.setfocus;

    end;
end;
Procedure TfrmTestQuality.AddMake(make: string);
var
    lbl : TLabel;
    item : TlistboxItem;
    roundR : TRoundRect;
begin

    item := TListBoxItem.Create(lbmakes);
    item.Text := '';
    item.Width := 105;
    item.Height := 150;
    item.Selectable := false;
    item.TagString := make;
    item.Margins.Bottom := 5;

    lbl := TLabel.Create(item);
    lbl.Parent := item;
    lbl.Align := TAlignLayout.Contents;
    lbl.StyledSettings := [];
    lbl.FontColor := $FF7A4242;
    lbl.TextSettings.HorzAlign := TTextAlign.Center;
    lbl.ParentControl.BringToFront;
    lbl.Text := make;

    roundR := TRoundRect.Create(item);
    roundR.Parent := item;
    roundr.Align := TAlignLayout.Contents;
    roundr.Width := lbl.Text.Length;
    roundr.Opacity := 0.4;
    roundr.Margins.Bottom := 3;
    roundr.Stroke.Kind := TBrushKind.None;
    roundr.HitTest := false;

    lbMakes.AddObject(item);
end;


procedure TfrmTestQuality.AddTask(id_roadmap, qtd_Test_realizado{, id_testador}: integer;
                                  functionality,make, model, range, system,  progress: string);
var
    json : TJSONObject;
   // max_tasks : integer;
begin
    // max_tasks := 25;
     json := TJSONObject.create();

     with lv_task_test.items.Add do
     begin
       json.AddPair('roadmap_id', id_roadmap.ToString);
       json.AddPair('txtProgress', progress);

       TagString := json.ToString;
       Height := 40;
       tag := 0;

       TListItemText(Objects.FindDrawable('txtMake')).Text := make;
       TListItemText(Objects.FindDrawable('txtModel')).Text := model;
       TListItemText(Objects.FindDrawable('txtRange')).Text := range;
       TListItemText(Objects.FindDrawable('txtSystem')).Text := system;
       TListItemText(Objects.FindDrawable('txtFunction')).Text := functionality;

       if progress = '100' then
       begin
          TListItemImage(Objects.FindDrawable('imgValidar')).Bitmap := img_validar.Bitmap;
       end
       else
       begin
          TListItemImage(Objects.FindDrawable('imgValidar')).Bitmap := img_dev.Bitmap;
       end;
       if progress >= '0' then
       begin
          TListItemText(Objects.FindDrawable('txtProgress')).Text := progress + ' %';
          TListItemText(Objects.FindDrawable('txtProgress')).TextColor := $FFF82313;
       end
       else
          TListItemText(Objects.FindDrawable('txtProgress')).Text := progress + ' -';
       if progress <= '99' then
          TListItemText(Objects.FindDrawable('txtProgress')).TextColor := $FFF82313;

          TListItemText(Objects.FindDrawable('txtTest')).Text := 'Qtd Tests Done (' +
                                                                  qtd_Test_realizado.ToString + ' / ' +')';

          TListItemImage(Objects.FindDrawable('imgFundo')).Width := lv_task_test.Width - 30;
          TListItemImage(Objects.FindDrawable('imgFundo')).Bitmap := img_barra_fundo.Bitmap;
//          TListItemImage(Objects.FindDrawable('imgFundo')).TagFloat := max_tasks;

          TListItemImage(Objects.FindDrawable('imgProgresso')).TagFloat := qtd_Test_realizado;
          TListItemImage(Objects.FindDrawable('imgProgresso')).Bitmap := img_barra_progresso.Bitmap;
          TListItemImage(Objects.FindDrawable('imgProgresso')).Width := (qtd_Test_realizado);// *
                                                                //TListItemImage(Objects.FindDrawable('imgFundo')).Width;
          TListItemImage(Objects.FindDrawable('imgProgresso')).PlaceOffset.Y := TListItemImage(Objects.FindDrawable('imgFundo')).PlaceOffset.Y;

          TListItemImage(Objects.FindDrawable('img_collapse')).Bitmap := img_open.Bitmap;
          TListItemImage(Objects.FindDrawable('imgVeiculoTestado')).Bitmap := img_vehicle.Bitmap;

     end;
end;

procedure TfrmTestQuality.AddTaskDone(id_roadmap, id_testador: integer; make, model, range, system, functionality, progress, status, hours: string );
begin
  try
     with lv_TaskDone.items.Add do
     begin
        Tag:= id_roadmap;
        tagstring := id_testador.ToString;
        Height := 369;

       TListItemText(Objects.FindDrawable('txtMake')).Text := make;
       TListItemText(Objects.FindDrawable('txtModel')).Text := model;
       TListItemText(Objects.FindDrawable('txtRange')).Text := range;
       TListItemText(Objects.FindDrawable('txtSystem')).Text := system;
       TListItemText(Objects.FindDrawable('txtStatus')).Text := status;

       TListItemText(Objects.FindDrawable('txtHours')).Text := hours + ' Hours';
       TListItemText(Objects.FindDrawable('txtFunction')).Text := functionality;

       if progress >= '0' then
       begin
          TListItemText(Objects.FindDrawable('txtProgress')).Text := progress + ' %';
          TListItemText(Objects.FindDrawable('txtProgress')).TextColor := $FFF82313;
       end
       else
          TListItemText(Objects.FindDrawable('txtProgress')).Text := progress + ' -';
       if progress <= '99' then
          TListItemText(Objects.FindDrawable('txtProgress')).TextColor := $FFF82313;
     end;
  except on ex:exception do
        begin
            showmessage(ex.Message);
            exit;
        end;
  end;
end;

procedure TfrmTestQuality.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := TCloseAction.caFree;
    frmTestQuality := nil;
end;

procedure TfrmTestQuality.FormCreate(Sender: TObject);
begin
     lytMenuInferior.Visible := true;
     MudarAba(img_aba2);
     lblTitulo.Text := 'FRS Avail. to Test';
     img_validar.Visible:= false;
     img_validar.opacity := 0.7;
     img_dev.Visible := false;
     img_dev.opacity := 0.7;
     layout_detalhe.Visible := false;
     Layout2.Height := 60;
     lytMakes.Visible := false;
end;

procedure TfrmTestQuality.FormShow(Sender: TObject);
begin
    ListarTask_;
end;

procedure TfrmTestQuality.Image1Click(Sender: TObject);
begin
     if TabControl1.ActiveTab.Index = 0 then
     begin
        close;
     end
    else
    if TabControl1.ActiveTab.Index = 2 then
    begin
      TabControl1.GotoVisibleTab(1,TTabTransition.Slide);
      MudarAba(img_aba2);
      edt_buscar.Text := '';
      lblTitulo.Text := 'FRS Avail. to Test';
      lv_task_test.Items.Clear;
      makeSel := '';
      ListarTask_;
      lytMakes.Visible := false;
    end
    else
    if TabControl1.ActiveTab.Index = 1 then
    begin
      TabControl1.GotoVisibleTab(0,TTabTransition.Slide);
      edt_buscar.TextPrompt := 'Search by Setting (New, Done ..)';
      lblTitulo.Text := 'Roadmap Content';
      edt_buscar.Text := '';
      MudarAba(img_aba1);
      ListarTaskDone(edt_buscar.Text,bundle);
      lytMakes.Visible := true;
    end;

end;

procedure TfrmTestQuality.img_aba1Click(Sender: TObject);
begin
    MudarAba(TImage(Sender));
    CloseSearch;
    edt_buscar.TextPrompt := 'Search by (New, Done..)';
    lblTitulo.Text := 'Roadmap Content';
    edt_buscar.Text := '';
    Layout2.Height := 97;
    lytMakes.Visible := true;
    ListarMake;
end;

procedure TfrmTestQuality.img_aba2Click(Sender: TObject);
begin
    MudarAba(img_aba2);
    CloseSearch;
    lblTitulo.Text := 'FRS Avail. to Test';
    lv_task_test.Items.Clear;
    ListarTask_;
    lytMakes.Visible := false;
    Layout2.Height := 60;
end;

procedure TfrmTestQuality.img_aba3Click(Sender: TObject);
begin
    MudarAba(img_aba3);
    lblTitulo.Text := 'Content Missing Val.';
    lv_TaskSemTest.Items.Clear;
    layout2.Height := 60;
    ListarMake;
end;

procedure TfrmTestQuality.img_buscaClick(Sender: TObject);
begin
    if TabControl1.ActiveTab.Index = 0 then
      begin
       edt_buscar.Text := '';
       OpenSearch;
       ListarTaskDone(edt_buscar.Text,bundle);
      end;
    if TabControl1.ActiveTab.Index = 1 then
      begin
       edt_buscar.Text := '';
       edt_buscar.TextPrompt := 'Search by Make';
       OpenSearch;
       ListarTask_;
      end;
end;

procedure TfrmTestQuality.img_fechar_detalheClick(Sender: TObject);
begin
    layout_detalhe.Visible := false;
end;

procedure TfrmTestQuality.lbAutoCompleteItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
     edt_buscar.Text := edt_buscar.Text + Copy(Item.Text, 0, Item.Text.Length);
     HideAutoComplete;
end;

procedure TfrmTestQuality.lbl_canc_buscarClick(Sender: TObject);
begin
    CloseSearch;
   // edt_buscar.Text :='';
end;

procedure TfrmTestQuality.lbMakeItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
    makesel := Item.TagString;
    ListarTaskDone(edt_buscar.Text,bundle);
end;

procedure TfrmTestQuality.ListarTaskDone(busca,bundle: string);
var
    i : integer;
    jsonArray : TJSONArray;
    erro: string;
begin

    if NOT dm.ListarTaskDone(makeSel, busca, jsonArray, erro) then
    begin
      ShowMessage(erro);
      exit;
    end;
    try
     lv_TaskDone.ScrollTo(0);
     lv_TaskDone.Items.Clear;
     lv_TaskDone.BeginUpdate;

    for i := 0 to jsonArray.Size -1 do
      begin
          AddTaskDone(jsonArray.Get(i).GetValue<integer>('roadmap_id', 0),
                      jsonArray.Get(i).GetValue<integer>('id_usuario',0),
                      jsonArray.Get(i).GetValue<string>('make', ''),
                      jsonArray.Get(i).GetValue<string>('model', ''),
                      jsonArray.Get(i).GetValue<string>('year_range', ''),
                      jsonArray.Get(i).GetValue<string>('system', ''),
                      jsonArray.Get(i).GetValue<string>('functionality', ''),
                      jsonArray.Get(i).GetValue<string>('vehicle_test', ''),
                      jsonArray.Get(i).GetValue<string>('setting', ''),
                      jsonArray.Get(i).GetValue<string>('hours', '')
                      );
      end;
      img_No_cat.Visible := jsonarray.size = 0;
      jsonArray.DisposeOf;
    finally
      lv_TaskDone.EndUpdate;
      lv_TaskDone.RecalcSize;
    end;

end;
procedure TfrmTestQuality.lv_TaskDoneItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
    json : string;
    jsonObj : TJSONObject;
begin
       try
        json := ItemObject.TagString; // Contem o json com todos os campos salvos...
        jsonObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONObject;

      //ShowMessage('Voc� selecionou a Task ' + jsonObj.GetValue('id_roadmap').Value.ToInteger;

    finally
        jsonObj.DisposeOf;
    end;
     {  if ItemObject.Name = 'imgValidar' then
        if TListItemText(ItemObject).Text = TListItemText(lv_TaskDone.Items[ItemIndex].Objects.FindDrawable('txtProgress')).Text then
        begin
         //

        end;   }
end;

procedure TfrmTestQuality.lv_TaskDoneScrollViewChange(Sender: TObject);
begin
    if lv_TaskDone.GetItemRect(0).Bottom > 0 then
        Layout2.Margins.Top := lv_TaskDone.GetItemRect(0).Top
    else
        Layout2.Margins.Top := -79;

    Layout2.Opacity := lv_TaskDone.GetItemRect(0).Bottom/2/100;
end;

procedure TfrmTestQuality.lv_TaskDoneUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
    txt,txt2: TListItemText;
begin

    // Calcula objeto make...
    txt := TListItemText(AItem.Objects.FindDrawable('txtMake'));
    txt.Width := lv_TaskDone.Width - 135;

    // Calcula objeto model...
    txt := TListItemText(AItem.Objects.FindDrawable('txtModel'));
    txt.Width := lv_TaskDone.Width - 300;
    txt.Height := TFunctions.GetTextHeight(txt, txt.width, txt.Text);

    // Calcula objeto system...
    txt := TListItemText(AItem.Objects.FindDrawable('txtSystem'));
    txt.Width := lv_TaskDone.Width - 245;
    txt.Height := TFunctions.GetTextHeight(txt, txt.width, txt.Text);

    //calcula objeto setting
    txt2 := TListItemText(AItem.Objects.FindDrawable('txtStatus'));
    txt2.Width := 100;
    txt2.PlaceOffset.X := 15;

     // Calcula objeto Function...
    txt := TListItemText(AItem.Objects.FindDrawable('txtFunction'));
    txt.Width := lv_TaskDone.Width - 105;
    txt.Height := TFunctions.GetTextHeight(txt, txt.width, txt.Text);
    txt.PlaceOffset.Y := txt.PlaceOffset.Y + txt2.Width/5;

    // Calcula altura do item da listview...
    Aitem.Height := 130;
end;

procedure TfrmTestQuality.lv_task_testItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var
  item : TlistViewItem;
  progress : integer;
  json : string;
  jsonObj : TJSONObject;
begin
    if ItemObject <> nil then
    begin
        if ItemObject.Name = 'img_collapse'  then
          begin
             item := lv_task_test.items[ItemIndex];

             if item.Tag = 0 then
                item.Tag := 1
             else
                item.Tag := 0;

           lv_task_test.RecalcSize;
          end;

        if ItemObject.Name = 'txtProgress' then
        begin
          try
              json := lv_task_test.items[ItemIndex].TagString;     // Contem o json com todos os campos salvos...
              jsonObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONObject;
              progress := jsonObj.GetValue('txtProgress').Value.ToInteger;
              if progress.ToString = '100' then
                begin
                   roadmap_id :=  jsonObj.GetValue('roadmap_id').Value.ToInteger;
                   lv_task_test.AllowSelection := true;
                   layout_detalhe.Visible := true;
                   ListarVeiculosTask;
                end
          finally
            jsonObj.DisposeOf
          end;
        end;
        if ItemObject.Name = 'imgVeiculoTestado' then
         begin
          try
              json := lv_task_test.items[ItemIndex].TagString;     // Contem o json com todos os campos salvos...
              jsonObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONObject;
              progress := jsonObj.GetValue('txtProgress').Value.ToInteger;
              if progress.ToString = '100' then
                begin
                   roadmap_id :=  jsonObj.GetValue('roadmap_id').Value.ToInteger;
                   lv_task_test.AllowSelection := true;
                   layout_detalhe.Visible := true;
                   ListarVeiculosTestado;
                end
          finally
            jsonObj.DisposeOf
          end;
        end;
    end;
end;

procedure TfrmTestQuality.lv_task_testUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
    txt,txt2, txtTest: TListItemText;
    img_validar,img_dev : TListItemImage;
    altura : integer;
    progresso,max_tasks, qtd_Test_realizado : double;
begin
    //max_tasks := lv_task_test.Height;
    //max_tasks := TListItemImage(AItem.Objects.FindDrawable('imgFundo')).TagFloat;
    qtd_Test_realizado := TListItemImage(AItem.Objects.FindDrawable('imgProgresso')).TagFloat;

    // Calcula objeto make...
    txt := TListItemText(AItem.Objects.FindDrawable('txtMake'));
    txt.Width := lv_task_test.Width - 135;

    // Calcula objeto model...
    txt := TListItemText(AItem.Objects.FindDrawable('txtModel'));
    txt.Width := lv_task_test.Width - 245;
    txt.Height := TFunctions.GetTextHeight(txt, txt.width*2, txt.Text);

    // Calcula objeto system...
    txt := TListItemText(AItem.Objects.FindDrawable('txtSystem'));
    txt.Width := lv_task_test.Width - 245;
    txt.Height := TFunctions.GetTextHeight(txt, txt.width, txt.Text);
    txt.PlaceOffset.X := txt.PlaceOffset.X + 20;

     // Calcula objeto Function...
    txt2 := TListItemText(AItem.Objects.FindDrawable('txtFunction'));
    txt2.Width := lv_task_test.Width - 105;
    txt2.Height := TFunctions.GetTextHeight(txt2, txt.width, txt.Text);
    txt2.PlaceOffset.Y := txt.PlaceOffset.Y + 53 {+ txt.Height - 25};

     // Calcula objeto btn...
    img_validar := TListItemImage(AItem.Objects.FindDrawable('imgValidar'));
    img_validar.PlaceOffset.X := -5;

    // Calcula objeto texto Test...
    txtTest := TListItemText(AItem.Objects.FindDrawable('txtTest'));
    txtTest.PlaceOffset.Y := txt2.PlaceOffset.Y + 30;

    if lv_task_test.Width < 350 then
        txtTest.Text := 'Vehiles Avail.('
    else
        txtTest.Text := 'Vehicles To Test (';
    txtTest.Text := txtTest.Text + qtd_Test_realizado.ToString + ' )';

    // Calcula tamanho da barra de progressao...
    progresso := (qtd_Test_realizado);
    //* TListItemImage(AItem.Objects.FindDrawable('imgFundo')).Width

    TListItemImage(AItem.Objects.FindDrawable('imgFundo')).Visible := false;
    TListItemImage(AItem.Objects.FindDrawable('imgFundo')).PlaceOffset.Y := txtTest.PlaceOffset.Y + txtTest.Height + 10;
    TListItemImage(AItem.Objects.FindDrawable('imgFundo')).Width := lv_task_test.Width - 230;

    TListItemImage(AItem.Objects.FindDrawable('imgProgresso')).Width := progresso;
    TListItemImage(AItem.Objects.FindDrawable('imgProgresso')).PlaceOffset.Y := TListItemImage(AItem.Objects.FindDrawable('imgFundo')).PlaceOffset.Y;
    TListItemImage(AItem.Objects.FindDrawable('imgProgresso')).Visible :=false;
    TListItemImage(AItem.Objects.FindDrawable('img_collapse')).Opacity := 0.5;
    TListItemImage(AItem.Objects.FindDrawable('imgVeiculoTestado')).Opacity := 0.5;


   if AItem.tag = 0 then
   begin
      //AItem.Height := 40;
      AItem.Height := trunc(txt.Height + 20);
      TListItemImage(AItem.Objects.FindDrawable('img_collapse')).Bitmap := img_open.Bitmap;
      TListItemText(AItem.Objects.FindDrawable('txtRange')).Visible := false;
      TListItemText(AItem.Objects.FindDrawable('txtProgress')).Visible := false;
      TListItemText(AItem.Objects.FindDrawable('txtFunction')).Visible := false;
      TListItemText(AItem.Objects.FindDrawable('txtTest')).Visible := false;
      TListItemImage(AItem.Objects.FindDrawable('imgProgresso')).Visible := false;
      TListItemImage(AItem.Objects.FindDrawable('imgValidar')).Visible := false;
      TListItemImage(AItem.Objects.FindDrawable('imgVeiculoTestado')).Visible := false;
   end
   else
   begin
      Aitem.Height := Trunc(img_validar.PlaceOffset.Y + img_validar.Height + 95);
      TListItemImage(AItem.Objects.FindDrawable('img_collapse')).Bitmap := img_close.Bitmap;
      TListItemText(AItem.Objects.FindDrawable('txtRange')).Visible := true;
      TListItemText(AItem.Objects.FindDrawable('txtProgress')).Visible := true;
      TListItemText(AItem.Objects.FindDrawable('txtFunction')).Visible := true;
      TListItemText(AItem.Objects.FindDrawable('txtTest')).Visible := true;
      TListItemImage(AItem.Objects.FindDrawable('imgProgresso')).Visible := false;
      TListItemImage(AItem.Objects.FindDrawable('imgValidar')).Visible := true;
      TListItemImage(AItem.Objects.FindDrawable('imgVeiculoTestado')).Visible := true;
   end;
end;

procedure TfrmTestQuality.processarListaMake;
var
    jsonArray : TJsonArray;
    json, retorno : string;
    i : integer;
begin
    try
        // Se deu erro...
        if dm.Request_Make.Response.StatusCode <> 200 then
        begin
            showmessage('Erro ao consultar Marcas');
            exit;
        end;

        TLoading.Hide;
        json := dm.Request_Make.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.ANSI.GetBytes(json), 0) as TJSONArray;

    except on ex:exception do
        begin
            TLoading.Hide;
            showmessage(ex.Message);
            exit;
        end;
    end;

    try
      lbMakes.Items.Clear;
      for i := 0 to jsonArray.Size - 1 do
      begin
          AddMake(jsonArray.Get(i).GetValue<string>('Make', ''));
      end;

    finally
          jsonArray.DisposeOf;
    end;

end;

procedure TfrmTestQuality.processarTask;
var
    jsonArray : TJsonArray;
    json, retorno : string;
    i : integer;
begin
    try
        // Se deu erro...
        if dm.requestTaskQTD.Response.StatusCode <> 200 then
        begin
            showmessage('Erro ao consultar tasks');
            exit;
        end;

        TLoading.Hide;
        json := dm.requestTaskQTD.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONArray;

    except on ex:exception do
        begin
            TLoading.Hide;
            showmessage(ex.Message);
            exit;
        end;
    end;

    try
     lv_task_test.ScrollTo(0);
     lv_task_test.items.Clear;
     lv_task_test.BeginUpdate;

    for i := 0 to jsonArray.Size -1 do
      begin
       AddTask(jsonArray.Get(i).GetValue<integer>('roadmap_id', 0),
                      jsonArray.Get(i).GetValue<integer>('QTD_Task',0),
                      jsonArray.Get(i).GetValue<string>('functionality', ''),
                      jsonArray.Get(i).GetValue<string>('make', ''),
                      jsonArray.Get(i).GetValue<string>('model', ''),
                      jsonArray.Get(i).GetValue<string>('year_range', ''),
                      jsonArray.Get(i).GetValue<string>('system', ''),
                      jsonArray.Get(i).GetValue<string>('vehicle_test', '')
                      );
      end;
      Image5.Visible := jsonarray.size = 0;
      jsonArray.DisposeOf;
    finally
      lv_task_test.EndUpdate;
      lv_task_test.RecalcSize;
    end;
end;

procedure TfrmTestQuality.ProcessarListaMakeErro(Sender: TObject);
begin
    TLoading.Hide;
    if Assigned(Sender) and (Sender is Exception) then
        ShowMessage(Exception(Sender).Message);
end;

procedure TfrmTestQuality.AddTaskSemTest(id_roadmap: integer; make, model, range, system, functionality, progress: string );
begin
     with lv_TasksemTest.items.Add do
     begin
       Tag:= id_roadmap;
 //      tagstring := id_testador.ToString;
       Height := 369;

       TListItemText(Objects.FindDrawable('txtMake')).Text := make;
       TListItemText(Objects.FindDrawable('txtModel')).Text := model;
       TListItemText(Objects.FindDrawable('txtRange')).Text := range;
       TListItemText(Objects.FindDrawable('txtSystem')).Text := system;
       TListItemText(Objects.FindDrawable('txtFunction')).Text := functionality;

       if progress = '100' then
          TListItemImage(Objects.FindDrawable('imgValidar')).Bitmap := img_validar.Bitmap
       else
          TListItemImage(Objects.FindDrawable('imgValidar')).Bitmap := img_dev.Bitmap;
       if progress >= '0' then
       begin
          TListItemText(Objects.FindDrawable('txtProgress')).Text := progress + ' %';
          TListItemText(Objects.FindDrawable('txtProgress')).TextColor := $FFF82313;
       end
       else
          TListItemText(Objects.FindDrawable('txtProgress')).Text := progress + ' -';
       if progress <= '99' then
          TListItemText(Objects.FindDrawable('txtProgress')).TextColor := $FFF82313;
     end;
end;

procedure TfrmTestQuality.processarTaskSemTest;
var
    jsonArray : TJsonArray;
    json, retorno : string;
    i : integer;
begin
    try
        // Se deu erro...
        if dm.request_TasktoTest.Response.StatusCode <> 200 then
        begin
            showmessage('Erro ao consultar tasks');
            exit;
        end;

        TLoading.Hide;
        json := dm.request_TasktoTest.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.ANSI.GetBytes(json), 0) as TJSONArray;

    except on ex:exception do
        begin
            TLoading.Hide;
            showmessage(ex.Message);
            exit;
        end;
    end;

    try
     lv_TasksemTest.ScrollTo(0);
     lv_TasksemTest.items.Clear;
     lv_TasksemTest.BeginUpdate;

    for i := 0 to jsonArray.Size -1 do
      begin
       AddTaskSemTest(jsonArray.Get(i).GetValue<integer>('roadmap_id', 0),
                    //  jsonArray.Get(i).GetValue<integer>('id_usuario',0),
                      jsonArray.Get(i).GetValue<string>('make', ''),
                      jsonArray.Get(i).GetValue<string>('model', ''),
                      jsonArray.Get(i).GetValue<string>('year_range', ''),
                      jsonArray.Get(i).GetValue<string>('system', ''),
                      jsonArray.Get(i).GetValue<string>('functionality', ''),
                      jsonArray.Get(i).GetValue<string>('vehicle_test', '')
                      );
      end;
      Image5.Visible := jsonarray.size = 0;
      jsonArray.DisposeOf;
    finally
      lv_TasksemTest.EndUpdate;
      lv_TasksemTest.RecalcSize;
    end;

end;

procedure TfrmTestQuality.ProcessarTaskSemTestErro(Sender: TObject);
begin
    TLoading.Hide;
    if Assigned(Sender) and (Sender is Exception) then
        ShowMessage(Exception(Sender).Message);
end;
procedure TfrmTestQuality.ProcessarTaskErro(Sender: TObject);
begin
    TLoading.Hide;
    if Assigned(Sender) and (Sender is Exception) then
       ShowMessage(Exception(Sender).Message);
end;

procedure TfrmTestQuality.ListarTaskSemTest();
begin
    TLoading.Show(frmTestQuality, 'Carregando...');
    try
      dm.request_TasktoTest.Params.Clear;
      dm.request_TasktoTest.AddParameter('bundle',bundle);
      dm.request_TasktoTest.AddParameter('busca',makeSel);
      dm.request_TasktoTest.ExecuteAsync(processarTaskSemTest, true, true, ProcessarTaskSemTestErro);
    except on ex:exception do
      begin
          TLoading.Hide;
          showmessage('Erro ao acessar o servidor: ' + ex.Message);
          exit;
      end;
    end;
end;

procedure TfrmTestQuality.ListarTask_();
begin
    TLoading.Show(frmTestQuality, 'Carregando...');
    try
      dm.requestTaskQTD.Params.Clear;
      dm.requestTaskQTD.AddParameter('bundle',bundle);
      dm.requestTaskQTD.AddParameter('busca',makeSel);
      dm.requestTaskQTD.AddParameter('busca',edt_buscar.Text);
      dm.requestTaskQTD.ExecuteAsync(processarTask, true, true, ProcessarTaskErro);

    except on ex:exception do
      begin
          TLoading.Hide;
          showmessage('Erro ao acessar o servidor: ' + ex.Message);
          exit;
      end;
    end;
end;

procedure TfrmTestQuality.ListarMake();
begin
    TLoading.Show(frmTestQuality, 'Carregando...');
    try
      dm.Request_Make.Params.Clear;
      dm.Request_Make.AddParameter('Make','');
      dm.Request_Make.ExecuteAsync(processarListaMake, true, true, ProcessarListaMakeErro);

    except on ex:exception do
      begin
          TLoading.Hide;
          showmessage('Erro ao acessar o servidor: ' + ex.Message);
          exit;
      end;
    end;
end;

procedure TfrmTestQuality.ListarVeiculosTask();
begin
    TLoading.Show(frmTestQuality, 'Carregando...');
    try
      dm.RequestVehicleTask.Params.Clear;
      dm.RequestVehicleTask.AddParameter('id_roadmap',roadmap_id.ToString);
      dm.RequestVehicleTask.ExecuteAsync(carregarVeiculosdaTask, true, true, ProcessarListaMakeErro);

    except on ex:exception do
      begin
          TLoading.Hide;
          showmessage('Erro ao acessar o servidor: ' + ex.Message);
          exit;
      end;
    end;
end;

procedure TfrmTestQuality.ListarVeiculosTestado();
begin
    TLoading.Show(frmTestQuality, 'Carregando...');
    try
      dm.Request_VeiculoTestado.Params.Clear;
      dm.Request_VeiculoTestado.AddParameter('roadmap_id',roadmap_id.ToString);
      dm.Request_VeiculoTestado.ExecuteAsync(carregarVeiculosTestado, true, true, ProcessarListaMakeErro);

    except on ex:exception do
      begin
          TLoading.Hide;
          showmessage('Erro ao acessar o servidor: ' + ex.Message);
          exit;
      end;
    end;
end;

procedure TfrmTestQuality.carregarVeiculosTestado;
var
    i : integer;
    item : TListBoxItem;
    frame : TframeVehicleTested;
    jsonArray : TJsonArray;
    erro,json : string;
begin
    lbl_vehicleList.Items.Clear;

    try
        // Se deu erro...
        if dm.Request_VeiculoTestado.Response.StatusCode <> 200 then
        begin
            showmessage('Erro ao consultar os veiculos testados da task');
            exit;
        end;

        TLoading.Hide;
        json := dm.Request_VeiculoTestado.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONArray;

    except on ex:exception do
        begin
            TLoading.Hide;
            showmessage(ex.Message);
            exit;
        end;
    end;

    for i := 0 to jsonArray.Size - 1 do
    begin
        item := TListBoxItem.Create(lbl_vehicleList);
        item.Text := '';
        item.Width := 144;
        item.Height := 40;
        item.Selectable := false;
        item.Margins.top := 10;
        item.tag := roadmap_id;
        item.tagstring := jsonArray.Get(i).GetValue<string>('roadmap_id', '');

        frame := TframeVehicleTested.Create(item);
        frame.Parent := item;
        frame.Align := TAlignLayout.client;
        frame.Margins.Top := 10;


        frame.lblEng.text := jsonArray.Get(i).GetValue<string>('eng_size', '');
        frame.lblmodel.text := jsonArray.Get(i).GetValue<string>('model', '');
        frame.lblTester.text := jsonArray.Get(i).GetValue<string>('name', '');
        frame.lblLocation.text := jsonArray.Get(i).GetValue<string>('location', '');
        frame.lblDate.Text := jsonArray.Get(i).GetValue<string>('test_data', '01/01/2000');

        lbl_vehicleList.AddObject(item);
    end;
    jsonArray.DisposeOf;
end;

procedure TfrmTestQuality.carregarVeiculosdaTask;
var
    i : integer;
    item : TListBoxItem;
    frame : TframeVehicleAV;
    jsonArray : TJsonArray;
    erro,json : string;
begin
    lbl_vehicleList.Items.Clear;

    try
        // Se deu erro...
        if dm.RequestVehicleTask.Response.StatusCode <> 200 then
        begin
            showmessage('Erro ao consultar os veiculos anexados na task');
            exit;
        end;

        TLoading.Hide;
        json := dm.RequestVehicleTask.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONArray;

    except on ex:exception do
        begin
            TLoading.Hide;
            showmessage(ex.Message);
            exit;
        end;
    end;

    for i := 0 to jsonArray.Size - 1 do
    begin
        item := TListBoxItem.Create(lbl_vehicleList);
        item.Text := '';
        item.Width := 144;
        item.Height := 40;
        item.Selectable := false;
        item.Margins.top := 10;
        item.tag := roadmap_id;
        item.tagstring := jsonArray.Get(i).GetValue<string>('vehicle_id', '');

        frame := TframeVehicleAV.Create(item);
        frame.Parent := item;
        frame.Align := TAlignLayout.client;
        frame.Margins.Top := 10;

        frame.lblYear.Text := jsonArray.Get(i).GetValue<string>('year', '');
        frame.lblModel.text := jsonArray.Get(i).GetValue<string>('model', '');
        frame.lblEngSize.text := jsonArray.Get(i).GetValue<string>('eng_size', '');

        lbl_vehicleList.AddObject(item);
    end;
        jsonArray.DisposeOf;
end;

procedure TfrmTestQuality.edt_buscarExit(Sender: TObject);
begin
    HideAutoComplete;
    if TabControl1.ActiveTab.Index = 0 then
      begin
         ListarTaskDone(edt_buscar.Text,bundle);
      end
    else
         ListarTask_;
end;

procedure TfrmTestQuality.edt_buscarTyping(Sender: TObject);
var
  t : string;
begin
     t := TEdit(Sender).Text;
      if Copy(t, t.Length, 1) <> '' then
        ShowAutoComplete
      else
        HideAutoComplete;
end;

procedure TfrmTestQuality.ShowAutoComplete;
begin
    rect_AutoComplete.Opacity := 0.9;
    rect_AutoComplete.visible := true;
    rect_AutoComplete.Height := 185;
    lbAutoComplete.Visible := true;
    rect_AutoComplete.Fill.Color := $FFE9E9E9;
end;

procedure TfrmTestQuality.HideAutoComplete;
begin
    rect_AutoComplete.Height := 62;
    lbAutoComplete.Visible := false;
    rect_AutoComplete.visible := false;
    rect_AutoComplete.Fill.Color := $FFFFFFFF;
end;

end.

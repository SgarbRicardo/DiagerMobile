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
    Layout2: TLayout;
    lv_TaskDone: TListView;
    img_validar: TImage;
    rec_pesquisa: TRectangle;
    edt_buscar: TEdit;
    img_Buscar: TImage;
    img_dev: TImage;
    lblBundle: TLabel;
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
    procedure img_BuscarClick(Sender: TObject);
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
    procedure lv_task_testItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure img_fechar_detalheClick(Sender: TObject);
  private
    makeSel : string;
    procedure AddTaskDone(id_roadmap,id_testador: integer; make, model, range, system, functionality, progress : string);
    procedure ListarTaskDone(busca,bundle: string);
    procedure ListarMake;
    procedure processarListaMake;
    procedure ProcessarListaMakeErro(Sender: TObject);
    procedure AddMake(make: string);
    procedure AddTaskSemTest(id_roadmap, id_testador: integer; make, model, range, system, functionality, progress: string );
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
  unitFrameVehicles;

procedure TfrmTestQuality.MudarAba(img: TImage);
begin
    img_aba1.Opacity := 0.3;
    img_aba2.Opacity := 0.3;
    img_aba3.Opacity := 0.3;
    img_aba4.Opacity := 0.3;

    img.Opacity := 1;
    TabControl1.GotoVisibleTab(img.Tag, TTabTransition.Slide);
end;

Procedure TfrmTestQuality.AddMake(make: string);
var
    lbl : TLabel;
    item : TlistboxItem;
    roundR : TRoundRect;
begin

    item := TListBoxItem.Create(lbMake);
    item.Text := '';
    item.Width := 105;
    item.Height := 150;
    item.Selectable := false;
    item.TagString := make;

    lbl := TLabel.Create(item);
    lbl.Parent := item;
    lbl.Align := TAlignLayout.Contents;
    lbl.StyledSettings := [];
    lbl.FontColor := $FFD52121;
    lbl.TextSettings.HorzAlign := TTextAlign.Center;
    lbl.Text := make;

    lbMake.AddObject(item);
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

       Height := 369;

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

     end;
end;

procedure TfrmTestQuality.AddTaskDone(id_roadmap, id_testador: integer; make, model, range, system, functionality, progress: string );

begin
     with lv_TaskDone.items.Add do
     begin
        Tag:= id_roadmap;
        tagstring := id_testador.ToString;
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
     rec_pesquisa.Visible := false;
     lblBundle.Margins.Left := 5;
     img_validar.Visible:= false;
     img_validar.opacity := 0.7;
     img_dev.Visible := false;
     img_dev.opacity := 0.7;
     layout_detalhe.Visible := false;
end;

procedure TfrmTestQuality.FormShow(Sender: TObject);
begin
      rec_pesquisa.Visible := true;
      ListarTask_;
      lblBundle.Text := 'Bundle Version '+ bundle;
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
      rec_pesquisa.Visible := true;
      lv_task_test.Items.Clear;
      makeSel := '';
      ListarTask_;
    end
    else
    if TabControl1.ActiveTab.Index = 1 then
    begin
      TabControl1.GotoVisibleTab(0,TTabTransition.Slide);
      lblTitulo.Text := 'FRS Content';
      rec_pesquisa.Visible := true;
      edt_buscar.Text := '';
      lblBundle.Margins.Bottom := 8;
      MudarAba(img_aba1);
      ListarTaskDone(edt_buscar.Text,bundle);
    end;

end;

procedure TfrmTestQuality.img_aba1Click(Sender: TObject);
begin
    MudarAba(TImage(Sender));
    lblTitulo.Text := 'FRS Content';
    lblBundle.Text := 'Bundle Version '+ bundle;
    edt_buscar.Text := '';
    rec_pesquisa.Visible := true;
    lblBundle.Margins.Bottom := 8;
    ListarTaskDone(edt_buscar.Text,bundle);
end;

procedure TfrmTestQuality.img_aba2Click(Sender: TObject);

begin
    MudarAba(img_aba2);
    lblTitulo.Text := 'FRS Avail. to Test';
    lv_task_test.Items.Clear;
    edt_buscar.Text := '';
    rec_pesquisa.Visible := true;
    ListarTask_;
end;

procedure TfrmTestQuality.img_aba3Click(Sender: TObject);
begin
    MudarAba(img_aba3);
    lblTitulo.Text := 'Content Missing Val.';
    lblBundle.Text := 'Bundle Version '+ bundle;
    lv_TaskSemTest.Items.Clear;
    rec_pesquisa.Visible := false;
    layout2.Height := 60;
    ListarMake;
end;

procedure TfrmTestQuality.img_BuscarClick(Sender: TObject);
begin

    if TabControl1.ActiveTab.Index = 0 then
      begin
         ListarTaskDone(edt_buscar.Text,bundle);
      end
      else
         ListarTask_;
end;

procedure TfrmTestQuality.img_fechar_detalheClick(Sender: TObject);
begin
    layout_detalhe.Visible := false;
end;

procedure TfrmTestQuality.lbMakeItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
begin
    makesel := Item.TagString;
    lblTitulo.Text := '#Missing Test to: '+makesel+'#';
    ListarTaskSemTest;
end;

procedure TfrmTestQuality.ListarTaskDone(busca,bundle: string);
var
    i : integer;
    jsonArray : TJSONArray;
    erro: string;
begin

    if NOT dm.ListarTaskDone(bundle, busca, jsonArray, erro) then
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
                      jsonArray.Get(i).GetValue<string>('vehicle_test', '')
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

procedure TfrmTestQuality.lv_TaskDoneUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
    txt,txt2, txtTest: TListItemText;
    img_validar,img_dev : TListItemImage;
    altura : integer;
begin

    // Calcula objeto make...
    txt := TListItemText(AItem.Objects.FindDrawable('txtMake'));
    txt.Width := lv_TaskDone.Width - 135;

    // Calcula objeto model...
    txt := TListItemText(AItem.Objects.FindDrawable('txtModel'));
    txt.Width := lv_TaskDone.Width - 210;
    txt.Height := TFunctions.GetTextHeight(txt, txt.width, txt.Text);

    // Calcula objeto system...
    txt := TListItemText(AItem.Objects.FindDrawable('txtSystem'));
    txt.Width := lv_TaskDone.Width - 245;
    txt.Height := TFunctions.GetTextHeight(txt, txt.width, txt.Text);

     // Calcula objeto Function...
    txt := TListItemText(AItem.Objects.FindDrawable('txtFunction'));
    txt.Width := lv_TaskDone.Width - 105;
    txt.Height := TFunctions.GetTextHeight(txt, txt.width, txt.Text);
    txt.PlaceOffset.Y := txt.PlaceOffset.Y + 3 {+ txt.Height - 25};

     // Calcula objeto btn...
    img_validar := TListItemImage(AItem.Objects.FindDrawable('imgValidar'));
    img_validar.PlaceOffset.X := -5;

    // Calcula altura do item da listview...
    Aitem.Height := Trunc(img_validar.PlaceOffset.Y + img_validar.Height + 80);
end;

procedure TfrmTestQuality.lv_task_testItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
    progress: integer;
    json : string;
    jsonObj : TJSONObject;
begin

    try
        json := AItem.TagString; // Contem o json com todos os campos salvos...
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
    txt.Width := lv_task_test.Width - 210;
    txt.Height := TFunctions.GetTextHeight(txt, txt.width, txt.Text);

    // Calcula objeto system...
    txt := TListItemText(AItem.Objects.FindDrawable('txtSystem'));
    txt.Width := lv_task_test.Width - 245;
    txt.Height := TFunctions.GetTextHeight(txt, txt.width, txt.Text);

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

    TListItemImage(AItem.Objects.FindDrawable('imgFundo')).PlaceOffset.Y := txtTest.PlaceOffset.Y + txtTest.Height + 10;
    TListItemImage(AItem.Objects.FindDrawable('imgFundo')).Width := lv_task_test.Width - 230;

    TListItemImage(AItem.Objects.FindDrawable('imgProgresso')).Width := progresso;
    TListItemImage(AItem.Objects.FindDrawable('imgProgresso')).PlaceOffset.Y := TListItemImage(AItem.Objects.FindDrawable('imgFundo')).PlaceOffset.Y;
   // TListItemImage(AItem.Objects.FindDrawable('imgProgresso')).Visible := progresso > 0;

    // Calcula altura do item da listview...
    Aitem.Height := Trunc(img_validar.PlaceOffset.Y + img_validar.Height + 95);
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
      lbMake.Items.Clear;
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

procedure TfrmTestQuality.AddTaskSemTest(id_roadmap, id_testador: integer; make, model, range, system, functionality, progress: string );
begin
     with lv_TasksemTest.items.Add do
     begin
       Tag:= id_roadmap;
       tagstring := id_testador.ToString;
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
                      jsonArray.Get(i).GetValue<integer>('id_usuario',0),
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

procedure TfrmTestQuality.carregarVeiculosdaTask;
var
    i : integer;
    item : TListBoxItem;
    frame : TframeVehicle;
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
        item.Width := 195;
        item.Height := 80;
        item.Selectable := false;
        item.Margins.top := 10;
        item.tag := roadmap_id;
        item.tagstring := jsonArray.Get(i).GetValue<string>('vehicle_id', '');

        frame := TframeVehicle.Create(item);
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


end.
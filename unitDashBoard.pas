unit unitDashBoard;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,system.JSON;

type
  TfrmDashBoard = class(TForm)
    VertScrollBox1: TVertScrollBox;
    Rectangle2: TRectangle;
    layout_chart2: TLayout;
    Rectangle4: TRectangle;
    layout_chart3: TLayout;
    Rectangle1: TRectangle;
    layout_chart1: TLayout;
    Rectangle5: TRectangle;
    layout_chart4: TLayout;
    Layout2: TLayout;
    Label2: TLabel;
    img_refresh: TImage;
    procedure img_refreshClick(Sender: TObject);
  private
    procedure MontaGraficos;
    procedure MontaGrafico1;
    procedure MontaGrafico2;
    procedure MontaGrafico3;
    procedure MontaGrafico4;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDashBoard: TfrmDashBoard;

implementation

{$R *.fmx}

uses uSuperChart, untDM;

procedure TfrmDashBoard.MontaGraficos;
begin
    MontaGrafico4;

    // Grafico 2...
    TThread.CreateAnonymousThread(procedure
    begin
        sleep(500);

        TThread.Synchronize(nil, MontaGrafico2);
    end).Start;

    // Grafico 3...
    TThread.CreateAnonymousThread(procedure
    begin
        sleep(1000);

        TThread.Synchronize(nil, MontaGrafico3);
    end).Start;

 {   // Grafico 4...
    TThread.CreateAnonymousThread(procedure
    begin
        sleep(1500);

        TThread.Synchronize(nil, MontaGrafico4);
    end).Start;    }
end;

procedure TfrmDashBoard.img_refreshClick(Sender: TObject);
begin
    MontaGraficos
end;

procedure tfrmDashBoard.MontaGrafico1;
var
    erro: string;
    chart : TSuperChart;
    jsonArray : TJsonArray;
    json, retorno : string;
begin
    try
        chart := TSuperChart.Create(layout_chart1, HorizontalBar);

        // Valores
        chart.ShowValues := true;
        chart.FontSizeValues := 11;
        chart.FontColorValues := $FFFFFFFF;
        chart.FormatValues := '';

        // Barras
        chart.BarColor := $FFFFFFFF;
        chart.ShowBackground := true;
        chart.BackgroundColor := $FF3F72EA;
        chart.RoundedBotton := true;
        chart.RoundedTop := true;
        //chart.LineColor := $FFFFD270;

        // Arguments
        chart.FontSizeArgument := 11;
        chart.FontColorArgument := $FFFFFFFF;

        dm.requestCCListaStatus.Params.Clear;
        dm.requestCCListaStatus.Execute;

        try
          if dm.requestCCListaStatus.Response.StatusCode <> 200 then
            begin
                showmessage('Erro ao consultar os dados suporte');
                exit;
            end;

          json := dm.requestCCListaStatus.Response.JSONValue.ToString;
          jsonArray := TJSONObject.ParseJSONValue(TEncoding.ANSI.GetBytes(json), 0) as TJSONArray;

          chart.LoadFromJSON(jsonArray.ToString, erro);

          // Tratamento de erro
          if erro <> '' then
                showmessage(erro);
        finally

            jsonArray.DisposeOf;
        end;
    finally
    chart.DisposeOf;

    end;

end;

procedure tfrmDashBoard.MontaGrafico2;
var
    erro, jsonStr: string;
    chart : TSuperChart;
    jsonArray : TJsonArray;
    json, retorno : string;
begin
    try
        chart := TSuperChart.Create(layout_chart2, Lines);

        // Valores
        chart.ShowValues := true;
        chart.FontSizeValues := 11;
        chart.FontColorValues := $FF433B3B;
        chart.FormatValues := '';

        // Barras
        //chart.BarColor := $FFFFFFFF;
        //chart.ShowBackground := true;
        //chart.BackgroundColor := $FF4679EE;
        //chart.RoundedBotton := true;
        //chart.RoundedTop := true;
        chart.LineColor := $FF487DF7;

        // Arguments
        chart.FontSizeArgument := 11;
        chart.FontColorArgument := $FF6C6C6C;

        dm.RequestListaVerAtendida.Params.Clear;
        dm.RequestListaVerAtendida.Execute;

        try
          if dm.RequestListaVerAtendida.Response.StatusCode <> 200 then
            begin
                showmessage('Erro ao consultar os dados suporte');
                exit;
            end;

          json := dm.RequestListaVerAtendida.Response.JSONValue.ToString;
          jsonArray := TJSONObject.ParseJSONValue(TEncoding.ANSI.GetBytes(json), 0) as TJSONArray;

          chart.LoadAtendVerFromJSON(jsonArray.ToString, erro);

        finally
            chart.DisposeOf;
        end;

        if erro <> '' then
            showmessage(erro);
    finally
        chart.DisposeOf;
        jsonArray.DisposeOf;
    end;
end;

procedure tfrmDashBoard.MontaGrafico3;
var
    chart : TSuperChart;
    jsonArray : TJsonArray;
    json, retorno,erro : string;
    i : integer;
begin
    try
        chart := TSuperChart.Create(layout_chart3, VerticalBar);

        // Valores
        chart.ShowValues := true;
        chart.FontSizeValues := 11;
        chart.FontColorValues := $FF433B3B;
        chart.FormatValues := '';

        // Barras
        chart.BarColor := $FFFFFFFF;
        chart.ShowBackground := false;
        chart.BackgroundColor := $FF4679EE;
        chart.RoundedBotton := false;
        chart.RoundedTop := true;
        //chart.LineColor := $FFFFD270;

        // Arguments
        chart.FontSizeArgument := 11;
        chart.FontColorArgument := $FFFFFFFF;

        // JSON
        dm.RequestListaVerAtendida.Params.Clear;
        dm.RequestListaVerAtendida.Execute;

        try
          if dm.RequestListaVerAtendida.Response.StatusCode <> 200 then
            begin
                showmessage('Erro ao consultar os dados suporte');
                exit;
            end;

          json := dm.RequestListaVerAtendida.Response.JSONValue.ToString;
          jsonArray := TJSONObject.ParseJSONValue(TEncoding.ANSI.GetBytes(json), 0) as TJSONArray;

          chart.LoadAtendVerFromJSON(jsonArray.ToString, erro);

        finally
            chart.DisposeOf;
        end;

        if erro <> '' then
            showmessage(erro);
    finally
        chart.DisposeOf;
        jsonArray.DisposeOf;
    end;
end;

procedure tfrmDashBoard.MontaGrafico4;
var
    chart : TSuperChart;
    jsonArray : TJsonArray;
    json, retorno,erro : string;
    i : integer;
begin
    try
        chart := TSuperChart.Create(layout_chart4, HorizontalBar);

        // Valores
        chart.ShowValues := true;
        chart.FontSizeValues := 11;
        chart.FontColorValues := $FF433B3B;
        chart.FormatValues := '';

        // Barras
        chart.BarColor := $FF487DF7;
        chart.ShowBackground := false;
        chart.BackgroundColor := $FF4679EE;
        chart.RoundedBotton := false;
        chart.RoundedTop := false;
        //chart.LineColor := $FFFFD270;

        // Arguments
        chart.FontSizeArgument := 11;
        chart.FontColorArgument := $FF6C6C6C;

        dm.requestCCListaStatus.Params.Clear;
        dm.requestCCListaStatus.Execute;
      try
        if dm.requestCCListaStatus.Response.StatusCode <> 200 then
          begin
              showmessage('Erro ao consultar os dados suporte');
              exit;
          end;


        json := dm.requestCCListaStatus.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.ANSI.GetBytes(json), 0) as TJSONArray;

        chart.LoadFromJSON(jsonArray.ToString, erro);

      except on ex:exception do
        begin
            showmessage(ex.Message);
            exit;
        end;

      end;

        // Tratamento de erro
        if erro <> '' then
            showmessage(erro);
    finally
        chart.DisposeOf;
        jsonArray.DisposeOf;
    end;
end;
end.

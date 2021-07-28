unit UnitDM;

interface

uses
  System.SysUtils, System.Classes, uDWDataModule, uDWAbout, uRESTDWServerEvents,
  uDWJSONObject, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, CUsuario, cPerfil, System.JSON,
  FireDAC.VCLUI.Wait, FMX.Graphics, soap.EncdDecd, uDWConsts,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, cEmprestimo, cCategoria;

type
  Tdm = class(TServerMethodDataModule)
    DWUsuario: TDWServerEvents;
    conn: TFDConnection;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    DWEmprestimo: TDWServerEvents;
    qryCategoria: TFDQuery;
    DWCategoria: TDWServerEvents;
    DWChat: TDWServerEvents;
    DWTask: TDWServerEvents;
    DWSuporte: TDWServerEvents;
    procedure ServerMethodDataModuleCreate(Sender: TObject);
    procedure DWEventsEventscriarContaReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWEventsEventsListarTesteReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWUsuarioEventsusuarioReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWEmprestimoEventsemprestimoReplyEventByType(
      var Params: TDWParams; var Result: string;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWCategoriaEventslistarReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWUsuarioEventsDadosUsuarioReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWTaskEventsTaskReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWTaskEventsChatReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWTaskEventsBundleReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWTaskEventsTasktoTestReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWTaskEventsMakeReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWTaskEventsListaTaskReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWTaskEventsListaTaskQTDReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWEmprestimoEventsTodoEmprestimosReplyEventByType(
      var Params: TDWParams; var Result: string;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWSuporteEventsListarTopReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWSuporteEventsListaWaitCRReplyEventByType(var Params: TDWParams;
      var Result: string; const RequestType: TRequestType;
      var StatusCode: Integer; RequestHeader: TStringList);
    procedure DWSuporteEventsListaQTDStatusReplyEventByType(
      var Params: TDWParams; var Result: string;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWSuporteEventsListaVerAtendReplyEventByType(
      var Params: TDWParams; var Result: string;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWTaskEventsListaVeiculosTaskReplyEventByType(
      var Params: TDWParams; var Result: string;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
    procedure DWCategoriaEventsListarQtdCatReplyEventByType(
      var Params: TDWParams; var Result: string;
      const RequestType: TRequestType; var StatusCode: Integer;
      RequestHeader: TStringList);
  private
    function ValidarLogin(usuario, senha: string; out status: integer): string;
    function CriarUsuario(usuario, senha, email, foto64, departamento, nivel_acesso,nome,logoda_ate: string;
      out status: integer): string;
    function ListaEmprestimo(busca: string;id_usuario, Cat_Id: integer;
                             //ind_destaque : string;
                             out status_code : integer):string;
    function ListaCategoria(out status_code: integer): string;
    function ListarChat(id_task_test,id_usuario : string; out status_code: integer): string;
    function CriarChat(id_usuario_de, id_usuario_para, texto, id_task_test : string;
                       out status: integer): string;
    function listaUsuario(out status_code: integer): string;
    function EditarEmprestimo(Empre_id,Empre_equip_id,Empre_Leasing,
                              Empre_user_id,id_equip,Empre_DT_Leasing: string; out status: integer): string;
    function ListaTask(bundle, busca: string;
                       out status_code: integer): string;
    function EditarUsuario(id_usuario, campo, valor: string;
      out status: integer): string;
    function ListaBundle(out status_code: integer): string;
    function ListarTaskSemTeste(bundle, busca: string;
      out status_code: integer): string;
    function ListaMarca(out status_code: integer): string;
    function ListaTaskTest(bundle, busca: string;
      out status_code: integer): string;
    function ListaQTDTask(bundle,busca: string; out status_code: integer): string;
    function ListaTodoEmprestimo(busca: string; Equip_Cat_Id: integer;
                                 out status_code : integer):string;
    function Listatop10(out status_code: integer): string;
    function ListaWaitCR(out status_code: integer): string;
    function ListaQTDStatus(out status_code: integer): string;
    function ListaVerAtend(out status_code: integer): string;
    function IsNumeric(S: String): Boolean;
    function ListaVeiculosTask(roadmap_id: integer;out status_code: integer): string;
    function ListaQtdCategoria(id_usuario: integer;
      out status_code: integer): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

uses system.inifiles, FMX.dialogs, cChat, uFunctions, cTask, cSuporte;


{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}


function LoadConfig() : string;

var
  arq_ini, base, usuario, senha, driver,Server, OSAuthent,MultipleActiveResultSets : string;
  ini : TiniFile;

begin
    try
      arq_ini := system.SysUtils.GetCurrentDir + '\servidor.ini';

      if NOT FileExists(arq_ini) then
      begin
        result := 'Arquivo ini não ENCONTRADO: ' + arq_ini;
        exit;
      end;

      ini:=   TIniFile.Create(arq_ini);

      base:= ini.ReadString('Banco de dados', 'Database', '');
      usuario:= ini.ReadString('Banco de dados', 'User_Name', '');
      senha:= ini.ReadString('Banco de dados', 'Password', '');
      driver:= ini.ReadString('Banco de dados', 'DriverID', '');
      Server := ini.ReadString('Banco de dados', 'Server', '');
      OSAuthent := ini.ReadString('Banco de dados', 'OSAuthent', '');
   //   MultipleActiveResultSets := ini.ReadString('Banco de dados', 'MultipleActiveResultSets', '');


      dm.conn.Params.Values ['DriverID'] := driver;
      dm.conn.Params.Values ['Database'] := base;
      dm.conn.Params.Values ['User_Name'] := usuario;
      dm.conn.Params.Values ['Password'] := senha;
      dm.conn.Params.Values ['Server'] := Server;
      dm.conn.Params.Values ['OSAuthent'] := OSAuthent;
   //   dm.conn.Params.Values ['MultipleActiveResultSets'] := MultipleActiveResultSets;

      try
        dm.conn.Connected := true;
        result := 'OK'
        except on ex:exception do
        Result := 'Erro ao conectar com o banco de dados: ' + ex.Message;

      end;
    finally
    ini.DisposeOf;

    end;
end;

Function BitmapFromBase64 (const base64: string): TBitmap;

var
  Input: TStringStream;
  Output: TBytesStream;
begin
    Input := TStringStream.Create(base64, Tencoding.ASCII);
    try
      Output := TBytesStream.Create;
      try
        Soap.EncdDecd.DecodeStream(Input, Output);
        Output.Position := 0;
        Result := TBitmap.Create;
        try
          Result.LoadFromStream(Output);
          Except
            Result.Free;
            raise;
        end;
      finally
        Output.Free;
      end;
      finally
        input.Free;
    end;

end;

function Tdm.ListaEmprestimo(busca: string;id_usuario, Cat_Id: integer;
                             out status_code : integer):string;
var
    e : TEmprestimo;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
    try
        e := TEmprestimo.Create(dm.conn);

        e.PROD_DESCRICAO := busca;
        e.COD_USUARIO := id_usuario;
        e.CAT_ID := Cat_Id;

        qry := e.ListarEmprestimo(busca,erro);

        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

    finally
         if Assigned (qry) then
            qry.DisposeOf;

         e.DisposeOf;
         json.DisposeOf;
     end;
end;

function Tdm.IsNumeric(S : String) : Boolean;
begin
    Result := True;
    Try
       StrToInt(S);
    Except
       Result := False;
    end;
end;

function Tdm.ListaTodoEmprestimo(busca: string; Equip_Cat_Id: integer;
                                out status_code : integer):string;
var
    e : TEmprestimo;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
    try
       e := TEmprestimo.Create(dm.conn);
       e.PROD_DESCRICAO := busca;
       e.CAT_ID := Equip_Cat_Id;

        qry := e.ListarTodosEmprestimo(busca,'',erro);

        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

    finally
         if Assigned (qry) then
            qry.DisposeOf;

         e.DisposeOf;
         json.DisposeOf;
     end;
end;

function Tdm.ListaTask(bundle, busca : string; out status_code : integer):string;
var
    t : TTask;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
  try
      try
        t := TTask.Create(dm.conn);
        t.BUNDLE := bundle;
        t.MAKE := busca;

        qry := t.ListaTaskDone(busca,'',erro);
        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy - hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

      except on ex:exception do
        begin
          status_code := 400;
          Result := '[{"retorno": "' + ex.Message + '"}]';
        end;

      end;
      finally
           t.DisposeOf;
           json.DisposeOf;
      end;
end;


function Tdm.ListaCategoria(out status_code : integer):string;
var
    c : TCategoria;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
    try
        c := TCategoria.Create(dm.conn);
        qry := c.ListaCategoria('',erro);

        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

    finally
         if Assigned (qry) then
            qry.DisposeOf;

         c.DisposeOf;
         json.DisposeOf;
     end;
end;

function Tdm.ListaMarca(out status_code : integer):string;
var
    t : TTask;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
    try
        t := TTask.Create(dm.conn);
        qry := t.ListaMake('',erro);

        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

    finally
         if Assigned (qry) then
            qry.DisposeOf;

         t.DisposeOf;
         json.DisposeOf;
     end;
end;

function Tdm.ListaVeiculosTask(roadmap_id: integer;out status_code : integer):string;
var
    t : TTask;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
    try
        t := TTask.Create(dm.conn);
        t.ID_ROADMAP := roadmap_id;
        qry := t.ListaVeiculosdaTask('',erro);

        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

    finally
         if Assigned (qry) then
            qry.DisposeOf;

         t.DisposeOf;
         json.DisposeOf;
     end;
end;


function Tdm.ListaBundle(out status_code : integer):string;
var
    t : TTask;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
    try
        t := TTask.Create(dm.conn);
        qry := t.ListaBundle('',erro);

        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

    finally
         if Assigned (qry) then
            qry.DisposeOf;

         t.DisposeOf;
         json.DisposeOf;
     end;
end;

function Tdm.ListaQTDStatus(out status_code : integer):string;
var
    SU : TSuporte;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
    try
        SU := TSuporte.Create(dm.conn);
        qry := SU.ListaStatusSuporte('',erro);

        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

    finally
         if Assigned (qry) then
            qry.DisposeOf;

         SU.DisposeOf;
         json.DisposeOf;
     end;
end;

function Tdm.ListaVerAtend(out status_code : integer):string;
var
    SU : TSuporte;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
    try
        SU := TSuporte.Create(dm.conn);
        qry := SU.ListaVersaoAtend('',erro);

        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

    finally
         if Assigned (qry) then
            qry.DisposeOf;

         SU.DisposeOf;
         json.DisposeOf;
     end;
end;

function Tdm.Listatop10(out status_code : integer):string;
var
    SU : TSuporte;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
    try
        SU := TSuporte.Create(dm.conn);
        qry := SU.ListaTop10Atend('',erro);

        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

    finally
         if Assigned (qry) then
            qry.DisposeOf;

         SU.DisposeOf;
         json.DisposeOf;
     end;
end;

function Tdm.ListaWaitCR(out status_code : integer):string;
var
    SU : TSuporte;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
    try
        SU := TSuporte.Create(dm.conn);
        qry := SU.ListaWaitCR('',erro);

        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

    finally
         if Assigned (qry) then
            qry.DisposeOf;

         SU.DisposeOf;
         json.DisposeOf;
     end;
end;

function Tdm.listaUsuario(out status_code : integer):string;
var
    u : TUsuario;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin

    try
        u := TUsuario.Create(dm.conn);
        qry := u.DadosUsuario('',erro);

        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

    finally
         u.DisposeOf;
         json.DisposeOf;
     end;
end;

function Tdm.ListarChat(id_task_test,id_usuario : string; out status_code : integer):string;
var
    c : Tchat;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
  try
      try
        c := TChat.Create(dm.conn);
        c.ID_TASK_TEST := id_task_test.ToInteger;
        c.USER_ID_TO := id_usuario.ToInteger;


        qry := c.ListarChat('',erro);

        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy - hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

      except on ex:exception do
        begin
          status_code := 400;
          Result := '[{"retorno": "' + ex.Message + '"}]';
        end;

      end;
      finally
           c.DisposeOf;
           json.DisposeOf;
      end;
end;

function Tdm.ListaQtdCategoria(id_usuario : integer; out status_code : integer):string;
var
    c : TCategoria;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
  try
      try
        C := TCategoria.Create(dm.conn);
        C.ID_USUARIO := id_usuario;

        qry := C.ListaQtdCat('',erro);
        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy - hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

      except on ex:exception do
        begin
          status_code := 400;
          Result := '[{"retorno": "' + ex.Message + '"}]';
        end;

      end;
      finally
           C.DisposeOf;
           json.DisposeOf;
      end;
end;

function Tdm.ListaQTDTask(bundle, busca : string; out status_code : integer):string;
var
    t : TTask;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
  try
      try
        t := TTask.Create(dm.conn);
        t.BUNDLE := bundle;
        t.MAKE := busca;

        qry := t.ListaTaskQtdTasks(busca,'',erro);
        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy - hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

      except on ex:exception do
        begin
          status_code := 400;
          Result := '[{"retorno": "' + ex.Message + '"}]';
        end;

      end;
      finally
           t.DisposeOf;
           json.DisposeOf;
      end;
end;


function Tdm.ListaTaskTest(bundle, busca : string; out status_code : integer):string;
var
    t : TTask;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
  try
      try
        t := TTask.Create(dm.conn);
        t.BUNDLE := bundle;
        t.MAKE := busca;

        qry := t.ListaTask(busca,'',erro);
        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy - hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

      except on ex:exception do
        begin
          status_code := 400;
          Result := '[{"retorno": "' + ex.Message + '"}]';
        end;

      end;
      finally
           t.DisposeOf;
           json.DisposeOf;
      end;
end;


function Tdm.ListarTaskSemTeste(bundle, busca : string; out status_code : integer):string;
var
    t : TTask;
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
    erro : string;
begin
  try
      try
        t := TTask.Create(dm.conn);
        t.BUNDLE := bundle;
        t.MAKE := busca;

        qry := t.ListaFaltaTeste(busca,'',erro);
        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', qry, false, jmPureJSON, 'dd/mm/yyyy - hh:nn:ss');

        Result := json.ToJSON;
        status_code := 200;

      except on ex:exception do
        begin
          status_code := 400;
          Result := '[{"retorno": "' + ex.Message + '"}]';
        end;

      end;
      finally
           t.DisposeOf;
           json.DisposeOf;
      end;
end;

procedure Tdm.DWCategoriaEventsListarQtdCatReplyEventByType(
  var Params: TDWParams; var Result: string; const RequestType: TRequestType;
  var StatusCode: Integer; RequestHeader: TStringList);
begin
    if RequestType = TRequestType.rtGet then
        Result := ListaQtdCategoria(params.ItemsString['id_usuario'].asInteger,
                                    StatusCode)
    else
    begin
       StatusCode := 403;
       Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
    end;
end;

procedure Tdm.DWCategoriaEventslistarReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
      // GET.............
    if RequestType = TRequestType.rtGet then
        Result := ListaCategoria(statusCode)

    else
    begin
       StatusCode := 403;
       Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
    end;
end;

procedure Tdm.DWEmprestimoEventsemprestimoReplyEventByType(
  var Params: TDWParams; var Result: string; const RequestType: TRequestType;
  var StatusCode: Integer; RequestHeader: TStringList);
begin
      // GET.............
    if RequestType = TRequestType.rtGet then
        Result := ListaEmprestimo(params.itemsString['busca'].AsString,
                                  params.itemsString['id_usuario'].AsInteger,
                                  params.itemsString['Cat_Id'].AsInteger,
                                  StatusCode)
     else
      // patch..........
     if RequestType = TRequestType.rtPatch then
        Result := EditarEmprestimo (params.itemsString['Empre_ID'].asString,
                                    params.itemsString['Empre_Equip_Id'].asString,
                                    params.ItemsString['Empre_Leasing'].AsString,
                                    params.itemsString['Empre_User_Id'].asString,
                                    params.itemsString['id_equip'].asString,
                                    params.ItemsString['Empre_DT_Leasing'].asString,
                                    StatusCode)
     else
      // patch..........
 {    if RequestType = TRequestType.rtPost then
        Result := InserirEmprestimo (params.itemsString['Empre_ID'].asString,
                                    params.itemsString['Empre_Equip_Id'].asString,
                                    params.itemsString['Empre_DT_Leasing'].asString,
                                    params.itemsString['Empre_DT_Return'].asString,
                                    params.itemsString['Empre_User_Id'].asString,
                                    StatusCode)
      else                                            }
      begin
         StatusCode := 403;
         Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
     end;
end;

procedure Tdm.DWEmprestimoEventsTodoEmprestimosReplyEventByType(
  var Params: TDWParams; var Result: string; const RequestType: TRequestType;
  var StatusCode: Integer; RequestHeader: TStringList);
begin
        // GET.............
    if RequestType = TRequestType.rtGet then
        Result := ListaTodoEmprestimo(params.itemsString['busca'].AsString,
                                    params.itemsString['Cat_Id'].AsInteger,
                                    StatusCode)
     else
       begin
         StatusCode := 403;
         Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
     end;
end;

procedure Tdm.DWEventsEventscriarContaReplyEvent(var Params: TDWParams;
  var Result: string);

//  var
//  email, user, senha, erro, foto64 : string;
//  usuario : TUsuario;
//  json : TJsonObject;
//  foto_bmp: TBitmap;
begin
//  //  try
//       email := Params.ItemsString['email'].AsString;
//       user := Params.ItemsString['user'].AsString;
//       senha := Params.ItemsString['senha'].AsString;
//       foto64 := Params.ItemsString['foto'].AsString;
//
//       json := TJsonObject.Create;
//
//
//       //validações
//
//       if (email = '' ) or (user = '' ) or (senha = '') or (foto64 = '')then
//       begin
//         json.AddPair('Sucesso', 'N');
//         json.AddPair('Erro', 'Informe todos os parametros');
//         json.AddPair('codusuario', '0');
//         Result := json.ToString;
//
//         exit;
//       end;
//
//       // Criar foto bitmap
//       try
//        foto_bmp := BitmapFromBase64(foto64);
//
//         except on ex:exception do
//         begin
//            json.AddPair('Sucesso', 'N');
//            json.AddPair('Erro', 'Erro ao criar imagem no servidor' + ex.Message);
//            json.AddPair('codusuario', '0');
//            Result := json.ToString;
//
//            exit;
//         end;
//         end;
//
//        try
//            usuario := TUsuario.Create(dm.conn);
//            usuario.Email := email;
//            usuario.Usuario := user;
//            usuario.Senha := senha;
//            usuario.Foto := foto_bmp;
//
//          if not usuario.CriarConta(erro) then
//            begin
//                 json.AddPair('Sucesso', 'N');
//                 json.AddPair('Erro', erro);
//                 json.AddPair('codusuario', '0');
//            end
//            else
//            begin
//                 json.AddPair('Sucesso', 'S');
//                 json.AddPair('Erro', erro);
//                 json.AddPair('Usuario', usuario.Cod_Usuario.ToString);
//            end;
//        Finally
//            foto_bmp.DisposeOf;
//            usuario.DisposeOf;
//        end;
//        Result := json.ToString;
//  finally
//      json.DisposeOf;
//  end;
end;

procedure Tdm.DWEventsEventsListarTesteReplyEvent(var Params: TDWParams;
  var Result: string);
  var
    perfil : TPerfil;
    json : uDWJSONObject.TJSONValue;
    erro : string;
    qry  : TFDQuery;
begin
    try
      json := uDWJSONObject.TJSONValue.Create;
      perfil := TPerfil.create(dm.conn);

      qry := perfil.ListarTestes(erro);

      json.LoadFromDataset('',qry,false,jmPureJSon);
      result := json.ToJSON;
    finally
      if Assigned(qry) then
      qry.DisposeOf;

      perfil.DisposeOf;
      json.DisposeOf;
    end;
end;

procedure Tdm.DWSuporteEventsListaQTDStatusReplyEventByType(
  var Params: TDWParams; var Result: string; const RequestType: TRequestType;
  var StatusCode: Integer; RequestHeader: TStringList);
begin
       if  RequestType = TRequestType.rtGet then
        Result := ListaQTDStatus(StatusCode)
      else
      begin
        StatusCode := 403;
        Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
      end;
end;

procedure Tdm.DWSuporteEventsListarTopReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
      if  RequestType = TRequestType.rtGet then
        Result := ListaTop10(StatusCode)
      else
      begin
        StatusCode := 403;
        Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
      end;
end;

procedure Tdm.DWSuporteEventsListaVerAtendReplyEventByType(
  var Params: TDWParams; var Result: string; const RequestType: TRequestType;
  var StatusCode: Integer; RequestHeader: TStringList);
begin
      if RequestType = TRequestType.rtGet then
         Result := ListaVerAtend(StatusCode)
      else
        begin
          StatusCode := 403;
          Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
        end;
end;

procedure Tdm.DWSuporteEventsListaWaitCRReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
      if  RequestType = TRequestType.rtGet then
          Result := ListaWaitCR(StatusCode)
      else
        begin
          StatusCode := 403;
          Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
        end;
end;

procedure Tdm.DWTaskEventsBundleReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
      // GET.............
    if  RequestType = TRequestType.rtGet then
        Result := ListaBundle(StatusCode)
    else
      begin
        StatusCode := 403;
        Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
      end;
end;

procedure Tdm.DWTaskEventsChatReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
          // GET.............
    if  RequestType = TRequestType.rtGet then
        Result := ListarChat(params.itemsString['id_task_test'].asString,
                            params.itemsString['id_usuario'].asString,
                            StatusCode)
    else
    if RequestType = TRequestType.rtPost then
        Result := CriarChat(params.itemsString['id_usuario_de'].asString,
                            params.itemsString['id_usuario_para'].asString,
                            params.itemsString['texto'].asString,
                            params.itemsString['id_task_test'].asString,
                            StatusCode)
    else
      begin
         StatusCode := 403;
         Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
     end;
end;

procedure Tdm.DWTaskEventsListaTaskQTDReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
      if RequestType = TRequestType.rtGet then
        Result := ListaQTDTask(params.itemsString['bundle'].asString,
                               params.itemsString['busca'].asString,
                               StatusCode)
      else
      begin
          StatusCode := 403;
          Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
      end;
end;

procedure Tdm.DWTaskEventsListaTaskReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
        // GET.............
    if  RequestType = TRequestType.rtGet then
        Result := ListaTaskTest(params.itemsString['bundle'].asString,
                                params.itemsString['busca'].asString,
                                StatusCode)
    else
    begin
        StatusCode := 403;
        Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
    end;
end;

procedure Tdm.DWTaskEventsListaVeiculosTaskReplyEventByType(
  var Params: TDWParams; var Result: string; const RequestType: TRequestType;
  var StatusCode: Integer; RequestHeader: TStringList);
begin
      // GET.............
    if  RequestType = TRequestType.rtGet then
        Result := ListaVeiculosTask(params.itemsString['id_roadmap'].AsInteger,
                                    StatusCode)
    else
      begin
        StatusCode := 403;
        Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
      end;
end;

procedure Tdm.DWTaskEventsMakeReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
    // GET.............
    if  RequestType = TRequestType.rtGet then
        Result := ListaMarca(StatusCode)
    else
      begin
        StatusCode := 403;
        Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
      end;

end;

procedure Tdm.DWTaskEventsTaskReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
       // GET.............
    if  RequestType = TRequestType.rtGet then
        Result := ListaTask(params.itemsString['bundle'].asString,
                            params.itemsString['busca'].asString,
                            StatusCode)
    else
    begin
        StatusCode := 403;
        Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
    end;

end;

procedure Tdm.DWTaskEventsTasktoTestReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
begin
      // GET.............
    if  RequestType = TRequestType.rtGet then
        Result := ListarTaskSemTeste(params.itemsString['bundle'].asString,
                                     params.itemsString['busca'].asString,
                                     StatusCode)
    else
     begin
         StatusCode := 403;
         Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
     end;
end;

function TDm.EditarUsuario(id_usuario, campo, valor : string;
                          out status: integer): string;
var
    u : TUsuario;
    json : TJSONObject;
    erro: string;
    foto_bmp : TBitmap;
begin
    try
        json := TJSONObject.Create;
        u := TUsuario.Create(dm.conn);


        if id_usuario = '' then
        begin
            json.AddPair('retorno', 'Foto do usuário não enviada');
            json.AddPair('id_usuario', '0');
            json.AddPair('usuario', '');
            Status := 400;
            Result := json.ToString;
            exit;
        end;

        if (campo <> 'photo'){ and (campo <> 'nome') and (campo <> 'usuario') and
           (campo <> 'foto') and (campo <> 'departamento') and (campo <> 'nivel_acesso') and
           (campo <> 'logado_ate') and (campo <> 'senha')} then
        begin
            json.AddPair('retorno', 'Campo inválido');
            json.AddPair('id_usuario', '0');
            json.AddPair('usuario', '');
            Status := 400;
            Result := json.ToString;
            exit;
        end;

        // Criar foto bitmap...
        if campo = 'photo' then
        begin
            try
                foto_bmp := TFunctions.BitmapFromBase64(valor);
            except on ex:exception do
                begin
                    json.AddPair('retorno', 'Erro ao criar imagem no servidor: ' + ex.Message);
                    json.AddPair('id_usuario', '0');
                    json.AddPair('usuario', '');
                    Status := 400;
                    Result := json.ToString;
                    exit;
                end;
            end;
        end;

        u.Cod_Usuario := id_usuario.ToInteger;
        u.FOTO := foto_bmp;

        if NOT u.Editar(campo, valor, erro) then
        begin
            json.AddPair('retorno', erro);
            json.AddPair('id_usuario', '0');
            json.AddPair('usuario', '');
            Status := 400;
        end
        else
        begin
            json.AddPair('retorno', 'OK');
            json.AddPair('id_usuario', u.Cod_Usuario.ToString);
            json.AddPair('usuario', u.Usuario);
            Status := 200;
        end;

        Result := json.ToString;

    finally
        foto_bmp.DisposeOf;
        json.DisposeOf;
        u.DisposeOf;
    end;
end;


function Tdm.ValidarLogin(usuario, senha : string; out status: integer): string;
var
  u : TUsuario;
  json : TJsonObject;
  erro: string;
begin
      try
          u := TUsuario.Create(dm.conn);
          u.Senha := senha;
          u.Usuario := usuario;

          json := TJsonObject.Create;

          if not u.ValidaLogin(erro) then
          begin
               // {"Sucesso": "N", "erro":"USUARIO NAO INFORMADO", "codusuario":"0"}'
               json.AddPair('Sucesso', erro);
               json.AddPair('codusuario', '0');
               json.AddPair('usuario','');
               status:= 401;
          end
          else
          begin
               json.AddPair('Sucesso', erro);
               json.AddPair('codusuario', u.Cod_Usuario.ToString);
               json.AddPair('usuario',u.Usuario);
               json.AddPair('email',u.Email);
               json.AddPair('department',u.Departamento);
               json.AddPair('access_level',u.Nivel_acesso);
               json.AddPair('name',u.Nome_Usuario);
               json.AddPair('login_until',u.Logado_ate);
               json.AddPair('foto',u.FOTO64);
               Status := 200;
          end;

          Result := json.ToString;

      finally
        json.DisposeOf;
        u.DisposeOf;
      end;
end;

function Tdm.CriarUsuario(usuario, senha, email, foto64, departamento, nivel_acesso,nome,logoda_ate : string; out status: integer): string;
var
  u : TUsuario;
  json : TJsonObject;
  erro: string;
  foto_bmp : Tbitmap;
begin
      try
          u := TUsuario.Create(dm.conn);
          json := TJsonObject.Create;

        if foto64 = '' then
        begin
            json.AddPair('retorno', 'Foto do usuário não enviada');
            json.AddPair('codusuario', '0');
            json.AddPair('usuario', '');
            Status := 400;
            Result := json.ToString;
            exit;
        end;

        // Criar foto bitmap...
        try
            foto_bmp := TFunctions.BitmapFromBase64(foto64);
        except on ex:exception do
            begin
                json.AddPair('retorno', 'Erro ao criar imagem no servidor: ' + ex.Message);
                json.AddPair('codusuario', '0');
                json.AddPair('usuario', '');
                Status := 400;
                Result := json.ToString;
                exit;
            end;
        end;

          u.Cod_Usuario := 0;
          u.Senha := senha;
          u.Usuario := usuario;
          u.Email := email;
          u.Foto := nil;
          u.Departamento := departamento;
          u.Nivel_acesso := nivel_acesso;
          u.Nome_Usuario := nome;
          u.Logado_ate:= logoda_ate;

          if NOT u.ListarUsuarios(erro)  then
          begin
               // {"Sucesso": "N", "erro":"USUARIO NAO INFORMADO", "codusuario":"0"}'
               json.AddPair('Sucesso', 'Email already in use!');
               json.AddPair('codusuario', '0');
               json.AddPair('usuario','');
               status:= 400;
               result := json.ToString;
               exit;
          end;
           if not u.CriarConta(erro) then
          begin
               // {"Sucesso": "N", "erro":"USUARIO NAO INFORMADO", "codusuario":"0"}'
               json.AddPair('Sucesso', erro);
               json.AddPair('codusuario', '0');
               json.AddPair('usuario','');
               status:= 400;
               result := json.ToString;
               exit;
          end
          else
          begin
               json.AddPair('Sucesso', 'OK');
               json.AddPair('codusuario', u.Cod_Usuario.ToString);
               json.AddPair('usuario',u.Usuario);
               Status := 201;
          end;

          foto_bmp.DisposeOf;
          Result := json.ToString;

      finally
        json.DisposeOf;
        u.DisposeOf;
      end;
end;
function Tdm.EditarEmprestimo(Empre_id,Empre_equip_id,Empre_Leasing, Empre_user_id,id_equip, Empre_DT_Leasing : string; out status: integer): string;
var
  e : TEmprestimo;
  json : TJsonObject;
  erro: string;
begin
      try
          e := TEmprestimo.Create(dm.conn);
          json := TJsonObject.Create;
          if (Empre_id = '') or(Empre_equip_id = '')  or (Empre_user_id = '') or (id_equip = '') or (Empre_DT_Leasing = '')then
          begin
            json.AddPair('retorno', 'Informe todos os parametros');
            json.AddPair('Empre_id', '0');
            status:= 400;
            result := json.ToString;
            exit;
          end;

          try
            StrToInt(Empre_user_id);
          except
            json.AddPair('retorno', 'ID. usuario nao encontrado');
            json.AddPair('EMPRE_USER_ID', '0');
            status:= 400;
            result := json.ToString;
            exit;
          end;

          try
            StrToInt(Empre_equip_id);
          except
            json.AddPair('retorno', 'ID. Equipment Leasing not found');
            json.AddPair('EMPRE_EQUIP_ID', '0');
            status:= 400;
            result := json.ToString;
            exit;
          end;
          try
            StrToInt(id_equip);
          except
            json.AddPair('retorno', 'ID. Equipment not found');
            json.AddPair('EQUIP_ID', '0');
            status:= 400;
            result := json.ToString;
            exit;
          end;

          e.EMPRE_ID := empre_id.Tointeger;
          e.Empre_Equip_Id := Empre_equip_id.ToInteger;
          e.EMPRE_LOCATARIO := Empre_user_id;
          e.Equip_Id := id_equip.ToInteger;
          e.EMPRE_DT_LOCACAO := TFunctions.StrToData(Empre_DT_Leasing, 'dd/mm/yyyy hh:nn');

          if NOT e.Alterar (ERRO) then
          begin
            json.AddPair('retorno', erro);
            json.AddPair('ID_Chat', '0');
            status:= 400;
          end
          else
          begin
            json.AddPair('retorno', 'The equipment was Changed');
            json.AddPair('ID_emprestimo', e.EMPRE_ID.ToString);
            status:= 201;
          end;

          Result := json.ToString;

      finally
        json.DisposeOf;
        e.DisposeOf;
      end;
end;

function Tdm.CriarChat(id_usuario_de, id_usuario_para, texto, id_task_test : string; out status: integer): string;
var
  c : TChat;
  json : TJsonObject;
  erro: string;
begin
      try
          c := TChat.Create(dm.conn);

          json := TJsonObject.Create;

          if (texto = '') then
          begin

               json.AddPair('Sucesso', 'Informe o texto!');
               json.AddPair('ID_Chat', '0');
               status:= 400;
               result := json.ToString;
               exit;
          end;
          try
            StrToInt(id_usuario_de);
          except
            json.AddPair('retorno', 'ID. usuario de origem invalido');
            json.AddPair('ID_Chat', '0');
            status:= 400;
            result := json.ToString;
            exit;
          end;

          try
            StrToInt(id_usuario_para);
          except
            json.AddPair('retorno', 'ID. usuario de destino invalido');
            json.AddPair('ID_Chat', '0');
            status:= 400;
            result := json.ToString;
            exit;
          end;

          try
            StrToInt(id_task_test);
          except
            json.AddPair('retorno', 'ID. Task inválido');
            json.AddPair('ID_Chat', '0');
            status:= 400;
            result := json.ToString;
            exit;
          end;

          c.USER_ID_TO := id_usuario_para.ToInteger;
          c.USER_ID_FROM := id_usuario_de.ToInteger;
          c.TEXT := unescape_chars(texto);
          c.ID_TASK_TEST := id_task_test.ToInteger;

          if NOT C.Inserir (ERRO) then
          begin
            json.AddPair('retorno', erro);
            json.AddPair('ID_Chat', '0');
            status:= 400;
          end
          else
          begin
            json.AddPair('retorno', 'ok');
            json.AddPair('ID_Chat', c.ID_CHAT.ToString);
            status:= 201;
          end;

          Result := json.ToString;

      finally
        json.DisposeOf;
        c.DisposeOf;
      end;
end;

procedure Tdm.DWUsuarioEventsDadosUsuarioReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);

begin
       // GET.............
    if RequestType = TRequestType.rtGet then
        Result := listaUsuario(statusCode)

    else
      begin
        StatusCode := 403;
        Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
      end;

end;

procedure Tdm.DWUsuarioEventsusuarioReplyEventByType(var Params: TDWParams;
  var Result: string; const RequestType: TRequestType; var StatusCode: Integer;
  RequestHeader: TStringList);
var
  uri_param : string;
begin
    try
      uri_param := Params.ItemsString['0'].ASstring;

    except
      uri_param := '';

    end;

       // GET.............
    if (RequestType = TRequestType.rtGet) and (uri_param = '') then
        Result := validarLogin(params.itemsString['usuario'].asString,
                               params.itemsString['senha'].asString,
                               StatusCode)
    else
    if (RequestType = TRequestType.rtGet) and (uri_param = '') then
        Result := listaUsuario(statusCode)

    else
      // POST..........
    if RequestType = TRequestType.rtPost then
        Result := CriarUsuario(params.itemsString['usuario'].asString,
                                params.itemsString['senha'].asString,
                                params.itemsString['email'].asString,
                                Params.ItemsString['foto'].AsString,
                                Params.ItemsString['departamento'].AsString,
                                Params.ItemsString['nivel_acesso'].AsString,
                                Params.ItemsString['nome'].AsString,
                                Params.ItemsString['logado_ate'].AsString,
                                StatusCode)
    else
    // PATCH.......
    if RequestType = TRequestType.rtPatch then
        Result := EditarUsuario(Params.ItemsString['id_usuario'].AsString,
                                Params.ItemsString['campo'].AsString,
                                Params.ItemsString['valor'].AsString,
                                StatusCode)
    else
      begin
        StatusCode := 403;
        Result := '{"Retorno":"Verbo HTPP não é valido. Utilize o GET, "cod_usuario: 0, "user": ""}';
      end;
end;


procedure Tdm.ServerMethodDataModuleCreate(Sender: TObject);
var
retorno : string;

begin
  retorno := LoadConfig;
  if retorno <> 'OK' then
  Showmessage(retorno);

end;

end.

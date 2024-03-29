unit untDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, System.IOUtils, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Authenticator.Basic, REST.Response.Adapter,
  System.JSON, FireDAC.Phys.SQLiteWrapper.Stat;

  {FireDAC.Phys.SQLiteWrapper.Stat,}

type
  Tdm = class(TDataModule)
    Conn: TFDConnection;
    qry_Geral: TFDQuery;
    qry_Emprestimo: TFDQuery;
    RESTClient: TRESTClient;
    Request_Usuario: TRESTRequest;
    HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
    Request_Perfil: TRESTRequest;
    Request_Inventario: TRESTRequest;
    RequestLogin: TRESTRequest;
    RequestConta: TRESTRequest;
    RequestCategory: TRESTRequest;
    RequestChat: TRESTRequest;
    RequestChatEnvia: TRESTRequest;
    Request_TaskDone: TRESTRequest;
    Request_Bundle: TRESTRequest;
    Request_Make: TRESTRequest;
    request_TasktoTest: TRESTRequest;
    requestTaskQTD: TRESTRequest;
    requestCCListaStatus: TRESTRequest;
    RequestListaVerAtendida: TRESTRequest;
    RequestVehicleTask: TRESTRequest;
    Request_VeiculoTestado: TRESTRequest;
    procedure DataModuleCreate(Sender: TObject);
  private


    { Private declarations }
  public
   function ListarInventario(id_usuario, Equip_Cat_Id,busca : string; out jsonArray: TJSONArray; out erro: string): boolean;
   function ListarCategoria (out jsonArray: TJsonArray; out erro: string) : boolean;
   function ListarTaskDone(make,busca: string;
      out jsonArray: TJSONArray; out erro: string): boolean;
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses uLoading, unitTestQuality;

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
//     with Conn do
  //   begin
    //  {$IFDEF MSWINDOWS}
      //  try
//          params.Values['Database']:= system.SysUtils.GetCurrentDir + '\DB\MFCDBLocal.db';
//          Connected := true;
//        except on E:Exception do
//                 raise Exception.Create('Erro de conex�o com o banco de dados'+ E.Message);
//        end;
//         {$ELSE}
//
//         Params.Values['DriverID'] := 'SQLite';
//         try
//            params.Values ['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'MFCDBLocal.db');
 //           Connected := True;
 //        except on E:Exception do
 //                 raise Exception.Create('Erro de conex�o com o banco de dados'+ E.Message);
 //       end;
   //     {$ENDIF}
  //   end;
end;

function Tdm.ListarInventario(id_usuario,Equip_Cat_Id, busca: string; out jsonArray: TJSONArray; out erro: string): boolean;
var
    json : string;
begin
    erro := '';

    try
        with Request_Inventario do
        begin
            Params.Clear;
            Method := rmGET;
            DM.Request_Inventario.Resource := 'emprestimos/emprestimo';
            AddParameter('id','', TRESTRequestParameterKind.pkGETorPOST);
            AddParameter('id_usuario', id_usuario, TRESTRequestParameterKind.pkGETorPOST);
            AddParameter('Cat_Id', Equip_Cat_Id, TRESTRequestParameterKind.pkGETorPOST);
            AddParameter('busca',busca, TRESTRequestParameterKind.pkGETorPOST);
            Execute;
        end;
    except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao listar equipamentos : ' + ex.Message;
            exit;
        end;
    end;

    if Request_Inventario.Response.StatusCode <> 200 then
    begin
        Result := false;
        erro := 'Erro ao listar Equipamentos do Invent�rio: ' + Request_Inventario.Response.StatusCode.ToString;
    end
    else
    begin
        json := Request_Inventario.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONArray;
        Result := true;
    end;
end;

function Tdm.ListarCategoria(out jsonArray: TJsonArray; out erro: string) : boolean;
var
    json : string;
begin
    erro := '';
    RequestCategory.Params.Clear;
    RequestCategory.Method := rmGET;
    RequestCategory.Resource := 'Categorias/listar';

    RequestCategory.Execute;

    if RequestCategory.Response.StatusCode <> 200 then
    begin
        Result := false;
        erro := 'Erro ao listar categorias: ' + RequestCategory.Response.StatusCode.ToString;
    end
    else
    begin
        json := RequestCategory.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONArray;
        Result := true;
    end;
end;

function Tdm.ListarTaskDone(make, busca: string;  out jsonArray: TJSONArray; out erro: string): boolean;
var
    json : string;
begin
    erro := '';

    try
        with Request_TaskDone do
        begin
            Params.Clear;
            AddParameter('id', '', TRESTRequestParameterKind.pkGETorPOST);
            AddParameter('make', make, TRESTRequestParameterKind.pkGETorPOST);
            AddParameter('busca', busca, TRESTRequestParameterKind.pkGETorPOST);
            Execute;
        end;
    except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao listar tasks : ' + ex.Message;
            exit;
        end;
    end;
    if Request_TaskDone.Response.StatusCode <> 200 then
    begin
        Result := false;
        erro := 'Erro ao listar tasks: ' + Request_TaskDone.Response.StatusCode.ToString;
    end
    else
    begin
        json := Request_TaskDone.Response.JSONValue.ToString;
        jsonArray := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(json), 0) as TJSONArray;
        Result := true;
    end;
end;

end.

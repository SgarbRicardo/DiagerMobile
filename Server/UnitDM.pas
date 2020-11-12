unit UnitDM;

interface

uses
  System.SysUtils, System.Classes, uDWDataModule, uDWAbout, uRESTDWServerEvents,
  uDWJSONObject, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, CUsuario, System.JSON,
  FireDAC.VCLUI.Wait, FMX.Graphics, soap.EncdDecd, uDWConsts,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  Tdm = class(TServerMethodDataModule)
    DWEvents: TDWServerEvents;
    conn: TFDConnection;
    qryGeral: TFDQuery;
    procedure DWEventsEventshoraReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWEventsEventsvalidaLoginReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure ServerMethodDataModuleCreate(Sender: TObject);
    procedure DWEventsEventscriarContaReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWEventsEventsListarInventarioReplyEvent(var Params: TDWParams;
      var Result: string);
    procedure DWEventsEventsListarUsuarioReplyEvent(var Params: TDWParams;
      var Result: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

uses system.inifiles, FMX.dialogs;


{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}


function LoadConfig() : string;

var
  arq_ini, base, usuario, senha, driver : string;
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

      dm.conn.Params.Values ['DriverID'] := driver;
      dm.conn.Params.Values ['Database'] := base;
      dm.conn.Params.Values ['User_Name'] := usuario;
      dm.conn.Params.Values ['Password'] := senha;

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

procedure Tdm.DWEventsEventscriarContaReplyEvent(var Params: TDWParams;
  var Result: string);

  var
  email, user, senha, erro, foto64 : string;
  usuario : TUsuario;
  json : TJsonObject;
  foto_bmp: TBitmap;
begin
    try
       Sleep(1000);
       email := Params.ItemsString['email'].AsString;
       user := Params.ItemsString['user'].AsString;
       senha := Params.ItemsString['senha'].AsString;
       foto64 := Params.ItemsString['foto'].AsString;

       json := TJsonObject.Create;


       //validações

       if (email = '' ) or (user = '' ) or (senha = '') or (foto64 = '')then
       begin
         json.AddPair('Sucesso', 'N');
         json.AddPair('Erro', 'Informe todos os parametros');
         json.AddPair('codusuario', '0');
         Result := json.ToString;

         exit;
       end;

       // Criar foto bitmap
       try
        foto_bmp := BitmapFromBase64(foto64);

         except on ex:exception do
         begin
            json.AddPair('Sucesso', 'N');
            json.AddPair('Erro', 'Erro ao criar imagem no servidor' + ex.Message);
            json.AddPair('codusuario', '0');
            Result := json.ToString;

            exit;
         end;
         end;

        try
            usuario := TUsuario.Create(dm.conn);
            usuario.Email := email;
            usuario.Usuario := user;
            usuario.Senha := senha;
            usuario.Foto := foto_bmp;

          if not usuario.CriarConta(erro) then
            begin
                 json.AddPair('Sucesso', 'N');
                 json.AddPair('Erro', erro);
                 json.AddPair('codusuario', '0');
            end
            else
            begin
                 json.AddPair('Sucesso', 'S');
                 json.AddPair('Erro', erro);
                 json.AddPair('Usuario', usuario.Cod_Usuario.ToString);
            end;
        Finally
            foto_bmp.DisposeOf;
            usuario.DisposeOf;
        end;
        Result := json.ToString;
  finally
      json.DisposeOf;
  end;
end;

procedure Tdm.DWEventsEventshoraReplyEvent(var Params: TDWParams;
  var Result: string);
begin
    result:= '{"hora": "' + FormatDateTime ('hh:nn:ss', now) + '"}';
end;

procedure Tdm.DWEventsEventsListarInventarioReplyEvent(var Params: TDWParams;
  var Result: string);
 var
    qry : TFDQuery;
    json : uDWJSONObject.TJSONValue;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := dm.conn;

        json := uDWJSONObject.TJSONValue.Create;

        qry.Active := false;
        qry.SQL.Clear;
        qry.SQL.Add('SELECT');
        qry.SQL.Add('FROM ');
        qry.SQL.Add('JOIN ');
     // qry.ParamByName('').Value := Params.ItemsString[''].AsInteger;
        qry.Active := true;

        json.LoadFromDataset('', qry, false, jmPureJSON);

        Result := json.ToJSON;

    finally
        json.DisposeOf;
        qry.DisposeOf;
    end;
end;

procedure Tdm.DWEventsEventsListarUsuarioReplyEvent(var Params: TDWParams;
  var Result: string);
var
    json : uDWJSONObject.TJSONValue;         //uDWJSONObject recurso do RestDW
begin
    dm.QryGeral.Active := false;
    dm.QryGeral.SQL.Clear;
    dm.QryGeral.SQL.Add('SELECT LG_EMAIL, LG_USUARIO FROM TAB_LOGIN');
    dm.QryGeral.SQL.Add('WHERE 1 = 1');
    dm.QryGeral.Active := true;

    try
        json := uDWJSONObject.TJSONValue.Create;
        json.LoadFromDataset('', dm.QryGeral, false, jmPureJSON);

        Result := json.ToJSON;
    finally
        json.DisposeOf;
    end;
end;

procedure Tdm.DWEventsEventsvalidaLoginReplyEvent(var Params: TDWParams;
  var Result: string);
  var
  email, senha, erro, user : string;
  usuario : TUsuario;
  json : TJsonObject;

begin
    try
      Sleep(1000);
      senha := Params.ItemsString['senha'].AsString;
      user  := Params.ItemsString['user'].AsString;

      json := TJsonObject.Create;

      usuario := TUsuario.Create(dm.conn);
      usuario.Senha := senha;
      usuario.Usuario := user;


      if not usuario.ValidaLogin(erro) then
      begin
           // {"Sucesso": "N", "erro":"USUARIO NAO INFORMADO", "codusuario":"0"}'
           json.AddPair('Sucesso', 'N');
           json.AddPair('Erro', erro);
           json.AddPair('codusuario', '0');
           json.AddPair('user','');
      end
      else
      begin
           json.AddPair('Sucesso', 'S');
           json.AddPair('Erro', erro);
           json.AddPair('codusuario', usuario.Cod_Usuario.ToString);
           json.AddPair('user',usuario.Usuario);
      end;

      Result := json.ToString;

    finally
      json.DisposeOf;
      usuario.DisposeOf;
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

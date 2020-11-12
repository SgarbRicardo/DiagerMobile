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
  REST.Authenticator.Basic, REST.Response.Adapter;

type
  Tdm = class(TDataModule)
    Conn: TFDConnection;
    qry_Geral: TFDQuery;
    qry_Emprestimo: TFDQuery;
    RESTClient: TRESTClient;
    Request_Usuario: TRESTRequest;
    HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
     with Conn do
     begin
      {$IFDEF MSWINDOWS}
        try
          params.Values['Database']:= system.SysUtils.GetCurrentDir + '\DB\MFCDBLocal.db';
          Connected := true;
        except on E:Exception do
                  raise Exception.Create('Erro de conexão com o banco de dados'+ E.Message);
        end;
         {$ELSE}

         Params.Values['DriverID'] := 'SQLite';
         try
            params.Values ['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'MFCDBLocal.db');
            Connected := True;
         except on E:Exception do
                  raise Exception.Create('Erro de conexão com o banco de dados'+ E.Message);
        end;
        {$ENDIF}
     end;
end;

end.

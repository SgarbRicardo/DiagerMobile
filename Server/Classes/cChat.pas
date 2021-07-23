unit cChat;

interface

uses FireDAC.Comp.Client, Data.DB, FMX.Graphics, Firedac.DApt;

type
    TChat = class
    private
        FConn : TFDConnection;
        FUSER_ID_TO: integer;
        FUSER_ID_FROM: integer;
        FID_TASK_TEST: INTEGER;
        FDT_GENERATION: TDateTime;
        FID_CHAT: integer;
        FTEXT: string;

    public
        constructor Create(conn : TFDConnection);
        property ID_CHAT : integer read FID_CHAT write FID_CHAT;
        property USER_ID_FROM : integer read FUSER_ID_FROM write FUSER_ID_FROM;
        property USER_ID_TO : integer read FUSER_ID_TO write FUSER_ID_TO;
        property ID_TASK_TEST : integer read FID_TASK_TEST write FID_TASK_TEST;
        property DT_GENERATION : TDateTime read FDT_GENERATION write FDT_GENERATION;
        property TEXT : string read FTEXT write FTEXT;

        function Inserir(out erro: string): Boolean;
        function Excluir(out erro: string): Boolean;
        function ListarChat(order_by: string; out erro: string): TFDQuery;
end;

implementation

uses
  System.SysUtils;


constructor TChat.Create(conn: TFDConnection);
begin
    FConn := conn;
end;

function TChat.ListarChat(order_by: string; out erro: string): TFDQuery;
var
    qry : TFDQuery;
begin
   { if (ID_CHAT <= 0) then
    begin
      Result:= nil;
      erro:= 'Chat nao encontrado';
      exit;
    end;  }

    try
        qry := TFDQuery.Create(nil);
        qry.Connection := FConn;

        with qry do
        begin
            Active := false;
            sql.Clear;
            SQL.Add('SELECT * FROM [MF_Control].[mf_control_db].[TAB_CHAT]');
            //SQL.Add('WHERE USER_ID = :USER_ID and ID_USER_FROM = :USER_ID_FROM or USER_ID = :USER_ID_FROM and ID_USER_FROM =:USER_ID');
            SQL.Add('WHERE ID_TASK_TEST = :id_task_test');

            if order_by = '' then
                SQL.Add('ORDER BY ID_CHAT')
            else
                SQL.Add('ORDER BY ' + order_by);

            ParamByName('id_task_test').Value := ID_TASK_TEST;

            Active := true;
        end;

        erro := '';
        result := qry;

    except on ex:exception do
        begin
            erro := 'Erro ao listar mensagens: ' + ex.Message;
            Result := nil;
        end;
    end;
end;

function TChat.Inserir(out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    if (USER_ID_FROM <= 0)  then
    begin
        Result := false;
        erro := 'Usu�rio origem n�o informado';
        exit;
    end;

    if (USER_ID_TO <= 0)  then
    begin
        Result := false;
        erro := 'Usu�rio destino n�o informado';
        exit;
    end;

    if (ID_TASK_TEST <= 0)  then
    begin
        Result := false;
        erro := 'Erro com o usuario loogado';
        exit;
    end;

    if (TEXT = '')  then
    begin
        Result := false;
        erro := 'Texto n�o informado';
        exit;
    end;

    try
        qry := TFDQuery.Create(nil);
        qry.Connection := FConn;

        with qry do
        begin
            Active := false;
            sql.Clear;
            SQL.Add('INSERT INTO [MF_Control].[mf_control_db].[TAB_CHAT](ID_USER_FROM, ID_USER_TO, ID_TASK_TEST,');
            SQL.Add('DT_GENERATION, TEXT)');
            SQL.Add('VALUES(:USER_ID_FROM, :USER_ID_TO,:ID_TASK_TEST, current_timestamp, :TEXT)');

            ParamByName('ID_USER_FROM').Value := USER_ID_FROM;
            ParamByName('ID_USER_TO').Value := USER_ID_TO;
            ParamByName('ID_TASK_TEST').Value := ID_TASK_TEST;
            ParamByName('TEXT').Value := TEXT;
            ExecSQL;


            // Busca o ID gerado...
            Active := false;
            sql.Clear;
            SQL.Add('SELECT MAX(ID_CHAT) AS ID_CHAT FROM [MF_Control].[mf_control_db].[TAB_CHAT]');
            SQL.Add('WHERE ID_TASK_TEST= :ID_TASK_TEST');
            paramByName('ID_TASK_TEST').Value := ID_TASK_TEST;
            Active := true;

            ID_CHAT := FieldByName('ID_CHAT').AsInteger;

            DisposeOf;
        end;

        Result := true;
        erro := '';

    except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao inserir mensagem: ' + ex.Message;
        end;
    end;
end;

function TChat.Excluir(out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    if (ID_CHAT <= 0)  then
    begin
        Result := false;
        erro := 'Id da mensagem n�o informado';
        exit;
    end;

    try
        qry := TFDQuery.Create(nil);
        qry.Connection := FConn;

        with qry do
        begin
            Active := false;
            sql.Clear;
            SQL.Add('DELETE FROM [MF_Control].[mf_control_db].[TAB_CHAT] WHERE ID_CHAT=:ID_CHAT');
            ParamByName('ID_CHAT').Value := ID_CHAT;
            ExecSQL;

            DisposeOf;
        end;

        Result := true;
        erro := '';

    except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao excluir mensagem: ' + ex.Message;
        end;
    end;
end;

end.

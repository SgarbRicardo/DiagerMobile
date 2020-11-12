unit cUsuario;

interface

uses FireDAC.Comp.Client, FireDAC.DApt, System.SysUtils, FMX.Graphics;

type
    TUsuario = class
     private
        Fconn: TFDConnection;
        FUSU_IND_LOGIN: string;
        FUSU_EMAIL: string;
        FUSU_SENHA: string;
        FUSU_DEPARTAMENTO: string;
        FUSU_ACCESS_LEVEL: STRING;
        FUSU_DT_LOGIN: TDateTime;
        FUSU_UND_SINCRONIZAR: STRING;
        FUSU_NOME: string;
        FCOD_USUARIO: Integer;
        FUSU_FOTO: TBitmap;
    public
        constructor Create(conn: TFDConnection);
        property COD_USUARIO: Integer read FCOD_USUARIO write FCOD_USUARIO;
        property USU_NOME: string read FUSU_NOME write FUSU_NOME;
        property USU_EMAIL: string read FUSU_EMAIL write FUSU_EMAIL;
        property USU_SENHA: string read FUSU_SENHA write FUSU_SENHA;
        property USU_DEPARTAMENTO: string read FUSU_DEPARTAMENTO write FUSU_DEPARTAMENTO;
        property USU_ACCESS_LEVEL: string read FUSU_ACCESS_LEVEL write FUSU_ACCESS_LEVEL;
        property USU_DT_LOGIN: TdateTime read FUSU_DT_LOGIN write FUSU_DT_LOGIN;
        property USU_UND_SINCRONIZAR: string read FUSU_UND_SINCRONIZAR write FUSU_UND_SINCRONIZAR;
        property USU_IND_LOGIN: string read FUSU_IND_LOGIN write FUSU_IND_LOGIN;
        property USU_FOTO: TBitmap read FUSU_FOTO write FUSU_FOTO;

        function ListarUsuario(out erro: string): TFDQuery;
        function Inserir(out erro: string): Boolean;
        function Alterar(out erro: string): Boolean;
        function Excluir(out erro: string): Boolean;
        function ValidarLogin(out erro: string): Boolean;
        function Logout(out erro: string): boolean;
end;

implementation

{ TUsuario }

uses untDM;

function TUsuario.Alterar(out erro: string): Boolean;
begin

end;

constructor TUsuario.Create(conn: TFDConnection);
begin
    Fconn := Conn;
end;

function TUsuario.Excluir(out erro: string): Boolean;
begin

end;

function TUsuario.Inserir(out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    try
        if Cod_Usuario <= 0 then
        begin
            erro := 'Código não informado';
            Result := false;
            exit;
        end;

        if USU_NOME = '' then
        begin
            erro := 'Nome não informado';
            Result := false;
            exit;
        end;

        if USU_EMAIL = '' then
        begin
            erro := 'Email não informado';
            Result := false;
            exit;
        end;

        if USU_SENHA = '' then
        begin
            erro := 'Senha não informada';
            Result := false;
            exit;
        end;

        qry := TFDQuery.Create(nil);
        qry.Connection := FConn;
        with qry do
        begin
            // Consistir se o email ja está em uso...
            SQL.Clear;
            SQL.Add('SELECT COD_USUARIO FROM TAB_USUARIO');
            SQL.Add('WHERE USU_EMAIL=:USU_EMAIL');
            SQL.Add('AND COD_USUARIO <> :COD_USUARIO');
            ParamByName('USU_EMAIL').Value := USU_EMAIL;
            ParamByName('COD_USUARIO').Value := Cod_Usuario;
            Active := true;

            if RecordCount > 0 then
            begin
                erro := 'O email informado já está sendo usado em outra conta';
                Result := false;
                exit;
            end;


            Active := false;
            SQL.Clear;
            SQL.Add('UPDATE TAB_USUARIO SET USU_EMAIL=:USU_EMAIL, USU_NOME=:USU_NOME, USU_SENHA=:USU_SENHA');
            SQL.Add('WHERE COD_USUARIO=:COD_USUARIO');
            ParamByName('USU_EMAIL').Value := USU_EMAIL;
            ParamByName('USU_NOME').Value := USU_NOME;
            ParamByName('USU_SENHA').Value := USU_SENHA;
            ParamByName('COD_USUARIO').Value := Cod_Usuario;
            ExecSQL;

            DisposeOf;
        end;

        Result := true;
        erro := '';

    except on ex:exception do
    begin
        Result := false;
        erro := 'Erro ao salvar USUARIO : ' + ex.Message;
    end;
    end;

end;

function TUsuario.ValidarLogin(out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    // Validacoes...
    if USU_EMAIL = '' then
    begin
        erro := 'Informe o email do usuário';
        Result := false;
        exit;
    end;

    if USU_SENHA = '' then
    begin
        erro := 'Informe a senha do usuário';
        Result := false;
        exit;
    end;

    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Fconn;

        try
            with qry do
            begin
                Active := false;
                sql.Clear;
                sql.Add('SELECT * FROM TAB_USUARIO');
                SQL.Add('WHERE USU_EMAIL = :USU_EMAIL');
                SQL.Add('AND USU_SENHA = :USU_SENHA');
                ParamByName('USU_EMAIL').Value := USU_EMAIL;
                ParamByName('USU_SENHA').Value := USU_SENHA;
                Active := true;


                if RecordCount = 0 then
                begin
                    Result := false;
                    erro := 'Email ou senha inválida';
                    exit;
                end;

                Active := false;
                sql.Clear;
                sql.Add('UPDATE TAB_USUARIO');
                SQL.Add('SET USU_IND_LOGIN = ''S''');
                ExecSQL;
            end;

            Result := true;
            erro := '';

        except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao validar login: ' + ex.Message;
        end;
        end;
    finally
        qry.DisposeOf;
    end;
end;

function TUsuario.Logout(out erro: string): boolean;
var
    qry : TFDQuery;
begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Fconn;

        try
            with qry do
            begin
                Active := false;
                sql.Clear;
                sql.Add('UPDATE TAB_USUARIO');
                SQL.Add('SET USU_IND_LOGIN = ''N''');
                ExecSQL;
            end;

            Result := true;
            erro := '';

        except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao fazer logout: ' + ex.Message;
        end;
        end;
    finally
        qry.DisposeOf;
    end;
end;

function TUsuario.ListarUsuario(out erro: string): TFDQuery;
var
    qry : TFDQuery;

begin
    try
        qry := TFDQuery.Create(nil);
        qry.Connection := Fconn;

        with qry do
        begin
            Active := false;
            sql.Clear;
            sql.Add('SELECT * FROM TAB_USUARIO');
            SQL.Add('WHERE 1 = 1');

            if COD_USUARIO > 0 then
            begin
                SQL.Add('AND COD_USUARIO = :COD_USUARIO');
                ParamByName('COD_USUARIO').Value := COD_USUARIO;
            end;

            if USU_EMAIL <> '' then
            begin
                SQL.Add('AND USU_EMAIL = :USU_EMAIL');
                ParamByName('USU_EMAIL').Value := USU_EMAIL;
            end;

            if USU_SENHA <> '' then
            begin
                SQL.Add('AND USU_SENHA = :USU_SENHA');
                ParamByName('USU_SENHA').Value := USU_SENHA;
            end;

            Active := true;
        end;

        Result := qry;
        erro := '';

    except on ex:exception do
    begin
        Result := nil;
        erro := 'Erro ao consultar usuários: ' + ex.Message;
    end;
    end;
end;


end.

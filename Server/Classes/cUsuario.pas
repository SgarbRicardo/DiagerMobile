unit cUsuario;

interface

uses Firedac.Comp.Client, System.SysUtils, Firedac.DApt, FMX.Graphics;

type
    TUsuario = class
      private
           FConn : TFDConnection;
           FCod_Usuario: Integer;
           FSenha: string;
           FEmail: string;
           FUsuario: string;
           FNome_Usuario: string;
           FFoto: TBitmap;
           FDepartamento: String;
           FCelular: String;
           FCargo: String;
           FToken_id: String;
           FPlataforma: String;
           FInd_Login: String;
           FInd_Ajuda: String;
    function ListarUsuarios(out erro: string): Boolean;


      public
          constructor Create (conn: TFDConnection);
          property Cod_Usuario : Integer read FCod_Usuario Write FCod_Usuario;
          property Senha : String read FSenha Write FSenha;
          property Email : String read FEmail Write FEmail;
          property Usuario : String read FUsuario Write FUsuario;
          property Nome_Usuario : String read FNome_Usuario Write FNome_Usuario;
          property Departamento : String read FDepartamento Write FDepartamento;
          property Celular : String read FCelular Write FCelular;
          property Cargo : String read FCargo Write FCargo;
          property Token_id : String read FToken_id Write FToken_id;
          property Plataforma : String read FPlataforma Write FPlataforma;
          property Ind_Login : String read FInd_Login Write FInd_Login;
          property Ind_Ajuda : String read FInd_Ajuda Write FInd_Ajuda;
          property Foto : TBitmap read FFoto Write FFoto;
          Function ValidaLogin (out erro :  string) :Boolean;
          function CriarConta(out erro: string): Boolean;
    end;

implementation

{ TUsuario }

constructor TUsuario.Create(conn: TFDConnection);
begin
     FConn := conn;
end;

function TUsuario.ValidaLogin(out erro: string): Boolean;
var
    qry: TFDQuery;
begin

    try
      qry := TFDQuery.Create(nil);
      qry.Connection := FConn;

      with  qry do
      begin
          Active := false;
          sql.Clear;
          SQL.Add('SELECT * FROM TAB_LOGIN');
          SQL.Add('WHERE LG_USUARIO=:LG_USUARIO AND LG_SENHA=:LG_SENHA');
          ParamByName('LG_USUARIO').Value := Usuario;
          ParamByName('LG_SENHA').Value := Senha;


          Active := true;

          if RecordCount > 0 then
          begin
            Cod_Usuario := FieldByName('LG_ID').AsInteger;
            erro   := '';
            Result := true;
          end
          else
          begin
            Cod_Usuario := 0;
            erro := 'Email ou Senha inv�lido';
            Result := false;
          end;

          DisposeOf;
      end;

    except on ex:exception do
    begin
        erro:= 'Erro ao validar login: ' + ex.Message;
        Result:= False;
    end;
    end;

end;

function TUsuario.ListarUsuarios(out erro: string): Boolean;
var
    qry: TFDQuery;
begin

    try
      qry := TFDQuery.Create(nil);
      qry.Connection := FConn;

      with  qry do
      begin
          Active := false;
          sql.Clear;
          SQL.Add('SELECT * FROM TAB_LOGIN');
          SQL.Add('WHERE LG_ID = Cod_Usuario');

          Active := true;

          if RecordCount > 0 then
          begin
            Cod_Usuario := FieldByName('LG_ID').AsInteger;
            Email := FieldByName('EMAIL').AsString;
            Usuario := FieldByName('USUARIO').AsString;
            erro   := '';
            Result := true;
          end;

          DisposeOf;
      end;

    except on ex:exception do
    begin
        erro:= 'Erro ao listar usuarios: ' + ex.Message;
        Result:= False;
    end;
    end;

end;

function TUsuario.CriarConta(out erro: string): Boolean;
var
    qry: TFDQuery;
begin

    try
      qry := TFDQuery.Create(nil);
      qry.Connection := FConn;

      with  qry do
      begin
          Active := false;
          SQL.Clear;
          SQL.Add('INSERT INTO TAB_USUARIO(LG_EMAIL, LG_USUARIO, LG_SENHA, FOTO) VALUES (:EMAIL, :LG_USUARIO, :SENHA, :FOTO)');
          ParamByName('LG_EMAIL').Value := Email;
          ParamByName('LG_USUARIO').Value := Usuario;
          ParamByName('LG_SENHA').Value := Senha;
          ParamByName('FOTO').assign(Foto);
          execSQL;

          Active := false;
          sql.Clear;
          SQL.Add('SELECT MAX (COD_USUARIO) AS COD_USUARIO FROM TAB_USUARIO');
          SQL.Add('WHERE EMAIL=:EMAIL');
          ParamByName('EMAIL').Value := Email;
          Active := true;

          Cod_Usuario := FieldByName('LG_ID').AsInteger;
          erro   := '';
          Result := true;

          DisposeOf;
      end;

    except on ex:exception do
    begin
        erro:= 'Erro ao CRIAR Conta: ' + ex.Message;
        Result:= False;
    end;
    end;

end;

end.
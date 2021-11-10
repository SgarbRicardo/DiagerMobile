unit cUsuario;

interface

uses Firedac.Comp.Client, System.SysUtils, Firedac.DApt, FMX.Graphics, Data.DB;

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
           FLogado_ate: String;
           FToken_id: String;
           FNivel_acesso: String;
           FInd_Login: String;
           FInd_Ajuda: String;
           FFOTO64: string;


      public
          constructor Create (conn: TFDConnection);
          property Cod_Usuario : Integer read FCod_Usuario Write FCod_Usuario;
          property Senha : string read FSenha Write FSenha;
          property Email : String read FEmail Write FEmail;
          property Usuario : String read FUsuario Write FUsuario;
          property Nome_Usuario : String read FNome_Usuario Write FNome_Usuario;
          property Departamento : String read FDepartamento Write FDepartamento;
          property Celular : String read FCelular Write FCelular;
          property Logado_ate : String read FLogado_ate Write FLogado_ate;
          property Token_id : String read FToken_id Write FToken_id;
          property Nivel_acesso : String read FNivel_acesso Write FNivel_acesso;
          property Ind_Login : String read FInd_Login Write FInd_Login;
          property Ind_Ajuda : String read FInd_Ajuda Write FInd_Ajuda;
          property Foto : TBitmap read FFoto Write FFoto;
          property FOTO64 : string read FFOTO64 write FFOTO64;

          function ValidaLogin (out erro: string): Boolean;
          function CriarConta(out erro: string): Boolean;
          function Editar(campo, valor: string; out erro: string): Boolean;
          function ListarUsuarios(out erro: string): Boolean;
          function DadosUsuario(order_by: string; out erro: string): TFDQuery;
    end;

implementation

{ TUsuario }

uses uFunctions;

constructor TUsuario.Create(conn: TFDConnection);
begin
     FConn := conn;
end;

function TUsuario.ValidaLogin(out erro: string): Boolean;
var
    qry: TFDQuery;
    test : integer;
    foto_bmp : TBitmap;
begin
     if (Usuario = '') then
     begin
       result := false;
       erro:= 'Please type the user';
       exit;
     end;
      if (Senha = '') then
     begin
       result := false;
       erro:= 'Please type the Password';
       exit;
     end;

    try
      qry := TFDQuery.Create(nil);
      qry.Connection := FConn;

      with  qry do
      begin
        if not Connection.InTransaction then
               Connection.StartTransaction;

          Active := false;
          sql.Clear;
          SQL.Add('declare @pwd3 varchar(20),');
          SQL.Add('@pwd4 varbinary(100)');
          SQL.Add('set @pwd3 =  '+QuotedStr(Trim(senha)));
          SQL.Add('SELECT @pwd4 = password from [MF_Control].[mf_control_db].[userP]');
          SQL.Add('where [user] = '+QuotedStr(Usuario));
          SQL.Add('select pwdCompare(@pwd3, @pwd4, 0)');
          Active := true;

          test := fields.Fields[0].AsInteger;

          if test = 1 then
          begin
            Active := false;
            sql.Clear;
            SQL.Add('SELECT *');
            SQL.Add('From [MF_Control].[mf_control_db].[userP]');
            SQL.Add('where [user] = '+QuotedStr(Usuario));
            Active := true;

            Cod_Usuario := fields.Fields[0].AsInteger;
            Nome_Usuario := FieldByName('name').AsString;
            Email := FieldByName('email').AsString;
            usuario := FieldByName('user').AsString;
            Nivel_acesso := FieldByName('access_level').AsString;
            Departamento := FieldByName('department').AsString;
            Senha := FieldByName('password').AsString;
            Logado_ate := FieldByName('login_until').AsString;

            if qry.FieldByName('photo').AsString <> '' then
            begin
              foto_bmp := TBitmap.Create;
              TFunctions.LoadBitmapFromBlob(foto_bmp, TBlobField(FieldByName('photo')));
              FOTO64 := TFunctions.Base64FromBitmap(foto_bmp);
              foto_bmp.DisposeOf;
            end
            else
              FOTO64 := '';

            erro   := '';
            Result := true;
          end
          else
          begin
            erro := 'Email or Password is invalid';
            Result := false;
          end;
          if  Connection.InTransaction then
              Connection.Commit;
          DisposeOf;
      end;
    except on ex:exception do
    begin
        if qry.Connection.InTransaction then
           qry.Connection.Rollback;
        erro:= 'Error in login validation: ' + ex.Message;
        Result:= False;
    end;
    end;

end;

function TUsuario.ListarUsuarios(out erro: string): Boolean;
var
    qry: TFDQuery;
    test : integer;
begin

    try
      qry := TFDQuery.Create(nil);
      qry.Connection := FConn;

      with  qry do
      begin
          Active := false;
          sql.Clear;
          SQL.Add('SELECT user_id, email, [user] From [MF_Control].[mf_control_db].[userP]');

          if Cod_Usuario > 0 then
          begin
             SQL.Add('where user_id = :cod_usuario');
             ParamByName('user_id').value := Cod_Usuario;
          end
          else
          if Email <> '' then
          begin
             SQL.Add('where email =:Email');
             ParamByName('email').value := Email;
          end;

          Active := true;

          if RecordCount > 0 then
          begin
            Cod_Usuario := FieldByName('user_id').AsInteger;
            Email := FieldByName('email').AsString;
            erro := '';
            Result := true;
          end
          else
          begin
            erro := 'User Not Found';
            Result := false;
          end;

          DisposeOf;
      end;

    except on ex:exception do
    begin
        erro:= 'Erro ao listar usuarios: ' + ex.Message;
        Result:= false;
    end;
    end;

end;

function TUsuario.CriarConta(out erro: string): Boolean;
var
    qry: TFDQuery;
begin
      if (Email = '') then
     begin
       result := false;
       erro:= 'Please type the Email';
       exit;
     end;
      if (Senha = '') then
     begin
       result := false;
       erro:= 'Please type the Password';
       exit;
     end;
      if (usuario = '') then
     begin
       result := false;
       erro:= 'Please type the User';
       exit;
     end;

    try
        qry := TFDQuery.Create(nil);
        qry.Connection := FConn;

        with  qry do
        begin
            Active := false;
            SQL.Clear;
            SQL.Add('declare @pwd3 varchar(20),');
            SQL.Add('@pwd4 varbinary(100)');
            SQL.Add('set @pwd3 =  '+QuotedStr(Trim(senha)));
            SQL.Add('set @pwd4 = convert(varbinary(100),pwdEncrypt(@pwd3))');

            SQL.Add('INSERT INTO [MF_Control].[mf_control_db].[userP](name,[user],password,email,access_level,login_until, department,photo');
            SQL.Add('VALUES (:name,:usuario, convert(varbinary(100),pwdEncrypt(:password)):email,:access_level,:login_until, :department, photo)');
            ParamByName('name').Value := name;
            ParamByName('usuario').Value := Usuario;
            ParamByName('password').Value := Senha;
            ParamByName('email').Value := email;
            ParamByName('access_level').Value := Nivel_acesso;
            ParamByName('login_until').Value := Logado_ate;
            ParamByName('department').Value := Departamento;
            ParamByName('photo').assign(Foto);

            if FOTO <> nil then
                ParamByName('photo').Assign(FOTO)
            else
                ParamByName('photo').Clear;
            execSQL;

            Active := false;
            sql.Clear;
            SQL.Add('SELECT MAX (user_id) AS user_id FROM [MF_Control].[mf_control_db].[userP]');
            SQL.Add('WHERE email=:email');
            ParamByName('email').Value := Email;
            Active := true;

            Cod_Usuario := FieldByName('user_id').AsInteger;

            DisposeOf;
        end;
            Result := true;
            erro   := '';

    except on ex:exception do
      begin
          Result:= False;
          erro:= 'Erro ao CRIAR Conta: ' + ex.Message;

      end;
    end;

end;

function TUsuario.DadosUsuario(order_by: string; out erro : string): TFDQuery;
var
  qry : TFDQuery;
begin
  try
      qry := TFDQuery.Create(nil);
      qry.Connection := FConn;

      with  qry do
        begin
          Active := false;
          SQL.Add('SELECT user_id, email, [user], Department, access_level, name, login_until');
          SQL.Add('From [MF_Control].[mf_control_db].[userP]');
          SQL.Add('where access_level <>''xxx''');

        if order_by = '' then
            SQL.Add('ORDER BY user_id')
        else
            SQL.Add('ORDER BY ' + Order_by);

        qry.Active := true;

        end;
         result := qry;
         erro:='';

  except on ex:exception do
    begin
        erro:= 'Erro carregar as usuarios: ' + ex.Message;
        Result := nil;
    end;

  end;
end;

function TUsuario.Editar(campo, valor: string; out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    if (campo = '')  then
    begin
        Result := false;
        erro := 'Informe o campo';
        exit;
    end;

    try
        qry := TFDQuery.Create(nil);
        qry.Connection := FConn;

        with qry do
        begin
            Active := false;
            sql.Clear;
            SQL.Add('UPDATE [MF_Control].[mf_control_db].[userP] SET ' + campo + ' = :VALOR');
            SQL.Add('WHERE user_id=:user_id');

            if campo = 'photo' then
                ParamByName('VALOR').Assign(FOTO)
            else
                ParamByName('VALOR').Value := valor;

            ParamByName('user_id').Value := Cod_Usuario;

            ExecSQL;

            DisposeOf;
        end;

        Result := true;
        erro := '';

    except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao alterar usuário: ' + ex.Message;
        end;
    end;
end;


end.

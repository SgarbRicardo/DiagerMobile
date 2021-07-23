unit cEmprestimo;

interface

uses FireDAC.Comp.Client, FireDAC.DApt, System.SysUtils, FMX.GRAPHICS;

type
    TEmprestimo = class
    private
        Fconn : TFDConnection;
        FEMPRE_LOGIN_ID: INTEGER;
        FEMPRE_DT_DEVOLUCAO_PREV: TdateTime;
        FEMPRE_LOCATARIO: STRING;
        FEMPRE_PROD_ID: INTEGER;
        FEMPRE_SNAPON_TAG: String;
        FEMPRE_QTD: STRING;
        FEMPRE_DT_ULTIMA_SINC: TDATETIME;
        FEMPRE_IND_SINC: CHAR;
        FEMPRE_DT_LOCACAO: TDatetime;
        FEMPRE_ID: Integer;
        FEMPRE_DT_DEVOLUCAO: TdateTime;
        FCOD_USUARIO : iNTEGER;
        FDATA_ATE: STRING;
        FDATA_DE: STRING;
        FPROD_DESCRICAO: string;


    public

        constructor Create (Conn: TFDConnection);
        property PROD_DESCRICAO : string read FPROD_DESCRICAO WRITE FPROD_DESCRICAO;
        property EMPRE_ID : Integer read FEMPRE_ID WRITE FEMPRE_ID;
        property EMPRE_LOCATARIO : STRING read FEMPRE_LOCATARIO WRITE FEMPRE_LOCATARIO;
        property EMPRE_QTD : STRING read FEMPRE_QTD WRITE FEMPRE_QTD;
        property EMPRE_DT_LOCACAO : TDATETIME read FEMPRE_DT_LOCACAO WRITE FEMPRE_DT_LOCACAO;
        property EMPRE_DT_DEVOLUCAO : TdateTime read FEMPRE_DT_DEVOLUCAO WRITE FEMPRE_DT_DEVOLUCAO;
        property EMPRE_DT_DEVOLUCAO_PREV : TdateTime read FEMPRE_DT_DEVOLUCAO_PREV WRITE FEMPRE_DT_DEVOLUCAO_PREV;
        property EMPRE_LOGIN_ID : INTEGER read FEMPRE_LOGIN_ID WRITE FEMPRE_LOGIN_ID;
        property EMPRE_DT_ULTIMA_SINC : TDATETIME read FEMPRE_DT_ULTIMA_SINC WRITE FEMPRE_DT_ULTIMA_SINC;
        property EMPRE_PROD_ID : INTEGER READ FEMPRE_PROD_ID WRITE FEMPRE_PROD_ID;
        property EMPRE_SNAPON_TAG : string READ FEMPRE_SNAPON_TAG WRITE FEMPRE_SNAPON_TAG;
        property EMPRE_IND_SINC  : CHAR read FEMPRE_IND_SINC WRITE FEMPRE_IND_SINC;
        property COD_USUARIO : integer read FCOD_USUARIO write FCOD_USUARIO;
        property DATA_DE : STRING READ  FDATA_DE WRITE FDATA_DE;
        property DATA_ATE : STRING READ  FDATA_ATE WRITE FDATA_ATE;

        function ListarEmprestimo(qtd_result: integer;out erro: string): TFDQuery;
        function Inserir(out erro: string): Boolean;
        function Alterar(out erro: string): Boolean;
        //function Excluir(out erro: string): Boolean;
end;

implementation

{ TEmprestimo }

uses untDM;

constructor TEmprestimo.Create(Conn: TFDConnection);
begin
      Fconn := Conn;
end;


function TEmprestimo.Inserir(out erro: string): Boolean;
var
  qry : TFDQuery;
begin
     //validações
//    if DESCRICAO = '' then
//      begin
//        erro:= 'Informe a descrição da Categoria: ';
//        result := false;
//        exit;
//      end;

      if EMPRE_PROD_ID <= 0 then
      begin
        erro:= 'Ferramenta não cadastrada ';
        result := false;
        exit;
      end;

      if EMPRE_LOGIN_ID.ToString = '' then
      begin
        erro:= 'Erro ao não encontrar usuário informado ';
        result := false;
        exit;
      end;

      try
          try
              qry := TFDQuery.Create(nil);
              qry.Connection := FConn;

              with qry do
              begin
                 Active:= false;
                 sql.Clear;
                 sql.Add('INSERT INTO TAB_EMPRESTIMO( EMPRE_LOCATARIO, EMPRE_QTD,EMPRE_DT_LOCACAO,EMPRE_DT_DEVOLUCAO,EMPRE_DT_DEVOLUCAO_PREV)');
                 sql.Add('EMPRE_PROD_ID,EMPRE_IND_SINC');
                 SQL.Add('VALUES(:EMPRE_LOCATARIO, :EMPRE_QTD, :EMPRE_DT_LOCACAO, :EMPRE_DT_DEVOLUCAO)');
                 sql.Add(':EMPRE_DT_DEVOLUCAO_PREV, :EMPRE_PROD_ID, :EMPRE_IND_SINC');
                 ParamByName('EMPRE_LOCATARIO').Value := EMPRE_LOCATARIO;
                 ParamByName('EMPRE_QTD').Value := EMPRE_QTD;
                 ParamByName('EMPRE_DT_LOCACAO').Value := EMPRE_DT_LOCACAO;
                 ParamByName('EMPRE_DT_DEVOLUCAO').Value := EMPRE_DT_DEVOLUCAO;
                 ParamByName('EMPRE_DT_DEVOLUCAO_PREV').Value := EMPRE_DT_DEVOLUCAO_PREV;
                 //ParamByName('EMPRE_LOGIN_ID').Value := EMPRE_LOGIN_ID;
                 //ParamByName('EMPRE_DT_ULTIMA_SINC').Value := EMPRE_DT_ULTIMA_SINC;
                 ParamByName('EMPRE_PROD_ID').Value := EMPRE_PROD_ID;
                 ParamByName('EMPRE_IND_SINC').Value := EMPRE_IND_SINC;
                 ExecSQL;
              end;
              result := true;
              erro := '';

           except on ex:exception do
           begin
              Result := false;
              erro := 'Erro ao Inserir a Emprestimo de ferramentas ' + ex.Message;
           end;
           end;
      finally
        qry.DisposeOf;
      end;
end;

function TEmprestimo.Alterar(out erro: string): Boolean;
var
 qry : TFDQuery;
begin
      if EMPRE_PROD_ID.ToString = '' then
      begin
        erro:= 'Ferramenta não cadastrada ';
        result := false;
        exit;
      end;

      if EMPRE_LOGIN_ID.ToString = '' then
      begin
        erro:= 'Erro ao não encontrar usuário informado ';
        result := false;
        exit;
      end;

      try
          try
              qry := TFDQuery.Create(nil);
              qry.Connection := FConn;

              with qry do
              begin
                 Active:= false;
                 sql.Clear;
                 sql.Add('UPDATE TAB_EMPRESTIMO SET ');
                 sql.Add('EMPRE_LOGIN_ID=:EMPRE_LOGIN_ID, EMPRE_DT_LOCACAO=:EMPRE_DT_LOCACAO');
                 SQL.Add('WHERE EMPRE_ID = :EMPRE_ID');
                 ParamByName('EMPRE_ID').Value := EMPRE_ID;
                 ParamByName('EMPRE_DT_LOCACAO').Value := EMPRE_DT_LOCACAO;
                 ParamByName('EMPRE_LOGIN_ID').Value := EMPRE_LOGIN_ID;
              // ParamByName('EMPRE_IND_SINC').Value := EMPRE_IND_SINC;
                 ExecSQL;
              end;
              result := true;
              erro := '';

           except on ex:exception do
             begin
                Result := false;
                erro := 'Erro ao alterar o Emprestimo de ferramentas; ' + ex.Message;
             end;
           end;

      finally
        qry.DisposeOf;
      end;
end;
 {
function TEmprestimo.Excluir(out erro: string): Boolean;
var
  qry : TFDQuery;
begin
     //validações
    if DESCRICAO = '' then
      begin
        erro:= 'Informe a descrição da Categoria: ';
        result := false;
        exit;
      end;
       if ID_CATEGORIA = 0 then
      begin
        erro:= 'Informe o ID da Categoria: ';
        result := false;
        exit;
      end;
      try
          try
              qry := TFDQuery.Create(nil);
              qry.Connection := FConn;

              //VALIDAR SE CATEGORIA POSSUI LANCAMENTOS

              with qry do
              begin
                 Active:= false;
                 sql.Clear;
                 sql.Add('DELETE FROM TAB_CATEGORIA');
                 SQL.Add('WHERE ID_CATEGORIA = :ID_CATEGORIA');
                 ParamByName('ID_CATEGORIA').Value := ID_CATEGORIA;
                 ExecSQL;
              end;
              result := true;
              erro := '';

           except on ex:exception do
           begin
              Result := false;
              erro := 'Erro ao excluir a categoria; ' + ex.Message;
           end;
           end;
      finally
        qry.DisposeOf;
      end;
end;
   }
function TEmprestimo.ListarEmprestimo(qtd_result: integer; out erro: string): TFDQuery;
var
  qry : TFDQuery;
begin
        try
           qry := TFDQuery.Create(nil);
           qry.Connection := FConn;

           with qry do
           begin
             Active:= false;
             sql.Clear;
             sql.Add('SELECT P.PROD_DESCRICAO, P.PROD_VERSAO, P.PROD_MARCA,P.PROD_FOTO, P.PROD_QTD, P.PROD_SNAP_TAG, C.CAT_DESCRICAO, E.EMPRE_LOCATARIO,');
             sql.Add('E.EMPRE_IND_SINC, E.EMPRE_ID, E.EMPRE_DT_LOCACAO, E.EMPRE_PROD_ID, U.COD_USUARIO, U.USU_NOME, U.USU_DEPARTAMENTO ');
             SQL.Add('FROM TAB_EMPRESTIMO E');
             SQL.Add(' JOIN TAB_PRODUTO P ON(E.EMPRE_PROD_ID = P.PROD_ID)');
             SQL.Add(' JOIN TAB_USUARIO U ON (E.EMPRE_LOGIN_ID = U.COD_USUARIO)');
             SQL.Add(' JOIN TAB_CATEGORIA C ON (P.PROD_ID_CATEGORIA = C.ID_CATEGORIA)');
             sql.Add(' WHERE 1 = 1');

             if EMPRE_ID > 0 then
              begin
                sql.Add('AND E.EMPRE_ID = :EMPRE_ID');
                ParamByName('EMPRE_ID').Value := EMPRE_ID;
              end;

               if EMPRE_PROD_ID > 0 then
              begin
                sql.Add('AND E.EMPRE_PROD_ID = :EMPRE_PROD_ID');
                ParamByName('EMPRE_PROD_ID').Value := EMPRE_PROD_ID;
              end;

              if COD_USUARIO > 0 then
              begin
                sql.Add('AND E.EMPRE_LOGIN_ID = :COD_USUARIO');
                ParamByName('EMPRE_LOGIN_ID').Value := COD_USUARIO;
              end;

               if (DATA_DE <> '') AND (DATA_ATE <> '') then
                sql.Add('AND E.EMPRE_DT_LOCACAO BETWEEN ''' + DATA_DE + ''' AND ''' + DATA_ATE + '''');

              sql.Add('ORDER BY E.EMPRE_DT_LOCACAO');

              if qtd_result > 0 then
                 sql.Add('LIMIT '+ qtd_result.ToString);

             Active := true;
           end;

           Result := qry;
           erro := '';

         except on ex:exception do
           begin
              Result := nil;
              erro := 'Erro ao Consultar EMPRESTIMOS; ' + ex.Message;
           end;
        end;

end;

end.

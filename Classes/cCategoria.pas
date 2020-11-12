unit cCategoria;

interface

uses FireDAC.Comp.Client, FireDAC.DApt, System.SysUtils, FMX.GRAPHICS;

type
    TCategoria = class
    private
        Fconn : TFDConnection;
        FID_CATEGORIA: Integer;
        FDESCRICAO: STRING;
        FICONE: TBitmap;
        FINDICE_ICONE : Integer;


    public
        constructor Create (Conn: TFDConnection);
        property ID_CATEGORIA : Integer read FID_CATEGORIA WRITE FID_CATEGORIA;
        property DESCRICAO : STRING read FDESCRICAO WRITE FDESCRICAO;
        property ICONE : TBitmap read FICONE WRITE FICONE;
        property INDICE_ICONE  : INTEGER read FINDICE_ICONE WRITE FINDICE_ICONE;

        function ListarCategoria(out erro: string): TFDQuery;
        function InserirCategoria(out erro: string): Boolean;
        function AlterarCategoria(out erro: string): Boolean;
        function ExcluirCategoria(out erro: string): Boolean;
end;

implementation

{ TCategoria }

uses untDM;

constructor TCategoria.Create(Conn: TFDConnection);
begin
      Fconn := Conn;
end;

function TCategoria.InserirCategoria(out erro: string): Boolean;
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
      try
          try
              qry := TFDQuery.Create(nil);
              qry.Connection := FConn;

              with qry do
              begin
                 Active:= false;
                 sql.Clear;
                 sql.Add('INSERT INTO TAB_CATEGORIA, CAT_DESCRICAO, CAT_ICONE');
                 SQL.Add('VALUES(:CAT_DESCRICAO, :CAT_ICONE)');
                 ParamByName('CAT_DESCRICAO').Value := DESCRICAO;
                 ParamByName('CAT_ICONE').Assign(ICONE);
                 ExecSQL;
              end;
              result := true;
              erro := '';

           except on ex:exception do
           begin
              Result := false;
              erro := 'Erro ao Inserir a categoria; ' + ex.Message;
           end;
           end;
      finally
        qry.DisposeOf;
      end;
end;

 function TCategoria.AlterarCategoria(out erro: string): Boolean;
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

              with qry do
              begin
                 Active:= false;
                 sql.Clear;
                 sql.Add('UPDATE TAB_CATEGORIA SET CAT_DESCRICAO:=DESCRICAO, CAT_ICONE:=ICONE');
                 SQL.Add('WHERE ID_CATEGORIA = :ID_CATEGORIA');
                 ParamByName('CAT_DESCRICAO').Value := DESCRICAO;
                 ParamByName('CAT_ICONE').Assign(ICONE);
                 ParamByName('ID_CATEGORIA').Value := ID_CATEGORIA;
                 ExecSQL;
              end;
              result := true;
              erro := '';

           except on ex:exception do
           begin
              Result := false;
              erro := 'Erro ao alterar a categoria; ' + ex.Message;
           end;
           end;
      finally
        qry.DisposeOf;
      end;
end;

function TCategoria.ExcluirCategoria(out erro: string): Boolean;
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

function TCategoria.ListarCategoria(out erro: string): TFDQuery;
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
         sql.Add('SELECT * FROM TAB_CATEGORIA');
         sql.Add('WHERE ID_CATEGORIA > 0');

          if ID_CATEGORIA > 0 then
          begin
            sql.Add('AND ID_CATEGORIA = :ID_CATEGORIA');
            ParamByName('ID_CATEGORIA').Value := ID_CATEGORIA;
          end;

         Active := true;
       end;

       Result := qry;
       erro := '';

     except on ex:exception do
     begin
        Result := nil;
        erro := 'Erro ao Consultar a categorias; ' + ex.Message;

     end;
     end;
end;

end.

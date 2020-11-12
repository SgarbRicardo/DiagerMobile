unit cEquipamento;

interface

uses FireDAC.Comp.Client, FireDAC.DApt, System.SysUtils, FMX.GRAPHICS;

type
    TEquipamento = class
    private
        Fconn : TFDConnection;
        FVERSION: DOUBLE;
        FQTD: STRING;
        FID_EQUIPAMENTO: Integer;
        FDESCRICAO: STRING;
        FSNAPON_TAG: INTEGER;
        FID_CATEGORIA: Integer;
        FBRAND: STRING;
        FINDICE_ICONE: INTEGER;
        FICONE: TBitmap;

    public
        constructor Create (Conn: TFDConnection);
        property ID_EQUIPAMENTO : Integer read FID_EQUIPAMENTO WRITE FID_EQUIPAMENTO;
        property ID_CATEGORIA : Integer read FID_CATEGORIA WRITE FID_CATEGORIA;
        property DESCRICAO : STRING read FDESCRICAO WRITE FDESCRICAO;
        property ICONE : TBitmap read FICONE WRITE FICONE;
        property INDICE_ICONE  : INTEGER read FINDICE_ICONE WRITE FINDICE_ICONE;
        property BRAND : STRING read FBRAND WRITE FBRAND;
        property VERSION : DOUBLE read FVERSION WRITE FVERSION;
        property SNAPON_TAG : INTEGER read FSNAPON_TAG WRITE FSNAPON_TAG;
        property QTD : STRING read FQTD WRITE FQTD;

        function AlterarEquipamento(out erro: string): Boolean;
        function ExcluirEquipamento(out erro: string): Boolean;
        function InserirEquipamento(out erro: string): Boolean;
        function ListarEquipamento(out erro: string): TFDQuery;

end;

implementation

{ TCategoria }

uses untDM;

constructor TEquipamento.Create(Conn: TFDConnection);
begin
      Fconn := Conn;
end;

function TEquipamento.InserirEquipamento(out erro: string): Boolean;
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

function TEquipamento.AlterarEquipamento(out erro: string): Boolean;
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

function TEquipamento.ExcluirEquipamento(out erro: string): Boolean;
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

function TEquipamento.ListarEquipamento(out erro: string): TFDQuery;
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
          sql.Add('SELECT P.*, C.CAT_DESCRICAO AS DESCRICAO_CATEGORIA');
          sql.Add('FROM TAB_PRODUTO P');
          sql.Add('JOIN TAB_CATEGORIA C ON (C.ID_CATEGORIA = P.PROD_ID_CATEGORIA)');
          sql.Add('WHERE 1 = 1');

          if ID_EQUIPAMENTO > 0 then
          begin
            sql.Add('AND PROD_ID = :PROD_ID');
            ParamByName('PROD_ID').Value := ID_EQUIPAMENTO;
          end;

          if ID_CATEGORIA > 0 then
          begin
            SQL.Add('AND P.PROD_ID_CATEGORIA = :PROD_ID_CATEGORIA');
            ParamByName('PROD_ID_CATEGORIA').Value := ID_CATEGORIA;
          end;

         Active := true;
       end;

       Result := qry;
       erro := '';

     except on ex:exception do
     begin
        Result := nil;
        erro := 'Erro ao Consultar os Equipamentos; ' + ex.Message;

     end;
     end;
end;

end.

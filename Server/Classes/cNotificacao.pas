unit cNotificacao;

interface

uses Firedac.Comp.Client, Data.DB, FMX.Graphics;

type
    TNotificacao  = class
      private
          Fconn :  TFDConnection;
          FDT_GERACAO: TDateTime;
          FEXTRA2: STRING;
          FEXTRA1: STRING;
          FTEXTO: STRING;
          FIND_LIDO: STRING;
          FCOD_USUARIO: integer;
          FID_NOTIFICACAO: integer;



      public
          constructor Create (conn : TFDConnection);
          property ID_NOTIFICACAO : integer read FID_NOTIFICACAO write FID_NOTIFICACAO;
          property COD_USUARIO : integer read FCOD_USUARIO write FCOD_USUARIO;
          property DT_GERACAO : TDateTime read FDT_GERACAO write FDT_GERACAO;
          property TEXTO : STRING read FTEXTO write FTEXTO;
          property IND_LIDO : STRING read FIND_LIDO write FIND_LIDO;
          property EXTRA1 : STRING read FEXTRA1 write FEXTRA1;
          property EXTRA2 : STRING read FEXTRA2 write FEXTRA2;

          function ListarNotificacao(order_by: string; out erro: string): TFDQuery;
          function InserirNotificacao(out erro: string): Boolean;
          function RemoverNotificacao(out erro: string): Boolean;

end;

implementation

uses
  system.SysUtils;

constructor TNotificacao.Create(conn: TFDConnection);
begin
    Fconn := conn;
end;

function TNotificacao.ListarNotificacao(order_by: string; out erro: string): TFDQuery;
var
    qry : TFDQuery;
begin
    if(COD_USUARIO <= 0) then
    begin
      Result := nil;
      erro := 'User not determined';
      exit;
    end;
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Fconn;

      with qry do
      begin
        Active := false;
        sql.Clear;
        sql.Add('Select * from [MF_Control].[mf_control_db].TAB_Notification');
         SQL.Add('where user_id = :cod_usuario');

         if order_by = '' then
         sql.Add('ORER BY ID_NOTIFICACAO DESC')
         else
         SQL.Add('ORDER BY'+ order_by);

         ParamByName('user_id').Value := COD_USUARIO;
         Active := true;

      end;

      erro := '';
      Result := qry;

    Except on ex:Exception do
      begin
        erro:= 'Error in attempt to read notifications' + ex.message;
        Result := nil;
      end;

    end;
end;

function TNotificacao.InserirNotificacao(out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    if(COD_USUARIO <= 0) then
    begin
      Result := false;
      erro := 'User not determined';
      exit;
    end;

     if(TEXTO = '') then
    begin
      Result := false;
      erro := 'Text Message not determined';
      exit;
    end;

    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Fconn;

      with qry do
      begin
        Active := false;
        sql.Clear;
        sql.Add('INSERT INTO MF_Control].[mf_control_db].TAB_Notification([user_id],dt_geracao,texto, ind_lido, extra1, extra2');
        sql.Add('VALUES(:user_id, current_timeStamp, :texto, :ind_lido, :extra1, :extra2');

        ParamByName('user_id').Value := COD_USUARIO;
        ParamByName('texto').Value := Text;
        ParamByName('ind_lido').Value := IND_LIDO;
        ParamByName('extra1').Value := extra2;
        ParamByName('extra2').Value := extra2;
        ExecSQL;

        Active := false;
        sql.Clear;
        Sql.Add('SELECT MAX (ID_NOTIFICACAO)AS ID_NOTIFICACAO FROM MF_Control].[mf_control_db].TAB_Notification');
        SQL.Add('WHERE user_id= :cod_usuario');
        ParamByName('user_id').Value := COD_USUARIO;
        active := true;

        ID_NOTIFICACAO := FieldByName('id_notificacao').AsInteger;
        DisposeOf;
      end;

      erro := '';
      Result := true;

    Except on ex:Exception do
      begin
        erro:= 'Error in attempt to insert notification' + ex.message;
        Result := false;
      end;

    end;
end;

function TNotificacao.RemoverNotificacao( out erro: string): Boolean;
var
    qry : TFDQuery;
begin
    if(ID_NOTIFICACAO <= 0) then
    begin
      Result := false;
      erro := 'Notification not determined';
      exit;
    end;
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := Fconn;

      with qry do
      begin
        Active := false;
        sql.Clear;
        sql.Add('Delete from [MF_Control].[mf_control_db].TAB_Notification ');
        SQL.Add('where id_notificacao = :id_notificacao');
        ParamByName('id_notificacao').Value := ID_NOTIFICACAO;

        disposeOf;
      end;

      Result := true;
      erro := '';

    Except on ex:Exception do
      begin
        Result := false ;
        erro:= 'Error in attempt to Remove the notification' + ex.message;
      end;

    end;
end;

end.

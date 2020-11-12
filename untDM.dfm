object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 484
  Width = 434
  object Conn: TFDConnection
    Params.Strings = (
      'Database=f:\MFCAppMobile\DB\MFCDBLocal.db'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    Left = 40
    Top = 40
  end
  object qry_Geral: TFDQuery
    Connection = Conn
    Left = 128
    Top = 112
  end
  object qry_Emprestimo: TFDQuery
    Connection = Conn
    Left = 40
    Top = 112
  end
  object RESTClient: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:8082'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 32
    Top = 176
  end
  object Request_Usuario: TRESTRequest
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'LG_USUARIO'
        Value = 'TF6119'
      end
      item
        Name = 'LG_EMAIL'
        Value = 'RDS@SNAPON.COM'
      end>
    Resource = 'ListarUsuario'
    SynchronizedEvents = False
    Left = 32
    Top = 232
  end
  object HTTPBasicAuthenticator1: THTTPBasicAuthenticator
    Username = 'admin'
    Password = 'admin'
    Left = 32
    Top = 304
  end
end

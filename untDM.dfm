object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 547
  Width = 522
  object Conn: TFDConnection
    Params.Strings = (
      'Database=f:\MFCAppMobile\DB\MFCDBLocal.db'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 40
    Top = 40
  end
  object qry_Geral: TFDQuery
    Connection = Conn
    Left = 120
    Top = 96
  end
  object qry_Emprestimo: TFDQuery
    Connection = Conn
    Left = 40
    Top = 96
  end
  object RESTClient: TRESTClient
    Authenticator = HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://192.168.1.15:8082'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 32
    Top = 176
  end
  object Request_Usuario: TRESTRequest
    Client = RESTClient
    Method = rmPOST
    Params = <>
    Resource = 'ListarTeste'
    SynchronizedEvents = False
    Left = 32
    Top = 232
  end
  object HTTPBasicAuthenticator1: THTTPBasicAuthenticator
    Username = 'admin'
    Password = 'admin'
    Left = 344
    Top = 8
  end
  object Request_Perfil: TRESTRequest
    Client = RESTClient
    Method = rmPATCH
    Params = <>
    Resource = 'usuarios/usuario'
    SynchronizedEvents = False
    Left = 232
    Top = 297
  end
  object Request_Inventario: TRESTRequest
    Client = RESTClient
    Params = <>
    Resource = 'emprestimos/TodoEmprestimos'
    SynchronizedEvents = False
    Left = 128
    Top = 232
  end
  object RequestLogin: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Name = 'email'
        Value = 'TF6119@SNAPON.COM'
      end
      item
        Name = 'user'
      end
      item
        Name = 'senha'
        Value = '12345'
      end>
    Resource = 'usuarios/usuario'
    SynchronizedEvents = False
    Left = 24
    Top = 296
  end
  object RequestConta: TRESTRequest
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Name = 'email'
        Value = 'TF6119@SNAPON.COM'
      end
      item
        Name = 'user'
        Value = 'teste'
      end
      item
        Name = 'senha'
        Value = '12345'
      end
      item
        Name = 'foto'
      end>
    Resource = 'usuarios/usuario'
    SynchronizedEvents = False
    Left = 24
    Top = 360
  end
  object RequestCategory: TRESTRequest
    Client = RESTClient
    Params = <>
    Resource = 'Categorias/listar'
    SynchronizedEvents = False
    Left = 128
    Top = 296
  end
  object RequestChat: TRESTRequest
    Client = RESTClient
    Params = <>
    Resource = 'task/Chat'
    SynchronizedEvents = False
    Left = 120
    Top = 360
  end
  object RequestChatEnvia: TRESTRequest
    Client = RESTClient
    Method = rmPOST
    Params = <>
    Resource = 'task/Chat'
    SynchronizedEvents = False
    Left = 240
    Top = 360
  end
  object Request_TaskDone: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Name = 'id_roadmap'
      end
      item
        Name = 'bundle'
      end
      item
        Name = 'busca'
      end>
    Resource = 'Task/Task'
    SynchronizedEvents = False
    Left = 240
    Top = 240
  end
  object Request_Bundle: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Name = 'id_roadmap'
      end
      item
        Name = 'bundle'
      end
      item
        Name = 'busca'
      end>
    Resource = 'Task/Bundle'
    SynchronizedEvents = False
    Left = 336
    Top = 240
  end
  object Request_Make: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Name = 'id_roadmap'
      end
      item
        Name = 'bundle'
      end
      item
        Name = 'busca'
      end>
    Resource = 'Task/make'
    SynchronizedEvents = False
    Left = 336
    Top = 304
  end
  object request_TasktoTest: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Name = 'id_roadmap'
      end
      item
        Name = 'bundle'
      end
      item
        Name = 'busca'
      end>
    Resource = 'Task/Tasktotest'
    SynchronizedEvents = False
    Left = 344
    Top = 360
  end
  object requestTaskQTD: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Name = 'id_roadmap'
      end
      item
        Name = 'bundle'
      end
      item
        Name = 'busca'
      end>
    Resource = 'Task/ListaTaskQTD'
    SynchronizedEvents = False
    Left = 344
    Top = 424
  end
  object requestCCListaStatus: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Name = 'id_roadmap'
      end
      item
        Name = 'bundle'
      end
      item
        Name = 'busca'
      end>
    Resource = 'Suporte/ListaQTDStatus'
    SynchronizedEvents = False
    Left = 232
    Top = 424
  end
  object RequestListaVerAtendida: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Name = 'id_roadmap'
      end
      item
        Name = 'bundle'
      end
      item
        Name = 'busca'
      end>
    Resource = 'Suporte/ListaVerAtend'
    SynchronizedEvents = False
    Left = 96
    Top = 424
  end
  object RequestVehicleTask: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Name = 'id_roadmap'
      end
      item
        Name = 'bundle'
      end
      item
        Name = 'busca'
      end>
    Resource = 'task/ListaVeiculosTask'
    SynchronizedEvents = False
    Left = 128
    Top = 176
  end
  object Request_VeiculoTestado: TRESTRequest
    Client = RESTClient
    Params = <
      item
        Name = 'id_roadmap'
      end
      item
        Name = 'bundle'
      end
      item
        Name = 'busca'
      end>
    Resource = 'task/ListaVeiculosTestados'
    SynchronizedEvents = False
    Left = 240
    Top = 176
  end
end

object dm: Tdm
  OldCreateOrder = False
  OnCreate = ServerMethodDataModuleCreate
  Encoding = esUtf8
  Height = 443
  Width = 456
  object DWEvents: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'hora'
        OnReplyEvent = DWEventsEventshoraReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'senha'
            Encoded = False
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'user'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'validaLogin'
        OnReplyEvent = DWEventsEventsvalidaLoginReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'email'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'user'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'senha'
            Encoded = True
          end
          item
            TypeObject = toParam
            ObjectDirection = odIN
            ObjectValue = ovString
            ParamName = 'foto'
            Encoded = True
          end>
        JsonMode = jmPureJSON
        Name = 'criarConta'
        OnReplyEvent = DWEventsEventscriarContaReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'ListarInventario'
        OnReplyEvent = DWEventsEventsListarInventarioReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'ListarUsuario'
        OnReplyEvent = DWEventsEventsListarUsuarioReplyEvent
      end>
    Left = 32
    Top = 40
  end
  object conn: TFDConnection
    Params.Strings = (
      'Database=E:\MFCAppMobile\DB\DB.FDB'
      'User_Name=SYSDBA'
      'Password=SYSDBA'
      'DriverID=FB')
    LoginPrompt = False
    Left = 32
    Top = 112
  end
  object qryGeral: TFDQuery
    Connection = conn
    Left = 88
    Top = 112
  end
end

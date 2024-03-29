object dm: Tdm
  OldCreateOrder = False
  OnCreate = ServerMethodDataModuleCreate
  Encoding = esUtf8
  Height = 443
  Width = 456
  object DWUsuario: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'hora'
        EventName = 'hora'
        OnlyPreDefinedParams = False
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
            ParamName = 'usuario'
            Encoded = False
          end>
        JsonMode = jmPureJSON
        Name = 'usuario'
        EventName = 'usuario'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWUsuarioEventsusuarioReplyEventByType
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
            ParamName = 'usuario'
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
        Name = 'CriarConta'
        EventName = 'usuario'
        OnlyPreDefinedParams = False
        OnReplyEvent = DWEventsEventscriarContaReplyEvent
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'DadosUsuario'
        EventName = 'DadosUsuario'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWUsuarioEventsDadosUsuarioReplyEventByType
      end>
    ContextName = 'usuarios'
    Left = 32
    Top = 48
  end
  object conn: TFDConnection
    Params.Strings = (
      'Database=MF_Control'
      'User_Name=mfcontrol'
      'Password=deelhersom4'
      'Server=10.32.2.29\SQLEXPRESS'
      'OSAuthent=Yes'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 288
    Top = 80
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 288
    Top = 16
  end
  object DWEmprestimo: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'emprestimo'
        EventName = 'emprestimo'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEmprestimoEventsemprestimoReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'TodoEmprestimos'
        EventName = 'TodoEmprestimos'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWEmprestimoEventsTodoEmprestimosReplyEventByType
      end>
    ContextName = 'emprestimos'
    Left = 120
    Top = 48
  end
  object qryCategoria: TFDQuery
    Connection = conn
    Left = 288
    Top = 144
  end
  object DWCategoria: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'listar'
        EventName = 'listar'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWCategoriaEventslistarReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'ListarQtdCat'
        EventName = 'ListarQtdCat'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWCategoriaEventsListarQtdCatReplyEventByType
      end>
    ContextName = 'Categorias'
    Left = 32
    Top = 120
  end
  object DWChat: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'listar'
        EventName = 'listar'
        OnlyPreDefinedParams = False
      end>
    ContextName = 'chat'
    Left = 32
    Top = 184
  end
  object DWTask: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'Task'
        EventName = 'Task'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWTaskEventsTaskReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'Chat'
        EventName = 'Chat'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWTaskEventsChatReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'Bundle'
        EventName = 'Bundle'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWTaskEventsBundleReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'TasktoTest'
        EventName = 'TasktoTest'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWTaskEventsTasktoTestReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'Make'
        EventName = 'Make'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWTaskEventsMakeReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'ListaTask'
        EventName = 'ListaTask'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWTaskEventsListaTaskReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'ListaTaskQTD'
        EventName = 'ListaTaskQTD'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWTaskEventsListaTaskQTDReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'ListaVeiculosTask'
        EventName = 'ListaVeiculosTask'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWTaskEventsListaVeiculosTaskReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'ListaVeiculosTestados'
        EventName = 'ListaVeiculosTestados'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWTaskEventsListaVeiculosTestadosReplyEventByType
      end>
    ContextName = 'task'
    Left = 120
    Top = 120
  end
  object DWSuporte: TDWServerEvents
    IgnoreInvalidParams = False
    Events = <
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'ListarTop'
        EventName = 'ListarTop'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWSuporteEventsListarTopReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'ListaWaitCR'
        EventName = 'ListaWaitCR'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWSuporteEventsListaWaitCRReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'ListaQTDStatus'
        EventName = 'ListaQTDStatus'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWSuporteEventsListaQTDStatusReplyEventByType
      end
      item
        Routes = [crAll]
        NeedAuthorization = True
        DWParams = <>
        JsonMode = jmPureJSON
        Name = 'ListaVerAtend'
        EventName = 'ListaVerAtend'
        OnlyPreDefinedParams = False
        OnReplyEventByType = DWSuporteEventsListaVerAtendReplyEventByType
      end>
    ContextName = 'Suporte'
    Left = 120
    Top = 184
  end
end

Imports Microsoft.VisualBasic

Public Interface IMessageBox
    Sub ClearMessage()

    Sub ShowOk(ByVal msg As String)

    Sub ShowError(ByVal msg As String)

    Sub ShowInformation(ByVal msg As String)

    Sub ShowQuestion(ByVal msg As String)

    Sub ShowWarning(ByVal msg As String)

    Sub ShowException(ByVal ex As System.Exception)

    Sub ShowMessage(ByVal msg As String, ByVal msgType As BVSoftware.Bvc5.Core.Content.DisplayMessageType)

End Interface

Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_MessageBox
    Inherits System.Web.UI.UserControl
    Implements IMessageBox

    Public Property AutoUpdateAfterCallback() As Boolean
        Get
            Return Me.pnlMain.AutoUpdateAfterCallBack
        End Get
        Set(ByVal value As Boolean)
            Me.pnlMain.AutoUpdateAfterCallBack = value
        End Set
    End Property

    Public Sub ShowOk(ByVal msg As String) Implements IMessageBox.ShowOk
        ShowMessage(msg, Content.DisplayMessageType.Success)
    End Sub

    Public Sub ShowError(ByVal msg As String) Implements IMessageBox.ShowError
        ShowMessage(msg, Content.DisplayMessageType.Error)
    End Sub

    Public Sub ShowInformation(ByVal msg As String) Implements IMessageBox.ShowInformation
        ShowMessage(msg, Content.DisplayMessageType.Information)
    End Sub

    Public Sub ShowQuestion(ByVal msg As String) Implements IMessageBox.ShowQuestion
        ShowMessage(msg, Content.DisplayMessageType.Question)
    End Sub

    Public Sub ShowWarning(ByVal msg As String) Implements IMessageBox.ShowWarning
        ShowMessage(msg, Content.DisplayMessageType.Warning)
    End Sub

    Public Sub ShowException(ByVal ex As System.Exception) Implements IMessageBox.ShowException
        Dim msg As String = ex.Message & "<br>" & ex.Source & "<br>" & ex.StackTrace
        ShowMessage(msg, Content.DisplayMessageType.Exception)
    End Sub

    Public Sub ShowMessage(ByVal msg As String, ByVal msgType As BVSoftware.BVC5.Core.Content.DisplayMessageType) Implements IMessageBox.ShowMessage
        Me.pnlMain.Visible = True
        Dim li As New HtmlGenericControl("li")
        li.Attributes.Add("class", "errorline")
        Dim icondiv As New HtmlGenericControl("div")
        li.Controls.Add(icondiv)
        icondiv.Attributes.Add("class", "icon")
        Dim img As New Image()
        img.ImageUrl = GetIconType(msgType)
        icondiv.Controls.Add(img)

        Dim divMessage As New HtmlGenericControl("div")
        divMessage.Attributes.Add("class", "message")

        Dim MessageLabel As New Label()
        MessageLabel.Text = msg
        divMessage.Controls.Add(MessageLabel)

        li.Controls.Add(divMessage)
        Me.MessageList.Controls.Add(li)
    End Sub

    Public Sub ClearMessage() Implements IMessageBox.ClearMessage
        Me.MessageList.Controls.Clear()
        Me.pnlMain.Visible = False
    End Sub

    Public Function GetIconType(ByVal msgType As Content.DisplayMessageType) As String
        Select Case msgType
            Case BVSoftware.BVC5.Core.Content.DisplayMessageType.Error
                Return PersonalizationServices.GetThemedButton("MessageError")
            Case BVSoftware.BVC5.Core.Content.DisplayMessageType.Exception
                Return PersonalizationServices.GetThemedButton("MessageException")
            Case BVSoftware.BVC5.Core.Content.DisplayMessageType.Information
                Return PersonalizationServices.GetThemedButton("MessageInformation")
            Case BVSoftware.BVC5.Core.Content.DisplayMessageType.Question
                Return PersonalizationServices.GetThemedButton("MessageQuestion")
            Case BVSoftware.BVC5.Core.Content.DisplayMessageType.Success
                Return PersonalizationServices.GetThemedButton("MessageOk")
            Case BVSoftware.BVC5.Core.Content.DisplayMessageType.Warning
                Return PersonalizationServices.GetThemedButton("MessageWarning")
        End Select
        Return String.Empty
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If WebAppSettings.MessageBoxErrorTestMode Then
            Me.ShowInformation("My Id is " & Me.ID)
            If Me.Parent IsNot Nothing Then
                Me.ShowInformation("My parent object is " & Me.Parent.ClientID)
            End If

            If Me.NamingContainer IsNot Nothing Then
                Me.ShowInformation("My Naming container is " & Me.NamingContainer.ClientID)
            End If

            For i As Integer = 0 To 3
                Me.ShowError("This is a test error. This is error number " & i.ToString())
            Next
            Me.ShowWarning("One really really long test error. We threw this one in so that you would have a really long error message to test. This way you can make sure that your pages render properly with a mutiline error.")
        End If
    End Sub
End Class

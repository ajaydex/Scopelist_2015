Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_MessageBox
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

    Public Sub ShowMessage(ByVal msg As String, ByVal msgType As BVSoftware.Bvc5.Core.Content.DisplayMessageType) Implements IMessageBox.ShowMessage
        Me.pnlMain.Visible = True
        'Success Message
        If (msgType = Content.DisplayMessageType.Success) Then
            dvSuccess.Attributes.Add("class", "success_panel")
            divInnerSuccess.Attributes.Add("class", "panel-inner")
            Dim li As New HtmlGenericControl("li")
            li.Attributes.Add("class", "liststyle")

            'Dim icondiv As New HtmlGenericControl("div")
            'li.Controls.Add(icondiv)
            'icondiv.Attributes.Add("class", "icon")

            Dim img As New Image()
            img.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/tick.png")
            img.CssClass = "su_tick"
            img.AlternateText = "success"
            'icondiv.Controls.Add(img)

            Dim MessageLabel As New Label()
            MessageLabel.Text = msg
            MessageLabel.CssClass = "error_message_text"

            li.Controls.Add(img)
            li.Controls.Add(MessageLabel)
            Me.SuccessList.Controls.Add(li)
        End If
        'Error Message
        If (msgType = Content.DisplayMessageType.Error) Then
            divError.Attributes.Add("class", "error_panel")
            divInnerError.Attributes.Add("class", "panel-inner")
            Dim li As New HtmlGenericControl("li")
            li.Attributes.Add("class", "liststyle")

            'Dim icondiv As New HtmlGenericControl("div")
            'li.Controls.Add(icondiv)
            'icondiv.Attributes.Add("class", "icon")

            Dim img As New Image()
            'img.ImageUrl = GetIconType(msgType)
            img.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/error_cross.png")
            img.CssClass = "er_cross"
            img.AlternateText = "error"
            'icondiv.Controls.Add(img)
            'Dim divMessage As New HtmlGenericControl("div")
            'divMessage.Attributes.Add("class", "InnerErroMessage")

            Dim MessageLabel As New Label()
            MessageLabel.Text = msg
            MessageLabel.CssClass = "error_message_text"

            'divMessage.Controls.Add(MessageLabel)
            'li.Controls.Add(divMessage)
            li.Controls.Add(img)
            li.Controls.Add(MessageLabel)
            Me.ErrorList.Controls.Add(li)
        End If
        'Information 
        If (msgType = Content.DisplayMessageType.Information) Then
            divInfo.Attributes.Add("class", "info_panel")
            divInnerInfo.Attributes.Add("class", "panel-inner")

            Dim li As New HtmlGenericControl("li")
            li.Attributes.Add("class", "liststyle")

            'Dim icondiv As New HtmlGenericControl("div")
            'li.Controls.Add(icondiv)
            'icondiv.Attributes.Add("class", "icon")

            Dim img1 As New Image()
            img1.ImageUrl = GetIconType(msgType)
            img1.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/info.png")
            img1.CssClass = "info_tick"
            img1.AlternateText = "Information"
            'icondiv.Controls.Add(img)
            'Dim divMessage As New HtmlGenericControl("div")
            'divMessage.Attributes.Add("class", "InnerErroMessage")
            Dim MessageLabel As New Label()
            MessageLabel.Text = msg
            MessageLabel.CssClass = "error_message_text"

            'icondiv.Controls.Add(MessageLabel)
            'divMessage.Controls.Add(MessageLabel)
            'li.Controls.Add(divMessage)
            li.Controls.Add(img1)
            li.Controls.Add(MessageLabel)
            Me.MessageList.Controls.Add(li)
        End If

        'Warning
        If (msgType = Content.DisplayMessageType.Warning) Then
            divWarning.Attributes.Add("class", "worning_panel")
            divInnerWarning.Attributes.Add("class", "panel-inner")
            Dim li As New HtmlGenericControl("li")
            li.Attributes.Add("class", "liststyle")

            'Dim icondiv As New HtmlGenericControl("div")
            'ul.Controls.Add(icondiv)
            'icondiv.Attributes.Add("class", "icon")

            Dim img As New Image()
            img.ImageUrl = GetIconType(msgType)
            img.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/worning.png")
            img.CssClass = "worning_tick"
            img.AlternateText = "warning Info"

            'icondiv.Controls.Add(img)
            'Dim divMessage As New HtmlGenericControl("div")
            'divMessage.Attributes.Add("class", "InnerErroMessage")

            Dim MessageLabel As New Label()
            MessageLabel.Text = msg
            MessageLabel.CssClass = "error_message_text"

            'divMessage.Controls.Add(MessageLabel)
            'ul.Controls.Add(divMessage)

            li.Controls.Add(img)
            li.Controls.Add(MessageLabel)
            Me.WarningList.Controls.Add(li)
        End If

        'Question
        If (msgType = Content.DisplayMessageType.Question) Then
            divQuestion.Attributes.Add("class", "ques_panel")
            divInnerQuestion.Attributes.Add("class", "panel-inner")
            Dim li As New HtmlGenericControl("li")
            li.Attributes.Add("class", "liststyle")

            'Dim icondiv As New HtmlGenericControl("div")
            'li.Controls.Add(icondiv)
            'icondiv.Attributes.Add("class", "icon")

            Dim img As New Image()
            'img.ImageUrl = GetIconType(msgType)
            img.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/ques.png")
            img.CssClass = "ques_tick"
            img.AlternateText = "question"

            'icondiv.Controls.Add(img)
            'Dim divMessage As New HtmlGenericControl("div")
            'divMessage.Attributes.Add("class", "InnerErroMessage")

            Dim MessageLabel As New Label()
            MessageLabel.Text = msg
            MessageLabel.CssClass = "error_message_text"

            'divMessage.Controls.Add(MessageLabel)
            'li.Controls.Add(divMessage)

            li.Controls.Add(img)
            li.Controls.Add(MessageLabel)
            Me.QuestionList.Controls.Add(li)
        End If

        'Exception
        If (msgType = Content.DisplayMessageType.Exception) Then
            divException.Attributes.Add("class", "ex_panel")
            divInnerException.Attributes.Add("class", "panel-inner")
            Dim li As New HtmlGenericControl("li")
            li.Attributes.Add("class", "liststyle")

            'Dim icondiv As New HtmlGenericControl("div")
            'li.Controls.Add(icondiv)
            'icondiv.Attributes.Add("class", "icon")

            Dim img As New Image()
            'img.ImageUrl = GetIconType(msgType)
            img.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/ex.png")
            img.CssClass = "ex_tick"
            img.AlternateText = "exception"


            'icondiv.Controls.Add(img)
            'Dim divMessage As New HtmlGenericControl("div")
            'divMessage.Attributes.Add("class", "InnerErroMessage")

            Dim MessageLabel As New Label()
            MessageLabel.Text = msg
            MessageLabel.CssClass = "error_message_text"

            'divMessage.Controls.Add(MessageLabel)
            'li.Controls.Add(divMessage)

            li.Controls.Add(img)
            li.Controls.Add(MessageLabel)
            Me.ExceptionList.Controls.Add(li)
        End If
    End Sub

    Public Sub ClearMessage() Implements IMessageBox.ClearMessage
        'divInnerInfo.InnerText = ""
        'divException.InnerHtml = ""
        'divError.InnerHtml = ""
        'divQuestion.InnerHtml = ""
        'dvSuccess.InnerHtml = ""
        'divWarning.InnerHtml = ""
        MessageList.Controls.Clear()
        WarningList.Controls.Clear()
        SuccessList.Controls.Clear()
        ErrorList.Controls.Clear()
        QuestionList.Controls.Clear()
        ExceptionList.Controls.Clear()
        Me.pnlMain.Visible = False
    End Sub

    Public Function GetIconType(ByVal msgType As Content.DisplayMessageType) As String
        Select Case msgType
            Case BVSoftware.Bvc5.Core.Content.DisplayMessageType.Error
                Return PersonalizationServices.GetThemedButton("MessageError")
            Case BVSoftware.Bvc5.Core.Content.DisplayMessageType.Exception
                Return PersonalizationServices.GetThemedButton("MessageException")
            Case BVSoftware.Bvc5.Core.Content.DisplayMessageType.Information
                Return PersonalizationServices.GetThemedButton("MessageInformation")
            Case BVSoftware.Bvc5.Core.Content.DisplayMessageType.Question
                Return PersonalizationServices.GetThemedButton("MessageQuestion")
            Case BVSoftware.Bvc5.Core.Content.DisplayMessageType.Success
                Return PersonalizationServices.GetThemedButton("MessageOk")
            Case BVSoftware.Bvc5.Core.Content.DisplayMessageType.Warning
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

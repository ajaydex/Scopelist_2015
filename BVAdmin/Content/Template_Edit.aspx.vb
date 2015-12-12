Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Content_Template_Edit
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Template"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub


    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        Me.MessageBox1.ClearMessage()

        Dim validationResults As Collection(Of Content.Templates.ParserMessage) = Content.Templates.TemplateParser.ValidateProductPageTemplate(Me.TemplateField.Text)
        If validationResults IsNot Nothing Then
            If validationResults.Count > 0 Then
                Dim sb As New StringBuilder
                For Each pm As Content.Templates.ParserMessage In validationResults
                    Select Case pm.MessageType
                        Case Content.Templates.ParserMessageType.Error
                            sb.Append("ERROR  : " & pm.MessageType & " LINE: " & pm.LineNumber & "<br />")
                        Case Content.Templates.ParserMessageType.Information
                            sb.Append("INFO   : " & pm.MessageType & " LINE: " & pm.LineNumber & "<br />")
                        Case Content.Templates.ParserMessageType.Warning
                            sb.Append("WARNING: " & pm.MessageType & " LINE: " & pm.LineNumber & "<br />")
                    End Select
                Next
                Me.MessageBox1.ShowInformation(sb.ToString())
            Else
                If Content.Templates.TemplateParser.GenerateProductPage(Me.TemplateField.Text) Then
                    Me.MessageBox1.ShowOk("Template Saved!")
                Else
                    Me.MessageBox1.ShowError("Unable to generate page. Unknown Error!")
                End If
            End If
        Else
            Me.MessageBox1.ShowError("Unable to validate. Unknown error.")
        End If

    End Sub

End Class

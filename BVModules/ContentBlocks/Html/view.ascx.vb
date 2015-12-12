Imports System.Collections.ObjectModel
Imports System.Linq

Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.Content


Partial Class BVModules_ContentBlocks_Html_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadText()
    End Sub

    Private Sub LoadText()
        Dim hideContent As Boolean = False

        If Me.SettingsManager.GetBooleanSetting("ShowHideByQueryString") Then
            Dim name As String = Me.SettingsManager.GetSetting("QueryStringName")
            Dim value As String = Me.SettingsManager.GetSetting("QueryStringValue")

            If String.IsNullOrEmpty(name) Then
                hideContent = Not Request.QueryString.GetValues(vbNullString)(0).ToLower().Contains(value.ToLower())
            Else
                hideContent = Not (String.Compare(Request.QueryString(name), value, True) = 0)
            End If

        End If

        If hideContent Then
            Me.Visible = False
        Else
            Me.HtmlContent.Text = Me.SettingsManager.GetSetting("HtmlData")
            If Me.SettingsManager.GetBooleanSetting("EnableScheduledContent") Then
                Dim now As DateTime = DateTime.Now
                Dim startDate As DateTime = DateTime.MinValue
                Dim endDate As DateTime = DateTime.MaxValue

                Dim tempDateTime As String = Me.SettingsManager.GetSetting("StartDateTime")
                If Not String.IsNullOrEmpty(tempDateTime) Then
                    Try
                        startDate = New DateTime(Long.Parse(tempDateTime))
                    Catch ex As Exception
                        ' use default MinValue
                    End Try
                End If

                tempDateTime = Me.SettingsManager.GetSetting("EndDateTime")
                If Not String.IsNullOrEmpty(tempDateTime) Then
                    Try
                        endDate = New DateTime(Long.Parse(tempDateTime))
                    Catch ex As Exception
                        ' use default MaxValue
                    End Try
                End If

                If now >= startDate AndAlso now <= endDate Then
                    Me.HtmlContent.Text = Me.SettingsManager.GetSetting("ScheduledHtmlData")
                End If
            End If

            If Me.SettingsManager.GetBooleanSetting("EnableReplacementTags") = True Then
                Me.HtmlContent.Text = EmailTemplateTag.ReplaceTags(Me.HtmlContent.Text, Me.ReplacementTags())
            End If

            If Not Me.SettingsManager.GetBooleanSetting("RemoveWrappingDiv") Then
                Me.HtmlContent.Text = String.Format("<div class=""block html"">{0}</div>", Me.HtmlContent.Text)
            End If
        End If
    End Sub

    Private Function ReplacementTags() As Collection(Of EmailTemplateTag)
        Dim result As New Collection(Of EmailTemplateTag)

        ' Site tags
        AddTags(New EmailTemplate().ReplacementTags(), result)

        ' User tags
        Dim u As Membership.UserAccount = SessionManager.GetCurrentUser()
        If u Is Nothing Then
            u = New Membership.UserAccount()
        End If
        AddTags(u.ReplacementTags(), result)

        Return result
    End Function

    Private Sub AddTags(ByVal source As Collection(Of EmailTemplateTag), ByVal destination As Collection(Of EmailTemplateTag))
        For Each t As EmailTemplateTag In source
            destination.Add(t)
        Next
    End Sub

End Class
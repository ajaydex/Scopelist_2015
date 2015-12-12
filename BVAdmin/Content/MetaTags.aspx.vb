Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Content_MetaTags
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = False Then
                Me.btnSave.Enabled = False
            End If
            Me.MetaKeywordsField.Text = WebAppSettings.MetaKeywords
            Me.MetaDescriptionField.Text = WebAppSettings.MetaDescription
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Meta Tags"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            MessageBox1.ShowOk("Meta Tags Saved Successfully.")
        Else
            MessageBox1.ShowError("Error Occurred While Saving. Please Check Event Log.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False
        WebAppSettings.MetaKeywords = Me.MetaKeywordsField.Text.Trim
        WebAppSettings.MetaDescription = Me.MetaDescriptionField.Text.Trim
        result = True
        Return result
    End Function

End Class

Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Images
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Images Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.save() = True Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If

            Me.ImagesMediumHeightField.Text = WebAppSettings.ImagesMediumHeight
            Me.ImagesMediumWidthField.Text = WebAppSettings.ImagesMediumWidth
            Me.ImagesSmallHeightField.Text = WebAppSettings.ImagesSmallHeight
            Me.ImagesSmallWidthField.Text = WebAppSettings.ImagesSmallWidth
            Me.ImageBrowser.Text = WebAppSettings.ImageBrowserDefaultDirectory
            Me.chkForceImageSizes.Checked = WebAppSettings.ForceImageSizes
            Me.chkHideCartImages.Checked = WebAppSettings.HideCartImages
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        WebAppSettings.ImagesMediumHeight = Integer.Parse(Me.ImagesMediumHeightField.Text)
        WebAppSettings.ImagesMediumWidth = Integer.Parse(Me.ImagesMediumWidthField.Text)
        WebAppSettings.ImagesSmallHeight = Integer.Parse(Me.ImagesSmallHeightField.Text)
        WebAppSettings.ImagesSmallWidth = Integer.Parse(Me.ImagesSmallWidthField.Text)
        WebAppSettings.ImageBrowserDefaultDirectory = Me.ImageBrowser.Text.Trim
        WebAppSettings.ForceImageSizes = Me.chkForceImageSizes.Checked
        WebAppSettings.HideCartImages = Me.chkHideCartImages.Checked
        result = True

        Return result
    End Function
End Class

Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Themes
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Theme Settings"
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
            LoadCurrentTheme()
        End If
    End Sub

    Private Sub LoadCurrentTheme()
        Me.ThemeField.DataSource = Content.ModuleController.FindThemes
        Me.ThemeField.DataBind()

        Dim currentTheme As String = WebAppSettings.ThemeName
        If ThemeField.Items.FindByValue(currentTheme) IsNot Nothing Then
            ThemeField.Items.FindByValue(currentTheme).Selected = True
            LoadPreview()
        End If
    End Sub

    Private Sub LoadPreview()
        Me.lnkAuthor.Text = String.Empty
        Me.lnkAuthor.NavigateUrl = String.Empty
        Me.lblTitle.Text = String.Empty
        Me.lblDescription.Text = String.Empty
        Me.lnkVersion.Text = String.Empty
        Me.lnkVersion.NavigateUrl = String.Empty

        Me.PreviewImage.ImageUrl = Content.ModuleController.FindThemePreviewImage(Me.ThemeField.SelectedValue, Request.PhysicalApplicationPath)
        Dim infoFilePath As String = Content.ModuleController.BuildThemeInfoPath(Me.ThemeField.SelectedValue, Request.PhysicalApplicationPath)
        Dim info As Content.ThemeInfo = Content.ThemeInfo.ReadFromXml(infoFilePath)
        If info IsNot Nothing Then
            Me.lnkAuthor.Text = info.Author
            Me.lnkAuthor.NavigateUrl = info.AuthorUrl
            Me.lblTitle.Text = info.Title
            Me.lblDescription.Text = info.Description
            Me.lnkVersion.Text = info.Version
            Me.lnkVersion.NavigateUrl = info.VersionUrl        
        End If

    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False
        WebAppSettings.ThemeName = Me.ThemeField.SelectedValue
        result = True
        Return result
    End Function

    Protected Sub ThemeField_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ThemeField.SelectedIndexChanged
        LoadPreview()
    End Sub
End Class

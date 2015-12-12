Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Categories
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Category Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.RegenerateDynamicCategoriesCheckBox.Checked = WebAppSettings.AutomaticallyRegenerateDynamicCategories
            Me.RegenerateIntervalTextBox.Text = WebAppSettings.AutomaticallyRegenerateDynamicCategoriesIntervalInHours
            Me.chkNewProductBadge.Checked = WebAppSettings.NewProductBadgeAllowed
            Me.txtNewProductBadgeDays.Text = WebAppSettings.NewProductBadgeDays
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        WebAppSettings.AutomaticallyRegenerateDynamicCategories = Me.RegenerateDynamicCategoriesCheckBox.Checked

        Dim val As Integer = 0
        If Integer.TryParse(RegenerateIntervalTextBox.Text, val) Then
            WebAppSettings.AutomaticallyRegenerateDynamicCategoriesIntervalInHours = val
        Else
            WebAppSettings.AutomaticallyRegenerateDynamicCategoriesIntervalInHours = 24
        End If

        WebAppSettings.NewProductBadgeAllowed = Me.chkNewProductBadge.Checked
        WebAppSettings.NewProductBadgeDays = Integer.Parse(Me.txtNewProductBadgeDays.Text)

        result = True

        Return result
    End Function


End Class

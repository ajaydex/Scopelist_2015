Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_AdminDisplay
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Admin Display Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If
            Me.HeaderMessage.Text = WebAppSettings.AdminHeaderMessage
            Me.TextEditorField.DataSource = Content.ModuleController.FindEditors
            Me.TextEditorField.DataBind()
            Me.ddlReportsDefaultPage.DataSource = Content.ModuleController.FindReports
            Me.ddlReportsDefaultPage.DataBind()
            Me.ddlReportsDefaultPage.SelectedValue = WebAppSettings.ReportsDefaultPage
            Me.chkStoreAdminLinksInNewWindow.Checked = WebAppSettings.StoreAdminLinksInNewWindow
            If Me.TextEditorField.Items.FindByValue(WebAppSettings.DefaultTextEditor) IsNot Nothing Then
                Me.TextEditorField.ClearSelection()
                Me.TextEditorField.Items.FindByValue(WebAppSettings.DefaultTextEditor).Selected = True
            End If
            Me.chkDisableAdminLights.Checked = WebAppSettings.DisableAdminLights
            Me.RowsPerPageTextBox.Text = WebAppSettings.RowsPerPage.ToString()
            Me.ProductLongDescriptionHeightTextBox.Text = WebAppSettings.ProductLongDescriptionEditorHeight
            Me.MaxCategoriesTextBox.Text = WebAppSettings.BreadCrumbTrailMaxEntries.ToString()
            Me.OrderNotesCheckBox.Checked = WebAppSettings.ReverseOrderNotes
            Me.DisplayEmptyTypePropertiesCheckBox.Checked = WebAppSettings.TypePropertiesDisplayEmptyProperties
            Me.KitDetailsCollapsedCheckBox.Checked = WebAppSettings.KitDisplayCollapsed
            Me.ddlProductTemplate.DataSource = Content.ModuleController.FindProductTemplates
            Me.ddlProductTemplate.DataBind()
            Me.ddlProductTemplate.SelectedValue = WebAppSettings.DefaultProductTemplate
            Me.ddlKitTemplate.DataSource = Content.ModuleController.FindKitTemplates
            Me.ddlKitTemplate.DataBind()
            Me.ddlKitTemplate.SelectedValue = WebAppSettings.DefaultKitTemplate
            Me.ddlCategoryTemplate.DataSource = Content.ModuleController.FindCategoryTemplates
            Me.ddlCategoryTemplate.DataBind()
            Me.ddlCategoryTemplate.SelectedValue = WebAppSettings.DefaultCategoryTemplate
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Page.IsValid Then
            If Me.Save() = True Then
                Me.MessageBox1.ShowOk("Settings saved successfully.")
            End If
        End If        
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False
        WebAppSettings.AdminHeaderMessage = HeaderMessage.Text.Trim()
        WebAppSettings.DefaultTextEditor = Me.TextEditorField.SelectedValue
        WebAppSettings.ReportsDefaultPage = Me.ddlReportsDefaultPage.SelectedValue
        WebAppSettings.StoreAdminLinksInNewWindow = Me.chkStoreAdminLinksInNewWindow.Checked
        WebAppSettings.DisableAdminLights = Me.chkDisableAdminLights.Checked
        WebAppSettings.RowsPerPage = Integer.Parse(Me.RowsPerPageTextBox.Text)
        WebAppSettings.ProductLongDescriptionEditorHeight = Integer.Parse(Me.ProductLongDescriptionHeightTextBox.Text)
        WebAppSettings.BreadCrumbTrailMaxEntries = Integer.Parse(Me.MaxCategoriesTextBox.Text)
        WebAppSettings.ReverseOrderNotes = Me.OrderNotesCheckBox.Checked
        WebAppSettings.TypePropertiesDisplayEmptyProperties = Me.DisplayEmptyTypePropertiesCheckBox.Checked
        WebAppSettings.KitDisplayCollapsed = Me.KitDetailsCollapsedCheckBox.Checked
        WebAppSettings.DefaultProductTemplate = Me.ddlProductTemplate.SelectedValue
        WebAppSettings.DefaultKitTemplate = Me.ddlKitTemplate.SelectedValue
        WebAppSettings.DefaultCategoryTemplate = Me.ddlCategoryTemplate.SelectedValue
        result = True

        Return result
    End Function

End Class

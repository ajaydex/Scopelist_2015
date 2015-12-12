Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Performance
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If
            'Me.chkDisableProductCaching.Checked = WebAppSettings.DisableProductCaching

            Me.chkUrlRewriteCategories.Checked = WebAppSettings.UrlRewriteCategories
            Me.UrlRewriteCategoriesPrefixField.Text = WebAppSettings.UrlRewriteCategoriesPrefix

            Me.chkUrlRewriteProducts.Checked = WebAppSettings.UrlRewriteProducts
            Me.UrlRewriteProductsPrefixField.Text = WebAppSettings.UrlRewriteProductsPrefix

            Me.chkMetricsRecordSearches.Checked = WebAppSettings.MetricsRecordSearches
            Me.SuggestedItemsMaxResultsField.Text = WebAppSettings.SuggestedItemsMaxResults
            Me.RVIMaxResults.Text = WebAppSettings.LastProductsViewedMaxResults
            'Me.MoveViewStateCheckBox.Checked = WebAppSettings.MoveViewstateToBottomOfPage
            Me.chkPerformanceAutoLoadProducts.Checked = WebAppSettings.PerformanceAutoLoadProductsList
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Performance Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        'WebAppSettings.DisableProductCaching = Me.chkDisableProductCaching.Checked

        WebAppSettings.UrlRewriteProducts = Me.chkUrlRewriteProducts.Checked
        WebAppSettings.UrlRewriteProductsPrefix = Me.UrlRewriteProductsPrefixField.Text.Trim

        WebAppSettings.UrlRewriteCategories = Me.chkUrlRewriteCategories.Checked
        WebAppSettings.UrlRewriteCategoriesPrefix = Me.UrlRewriteCategoriesPrefixField.Text.Trim
        WebAppSettings.MetricsRecordSearches = Me.chkMetricsRecordSearches.Checked
        WebAppSettings.SuggestedItemsMaxResults = Me.SuggestedItemsMaxResultsField.Text.Trim
        WebAppSettings.LastProductsViewedMaxResults = Me.RVIMaxResults.Text.Trim
        'WebAppSettings.MoveViewstateToBottomOfPage = Me.MoveViewStateCheckBox.Checked

        WebAppSettings.PerformanceAutoLoadProductsList = Me.chkPerformanceAutoLoadProducts.Checked
        result = True

        Return result
    End Function


End Class

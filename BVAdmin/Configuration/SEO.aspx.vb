Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_SEO
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If

            Me.SiteStandardRoot.Text = WebAppSettings.SiteStandardRoot
            Me.chkRedirectToPrimaryDomain.Checked = WebAppSettings.RedirectToPrimaryDomain
            Me.SiteHomePageFileNameField.Text = WebAppSettings.DefaultHomePage
            Me.chkUrlRewriteCategories.Checked = WebAppSettings.UrlRewriteCategories
            Me.UrlRewriteCategoriesPrefixField.Text = WebAppSettings.UrlRewriteCategoriesPrefix
            Me.chkUrlRewriteProducts.Checked = WebAppSettings.UrlRewriteProducts
            Me.UrlRewriteProductsPrefixField.Text = WebAppSettings.UrlRewriteProductsPrefix
            Me.chkCanonicalUrlEnabled.Checked = WebAppSettings.CanonicalUrlEnabled

            Me.chkFacebookOpenGraph.Checked = WebAppSettings.FacebookOpenGraphEnabled

            Me.chkMetaTitleAppendStoreName.Checked = WebAppSettings.MetaTitleAppendStoreName
            Me.txtHomepageMetaTitle.Text = WebAppSettings.HomepageMetaTitle
            Me.txtHomepageMetaDescritpion.Text = WebAppSettings.HomepageMetaDescription
            Me.txtHomepageMetaKeywords.Text = WebAppSettings.HomepageMetaKeywords
            Me.MetaKeywordsField.Text = WebAppSettings.MetaKeywords
            Me.MetaDescriptionField.Text = WebAppSettings.MetaDescription
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "SEO Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        WebAppSettings.SiteStandardRoot = Me.SiteStandardRoot.Text.Trim()
        WebAppSettings.RedirectToPrimaryDomain = Me.chkRedirectToPrimaryDomain.Checked
        ' automatically enable redirector when 'redirect to primary domain' is enabled
        If WebAppSettings.RedirectToPrimaryDomain Then
            WebAppSettings.RedirectorEnabled = True
        End If
        WebAppSettings.DefaultHomePage = Me.SiteHomePageFileNameField.Text.Trim()
        WebAppSettings.UrlRewriteProducts = Me.chkUrlRewriteProducts.Checked
        WebAppSettings.UrlRewriteProductsPrefix = Me.UrlRewriteProductsPrefixField.Text.Trim()
        WebAppSettings.UrlRewriteCategories = Me.chkUrlRewriteCategories.Checked
        WebAppSettings.UrlRewriteCategoriesPrefix = Me.UrlRewriteCategoriesPrefixField.Text.Trim
        WebAppSettings.CanonicalUrlEnabled = Me.chkCanonicalUrlEnabled.Checked

        WebAppSettings.FacebookOpenGraphEnabled = Me.chkFacebookOpenGraph.Checked

        WebAppSettings.MetaTitleAppendStoreName = Me.chkMetaTitleAppendStoreName.Checked
        WebAppSettings.HomepageMetaTitle = Me.txtHomepageMetaTitle.Text.Trim()
        WebAppSettings.HomepageMetaDescription = Me.txtHomepageMetaDescritpion.Text.Trim()
        WebAppSettings.HomepageMetaKeywords = Me.txtHomepageMetaKeywords.Text.Trim()
        WebAppSettings.MetaKeywords = Me.MetaKeywordsField.Text.Trim()
        WebAppSettings.MetaDescription = Me.MetaDescriptionField.Text.Trim()

        result = True

        Return result
    End Function


End Class
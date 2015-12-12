Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_ProductReviews
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Review Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'If Not Page.IsPostBack Then
        '    MetaKeywordsControl.Content = WebAppSettings.MetaKeywords
        '    MetaDescriptionControl.Content = WebAppSettings.MetaDescription

        'End If

        If Not Page.IsPostBack Then

            Me.chkProductReviewAllow.Checked = WebAppSettings.ProductReviewAllow
            Me.ProductReviewCountField.Text = WebAppSettings.ProductReviewCount
            Me.chkProductReviewModerate.Checked = WebAppSettings.ProductReviewModerate
            Me.chkProductReviewShow.Checked = WebAppSettings.ProductReviewShow
            Me.chkProductReviewShowKarma.Checked = WebAppSettings.ProductReviewShowKarma
            Me.chkProductReviewShowRating.Checked = WebAppSettings.ProductReviewShowRating
            Me.chkSendProductReviewNotificationEmail.Checked = WebAppSettings.SendProductReviewNotificationEmail

        End If
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        msg.ClearMessage()


        WebAppSettings.ProductReviewAllow = Me.chkProductReviewAllow.Checked
        WebAppSettings.ProductReviewCount = Me.ProductReviewCountField.Text.Trim
        WebAppSettings.ProductReviewModerate = Me.chkProductReviewModerate.Checked
        WebAppSettings.ProductReviewShow = Me.chkProductReviewShow.Checked
        WebAppSettings.ProductReviewShowKarma = Me.chkProductReviewShowKarma.Checked
        WebAppSettings.ProductReviewShowRating = Me.chkProductReviewShowRating.Checked
        WebAppSettings.SendProductReviewNotificationEmail = Me.chkSendProductReviewNotificationEmail.Checked

        Me.msg.ShowOk("Settings saved successfully.")

    End Sub


End Class

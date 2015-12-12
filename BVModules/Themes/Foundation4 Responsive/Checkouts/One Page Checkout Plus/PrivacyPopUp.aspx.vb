Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Checkouts_One_Page_Checkout_Plus_PrivacyPopUp
    Inherits BaseStorePage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Popup.master")
    End Sub

    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        PageTitle = Content.SiteTerms.GetTerm("PrivacyPolicy")
        If Not Page.IsPostBack Then
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("PrivacyPolicy")

            Dim policy As Content.Policy = Content.Policy.FindByBvin(WebAppSettings.PrivacyPolicy)
            For Each block As Content.PolicyBlock In policy.Blocks
                privacyInfo.InnerHtml += block.Description
            Next

        End If

    End Sub

End Class

Imports BVSoftware.BVC5.Core

Partial Class Terms
    Inherits BaseStorePage


    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Popup.master")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        PageTitle = Content.SiteTerms.GetTerm("AffiliateTermsAndConditions")
        If Not Page.IsPostBack Then
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("AffiliateTermsAndConditions")

            Dim policy As Content.Policy = Content.Policy.FindByBvin(WebAppSettings.AffiliateTermsAndConditionsPolicy)
            For Each block As Content.PolicyBlock In policy.Blocks
                termsInfo.InnerHtml += block.Description
            Next
        End If
    End Sub
End Class

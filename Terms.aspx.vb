Imports BVSoftware.BVC5.Core

Partial Class Terms
    Inherits BaseStorePage


    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Service.master")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Me.ManualBreadCrumbTrail1.ClearTrail()
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("CustomerService"), "~/ContactUs.aspx")
        Me.ManualBreadCrumbTrail1.AddNonLink(Content.SiteTerms.GetTerm("TermsAndConditions"))

        PageTitle = Content.SiteTerms.GetTerm("TermsandConditions")
        If Not Page.IsPostBack Then
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("TermsandConditions")

            Dim policy As Content.Policy = Content.Policy.FindByBvin(WebAppSettings.TermsAndConditionsPolicy)
            For Each block As Content.PolicyBlock In policy.Blocks
                termsInfo.InnerHtml += block.Description
            Next

        End If

    End Sub


End Class

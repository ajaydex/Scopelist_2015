Imports BVSoftware.BVC5.Core

Partial Class Privacy
    Inherits BaseStorePage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Service.master")
    End Sub

    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Me.ManualBreadCrumbTrail1.ClearTrail()
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("CustomerService"), "~/ContactUs.aspx")
        Me.ManualBreadCrumbTrail1.AddNonLink(Content.SiteTerms.GetTerm("PrivacyPolicy"))

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

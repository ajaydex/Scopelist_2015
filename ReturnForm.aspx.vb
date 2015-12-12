Imports BVSoftware.BVC5.Core

Partial Class ReturnForm
    Inherits BaseStorePage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Service.master")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Me.ManualBreadCrumbTrail1.ClearTrail()
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("CustomerService"), "~/ContactUs.aspx")
        Me.ManualBreadCrumbTrail1.AddNonLink(Content.SiteTerms.GetTerm("ReturnPolicy"))


        PageTitle = Content.SiteTerms.GetTerm("ReturnPolicy")
        If Not Page.IsPostBack Then
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("ReturnPolicy")

            Dim policy As Content.Policy = Content.Policy.FindByBvin(WebAppSettings.ReturnPolicy)
            For Each block As Content.PolicyBlock In policy.Blocks
                returnInfo.InnerHtml += block.Description
            Next

        End If

    End Sub

End Class

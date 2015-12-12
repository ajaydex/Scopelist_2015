Imports BVSoftware.BVC5.Core

Partial Class FAQ
    Inherits BaseStorePage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Service.master")
    End Sub

    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Me.ManualBreadCrumbTrail1.ClearTrail()
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("CustomerService"), "~/ContactUs.aspx")
        Me.ManualBreadCrumbTrail1.AddNonLink(Content.SiteTerms.GetTerm("FAQ"))
        PageTitle = Content.SiteTerms.GetTerm("FAQ")
        If Not Page.IsPostBack Then
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("FAQ")
            LoadPolicies()
        End If
    End Sub

    Sub LoadPolicies()
        Try
            Dim p As Content.Policy = Content.Policy.FindByBvin(WebAppSettings.FAQPolicy)
            If p IsNot Nothing Then
                dlPolicy.DataSource = p.Blocks
                dlPolicy.DataBind()
                dlQuestions.DataSource = p.Blocks
                dlQuestions.DataBind()
            End If

        Catch Ex As Exception
            msg.Visible = True
            msg.ShowException(Ex)
        End Try
    End Sub

End Class

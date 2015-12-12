Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_SiteTermsAgreement
    Inherits System.Web.UI.UserControl

    Public Property IsValid() As Boolean
        Get
            If WebAppSettings.DisplaySiteTermsToCustomerUponCheckout Then
                Return AgreeToTermsCheckBox.Checked
            Else
                Return True
            End If
        End Get
        Set(ByVal value As Boolean)
            AgreeToTermsCheckBox.Checked = value
        End Set
    End Property

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If WebAppSettings.DisplaySiteTermsToCustomerUponCheckout Then
            Me.Visible = True
            AgreeLiteral.Text = Content.SiteTerms.GetTerm("TermsAndConditionsAgreement")
            ViewSiteTermsLiteral.Text = Content.SiteTerms.GetTerm("TermsAndConditions")
            ShippingHyperLink.Attributes.Add("onclick", "javascript:window.open('" & Page.ResolveUrl("~/TermsPopUp.aspx") & "','Policy','width=400, height=500, menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no')")
            ShippingHyperLink.NavigateUrl = "javascript:void(0);"
        Else
            Me.Visible = False
        End If
    End Sub
End Class

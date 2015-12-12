Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_EstimateShipping
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Me.imgGetRates.ImageUrl = PersonalizationServices.GetThemedButton("ShippingRates")
            Me.imgGetRates.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-shipping.png")
        End If

        Dim w As Integer = 400
        Dim h As Integer = 600

        Me.GetRatesLink.Style.Add("CURSOR", "pointer")
        Me.GetRatesLink.Attributes.Add("onclick", "JavaScript:window.open('" & Page.ResolveClientUrl("~/EstimateShipping.aspx") & "','Images','width=" & w & ", height=" & h & ", menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no')")

    End Sub

End Class

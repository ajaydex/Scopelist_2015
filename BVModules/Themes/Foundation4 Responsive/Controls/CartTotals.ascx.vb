Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_CartTotals
    Inherits System.Web.UI.UserControl

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        Me.litCart.Text = Content.SiteTerms.GetTerm("ViewCart")

        If SessionManager.CurrentCartID = String.Empty Then
            Me.lblItemCount.Text = "(0)"
            Me.lblSubTotal.Text = String.Format("{0:c}", 0)
        Else
            Me.lblItemCount.Text = SessionManager.CurrentShoppingCart.TotalQuantity.ToString("(0)")
            Me.lblSubTotal.Text = String.Format("{0:c}", SessionManager.CurrentShoppingCart.SubTotal)
        End If
    End Sub
End Class

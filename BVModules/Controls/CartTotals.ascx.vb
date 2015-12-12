Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_CartTotals
    Inherits System.Web.UI.UserControl

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If SessionManager.CurrentCartID = String.Empty Then
            lblItemCount.Text = 0 & " " & Content.SiteTerms.GetTerm("Products")
            lblSubTotal.Text = String.Format("{0:c}", 0)
        Else
            If SessionManager.CurrentShoppingCart.TotalQuantity > 1 OrElse SessionManager.CurrentShoppingCart.TotalQuantity = 0 Then
                lblItemCount.Text = SessionManager.CurrentShoppingCart.TotalQuantity.ToString("0") & " " & Content.SiteTerms.GetTerm("Products")
            Else
                lblItemCount.Text = SessionManager.CurrentShoppingCart.TotalQuantity.ToString("0") & " " & Content.SiteTerms.GetTerm("Product")
            End If

            lblSubTotal.Text = String.Format("{0:c}", SessionManager.CurrentShoppingCart.SubTotal)
        End If
    End Sub
End Class

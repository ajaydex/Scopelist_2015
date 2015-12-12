Imports Microsoft.VisualBasic

Public Class BaseStoreCheckoutPage
    Inherits BaseStorePage

    Private Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit        
        If Request.RawUrl.ToLower().Contains("bvmodules/checkouts") AndAlso Request.QueryString("Anthem_Callback") Is Nothing Then
            Response.Redirect("~/default.aspx")
        End If
    End Sub

End Class
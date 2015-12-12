
Partial Class BVAdmin_Controls_OrderDetailsButtons
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Init
        Me.EnableViewState = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim bvin As String = Request.QueryString("id")
        If String.IsNullOrEmpty(bvin) Then
            Me.Visible = False
        Else
            Dim currentUrl As String = Request.Url.AbsolutePath.ToLower()
            
            Me.lnkDetails.NavigateUrl = String.Format("~/BVAdmin/Orders/ViewOrder.aspx?id={0}", bvin)
            Me.lnkDetails.Enabled = (Not currentUrl.EndsWith("vieworder.aspx"))

            Me.lnkPayment.NavigateUrl = String.Format("~/BVAdmin/Orders/ReceivePayments.aspx?id={0}", bvin)
            Me.lnkPayment.Enabled = (Not currentUrl.EndsWith("receivepayments.aspx"))

            Me.lnkShipping.NavigateUrl = String.Format("~/BVAdmin/Orders/ShipOrder.aspx?id={0}", bvin)
            Me.lnkShipping.Enabled = (Not currentUrl.EndsWith("shiporder.aspx"))

            Me.lnkEdit.NavigateUrl = String.Format("~/BVAdmin/Orders/EditOrder.aspx?id={0}", bvin)
            Me.lnkEdit.Enabled = (Not currentUrl.EndsWith("editorder.aspx"))

            Me.lnkPrint.NavigateUrl = String.Format("~/BVAdmin/Orders/PrintOrder.aspx?id={0}", bvin)
            Me.lnkPrint.Enabled = (Not currentUrl.EndsWith("printorder.aspx"))

            Me.lnkOrderManager.NavigateUrl = "~/BVAdmin/Orders/Default.aspx"
            Me.lnkOrderManager.Enabled = (Not currentUrl.EndsWith("default.aspx"))
        End If
    End Sub

End Class
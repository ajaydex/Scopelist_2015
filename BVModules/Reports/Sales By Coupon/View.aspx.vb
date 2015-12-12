Imports BVSoftware.Bvc5.Core
Imports System.Data
Imports System.Collections.ObjectModel


Partial Class BVAdmin_Reports_Coupons
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Sales By Coupon"
        Me.CurrentTab = AdminTabType.Reports
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ReportsView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not Page.IsPostBack() Then
            DateRangeField.RangeType = BVSoftware.Bvc5.Core.Utilities.DateRangeType.ThisMonth
            LoadCouponCodes()
            FillList()
        End If

    End Sub

    Private Sub btnShow_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShow.Click
        dgList.CurrentPageIndex = 0
        FillList()
    End Sub

    Sub LoadCouponCodes()

        Dim Coupons As New Collection(Of Marketing.Offer)
        Coupons = Marketing.Offer.GetAllOffers

        Dim iCounter As Integer = 0
        For iCounter = 0 To Coupons.Count() - 1
            If Coupons(iCounter).PromotionalCode.ToString.Length() > 0 Then
                Dim li As New ListItem
                li.Text = Coupons(iCounter).PromotionalCode & " - " & Coupons(iCounter).Name
                li.Value = Coupons(iCounter).PromotionalCode
                lstCouponCode.Items.Add(li)
                li = Nothing
            End If
        Next

        If lstCouponCode.Items.Count < 1 Then
            msg.ShowInformation("No coupon codes were found.")
            lstCouponCode.Items.Add("No coupon codes found.")
            Me.btnShow.Visible = False
        End If
    End Sub

    Sub FillList()
        msg.ClearMessage()
        Try
            If lstCouponCode.Items.Count() > 0 Then
                Dim dtOrders As Collection(Of Orders.Order) = Orders.Order.FindByCouponCode(lstCouponCode.SelectedItem.Value, DateRangeField.StartDate, DateRangeField.EndDate)
                dgList.DataSource = dtOrders
                dgList.DataBind()

                Dim orderTotal As Decimal = 0
                For i As Integer = 0 To dtOrders.Count - 1
                    orderTotal += dtOrders(i).SubTotal - dtOrders(i).OrderDiscounts	'dtOrders(i).GrandTotal
                Next

                If dtOrders.Count > 0 Then
                    lblResponse.Text = dtOrders.Count & " Orders Found: Totaling " & String.Format("{0:c}", orderTotal)
                Else
                    lblResponse.Text = "No Orders Found"
                End If
            Else
                lblResponse.Text = "No coupons were found."
            End If
        Catch Ex As Exception
            msg.ShowException(Ex)
        End Try

    End Sub

    Sub dgList_edit(ByVal sender As Object, ByVal e As DataGridCommandEventArgs) Handles dgList.EditCommand
        Response.Redirect("../Orders/Details.aspx?id=" & dgList.DataKeys(e.Item.ItemIndex), True)
    End Sub

    Sub dgList_PageIndexChanged(ByVal sender As Object, ByVal e As DataGridPageChangedEventArgs) Handles dgList.PageIndexChanged
        dgList.CurrentPageIndex = e.NewPageIndex
        FillList()
    End Sub

    Private Sub dgList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgList.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
            Dim litSubTotal As System.Web.UI.WebControls.Literal = e.Item.FindControl("litSubTotal")
            litSubTotal.Text = (Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "SubTotal")) - Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "OrderDiscounts"))).ToString("C")
        End If
    End Sub

End Class

Imports BVSoftware.Bvc5.Core
Imports System.Data
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Reports_Sales_Day
    Inherits BaseAdminPage

    Private TotalDiscounts As Decimal = 0
    Private TotalSub As Decimal = 0
    Private TotalShip As Decimal = 0
    Private TotalHandling As Decimal = 0
    Private TotalTax As Decimal = 0
    Private TotalGrand As Decimal = 0

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Daily Sales"
        Me.CurrentTab = AdminTabType.Reports
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ReportsView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Reports
            SetUserControlValues()
            FillList(Me.DatePicker.SelectedDate)
        End If
    End Sub

    Private Sub btnLast_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnLast.Click
        Me.DatePicker.SelectedDate = Me.DatePicker.SelectedDate.AddDays(-1)
        FillList(Me.DatePicker.SelectedDate)
    End Sub

    Private Sub btnNext_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNext.Click
        Me.DatePicker.SelectedDate = Me.DatePicker.SelectedDate.AddDays(1)
        FillList(Me.DatePicker.SelectedDate)
    End Sub

    Private Sub btnShow_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShow.Click
        dgList.CurrentPageIndex = 0
        FillList(Me.DatePicker.SelectedDate)
    End Sub

    Sub FillList(ByVal d As Date)
        msg.ClearMessage()

        Try
            TotalDiscounts = 0
            TotalSub = 0
            TotalShip = 0
            TotalHandling = 0
            TotalTax = 0
            TotalGrand = 0

            Dim c As New Orders.OrderSearchCriteria
            c.IsPlaced = True
            c.StartDate = Me.DatePicker.SelectedDate
            c.EndDate = Me.DatePicker.SelectedDate.AddDays(1)
            'c.PaymentStatus = Orders.OrderPaymentStatus.Paid    ' uncomment to only include paid orders

            Dim dtOrders As Collection(Of Orders.Order) = Orders.Order.FindByCriteria(c)

            dgList.DataSource = dtOrders
            dgList.DataBind()
            lblResponse.Text = dtOrders.Count & " Orders Found"

        Catch Ex As Exception
            msg.ShowException(Ex)
        End Try

    End Sub

    Sub SetUserControlValues()
        Dim sDate As String = ""
        If Request.Params("date") <> Nothing Then
            sDate = Request.Params("date")
            Me.DatePicker.SelectedDate = Date.Parse(sDate)
        Else
            Me.DatePicker.SelectedDate = DateTime.Now
        End If

    End Sub

    Private Sub dgList_PageIndexChanged(ByVal sender As Object, ByVal e As DataGridPageChangedEventArgs) Handles dgList.PageIndexChanged
        dgList.CurrentPageIndex = e.NewPageIndex
        FillList(Me.DatePicker.SelectedDate)
    End Sub

    Private Sub dgList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgList.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then

            Dim _Discounts As Decimal = 0
            Dim _Sub As Decimal = 0
            Dim _Ship As Decimal = 0
            Dim _Handling As Decimal = 0
            Dim _Tax As Decimal = 0
            Dim _Grand As Decimal = 0

            _Discounts = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "OrderDiscounts"))
            _Sub = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "SubTotal"))
            _Tax = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "TaxTotal"))
            _Handling = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "HandlingTotal"))
            _Ship = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "ShippingTotal"))
            _Grand = Convert.ToDecimal(DataBinder.Eval(e.Item.DataItem, "GrandTotal"))

            Me.TotalGrand += _Grand
            Me.TotalHandling += _Handling
            Me.TotalShip += _Ship
            Me.TotalSub += _Sub
            Me.TotalTax += _Tax
            Me.TotalDiscounts += _Discounts
        Else
            If e.Item.ItemType = ListItemType.Footer Then
                e.Item.Cells(0).Text = "Totals:"
                e.Item.Cells(1).Text = String.Format("{0:C}", TotalSub)
                e.Item.Cells(2).Text = String.Format("{0:C}", TotalDiscounts)
                e.Item.Cells(3).Text = String.Format("{0:C}", TotalShip)
                e.Item.Cells(4).Text = String.Format("{0:C}", TotalHandling)
                e.Item.Cells(5).Text = String.Format("{0:C}", TotalTax)
                e.Item.Cells(6).Text = String.Format("{0:C}", TotalGrand)
            End If
        End If
    End Sub

    Protected Sub DatePicker_DateChanged(ByVal sender As Object, ByVal e As BVSoftware.Bvc5.Core.Content.BVModuleEventArgs) Handles DatePicker.DateChanged
        FillList(Me.DatePicker.SelectedDate)
    End Sub
End Class

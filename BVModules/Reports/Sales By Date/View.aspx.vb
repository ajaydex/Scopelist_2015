Imports BVSoftware.Bvc5.Core
Imports System.Data
Imports System.Collections.ObjectModel


Partial Class BVAdmin_Reports_Default
    Inherits BaseAdminPage

    Private TotalDiscounts As Decimal = 0
    Private TotalSub As Decimal = 0
    Private TotalShip As Decimal = 0
    Private TotalHandling As Decimal = 0
    Private TotalTax As Decimal = 0
    Private TotalGrand As Decimal = 0
    Private TotalCount As Integer = 0

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Reports"
        Me.CurrentTab = AdminTabType.Reports
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ReportsView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack() Then
            FillList()
            SetImageURL(Date.Today.Month, Date.Today.Year)
        End If

    End Sub

    Private Sub btnShow_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShow.Click
        dgList.CurrentPageIndex = 0
        FillList()
        Dim sDate As String = Me.DateRangeField.StartDate
        Dim eDate As String = Me.DateRangeField.EndDate
        SetImageURL(sDate, eDate)
    End Sub

    Sub FillList()

        Try

            TotalDiscounts = 0
            TotalSub = 0
            TotalShip = 0
            TotalHandling = 0
            TotalTax = 0
            TotalGrand = 0
            TotalCount = 0

            Dim c As New Orders.OrderSearchCriteria
            c.IsPlaced = True
            'c.PaymentStatus = Orders.OrderPaymentStatus.Paid    ' uncomment to only include paid orders
            c.StartDate = Me.DateRangeField.StartDate
            c.EndDate = Me.DateRangeField.EndDate

            Dim found As New Collection(Of Orders.Order)
            found = Orders.Order.FindByCriteria(c)

            TotalCount = found.Count

            For Each o As Orders.Order In found
                TotalDiscounts += o.OrderDiscounts
                TotalSub += o.SubTotal
                TotalShip += o.ShippingTotal
                TotalHandling += o.HandlingTotal
                TotalTax += o.TaxTotal + o.TaxTotal2
                TotalGrand += o.GrandTotal
            Next

            Dim i As Integer = 0
            Dim month As String = String.Empty
            Dim monthTotal As Decimal = 0D
            Dim dayTotal As Decimal = 0D
            Dim day As String = String.Empty
            If found.Count > 0 Then
                month = found(0).TimeOfOrder.Month.ToString() + ":" + found(0).TimeOfOrder.Year.ToString()
                day = found(0).TimeOfOrder.DayOfYear.ToString() + ":" + found(0).TimeOfOrder.Year.ToString()
                While i <= found.Count - 1
                    monthTotal = monthTotal + found(i).GrandTotal
                    dayTotal = dayTotal + found(i).GrandTotal
                    If found(i).TimeOfOrder.DayOfYear.ToString() + ":" + found(i).TimeOfOrder.Year.ToString() <> day Then
                        day = found(i).TimeOfOrder.DayOfYear.ToString() + ":" + found(i).TimeOfOrder.Year.ToString()
                        ' we need to insert a day total
                        Dim order As New Orders.Order()
                        order.OrderNumber = "DayTotal"
                        'order.TimeOfOrder = found(i).TimeOfOrder.Date
                        order.GrandTotal = (dayTotal - found(i).GrandTotal)
                        dayTotal = found(i).GrandTotal
                        found.Insert(i, order)
                        i += 1
                    End If

                    If found(i).TimeOfOrder.Month.ToString() + ":" + found(i).TimeOfOrder.Year.ToString() <> month Then
                        month = found(i).TimeOfOrder.Month.ToString() + ":" + found(i).TimeOfOrder.Year.ToString()
                        ' we need to insert a month total
                        Dim order As New Orders.Order()
                        order.OrderNumber = "MonthTotal"
                        order.GrandTotal = (monthTotal - found(i).GrandTotal)
                        monthTotal = found(i).GrandTotal
                        found.Insert(i, order)
                        i += 1
                    End If                    
                    i += 1
                End While
                If dayTotal > 0 Then
                    ' we need to insert a day total
                    Dim order As New Orders.Order()
                    order.OrderNumber = "DayTotal"
                    order.GrandTotal = dayTotal                    
                    found.Add(order)                    
                End If
                If monthTotal > 0 Then
                    Dim order As New Orders.Order()
                    order.OrderNumber = "MonthTotal"
                    order.GrandTotal = monthTotal                    
                    found.Add(order)
                End If
            End If
            lblResponse.Text = "<b>" & TotalCount & "</b>"
            lblResponse.Text += " Orders Totaling <b>"
            lblResponse.Text += String.Format("{0:c}", TotalGrand)
            lblResponse.Text += "</b>"

            dgList.DataSource = found
            dgList.DataBind()

        Catch Ex As Exception
            msg.ShowException(Ex)
            EventLog.LogEvent(Ex)
        End Try

    End Sub

    Sub SetImageURL(ByVal sMonth As String, ByVal sYear As String)
        Dim sURL As String
        sURL = "reports_sales_graph.aspx?"
        sURL += "DateCode="
        If sMonth.Length < 2 Then
            sURL += "0"
        End If
        sURL += sMonth & sYear
        'imgGraph.ImageUrl = sURL
        sURL = Nothing
    End Sub

    Private Sub dgList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgList.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim order As Orders.Order = DirectCast(e.Item.DataItem, Orders.Order)

            If order.OrderNumber = "DayTotal" Then
                Dim theDate As DateTime = Convert.ToDateTime(dgList.DataKeys(e.Item.ItemIndex - 1)).Date

                Dim cell As New TableCell()
                cell.CssClass = "rowheader"
                cell.ColumnSpan = e.Item.Cells.Count
                cell.Text = "<a href=""../Daily Sales/view.aspx?Date=" + HttpUtility.UrlEncode(theDate.ToShortDateString()) + """>Day Total</a>: " + String.Format("{0:c}", order.GrandTotal)
                e.Item.Cells.Clear()
                e.Item.Cells.Add(cell)
                e.Item.ControlStyle.CssClass = "separator"
            ElseIf order.OrderNumber = "MonthTotal" Then
                Dim cell As New TableCell()
                cell.ColumnSpan = e.Item.Cells.Count
                cell.Text = "Month Total: " + String.Format("{0:c}", order.GrandTotal)
                e.Item.Cells.Clear()
                e.Item.Cells.Add(cell)
                e.Item.ControlStyle.CssClass = "separator"
            End If
        End If

        If e.Item.ItemType = ListItemType.Footer Then
            e.Item.Cells(0).Text = "Totals:"
            e.Item.Cells(2).Text = String.Format("{0:C}", TotalSub)
            e.Item.Cells(3).Text = String.Format("{0:C}", TotalDiscounts)
            e.Item.Cells(4).Text = String.Format("{0:C}", TotalShip)
            e.Item.Cells(5).Text = String.Format("{0:C}", TotalHandling)
            e.Item.Cells(6).Text = String.Format("{0:C}", TotalTax)
            e.Item.Cells(7).Text = String.Format("{0:C}", TotalGrand)
        End If

    End Sub

    Protected Sub DateRangeField_RangeTypeChanged(ByVal e As System.EventArgs) Handles DateRangeField.RangeTypeChanged
        If DateRangeField.RangeType <> Utilities.DateRangeType.Custom Then
            FillList()
        End If
    End Sub

End Class

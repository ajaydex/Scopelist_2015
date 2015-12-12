Imports System.Data
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Reports_Sales_By_Sales_Person_View
    Inherits BaseAdminPage

    Dim totalOrderCount As Integer = 0
    Dim totalItemCount As Integer = 0
    Dim totalSalesAmount As Decimal = 0D
    Dim avgAvgOrderValue As Decimal = 0D

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.CurrentTab = AdminTabType.Reports
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ReportsView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack() Then
            Me.ucDateRangeField.RangeType = Utilities.DateRangeType.ThisMonth
            LoadSalesPeople()
        End If
    End Sub

    Private Sub LoadSalesPeople()
        Me.ddlSalesPerson.DataSource = Membership.UserAccount.FindAllSalesPeople()
        Me.ddlSalesPerson.AppendDataBoundItems = True
        Me.ddlSalesPerson.Items.Add(New ListItem("- All -", ""))
        Me.ddlSalesPerson.DataValueField = "bvin"
        Me.ddlSalesPerson.DataTextField = "UserName"
        Me.ddlSalesPerson.DataBind()
    End Sub

    Private Sub btnShow_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShow.Click
        LoadData()
    End Sub

    Private Sub LoadData()
        Me.ucMessageBox.ClearMessage()

        Dim request As New Datalayer.DataRequest()
        request.Transactional = False
        request.CommandType = CommandType.Text
        request.AddParameter("@StartDate", Me.ucDateRangeField.StartDate)
        request.AddParameter("@EndDate", Me.ucDateRangeField.EndDate)
        If String.IsNullOrEmpty(Me.ddlSalesPerson.SelectedValue) Then
            request.AddParameter("@SalesPersonId", DBNull.Value)
        Else
            request.AddParameter("@SalesPersonId", Me.ddlSalesPerson.SelectedValue)
        End If

        ' XML literal hack to allow 'clean' multi-line strings in VB.NET
        request.Command = <![CDATA[
            SELECT 
	            report.*, 
	            u.UserName, 
	            u.Email, 
	            u.FirstName, 
	            u.LastName,
	            CASE WHEN u.bvin IS NULL THEN 1 ELSE 0 END AS DeletedUser
            FROM (
	            SELECT
		            SalesPersonId,
		            COUNT(*) AS Orders,
		            SUM(li.OrderItems) AS Items,
		            SUM(SubTotal - OrderDiscounts) AS Amount
	            FROM bvc_Order AS o
	            INNER JOIN (
		            SELECT OrderBvin, SUM(Quantity) AS OrderItems
		            FROM bvc_LineItem
		            GROUP BY OrderBvin
	            ) AS li ON li.OrderBvin = o.Bvin
	            WHERE
		            IsPlaced = 1
		            AND SalesPersonId <> ''
		            AND (@SalesPersonId IS NULL OR SalesPersonId = @SalesPersonId)
		            AND (@StartDate IS NULL OR o.TimeOfOrder >= @StartDate) 
		            AND (@EndDate IS NULL OR o.TimeOfOrder <= @EndDate)
	            GROUP BY SalesPersonId
            ) AS report
            LEFT JOIN bvc_User AS u ON u.bvin = SalesPersonId
        ]]>.Value

        Dim ds As DataSet = Datalayer.SqlDataHelper.ExecuteDataSet(request)
        If ds.Tables.Count > 0 Then
            Me.rpReport.DataSource = ds.Tables(0)
            Me.rpReport.DataBind()

            ' auto-load selected sales person orders
            If ds.Tables(0).Rows.Count = 1 Then
                For Each item As RepeaterItem In rpReport.Items
                    If item.ItemType = ListItemType.Item OrElse item.ItemType = ListItemType.AlternatingItem Then
                        Dim viewLink As Anthem.LinkButton = CType(item.FindControl("viewLink"), Anthem.LinkButton)
                        If viewLink IsNot Nothing Then
                            Dim args As New CommandEventArgs(viewLink.CommandName, viewLink.CommandArgument)
                            Dim e As New RepeaterCommandEventArgs(item, viewLink, args)
                            rpReport_ItemCommand(viewLink, e)
                        End If
                    End If
                Next
            End If

            If ds.Tables(0).Rows.Count > 0 Then
                Me.lblResults.Text = String.Format("{0} Sales People were found.", ds.Tables(0).Rows.Count.ToString())
            Else
                Me.lblResults.Text = "No Sales People were found or the server timed out."
            End If
        End If
    End Sub

    Protected Sub rpReport_RowDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles rpReport.ItemDataBound
        Select Case e.Item.ItemType
            Case ListItemType.Item, ListItemType.AlternatingItem
                Dim trSalesPersonSummary As HtmlTableRow = CType(e.Item.FindControl("trSalesPersonSummary"), HtmlTableRow)
                trSalesPersonSummary.Attributes("class") = If(e.Item.ItemIndex Mod 2 = 0, "row", "alternaterow")

                Dim trSalesPersonOrders As HtmlTableRow = CType(e.Item.FindControl("trSalesPersonOrders"), HtmlTableRow)
                trSalesPersonOrders.Attributes("class") = If(e.Item.ItemIndex Mod 2 = 0, "row toggleRow", "alternaterow toggleRow")
                trSalesPersonOrders.Visible = False

                Dim dr As DataRowView = CType(e.Item.DataItem, DataRowView)
                If dr IsNot Nothing Then
                    Dim lblSalesPerson As Label = CType(e.Item.FindControl("lblSalesPerson"), Label)
                    If lblSalesPerson IsNot Nothing Then
                        If dr("DeletedUser").ToString() = "1" Then
                            lblSalesPerson.Text = "[DELETED USER]"
                        Else
                            lblSalesPerson.Text = dr("FirstName").ToString() + " " + dr("LastName").ToString()
                            lblSalesPerson.ToolTip = dr("UserName").ToString()
                        End If
                    End If

                    Dim orderCount As Integer = 0
                    Dim lblOrderCount As Label = CType(e.Item.FindControl("lblOrderCount"), Label)
                    If lblOrderCount IsNot Nothing Then
                        orderCount = Convert.ToInt32(dr("Orders"))
                        lblOrderCount.Text = orderCount.ToString("N0")
                    End If

                    Dim itemCount As Integer = Convert.ToInt32(dr("Items"))
                    Dim lblItemCount As Label = CType(e.Item.FindControl("lblItemCount"), Label)
                    If lblItemCount IsNot Nothing Then
                        lblItemCount.Text = itemCount.ToString("N0")
                    End If

                    Dim salesAmount As Decimal = 0D
                    Dim lblSalesAmount As Label = CType(e.Item.FindControl("lblSalesAmount"), Label)
                    If lblSalesAmount IsNot Nothing Then
                        salesAmount = Convert.ToDecimal(dr("Amount"))
                        lblSalesAmount.Text = salesAmount.ToString("c")
                    End If

                    Dim lblAvgOrderValue As Label = CType(e.Item.FindControl("lblAvgOrderValue"), Label)
                    If lblAvgOrderValue IsNot Nothing Then
                        lblAvgOrderValue.Text = (salesAmount / Convert.ToDecimal(orderCount)).ToString("c")
                    End If

                    ' add up totals
                    totalOrderCount += orderCount
                    totalItemCount += itemCount
                    totalSalesAmount += salesAmount

                    Dim viewLink As Anthem.LinkButton = CType(e.Item.FindControl("viewLink"), Anthem.LinkButton)
                    viewLink.CommandArgument = dr("SalesPersonId")
                End If

            Case ListItemType.Footer
                Dim lblTotalOrderCount As Label = CType(e.Item.FindControl("lblTotalOrderCount"), Label)
                If lblTotalOrderCount IsNot Nothing Then
                    lblTotalOrderCount.Text = totalOrderCount.ToString("N0")
                End If

                Dim lblTotalItemCount As Label = CType(e.Item.FindControl("lblTotalItemCount"), Label)
                If lblTotalItemCount IsNot Nothing Then
                    lblTotalItemCount.Text = totalItemCount.ToString("N0")
                End If

                Dim lblTotalSalesAmount As Label = CType(e.Item.FindControl("lblTotalSalesAmount"), Label)
                If lblTotalSalesAmount IsNot Nothing Then
                    lblTotalSalesAmount.Text = totalSalesAmount.ToString("c")
                End If

                Dim lblAvgAvgOrderValue As Label = CType(e.Item.FindControl("lblAvgAvgOrderValue"), Label)
                If lblAvgAvgOrderValue IsNot Nothing Then
                    If totalOrderCount > 0 Then
                        lblAvgAvgOrderValue.Text = (totalSalesAmount / Convert.ToDecimal(totalOrderCount)).ToString("c")
                    Else
                        lblAvgAvgOrderValue.Text = Decimal.Zero.ToString("c")
                    End If
                End If
        End Select
    End Sub

    Protected Sub rpReport_ItemCommand(ByVal sender As Object, ByVal e As RepeaterCommandEventArgs) Handles rpReport.ItemCommand
        For Each ri As RepeaterItem In rpReport.Items
            If ri.ItemType = ListItemType.Item OrElse ri.ItemType = ListItemType.AlternatingItem Then
                Dim viewLink As Anthem.LinkButton = CType(ri.FindControl("viewLink"), Anthem.LinkButton)
                Dim trSalesPersonSummary As HtmlTableRow = CType(ri.FindControl("trSalesPersonSummary"), HtmlTableRow)
                Dim trSalesPersonOrders As HtmlTableRow = CType(ri.FindControl("trSalesPersonOrders"), HtmlTableRow)

                If ri.ItemIndex = e.Item.ItemIndex Then
                    If trSalesPersonOrders.Visible Then
                        viewLink.Text = "Show Orders &blacktriangledown;"
                        trSalesPersonOrders.Visible = False
                        trSalesPersonSummary.Attributes("class") = If(ri.ItemIndex Mod 2 = 0, "row", "alternaterow")
                    Else
                        viewLink.Text = "Hide Orders &blacktriangle;"
                        trSalesPersonOrders.Visible = True
                        trSalesPersonSummary.Attributes("class") = If(ri.ItemIndex Mod 2 = 0, "row rowselected", "alternaterow rowselected")

                        Dim criteria As New Orders.OrderSearchCriteria
                        criteria.SalesPersonId = e.CommandArgument
                        criteria.IsPlaced = True
                        criteria.StartDate = ucDateRangeField.StartDate
                        criteria.EndDate = ucDateRangeField.EndDate

                        Dim rpOrders As Repeater = CType(ri.FindControl("rpOrders"), Repeater)
                        AddHandler rpOrders.ItemDataBound, AddressOf rptrOrders_RowDataBound
                        rpOrders.DataSource = Orders.Order.FindByCriteria(criteria)
                        rpOrders.DataBind()
                    End If
                Else
                    viewLink.Text = "Show Orders &blacktriangledown;"
                    trSalesPersonOrders.Visible = False
                    trSalesPersonSummary.Attributes("class") = If(ri.ItemIndex Mod 2 = 0, "row", "alternaterow")
                End If
            End If
        Next
    End Sub

    Protected Sub rptrOrders_RowDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim o As Orders.Order = CType(e.Item.DataItem, Orders.Order)
            Dim lblOrderNumber As Label = CType(e.Item.FindControl("lblOrderNumber"), Label)
            Dim lblGrandTotal As Label = CType(e.Item.FindControl("lblGrandTotal"), Label)
            Dim viewLink As HyperLink = CType(e.Item.FindControl("viewLink"), HyperLink)

            lblOrderNumber.Text = o.OrderNumber
            lblGrandTotal.Text = o.GrandTotal.ToString("C")
            viewLink.NavigateUrl = String.Format("~/BVAdmin/Orders/ViewOrder.aspx?id={0}", o.Bvin)
        End If
    End Sub

End Class
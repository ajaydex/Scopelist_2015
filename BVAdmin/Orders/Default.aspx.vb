Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Orders_Default
    Inherits BaseAdminPage

    Public criteriaSessionKey As String = "OrderCriteria"
    Private currentPageSessionKey As String = "OrdersCurrentPage"

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            GridView1.PageSize = WebAppSettings.RowsPerPage
            PopulateStatusCodes()
            LoadLastSearchValues()
            FindOrders()

            Dim currentPage As Nullable(Of Integer) = CType(Session(currentPageSessionKey), Integer)
            If currentPage.HasValue Then
                If currentPage.Value < GridView1.PageCount Then
                    GridView1.PageIndex = currentPage.Value
                End If
            End If
        End If
    End Sub

    Private Sub LoadLastSearchValues()       
        Me.FilterField.Text = SessionManager.AdminOrderSearchKeyword.Trim

        SetListToValue(Me.PaymentFilterField, SessionManager.AdminOrderSearchPaymentFilter)
        SetListToValue(Me.ShippingFilterField, SessionManager.AdminOrderSearchShippingFilter)
        SetListToValue(Me.StatusFilterField, SessionManager.AdminOrderSearchStatusFilter)
        Me.DateRangeField.RangeType = SessionManager.AdminOrderSearchDateRange
        If Me.DateRangeField.RangeType = Utilities.DateRangeType.Custom Then
            Me.DateRangeField.StartDate = SessionManager.AdminOrderSearchStartDate
            Me.DateRangeField.EndDate = SessionManager.AdminOrderSearchEndDate
        End If
    End Sub

    Private Sub PopulateStatusCodes()
        Dim any As New Orders.OrderStatusCode
        any.Bvin = String.Empty
        any.StatusName = "- Any -"

        Dim codes As Collection(Of Orders.OrderStatusCode) = Orders.OrderStatusCode.FindAll
        codes.Insert(0, any)

        Me.StatusFilterField.DataSource = codes
        Me.StatusFilterField.DataTextField = "StatusName"
        Me.StatusFilterField.DataValueField = "bvin"
        Me.StatusFilterField.DataBind()
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Orders"
        Me.CurrentTab = AdminTabType.Orders
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersView)
    End Sub

    Protected Sub PaymentFilterField_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles PaymentFilterField.SelectedIndexChanged
        FindOrders()
    End Sub

    Protected Sub ShippingFilterField_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ShippingFilterField.SelectedIndexChanged
        FindOrders()
    End Sub

    Protected Sub StatusFilterField_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles StatusFilterField.SelectedIndexChanged
        FindOrders()
    End Sub

    Protected Sub btnGo_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGo.Click
        FindOrders()
    End Sub

    Private Sub FindOrders()
        Dim c As New Orders.OrderSearchCriteria
        c.Keyword = Me.FilterField.Text.Trim
        c.KeywordIsExact = False
        c.StatusCode = Me.StatusFilterField.SelectedValue
        c.PaymentStatus = CType(Me.PaymentFilterField.SelectedValue, Integer)
        c.ShippingStatus = CType(Me.ShippingFilterField.SelectedValue, Integer)
        c.IsPlaced = True
        c.StartDate = Me.DateRangeField.StartDate
        c.EndDate = Me.DateRangeField.EndDate
        Session(criteriaSessionKey) = c
        Me.GridView1.DataBind()

        ' Save Setting to Session
        SessionManager.AdminOrderSearchKeyword = Me.FilterField.Text.Trim
        SessionManager.AdminOrderSearchPaymentFilter = Me.PaymentFilterField.SelectedValue
        SessionManager.AdminOrderSearchShippingFilter = Me.ShippingFilterField.SelectedValue
        SessionManager.AdminOrderSearchStatusFilter = Me.StatusFilterField.SelectedValue
        SessionManager.AdminOrderSearchDateRange = Me.DateRangeField.RangeType
        SessionManager.AdminOrderSearchEndDate = Me.DateRangeField.EndDate
        SessionManager.AdminOrderSearchStartDate = Me.DateRangeField.StartDate
        
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim o As Orders.Order = CType(e.Row.DataItem, Orders.Order)
            If o IsNot Nothing Then

                Dim GrandTotalField As Label = e.Row.FindControl("GrandTotalField")
                Dim SoldToField As Label = e.Row.FindControl("SoldToField")
                Dim PaymentLink As HyperLink = e.Row.FindControl("PaymentLink")
                Dim ShippingLink As HyperLink = e.Row.FindControl("ShippingLink")
                Dim TimeOfOrderField As Label = e.Row.FindControl("TimeOfOrderField")
                Dim StatusLink As HyperLink = e.Row.FindControl("StatusLink")

                If GrandTotalField IsNot Nothing Then
                    GrandTotalField.Text = String.Format("{0:c}", o.GrandTotal)
                End If

                If SoldToField IsNot Nothing Then                    
                    SoldToField.Text = Utilities.MailServices.MailToLink(o.UserEmail, _
                                                                         "Order " & o.OrderNumber, _
                                                                         o.BillingAddress.FirstName & ",", _
                                                                         o.BillingAddress.FirstName & " " & o.BillingAddress.LastName)
                End If

                If PaymentLink IsNot Nothing Then
                    PaymentLink.Text = Utilities.EnumToString.OrderPaymentStatus(o.PaymentStatus)
                    PaymentLink.ToolTip = PaymentLink.Text
                    PaymentLink.NavigateUrl = "ReceivePayments.aspx?id=" & o.Bvin
                    If WebAppSettings.DisableAdminLights = False Then
                        Select Case o.PaymentStatus
                            Case Orders.OrderPaymentStatus.Overpaid
                                PaymentLink.ImageUrl = "~/BVAdmin/Images/Lights/PaymentError.gif"
                            Case Orders.OrderPaymentStatus.PartiallyPaid
                                PaymentLink.ImageUrl = "~/BVAdmin/Images/Lights/PaymentAuthorized.gif"
                            Case Orders.OrderPaymentStatus.Paid
                                PaymentLink.ImageUrl = "~/BVAdmin/Images/Lights/PaymentComplete.gif"
                            Case Orders.OrderPaymentStatus.Unknown
                                PaymentLink.ImageUrl = "~/BVAdmin/Images/Lights/PaymentNone.gif"
                            Case Orders.OrderPaymentStatus.Unpaid
                                PaymentLink.ImageUrl = "~/BVAdmin/Images/Lights/PaymentNone.gif"
                        End Select
                    End If
                    
                End If

                If ShippingLink IsNot Nothing Then
                    ShippingLink.Text = Utilities.EnumToString.OrderShippingStatus(o.ShippingStatus)
                    ShippingLink.ToolTip = ShippingLink.Text
                    ShippingLink.NavigateUrl = "ShipOrder.aspx?id=" & o.Bvin
                    If WebAppSettings.DisableAdminLights = False Then
                        Select Case o.ShippingStatus
                            Case Orders.OrderShippingStatus.FullyShipped
                                ShippingLink.ImageUrl = "~/BVAdmin/Images/Lights/ShippingShipped.gif"
                            Case Orders.OrderShippingStatus.NonShipping
                                ShippingLink.ImageUrl = "~/BVAdmin/Images/Lights/ShippingNone.gif"
                            Case Orders.OrderShippingStatus.PartiallyShipped
                                ShippingLink.ImageUrl = "~/BVAdmin/Images/Lights/ShippingPartially.gif"
                            Case Orders.OrderShippingStatus.Unknown
                                ShippingLink.ImageUrl = "~/BVAdmin/Images/Lights/ShippingNone.gif"
                            Case Orders.OrderShippingStatus.Unshipped
                                ShippingLink.ImageUrl = "~/BVAdmin/Images/Lights/ShippingNone.gif"
                        End Select
                    End If
                End If

                If TimeOfOrderField IsNot Nothing Then
                    TimeOfOrderField.Text = BVSoftware.Web.Dates.FriendlyShortDate(o.TimeOfOrder, DateTime.Now.Year)
                End If

                If StatusLink IsNot Nothing Then
                    StatusLink.Text = o.StatusName
                    StatusLink.ToolTip = StatusLink.Text
                    StatusLink.NavigateUrl = "ViewOrder.aspx?id=" & o.Bvin
                    If WebAppSettings.DisableAdminLights = False Then
                        Select Case o.StatusCode
                            Case WebAppSettings.OrderStatusCodeComplete
                                StatusLink.ImageUrl = "~/BVAdmin/Images/Lights/OrderComplete.gif"
                            Case WebAppSettings.OrderStatusCodeInProcess                                
                                StatusLink.ImageUrl = "~/BVAdmin/Images/Lights/OrderInProcess.gif"
                            Case WebAppSettings.OrderStatusCodeOnHold
                                If o.StatusName = "Problem Order" Then
                                    StatusLink.ImageUrl = "~/BVAdmin/Images/Lights/OrderProblem.gif"
                                Else
                                    StatusLink.ImageUrl = "~/BVAdmin/Images/Lights/OrderOnHold.gif"
                                End If
                            Case Else
                                StatusLink.Text = "<img src=""" & Page.ResolveClientUrl("~/BVAdmin/Images/Lights/OrderInProcess.gif") & """ border=""0"" alt=""" & o.StatusName & """ /> " & o.StatusName
                        End Select
                    End If
                End If

            End If

        End If
    End Sub

    Protected Sub DateRangeField_RangeTypeChanged(ByVal e As System.EventArgs) Handles DateRangeField.RangeTypeChanged
        If DateRangeField.RangeType <> Utilities.DateRangeType.Custom Then
            FindOrders()
        End If
    End Sub

    Protected Sub BatchActionField_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles BatchActionField.SelectedIndexChanged
        Dim action As String = Me.BatchActionField.SelectedItem.Value
        If (action = "") OrElse (action = "0") Then
            Me.BatchActionField.ClearSelection()
        Else
            Me.BatchActionField.ClearSelection()
            Select Case action
                Case "Capture"
                    BatchCapture()

                Case "PrintPackingSlip"
                    SendToPrint("pack")
                Case "PrintAdminReceipt"
                    SendToPrint("receipt")
                Case "PrintInvoice"
                    SendToPrint("invoice")
                Case "Print"
                    SendToPrint("")
                Case Else
                    ' do nothing
            End Select
        End If

        FindOrders()
    End Sub

    Private Function FindCheckedOrders() As StringCollection
        Dim result As New StringCollection

        For Each gr As GridViewRow In Me.GridView1.Rows
            If gr.RowType = DataControlRowType.DataRow Then
                Dim chk As CheckBox = gr.FindControl("chkSelected")
                If chk IsNot Nothing Then
                    If chk.Checked = True Then
                        result.Add(CStr(Me.GridView1.DataKeys(gr.RowIndex).Value))
                    End If
                End If
            End If
        Next

        Return result
    End Function

    Private Function FindCheckedOrdersAsString() As String
        Dim result As String = String.Empty

        Dim o As StringCollection = FindCheckedOrders()
        For i As Integer = 0 To o.Count - 1
            result += o(i)
            If i < o.Count - 1 Then
                result += ","
            End If
        Next

        Return result
    End Function

    Private Sub SendToPrint(ByVal mode As String)
        If FindCheckedOrders.Count > 0 Then

            Dim destination As String = "PrintOrder.aspx?"
            If mode <> String.Empty Then
                destination += "mode=" & mode & "&"
            End If
            destination += "id=" & FindCheckedOrdersAsString
            Response.Redirect(destination)
        End If
    End Sub

    Private Sub BatchCapture()
        Dim orderIds As StringCollection = Me.FindCheckedOrders
        For i As Integer = 0 To orderIds.Count - 1
            CaptureOrder(orderIds(i))
        Next
    End Sub

    Private Sub CaptureOrder(ByVal orderId As String)
        Dim o As Orders.Order = Orders.Order.FindByBvin(orderId)
        If o IsNot Nothing Then
            Dim previousPaymentStatus As Orders.OrderPaymentStatus = o.PaymentStatus
            For Each op As Orders.OrderPayment In o.Payments
                If op.PaymentMethodId = WebAppSettings.PaymentIdCreditCard Then
                    Dim m As Payment.PaymentMethod = op.FindMethod(TaskLoader.LoadPaymentMethods())
                    Dim method As Payment.CollectablePaymentMethod = CType(m, Payment.CollectablePaymentMethod)
                    If method.CaptureIsValid(op) = True Then
                        Dim d As New Payment.PaymentData
                        d.OrderPaymentId = op.Bvin
                        d.StoreOrder = o
                        d.Amount = op.AmountAuthorized
                        method.Capture(d)
                        ' Reload Order Status
                        o = Orders.Order.FindByBvin(orderId)
                        Dim context As New BusinessRules.OrderTaskContext
                        context.Order = o
                        context.UserId = o.UserID
                        context.Inputs.Add("bvsoftware", "PreviousPaymentStatus", previousPaymentStatus.ToString())
                        If Not BusinessRules.Workflow.RunByBvin(context, WebAppSettings.WorkflowIdPaymentChanged) Then
                            MessageBox1.ShowError("An Error occurred while trying to capture orders. Please see the Event Log.")
                            For Each item As BusinessRules.WorkflowMessage In context.Errors
                                EventLog.LogEvent("Payment Changed Workflow", item.Name & ": " & item.Description, Metrics.EventLogSeverity.Error)
                            Next
                        End If

                    End If
                End If
            Next
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource1.Selecting
        If e.ExecutingSelectCount Then
            e.InputParameters("rowCount") = HttpContext.Current.Items("RowCount")
            HttpContext.Current.Items("RowCount") = Nothing
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If e.OutputParameters("RowCount") IsNot Nothing Then
            HttpContext.Current.Items("RowCount") = e.OutputParameters("RowCount")
        End If
    End Sub

    Private Sub SetListToValue(ByVal l As DropDownList, ByVal value As String)
        If l IsNot Nothing Then
            If l.Items.FindByValue(value) IsNot Nothing Then
                l.ClearSelection()
                l.Items.FindByValue(value).Selected = True
            End If
        End If
    End Sub

    Protected Sub GridView1_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PageIndexChanged
        Session(currentPageSessionKey) = GridView1.PageIndex
    End Sub

End Class

Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Orders_ReceivePayments
    Inherits BaseAdminPage

    Private Class RowData

        Public Amount As Decimal = 0
        Public CheckNumber As String = String.Empty
        Public PurchaseOrderNumber As String = String.Empty
        Public CreditCardNumber As String = String.Empty
        Public CreditCardHolder As String = String.Empty
        Public CreditCardExpMonth As Integer = 0
        Public CreditCardExpYear As Integer = 0
        Public CreditCardType As String = String.Empty
        Public CreditCardSecurityCode As String = String.Empty
        Public OrderNumber As String = String.Empty
        Public GiftCardId As String = String.Empty
        Public Notes As String = String.Empty

    End Class

    Private o As Orders.Order = New BVSoftware.Bvc5.Core.Orders.Order

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Dim val As Decimal = 0D
        PaymentAuthorizedField.Text = val.ToString("c")
        PaymentChargedField.Text = val.ToString("c")
        PaymentRefundedField.Text = val.ToString("c")
        PaymentDueField.Text = val.ToString("c")
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Payments"
        Me.CurrentTab = AdminTabType.Orders
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersEdit)
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString("id") <> Nothing Then
                BvinField.Value = Request.QueryString("id")
            End If
            PopulatePaymentList()

            
        End If

        o = Orders.Order.FindByBvin(Me.BvinField.Value)

        If Not Page.IsPostBack Then
            LoadOrder()
            AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Orders, _
                               BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Information, _
                                "Order Payment Information Viewed", "An administrator viewed order payment information for order " & o.OrderNumber & ".")
        End If
    End Sub

    Private Sub LoadOrder()
        If o IsNot Nothing Then
            If o.Bvin <> String.Empty Then
                PopulateFromOrder(o)
            End If
        End If
    End Sub

    Private Sub ReloadOrder(ByVal previousPaymentStatus As Orders.OrderPaymentStatus)
        o = Orders.Order.FindByBvin(Me.BvinField.Value)
        Dim context As New BusinessRules.OrderTaskContext
        context.Order = o
        context.UserId = o.UserID
        context.Inputs.Add("bvsoftware", "PreviousPaymentStatus", previousPaymentStatus.ToString())
        BusinessRules.Workflow.RunByBvin(context, WebAppSettings.WorkflowIdPaymentChanged)
        LoadOrder()
    End Sub

    Private Sub PopulateFromOrder(ByVal o As Orders.Order)

        ' Header
        Me.OrderNumberField.Text = o.OrderNumber

        ' Status
        Me.StatusField.Text = o.FullOrderStatusDescription
        Me.lblCurrentStatus.Text = o.StatusName

        ' Payment
        Dim paySummary As Orders.OrderPaymentSummary = o.PaymentSummary
        'Me.lblPaymentSummary.Text = paySummary.PaymentsSummary
        Me.PaymentAuthorizedField.Text = String.Format("{0:C}", paySummary.AmountAuthorized)
        Me.PaymentChargedField.Text = String.Format("{0:C}", paySummary.AmountCharged)
        Me.PaymentDueField.Text = String.Format("{0:C}", paySummary.AmountDue)
        Me.PaymentRefundedField.Text = String.Format("{0:C}", paySummary.AmountRefunded)

        ' Payment Records
        LoadPayments()

    End Sub

    Private Sub LoadPayments()
        Me.GridView1.DataSource = o.Payments
        Me.GridView1.DataBind()
    End Sub

    Private Function GetRowData(ByVal row As GridViewRow) As RowData
        Dim result As New RowData

        Dim AmountField As TextBox = row.FindControl("AmountField")
        If AmountField IsNot Nothing Then
            Dim val As Decimal = 0
            If Decimal.TryParse(AmountField.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, val) Then
                result.Amount = val
            Else
                result.Amount = 0
            End If

        End If

        Dim CheckNumberField As TextBox = row.FindControl("CheckNumberField")
        If CheckNumberField IsNot Nothing Then
            result.CheckNumber = CheckNumberField.Text
        End If

        Dim GiftCardIdTextBox As TextBox = row.FindControl("GiftCardIdTextBox")
        If GiftCardIdTextBox IsNot Nothing Then
            result.GiftCardId = GiftCardIdTextBox.Text
        End If

        Dim PurchaseOrderNumberField As TextBox = row.FindControl("PurchaseOrderNumberField")
        If PurchaseOrderNumberField IsNot Nothing Then
            result.PurchaseOrderNumber = PurchaseOrderNumberField.Text
        End If

        Dim CreditCardInput1 As BVModules_Controls_CreditCardInput = row.FindControl("CreditCardInput1")
        If CreditCardInput1 IsNot Nothing Then
            result.CreditCardExpMonth = CreditCardInput1.ExpirationMonth
            result.CreditCardExpYear = CreditCardInput1.ExpirationYear
            result.CreditCardHolder = CreditCardInput1.CardHolderName
            result.CreditCardNumber = CreditCardInput1.CardNumber
            result.CreditCardType = CreditCardInput1.CardCode
            result.CreditCardSecurityCode = CreditCardInput1.SecurityCode
        End If

        Dim OrderNumberOverrideField As TextBox = row.FindControl("OrderNumberOverrideField")
        If OrderNumberOverrideField IsNot Nothing Then
            result.OrderNumber = OrderNumberOverrideField.Text.Trim
        End If

        Dim NotesField As TextBox = CType(row.FindControl("NotesTextBox"), TextBox)
        result.Notes = NotesField.Text

        Return result
    End Function

    Private Sub PopulatePayDataFromRowData(ByVal rd As RowData, ByVal p As Payment.PaymentData)
        p.Amount = rd.Amount
        p.Payment.CheckNumber = rd.CheckNumber
        p.Payment.PurchaseOrderNumber = rd.PurchaseOrderNumber
        p.Payment.GiftCertificateNumber = rd.GiftCardId
        If p.Payment.PaymentMethodId = WebAppSettings.PaymentIdCreditCard Then
            p.Payment.CreditCardExpMonth = rd.CreditCardExpMonth
            p.Payment.CreditCardExpYear = rd.CreditCardExpYear
            p.Payment.CreditCardHolder = rd.CreditCardHolder
            If rd.CreditCardNumber.Trim.Length > 0 Then
                If rd.CreditCardNumber.StartsWith("*") Then
                    Dim op As Orders.OrderPayment = Orders.OrderPayment.FindByBvin(p.OrderPaymentId)
                    If op IsNot Nothing Then
                        p.Payment.CreditCardNumber = op.CreditCardNumber
                    End If
                Else
                    p.Payment.CreditCardNumber = rd.CreditCardNumber
                End If
            End If
            p.Payment.CreditCardType = rd.CreditCardType
            p.Payment.CreditCardSecurityCode = rd.CreditCardSecurityCode
        End If
        p.Payment.CustomPropertySet("bvsoftware", "ordernumber", rd.OrderNumber)
        p.Payment.CustomPropertySet("bvsoftware", "notes", rd.Notes)
        Orders.OrderPayment.Update(p.Payment)
    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        MessageBox1.ClearMessage()
        Dim previousPaymentStatus As Orders.OrderPaymentStatus = o.PaymentStatus
        Select Case e.CommandName
            Case "BVAuthorize"
                Dim row As GridViewRow = GridView1.Rows(CInt(e.CommandArgument))
                If row IsNot Nothing Then
                    Dim d As New Payment.PaymentData
                    d.OrderPaymentId = o.Payments(e.CommandArgument).Bvin
                    d.StoreOrder = o
                    Dim rd As RowData = GetRowData(row)
                    PopulatePayDataFromRowData(rd, d)
                    CType(o.Payments(e.CommandArgument).FindMethod, Payment.CollectablePaymentMethod).Authorize(d)
                    If d.ResponseMessage.Length > 0 Then
                        MessageBox1.ShowMessage(d.ResponseMessage, d.ResponseMessageType)
                    End If
                    ReloadOrder(previousPaymentStatus)
                End If

            Case "BVCapture"
                Dim row As GridViewRow = GridView1.Rows(CInt(e.CommandArgument))
                If row IsNot Nothing Then
                    Dim d As New Payment.PaymentData
                    d.OrderPaymentId = o.Payments(e.CommandArgument).Bvin
                    d.StoreOrder = o
                    Dim rd As RowData = GetRowData(row)
                    PopulatePayDataFromRowData(rd, d)
                    CType(o.Payments(e.CommandArgument).FindMethod, Payment.CollectablePaymentMethod).Capture(d)
                    If d.ResponseMessage.Length > 0 Then
                        MessageBox1.ShowMessage(d.ResponseMessage, d.ResponseMessageType)
                    End If
                    ReloadOrder(previousPaymentStatus)
                End If

            Case "BVCharge"
                Dim row As GridViewRow = GridView1.Rows(CInt(e.CommandArgument))
                If row IsNot Nothing Then
                    Dim d As New Payment.PaymentData
                    d.OrderPaymentId = o.Payments(e.CommandArgument).Bvin
                    d.StoreOrder = o
                    Dim rd As RowData = GetRowData(row)
                    PopulatePayDataFromRowData(rd, d)
                    CType(o.Payments(e.CommandArgument).FindMethod, Payment.CollectablePaymentMethod).Charge(d)
                    If d.ResponseMessage.Length > 0 Then
                        MessageBox1.ShowMessage(d.ResponseMessage, d.ResponseMessageType)
                    End If
                    ReloadOrder(previousPaymentStatus)
                End If
            Case "BVRefund"
                Dim row As GridViewRow = GridView1.Rows(CInt(e.CommandArgument))
                If row IsNot Nothing Then
                    Dim d As New Payment.PaymentData
                    d.OrderPaymentId = o.Payments(e.CommandArgument).Bvin
                    d.StoreOrder = o
                    Dim rd As RowData = GetRowData(row)
                    PopulatePayDataFromRowData(rd, d)
                    CType(o.Payments(e.CommandArgument).FindMethod, Payment.CollectablePaymentMethod).Refund(d)
                    If d.ResponseMessage.Length > 0 Then
                        MessageBox1.ShowMessage(d.ResponseMessage, d.ResponseMessageType)
                    End If
                    ReloadOrder(previousPaymentStatus)
                End If
            Case "BVVoid"
                Dim row As GridViewRow = GridView1.Rows(CInt(e.CommandArgument))
                If row IsNot Nothing Then
                    Dim d As New Payment.PaymentData
                    d.OrderPaymentId = o.Payments(e.CommandArgument).Bvin
                    d.StoreOrder = o
                    Dim rd As RowData = GetRowData(row)
                    PopulatePayDataFromRowData(rd, d)
                    CType(o.Payments(e.CommandArgument).FindMethod, Payment.CollectablePaymentMethod).Void(d)
                    If d.ResponseMessage.Length > 0 Then
                        MessageBox1.ShowMessage(d.ResponseMessage, d.ResponseMessageType)
                    End If
                    ReloadOrder(previousPaymentStatus)
                End If
            Case Else
                ' Do Nothing
        End Select
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim pay As Orders.OrderPayment = CType(e.Row.DataItem, Orders.OrderPayment)
            Dim m As Payment.PaymentMethod = pay.FindMethod()

            Dim AmountField As TextBox = e.Row.FindControl("AmountField")
            If AmountField IsNot Nothing Then

                If TypeOf m Is Payment.CollectablePaymentMethod Then
                    If o.PaymentSummary.AmountDue >= 0 Then
                        AmountField.Text = o.PaymentSummary.AmountDue.ToString("c")
                    End If
                    If AmountField.Text.Trim.Length < 1 Then
                        Dim val As Decimal = 0
                        AmountField.Text = val.ToString("c")
                    End If
                Else
                    Dim trAmount As HtmlTableRow = e.Row.FindControl("trAmount")
                    If trAmount IsNot Nothing Then
                        trAmount.Visible = False
                    End If
                End If

            End If

            Dim lblStatus As Label = e.Row.FindControl("lblStatus")
            If lblStatus IsNot Nothing Then
                lblStatus.Text = pay.FriendlyStatus
            End If

            Dim OrderNumberOverrideField As TextBox = e.Row.FindControl("OrderNumberOverrideField")
            If OrderNumberOverrideField IsNot Nothing Then
                OrderNumberOverrideField.Text = o.OrderNumber
            End If

            Dim NotesTextBox As TextBox = CType(e.Row.FindControl("NotesTextBox"), TextBox)
            If NotesTextBox IsNot Nothing Then
                If pay.CustomPropertyExists("bvsoftware", "Notes") Then
                    NotesTextBox.Text = pay.CustomProperties("Notes").Value
                Else
                    NotesTextBox.Text = String.Empty
                End If

            End If

            Select Case pay.PaymentMethodId
                Case WebAppSettings.PaymentIdTelephone
                    ' Do Nothing
                Case WebAppSettings.PaymentIdCheck
                    Dim trCheckNumber As HtmlTableRow = e.Row.FindControl("trCheckNumber")
                    If trCheckNumber IsNot Nothing Then
                        trCheckNumber.Visible = True
                        Dim CheckNumberField As TextBox = trCheckNumber.FindControl("CheckNumberField")
                        If CheckNumberField IsNot Nothing Then
                            CheckNumberField.Text = pay.CheckNumber
                        End If
                    End If
                Case WebAppSettings.PaymentIdCreditCard
                    Dim trCreditCard As HtmlTableRow = e.Row.FindControl("trCreditCard")
                    If trCreditCard IsNot Nothing Then
                        trCreditCard.Visible = True
                        Dim CreditCardInput1 As BVModules_Controls_CreditCardInput = trCreditCard.FindControl("CreditCardInput1")
                        If CreditCardInput1 IsNot Nothing Then
                            CreditCardInput1.LoadFromPayment(pay)
                        End If
                    End If
                    Dim trOrderNumber As HtmlTableRow = e.Row.FindControl("trOrderNumber")
                    If trOrderNumber IsNot Nothing Then
                        trOrderNumber.Visible = True
                    End If
                Case WebAppSettings.PaymentIdPurchaseOrder
                    Dim trPurchaseOrder As HtmlTableRow = e.Row.FindControl("trPurchaseOrder")
                    If trPurchaseOrder IsNot Nothing Then
                        trPurchaseOrder.Visible = True
                        Dim PurchaseOrderNumberField As TextBox = trPurchaseOrder.FindControl("PurchaseOrderNumberField")
                        If PurchaseOrderNumberField IsNot Nothing Then
                            PurchaseOrderNumberField.Text = pay.PurchaseOrderNumber
                        End If
                    End If
                Case WebAppSettings.PaymentIdCashOnDelivery
                    ' Do Nothing
                Case WebAppSettings.PaymentIdGiftCertificate
                    Dim trGiftCard As HtmlTableRow = e.Row.FindControl("trGiftCard")
                    If trGiftCard IsNot Nothing Then
                        trGiftCard.Visible = True
                        Dim GiftCardIdTextBox As TextBox = trGiftCard.FindControl("GiftCardIdTextBox")
                        If GiftCardIdTextBox IsNot Nothing Then
                            GiftCardIdTextBox.Text = pay.GiftCertificateNumber
                        End If
                    End If
                Case Else
                    ' Do Nothing
            End Select


            Dim btnAuthorize As ImageButton = e.Row.FindControl("btnAuth")
            Dim btnCapture As ImageButton = e.Row.FindControl("btnCapture")
            Dim btnCharge As ImageButton = e.Row.FindControl("btnCharge")
            Dim btnRefund As ImageButton = e.Row.FindControl("btnRefund")
            Dim btnVoid As ImageButton = e.Row.FindControl("btnVoid")

            If TypeOf m Is Payment.CollectablePaymentMethod Then

                Dim method As Payment.CollectablePaymentMethod = CType(m, Payment.CollectablePaymentMethod)

                If btnAuthorize IsNot Nothing Then
                    btnAuthorize.CommandArgument = e.Row.RowIndex
                    btnAuthorize.ImageUrl = method.AuthorizeButton
                    btnAuthorize.Visible = method.AuthorizationIsValid(pay)
                    btnAuthorize.AlternateText = method.AuthorizeButtonToolTip
                End If

                If btnCapture IsNot Nothing Then
                    btnCapture.CommandArgument = e.Row.RowIndex
                    btnCapture.ImageUrl = method.CaptureButton
                    btnCapture.Visible = method.CaptureIsValid(pay)
                    btnCapture.AlternateText = method.CaptureButtonToolTip                    
                End If

                If btnCharge IsNot Nothing Then
                    btnCharge.CommandArgument = e.Row.RowIndex
                    btnCharge.ImageUrl = method.ChargeButton
                    btnCharge.Visible = method.ChargeIsValid(pay)
                    btnCharge.AlternateText = method.ChargeButtonToolTip
                End If

                If btnRefund IsNot Nothing Then
                    btnRefund.CommandArgument = e.Row.RowIndex
                    btnRefund.ImageUrl = method.RefundButton
                    btnRefund.Visible = method.RefundIsValid(pay)
                    btnRefund.AlternateText = method.RefundButtonToolTip
                End If

                If btnVoid IsNot Nothing Then
                    btnVoid.CommandArgument = e.Row.RowIndex
                    btnVoid.ImageUrl = method.VoidButton
                    btnVoid.Visible = method.VoidIsValid(pay)
                    btnVoid.AlternateText = method.VoidButtonToolTip
                End If

            End If


        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        MessageBox1.ClearMessage()
        Dim bvin As String = CStr(GridView1.DataKeys(e.RowIndex).Value)
        If o IsNot Nothing Then
            Dim previousPaymentStatus As Orders.OrderPaymentStatus = o.PaymentStatus
            If o.RemovePayment(bvin) Then
                Dim context As New BusinessRules.OrderTaskContext()
                context.Order = o
                context.UserId = SessionManager.GetCurrentUserId()
                context.Inputs.Add("bvsoftware", "PreviousPaymentStatus", previousPaymentStatus.ToString())
                If Not BusinessRules.Workflow.RunByBvin(context, WebAppSettings.WorkflowIdPaymentChanged) Then
                    For Each item As BusinessRules.WorkflowMessage In context.Errors
                        EventLog.LogEvent(item.Name, item.Description, Metrics.EventLogSeverity.Error)
                        MessageBox1.ShowError(item.Description)
                    Next
                End If
            End If
            LoadOrder()
        End If
    End Sub

    Private Sub PopulatePaymentList()
        Me.lstNewPayment.DataSource = Payment.AvailablePayments.CollectibleMethods
        Me.lstNewPayment.DataTextField = "MethodName"
        Me.lstNewPayment.DataValueField = "MethodId"
        Me.lstNewPayment.DataBind()
    End Sub

    Protected Sub btnNewPayment_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewPayment.Click
        MessageBox1.ClearMessage()
        If o IsNot Nothing Then
            Dim p As New Orders.OrderPayment
            p.PaymentMethodId = Me.lstNewPayment.SelectedValue
            p.PaymentMethodName = Me.lstNewPayment.SelectedItem.Text
            o.AddPayment(p)
            LoadOrder()
        End If
    End Sub

    Protected Sub btnPreviousStatus_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnPreviousStatus.Click
        Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        If o IsNot Nothing Then
            o.MoveToPreviousStatus()
            LoadOrder()
        End If
    End Sub

    Protected Sub btnNextStatus_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNextStatus.Click
        Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
        If o IsNot Nothing Then
            o.MoveToNextStatus()
            LoadOrder()
        End If
    End Sub

End Class
Imports BVSoftware.BVC5.Core
Imports BVSoftware.BVC5.Core.Orders
Imports System.IO
Imports System.Text
Imports BVSoftware.CredEx

Partial Class CredExPostBack
    Inherits System.Web.UI.Page


    Protected Sub CredExPostBack_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            ' Find the Order Matching the Post Back Request
            Dim orderBvin As String = Request("id")
            If (orderBvin Is Nothing) Then
                Return
            End If
            If (orderBvin = String.Empty) Then
                Return
            End If
            Dim o As Order = Orders.Order.FindByBvin(orderBvin)
            If (o Is Nothing) Then
                Return
            End If
            If (o.Bvin = String.Empty) Then
                Return
            End If

            ' Read Xml Data Posted
            Dim sr As New StreamReader(Request.InputStream)
            Dim xmlData As String = sr.ReadToEnd()

            Dim postData As New BVSoftware.CredEx.CreditPostBackData()
            postData.FromXml(xmlData)
            
            If (postData IsNot Nothing) Then
                ProcessPost(postData, o)
            End If

        End If
    End Sub

    Private Sub ProcessPost(ByVal postData As CreditPostBackData, ByVal o As Orders.Order)

        If (postData.StatusCode.Trim().ToUpper() = "Y") Then
            For Each op As OrderPayment In o.Payments
                If op.PaymentMethodId = WebAppSettings.PaymentIdCredEx Then
                    If (o.PaymentStatus = OrderPaymentStatus.Unpaid) Then

                        ' Approve Credit on Order
                        op.AmountCharged = o.GrandTotal
                        Orders.OrderPayment.Update(op)
                        Dim previousPaymentStatus As Orders.OrderPaymentStatus = o.PaymentStatus
                        o.EvaluatePaymentStatus()
                        Orders.Order.Update(o)

                        ' Run Workflow since Payment has Changed
                        Dim context As New BusinessRules.OrderTaskContext()
                        context.Order = o
                        context.UserId = o.UserID
                        context.Inputs.Add("bvsoftware", "PreviousPaymentStatus", previousPaymentStatus.ToString())
                        If Not BusinessRules.Workflow.RunByBvin(context, WebAppSettings.WorkflowIdPaymentChanged) Then
                            For Each item As BusinessRules.WorkflowMessage In context.Errors
                                EventLog.LogEvent(item.Name, item.Description, Metrics.EventLogSeverity.Error)
                            Next
                        End If
                    End If
                End If
            Next
        ElseIf (postData.StatusCode.Trim().ToUpper() = "R") Then
            ' Citi App Card Info instead of credit approval
            Dim op As New OrderPayment
            op.AuditDate = DateTime.Now
            op.CreditCardNumber = Utilities.CreditCardValidator.CleanCardNumber(postData.CardNumber)
            If op.CreditCardNumber.StartsWith("4") Then
                op.CreditCardType = "Visa"
            Else
                op.CreditCardType = "MasterCard"
            End If
            Dim expMonth As Integer = 1
            Dim expYear As Integer = 1999
            Integer.TryParse(postData.ExpMonth, expMonth)
            Integer.TryParse(postData.ExpYear, expYear)
            op.CreditCardSecurityCode = postData.CVV
            op.Encrypted = True
            op.OrderID = o.Bvin
            op.TransactionReferenceNumber = postData.CredExReferenceNumber
            op.ThirdPartyTransId = postData.CredExReferenceNumber
            op.ThirdPartyOrderId = postData.MerchantRefernceNumber
            op.PaymentMethodId = WebAppSettings.PaymentIdCreditCard
            op.PaymentMethodName = "Credit Card"
            op.AmountAuthorized = o.GrandTotal
            o.AddPayment(op)
            Orders.Order.Update(o)

            CollectPayment(o, postData.CredExReferenceNumber, postData.MerchantRefernceNumber)
        Else
            Dim note As New OrderNote()
            note.NoteType = OrderNoteType.Private
            note.Note = "CredEx: " & postData.Status & " | " & postData.Reason & " | " & postData.CustomerAccountMessage
            o.AddNote(note)
            Orders.Order.Update(o)
        End If
        
    End Sub

    Private Sub CollectPayment(ByVal o As Orders.Order, ByVal credExRef As String, ByVal merchRef As String)

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
                    o = Orders.Order.FindByBvin(o.Bvin)
                    Dim context As New BusinessRules.OrderTaskContext
                    context.Order = o
                    context.UserId = o.UserID
                    context.Inputs.Add("bvsoftware", "PreviousPaymentStatus", previousPaymentStatus.ToString())
                    If Not BusinessRules.Workflow.RunByBvin(context, WebAppSettings.WorkflowIdPaymentChanged) Then
                        SendCardResponse(False, credExRef, merchRef)
                        For Each item As BusinessRules.WorkflowMessage In context.Errors
                            EventLog.LogEvent("Payment Changed Workflow", item.Name & ": " & item.Description, Metrics.EventLogSeverity.Error)
                        Next
                    Else
                        SendCardResponse(True, credExRef, merchRef)
                    End If
                End If
            End If
        Next

    End Sub

    Private Sub SendCardResponse(ByVal success As Boolean, ByVal credExRef As String, ByVal merchRef As String)

        Dim res As New CreditPostBackResponse()

        res.Data.CredExReferenceNumber = credExRef
        res.Data.MerchantRefernceNumber = merchRef

        If (success) Then
            res.Data.StatusCode = "Y"
            res.Data.Status = "approved"
        Else
            res.Data.StatusCode = "N"
            res.Data.Status = "declined"
        End If

        res.Settings.CredExProductId = WebAppSettings.CredExProductId
        res.Settings.IsTestMode = WebAppSettings.CredExTestMode
        res.Settings.MerchantId = WebAppSettings.CredExMerchantId
        res.Settings.MerchantKey = WebAppSettings.CredExMerchantKey                

        Dim svc As New CredExService()
        svc.ProcessRequest(res)
    End Sub
End Class

Imports BVSoftware.Bvc5.Core
Imports System.Web
Imports System.Collections.ObjectModel

Partial Class IPNHandler
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strFormValues As String = Request.Form.ToString()
        Dim strNewValue As String = String.Empty
        Dim strResponse As String = String.Empty

        Dim req As Net.HttpWebRequest
        ' Create the request back
        If String.Compare(WebAppSettings.PaypalMode, "Live", True) = 0 Then
            req = CType(Net.WebRequest.Create("https://www.paypal.com/cgi-bin/webscr"), Net.HttpWebRequest)
        Else
            req = CType(Net.WebRequest.Create("https://www.sandbox.paypal.com/cgi-bin/webscr"), Net.HttpWebRequest)
        End If


        ' Set values for the request back
        req.Method = "POST"
        req.ContentType = "application/x-www-form-urlencoded"
        strNewValue = strFormValues + "&cmd=_notify-validate"
        req.ContentLength = strNewValue.Length

        ' Write the request back IPN strings
        Dim stOut As IO.StreamWriter = New IO.StreamWriter(req.GetRequestStream(), Encoding.ASCII)
        stOut.Write(strNewValue)
        stOut.Close()

        ' Do the request to PayPal and get the response
        Dim stIn As IO.StreamReader = New IO.StreamReader(req.GetResponse().GetResponseStream())
        strResponse = stIn.ReadToEnd()
        stIn.Close()

        ' Confirm whether the IPN was VERIFIED or INVALID. If INVALID, just ignore the IPN
        If (strResponse = "VERIFIED") Then
            'Create the IpnTransaction                
            If Request.Form("payment_status") IsNot Nothing Then
                Dim payment_status As String = Request.Form("payment_status")
                If Request.Form("txn_id") IsNot Nothing Then
                    Dim transId As String = CStr(Request.Form("txn_id"))
                    If payment_status = "Completed" Then
                        Dim transPayments As Collection(Of Orders.OrderPayment) = Orders.OrderPayment.FindByThirdPartyTransactionId(transId)
                        If transPayments.Count > 0 Then
                            Dim paymentAmount As Decimal = 0D
                            If Decimal.TryParse(Request.Form("mc_gross"), paymentAmount) Then
                                For Each payItem As Orders.OrderPayment In transPayments
                                    If (payItem.AmountCharged + paymentAmount) <= payItem.AmountAuthorized Then
                                        payItem.AmountCharged += paymentAmount
                                    End If
                                    payItem.CustomProperties.Remove(payItem.CustomProperties("status"))
                                    Orders.OrderPayment.Update(payItem)
                                    Dim order As Orders.Order = Orders.Order.FindByBvin(payItem.OrderID)

                                    Dim context As New BusinessRules.OrderTaskContext
                                    context.Order = order
                                    context.UserId = SessionManager.GetCurrentUserId()
                                    Dim previousPaymentStatus As Orders.OrderPaymentStatus = order.PaymentStatus
                                    order.EvaluatePaymentStatus()
                                    context.Inputs.Add("bvsoftware", "PreviousPaymentStatus", previousPaymentStatus.ToString())
                                    BusinessRules.Workflow.RunByBvin(context, WebAppSettings.WorkflowIdPaymentChanged)

                                    Orders.Order.Update(order)
                                Next
                            End If
                        Else
                            'check to see if we can find our order based on the auth id
                            Dim authId As String = CStr(Request.Form("auth_id"))
                            transPayments = Orders.OrderPayment.FindByThirdPartyTransactionId(authId)
                            If transPayments.Count > 0 Then
                                Dim paymentAmount As Decimal = 0D
                                If Decimal.TryParse(Request.Form("mc_gross"), paymentAmount) Then
                                    For Each payItem As Orders.OrderPayment In transPayments
                                        If (payItem.AmountCharged + paymentAmount) <= payItem.AmountAuthorized Then
                                            payItem.AmountCharged += paymentAmount
                                        End If
                                        payItem.CustomProperties.Remove(payItem.CustomProperties("status"))
                                        Orders.OrderPayment.Update(payItem)
                                        Dim order As Orders.Order = Orders.Order.FindByBvin(payItem.OrderID)

                                        Dim context As New BusinessRules.OrderTaskContext
                                        context.Order = order
                                        context.UserId = SessionManager.GetCurrentUserId()
                                        Dim previousPaymentStatus As Orders.OrderPaymentStatus = order.PaymentStatus
                                        order.EvaluatePaymentStatus()
                                        context.Inputs.Add("bvsoftware", "PreviousPaymentStatus", previousPaymentStatus.ToString())
                                        BusinessRules.Workflow.RunByBvin(context, WebAppSettings.WorkflowIdPaymentChanged)

                                        Orders.Order.Update(order)
                                    Next
                                End If
                            End If
                        End If
                    ElseIf payment_status = "Failed" Then
                        If Not FindAndMarkStatus(transId, "Failed") Then
                            'check to see if we can find our order based on the auth id
                            Dim authId As String = CStr(Request.Form("auth_id"))
                            FindAndMarkStatus(authId, "Failed")
                        End If
                    ElseIf payment_status = "Denied" Then
                        If Not FindAndMarkStatus(transId, "Denied") Then
                            'check to see if we can find our order based on the auth id
                            Dim authId As String = CStr(Request.Form("auth_id"))
                            FindAndMarkStatus(authId, "Denied")
                        End If
                    ElseIf payment_status = "Reversed" Then
                        If Not FindAndMarkStatus(transId, "Reversed") Then
                            'check to see if we can find our order based on the auth id
                            Dim authId As String = CStr(Request.Form("auth_id"))
                            FindAndMarkStatus(authId, "Reversed")
                        End If
                    End If
                End If
            End If
        End If
    End Sub

    Private Function FindAndMarkStatus(ByVal transId As String, ByVal status As String) As Boolean
        Dim transPayments As Collection(Of Orders.OrderPayment) = Orders.OrderPayment.FindByThirdPartyTransactionId(transId)
        If transPayments.Count > 0 Then
            For Each payItem As Orders.OrderPayment In transPayments
                payItem.CustomProperties.Add("bvsoftware", "status", "Failed")
                Orders.OrderPayment.Update(payItem)
                Return True
            Next
        End If
        Return False
    End Function
End Class

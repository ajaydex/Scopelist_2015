Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Checkouts_One_Page_Checkout_Plus_Payment
    Inherits System.Web.UI.UserControl

    Private _errors As New Collection(Of String)()

    Public ReadOnly Property Errors() As Collection(Of String)
        Get
            Return _errors
        End Get
    End Property

    Private _tabIndex As Integer = -1

    Public Property TabIndex() As Integer
        Get
            Return _tabIndex
        End Get
        Set(ByVal value As Integer)
            _tabIndex = value
        End Set
    End Property

    Private Sub InitializeValidators()
        If rbCreditCard.Checked Then
            CreditCardInput1.EnabledValidators()
        Else
            CreditCardInput1.DisableValidators()
        End If
    End Sub

    Public Sub LoadPaymentMethods(ByVal orderCost As Decimal)
        Dim enabledMethods As Collection(Of Payment.PaymentMethod)
        enabledMethods = Payment.AvailablePayments.EnabledMethods()

        If (orderCost > 0) OrElse (Not WebAppSettings.AllowZeroDollarOrders) Then
            Me.rowNoPaymentNeeded.Visible = False
            For Each m As Payment.PaymentMethod In enabledMethods
                Select Case m.MethodId
                    Case WebAppSettings.PaymentIdCheck
                        Me.rbCheck.Text = WebAppSettings.PaymentCheckName
                        Me.lblCheckDescription.Text = WebAppSettings.PaymentCheckDescription
                        Me.rowCheck.Visible = True
                    Case WebAppSettings.PaymentIdCreditCard
                        Me.rowCreditCard.Visible = True
                    Case WebAppSettings.PaymentIdTelephone
                        Me.rbTelephone.Text = WebAppSettings.PaymentTelephoneName
                        Me.lblTelephoneDescription.Text = WebAppSettings.PaymentTelephoneDescription
                        Me.rowTelephone.Visible = True
                    Case WebAppSettings.PaymentIdPurchaseOrder
                        Me.rbPurchaseOrder.Text = WebAppSettings.PaymentPurchaseOrderName
                        Me.lblPurchaseOrderDescription.Text = WebAppSettings.PaymentPurchaseOrderDescription
                        Me.trPurchaseOrder.Visible = True
                    Case WebAppSettings.PaymentIdCashOnDelivery
                        Me.rbCOD.Text = WebAppSettings.PaymentCODName
                        Me.lblCOD.Text = WebAppSettings.PaymentCODDescription
                        Me.trCOD.Visible = True
                    Case WebAppSettings.PaymentIdPaypalExpress
                        Me.trPaypal.Visible = True
                    Case WebAppSettings.PaymentIdCredEx
                        Me.trCredEx.Visible = True
                    Case Else
                        ' do nothing
                End Select
            Next

            If enabledMethods.Count = 1 Then
                Select Case enabledMethods(0).MethodId
                    Case WebAppSettings.PaymentIdCheck
                        rbCheck.Checked = True
                    Case WebAppSettings.PaymentIdCreditCard
                        rbCreditCard.Checked = True
                    Case WebAppSettings.PaymentIdTelephone
                        rbTelephone.Checked = True
                    Case WebAppSettings.PaymentIdPurchaseOrder
                        rbPurchaseOrder.Checked = True
                    Case WebAppSettings.PaymentIdCashOnDelivery
                        rbCOD.Checked = True
                    Case WebAppSettings.PaymentIdPaypalExpress
                        rbPaypal.Checked = True
                    Case WebAppSettings.PaymentIdCredEx
                        rbCredEx.Checked = True
                End Select
            End If
        Else
            rbNoPayment.Checked = True
            rbNoPayment.Text = WebAppSettings.PaymentNoPaymentNeededDescription
            For Each item As Control In Me.Controls
                If TypeOf item Is HtmlTableRow Then
                    If item Is rowNoPaymentNeeded Then
                        item.Visible = True
                    Else
                        item.Visible = False
                    End If
                End If
            Next
        End If
    End Sub

    Public Sub SetPaymentMethod(ByVal methodID As String)
        Select Case methodID
            Case WebAppSettings.PaymentIdCheck
                Me.rbCheck.Checked = True
            Case WebAppSettings.PaymentIdCreditCard
                Me.rbCreditCard.Checked = True
            Case WebAppSettings.PaymentIdTelephone
                Me.rbTelephone.Checked = True
            Case WebAppSettings.PaymentIdPurchaseOrder
                Me.rbPurchaseOrder.Checked = True
            Case WebAppSettings.PaymentIdCashOnDelivery
                Me.rbCOD.Checked = True
            Case WebAppSettings.PaymentIdPaypalExpress
                Me.rbPaypal.Checked = True
            Case WebAppSettings.PaymentIdCredEx
                Me.rbCredEx.Checked = True
            Case Else
                ' do nothing
        End Select
    End Sub

    Public Sub SavePaymentInfo(ByVal o As Orders.Order)
        'clear out the orders before we apply it
        For Each item As Orders.OrderPayment In o.Payments
            Orders.OrderPayment.Delete(item.Bvin)
        Next
        o.Payments.Clear()

        Dim found As Boolean = False
        Dim p As New Orders.OrderPayment
        p.OrderID = o.Bvin
        p.AuditDate = DateTime.Now

        If Me.rbCreditCard.Checked = True Then
            found = True
            p.PaymentMethodName = "Credit Card"
            p.PaymentMethodId = WebAppSettings.PaymentIdCreditCard
            Me.CreditCardInput1.CopyToPayment(p)
        End If

        If (found = False) AndAlso (Me.rbCheck.Checked = True) Then
            found = True
            p.PaymentMethodName = WebAppSettings.PaymentCheckName
            p.PaymentMethodId = WebAppSettings.PaymentIdCheck
        End If

        If (found = False) AndAlso (Me.rbTelephone.Checked = True) Then
            found = True
            p.PaymentMethodName = WebAppSettings.PaymentTelephoneName
            p.PaymentMethodId = WebAppSettings.PaymentIdTelephone
        End If

        If (found = False) AndAlso (Me.rbPurchaseOrder.Checked = True) Then
            found = True
            p.PaymentMethodName = WebAppSettings.PaymentPurchaseOrderName
            p.PaymentMethodId = WebAppSettings.PaymentIdPurchaseOrder
            p.PurchaseOrderNumber = Me.PurchaseOrderField.Text.Trim
        End If

        If (found = False) AndAlso (Me.rbCOD.Checked = True) Then
            found = True
            p.PaymentMethodName = WebAppSettings.PaymentCODName
            p.PaymentMethodId = WebAppSettings.PaymentIdCashOnDelivery
        End If

        If (found = False) AndAlso (Me.rbPaypal.Checked = True) Then
            found = True
            p.PaymentMethodName = "Paypal Express"
            p.PaymentMethodId = WebAppSettings.PaymentIdPaypalExpress
        End If

        If (found = False) AndAlso (Me.rbCredEx.Checked = True) Then
            found = True
            p.PaymentMethodName = "CredEx"
            p.PaymentMethodId = WebAppSettings.PaymentIdCredEx
        End If

        If found Then
            o.AddPayment(p)
        End If

        If o.GiftCertificates.Count > 0 Then
            For Each item As String In o.GiftCertificates
                p = New Orders.OrderPayment()
                p.OrderID = o.Bvin
                p.AuditDate = DateTime.Now
                p.GiftCertificateNumber = item
                p.PaymentMethodName = "Gift Certificate"
                p.PaymentMethodId = WebAppSettings.PaymentIdGiftCertificate
                o.AddPayment(p)
            Next
        End If
    End Sub

    Public Function IsValid() As Boolean
        Dim result As Boolean = False
        Dim paymentFound As Boolean = False
        If Me.rbCreditCard.Checked = True Then
            paymentFound = True
            result = True
            If Me.CreditCardInput1.Validate = False Then
                For Each errorItem As String In Me.CreditCardInput1.ValidateErrors
                    Me.Errors.Add(errorItem)
                Next
                result = False
            End If
        End If
        If Me.rbCheck.Checked = True Then
            paymentFound = True
            result = True
        End If
        If Me.rbTelephone.Checked = True Then
            paymentFound = True
            result = True
        End If
        If Me.rbPurchaseOrder.Checked = True Then
            If PurchaseOrderValidator.IsValid Then
                paymentFound = True
                result = True
            Else
                paymentFound = False
                result = False
                Me.Errors.Add("Purchase order number required.")
            End If
        End If
        If Me.rbCOD.Checked = True Then
            paymentFound = True
            result = True
        End If
        If Me.rbPaypal.Checked Then
            paymentFound = True
            result = True
        End If
        If Me.rbCredEx.Checked Then
            paymentFound = True
            result = True
        End If

        ' Try CC as default payment method
        If paymentFound = False Then
            If Me.CreditCardInput1.CardNumber.Length > 12 Then
                paymentFound = True
                result = True
                Me.rbCreditCard.Checked = True
                If Me.CreditCardInput1.Validate = False Then
                    For Each errorItem As String In Me.CreditCardInput1.ValidateErrors
                        Me.Errors.Add(errorItem)
                    Next
                    result = False
                End If
            End If
        End If

        If rowNoPaymentNeeded.Visible Then
            If rbNoPayment.Checked Then
                result = True
            End If
        End If

        If (Not paymentFound) AndAlso (Not result) Then
            If Me.Errors.Count = 0 Then
                Me.Errors.Add("Please select a payment method.")
            End If
        End If

        Return result
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        InitializeValidators()
        If Not Page.IsPostBack Then
            If Me.TabIndex <> -1 Then
                rbNoPayment.TabIndex = Me.TabIndex
                rbCredEx.TabIndex = Me.TabIndex
                rbCreditCard.TabIndex = Me.TabIndex + 1
                Me.CreditCardInput1.TabIndex = Me.TabIndex + 2
                Me.rbPaypal.TabIndex = Me.TabIndex + 9
                rbPurchaseOrder.TabIndex = Me.TabIndex + 10
                PurchaseOrderField.TabIndex = Me.TabIndex + 11
                rbCheck.TabIndex = Me.TabIndex + 12
                rbTelephone.TabIndex = Me.TabIndex + 13
                rbCOD.TabIndex = Me.TabIndex + 14
            End If
        End If
    End Sub

    Public Sub PurchaseOrderValidator_ServerValidate(ByVal sender As Object, ByVal e As ServerValidateEventArgs) Handles PurchaseOrderValidator.ServerValidate
        If Not Me.rbPurchaseOrder.Checked Then
            e.IsValid = True
        Else
            e.IsValid = (Not WebAppSettings.PaymentPurchaseOrderRequirePONumber OrElse Not String.IsNullOrEmpty(Me.PurchaseOrderField.Text))
        End If
    End Sub

End Class
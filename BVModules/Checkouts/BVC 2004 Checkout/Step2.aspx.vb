Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Checkouts_BVC_2004_Checkout_Step2
    Inherits BaseStoreCheckoutPage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.UseTabIndexes = True
        Utilities.WebForms.MakePageNonCacheable(Me)        
        If Not Page.IsPostBack Then
            Shipping.SetFocus()
            btnBack.ImageUrl = PersonalizationServices.GetThemedButton("Previous")
            btnNext.ImageUrl = PersonalizationServices.GetThemedButton("ReviewOrder")

            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart()
            Shipping.LoadShippingMethodsForOrder(Basket, Basket.ShippingAddress.PostalCode)            

            CheckForNonShippingOrder(Basket)

            If Not Basket.HasShippingItems Then
                Payment1.LoadPaymentMethods(Basket.GrandTotal)
            Else
                Payment1.LoadPaymentMethods(1D)
            End If

            If Basket.ShippingMethodUniqueKey.Trim() <> String.Empty Then
                Shipping.SetShippingMethod(Basket.ShippingMethodUniqueKey)
            End If
            If Basket.Payments.Count > 0 Then
                Payment1.SetPaymentMethod(Basket.Payments(0).PaymentMethodId)
            End If
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Checkout.master")
        Me.Title = "Checkout Step 2 of 3"
    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnBack.Click
        Response.Redirect("~/checkout/Checkout.aspx")
    End Sub

    Protected Sub btnNext_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNext.Click
        If Page.IsValid Then
            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart()
            Dim Checkout As Boolean = False
            If Shipping.IsValid Then                
                If Payment1.IsValid Then
                    Checkout = True
                Else
                    Dim totalValue As Decimal = 0
                    For Each gc As Catalog.GiftCertificate In Basket.GetGiftCertificates
                        totalValue += gc.CurrentAmount
                    Next

                    Basket.CalculateGrandTotalOnly(False, False)
                    If totalValue >= Basket.GrandTotal Then
                        Checkout = True                    
                    End If

                    If Not Checkout AndAlso Not Payment1.IsValid Then
                        For Each item As String In Payment1.Errors
                            MessageBox1.ShowError(item)
                        Next                        
                    End If
                End If
            Else
                MessageBox1.ShowError("Please select a shipping method.")
            End If

            If Checkout Then

                ' Save Shipping Selection
                Dim r As Shipping.ShippingRate = Shipping.FindSelectedRate(Basket)
                Basket.ApplyShippingRate(r)

                Payment1.SavePaymentInfo(Basket)

                Orders.Order.Update(Basket)

                For Each payment As Orders.OrderPayment In Basket.Payments
                    If payment.PaymentMethodId = WebAppSettings.PaymentIdCreditCard Then
                        Dim crypto As New Utilities.Cryptography.TripleDesEncryption()                        
                        Dim securityCode As String = crypto.Encode(payment.CreditCardSecurityCode)
                        If Session("2004Sec") Is Nothing Then
                            Session.Add("2004Sec", securityCode)
                        Else
                            Session("2004Sec") = securityCode
                        End If
                    End If
                Next                

                ' Save as Order
                Dim c As New BusinessRules.OrderTaskContext
                c.UserId = SessionManager.GetCurrentUserId
                c.Order = Basket

                Dim paypalCheckoutSelected As Boolean = False
                For Each payment As Orders.OrderPayment In Basket.Payments
                    If payment.PaymentMethodId = WebAppSettings.PaymentIdPaypalExpress Then
                        paypalCheckoutSelected = True
                        Exit For
                    End If
                Next

                If paypalCheckoutSelected Then
                    c.Inputs.Add("bvsoftware", "Mode", "PaypalExpress")
                    c.Inputs.Add("bvsoftware", "AddressSupplied", "1")
                    If Not BusinessRules.Workflow.RunByBvin(c, WebAppSettings.WorkflowIdThirdPartyCheckoutSelected) Then
                        Dim customerMessageFound As Boolean = False
                        EventLog.LogEvent("Paypal Express Checkout Failed", "Specific Errors to follow", Metrics.EventLogSeverity.Error)
                        ' Show Errors                
                        For Each item As BusinessRules.WorkflowMessage In c.GetCustomerVisibleErrors
                            MessageBox1.ShowError(item.Description)                            
                        Next
                    End If
                Else
                    Response.Redirect("~/checkout/Review.aspx")
                End If
            End If
        End If
    End Sub

    Protected Sub CheckForNonShippingOrder(ByVal Basket As Orders.Order)
        If WebAppSettings.HideShippingControlsForNonShippingOrders Then
            If Not Basket.HasShippingItems Then
                ShippingSection.Visible = False
            End If
        End If
    End Sub
    
End Class

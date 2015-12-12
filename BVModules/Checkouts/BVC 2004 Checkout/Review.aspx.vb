Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Checkouts_BVC_2004_Checkout_Review
    Inherits BaseStoreCheckoutPage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart()
        Basket.CalculateTax()
        Orders.Order.Update(Basket)
        ViewOrder1.OrderBvin = Basket.Bvin
        ViewOrder1.LoadOrder()
        If Not Page.IsPostBack Then
            btnBack.ImageUrl = PersonalizationServices.GetThemedButton("Previous")
            btnNext.ImageUrl = PersonalizationServices.GetThemedButton("PlaceOrder")
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Checkout.master")
        Me.Title = "Checkout Step 3 of 3"
    End Sub

    Protected Sub btnNext_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNext.Click
        If Page.IsValid Then
            If Not SiteTermsAgreement1.IsValid Then
                MessageBox.ShowError(Content.SiteTerms.GetTerm("SiteTermsAgreementError"))                
            Else
                Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart()

                If Basket IsNot Nothing Then
                    For Each payment As Orders.OrderPayment In Basket.Payments
                        If payment.PaymentMethodId = WebAppSettings.PaymentIdCreditCard Then
                            Dim crypto As New Utilities.Cryptography.TripleDesEncryption()                            
                            If Session("2004Sec") IsNot Nothing Then                                
                                If Not String.IsNullOrEmpty(Session("2004Sec")) Then
                                    payment.CreditCardSecurityCode = crypto.Decode(Session("2004Sec"))
                                End If
                                Session("2004Sec") = String.Empty
                            End If
                        End If
                    Next

                    CheckForNewAddressesAndAddToAddressBook(Basket.ShippingAddress, Basket.BillingAddress)
                    Basket.AffiliateID = Contacts.Affiliate.GetCurrentAffiliateID()
                    Basket.Instructions = Me.SpecialInstructions.Text.Trim

                    Dim c As New BusinessRules.OrderTaskContext
                    c.UserId = SessionManager.GetCurrentUserId
                    c.Order = Basket

                    If BusinessRules.Workflow.RunByName(c, "Process New Order") Then
                        SessionManager.CurrentCartID = String.Empty
                        Response.Redirect("~/Receipt.aspx?id=" & Basket.Bvin)
                    Else
                        ' Show Errors                
                        For Each item As BusinessRules.WorkflowMessage In c.GetCustomerVisibleErrors
                            MessageBox.ShowError(item.Description)
                        Next
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub CheckForNewAddressesAndAddToAddressBook(ByVal shippingAddress As Contacts.Address, ByVal billingAddress As Contacts.Address)
        If SessionManager.IsUserAuthenticated Then
            Dim user As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
            If user.Bvin <> String.Empty Then                
                user.CheckIfNewAddressAndAdd(shippingAddress)
                user.CheckIfNewAddressAndAdd(billingAddress)
            End If
        End If
    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnBack.Click
        Response.Redirect("~/checkout/Step2.aspx")
    End Sub
End Class

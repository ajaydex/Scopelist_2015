Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Checkouts_BVC_2004_Checkout_Checkout
    Inherits BaseStoreCheckoutPage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
        StoreAddressEditorShipping.Initialize(BVSoftware.Bvc5.Core.Controls.AddressTypes.Shipping)
        StoreAddressEditorBilling.Initialize(BVSoftware.Bvc5.Core.Controls.AddressTypes.Billing)
        If Not Page.IsPostBack Then            
            StoreAddressEditorShipping.SetFocus()
            btnNext.ImageUrl = PersonalizationServices.GetThemedButton("Next")
            LoadAddresses()

            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart()

            CheckForNonShippingOrder(Basket)

            'set affiliate id
            Dim affid As String = Contacts.Affiliate.GetCurrentAffiliateID()
            If Not String.IsNullOrEmpty(affid) Then
                Basket.AffiliateID = affid
                Orders.Order.Update(Basket)
            End If

            Dim c As New BusinessRules.OrderTaskContext()
            c.Order = Basket
            c.UserId = SessionManager.GetCurrentUserId()
            BusinessRules.Workflow.RunByBvin(CType(c, BusinessRules.TaskContext), WebAppSettings.WorkflowIdCheckoutStarted)
            For Each errorMessage As BusinessRules.WorkflowMessage In c.Errors
                EventLog.LogEvent(errorMessage.Name, errorMessage.Description, Metrics.EventLogSeverity.Error)
                If errorMessage.CustomerVisible Then
                    MessageBox1.ShowError(Content.DisplayMessageType.Error)
                End If
            Next
        End If
    End Sub

    Private Sub LoadAddresses()
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart()
        If Basket.ShippingAddress.IsValid Then
            StoreAddressEditorShipping.LoadFromAddress(Basket.ShippingAddress)
            StoreAddressEditorBilling.LoadFromAddress(Basket.BillingAddress)
        Else
            If SessionManager.IsUserAuthenticated = True Then
                Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
                If u IsNot Nothing Then
                    StoreAddressEditorShipping.LoadFromAddress(u.ShippingAddress)
                    StoreAddressEditorBilling.LoadFromAddress(u.BillingAddress)
                End If
            End If
        End If        
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Checkout.master")
        Me.Title = "Checkout Step 1 of 3"        
    End Sub

    Protected Sub SameAsShippingCheckBox_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles SameAsShippingCheckBox.CheckedChanged
        BillingPanel.Visible = Not SameAsShippingCheckBox.Checked
        BillingPanel.UpdateAfterCallBack = True
    End Sub

    Public Sub AddressSelected(ByVal addressType As String, ByVal address As Contacts.Address) Handles AddressBook1.AddressSelected
        If String.Compare(addressType, "Billing", True) = 0 Then
            StoreAddressEditorBilling.LoadFromAddress(address)
            BillingPanel.UpdateAfterCallBack = True
        ElseIf String.Compare(addressType, "Shipping", True) = 0 Then
            StoreAddressEditorShipping.LoadFromAddress(address)
            ShippingPanel.UpdateAfterCallBack = True
        End If
    End Sub

    Protected Sub btnNext_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNext.Click
        If Page.IsValid Then
            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart()

            Basket.SetShippingAddress(StoreAddressEditorShipping.GetAsAddress())
            If SameAsShippingCheckBox.Checked Then
                Basket.BillingAddress = StoreAddressEditorShipping.GetAsAddress()
            Else
                Basket.BillingAddress = StoreAddressEditorBilling.GetAsAddress()
            End If

            If Basket.ShippingAddress.IsValid Then
                If Basket.BillingAddress.IsValid Then
                    If SessionManager.IsUserAuthenticated Then
                        Dim user As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
                        If user.Bvin <> String.Empty Then
                            user.CheckIfNewAddressAndAdd(Basket.BillingAddress)
                            user.CheckIfNewAddressAndAdd(Basket.ShippingAddress)
                        End If
                    End If

                    Basket.UserEmail = EmailAddressEntry1.GetUserEmail

                    If Orders.Order.Update(Basket) Then
                        Response.Redirect("~/checkout/Step2.aspx")
                    Else
                        MessageBox1.ShowError("Error Updating Shopping Cart, Please Try Again.")
                    End If
                Else
                    MessageBox1.ShowError("Billing Address Is Invalid")
                End If
            Else
                MessageBox1.ShowError("Shipping Address Is Invalid")
            End If
        End If
    End Sub

    Protected Sub CheckForNonShippingOrder(ByVal Basket As Orders.Order)        
        If WebAppSettings.HideShippingAddressForNonShippingOrders Then
            If Not Basket.HasShippingItems Then
                BillingSection.Visible = False
                SameAsShippingCheckBox.Checked = True
                ShipToHeader.InnerText = "Bill To:"
            End If
        End If        
    End Sub
End Class

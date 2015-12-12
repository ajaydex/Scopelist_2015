Imports System.Collections.ObjectModel
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web.Services
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Checkouts_One_Page_Checkout_Plus
    Inherits BaseStoreCheckoutPage

    Private _InputsAndModifiersLoaded As Boolean = False

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Checkout.master")
        Me.Title = "Checkout"
        Me.UseTabIndexes = True
    End Sub

    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
        Anthem.Manager.AddScriptForClientSideEval("init_page()")
        If Not Page.IsPostBack Then


            If WebAppSettings.AvalaraEnabled Then
                Me.Shippingaddress1Field.AutoPostBack = True
            End If

            Me.btnSubmit.ImageUrl = PersonalizationServices.GetThemedButton("PlaceOrder")
            Me.btnKeepShopping.ImageUrl = PersonalizationServices.GetThemedButton("ContinueShopping")
            Me.btnAddCoupon.ImageUrl = PersonalizationServices.GetThemedButton("Go")
            'Me.pnlBilling.Visible = Not Me.chkBillToSame.Checked

            Me.lnkPrivacyPolicy.Text = Content.SiteTerms.GetTerm("PrivacyPolicy")
            Me.UsernameLabel.Text = Content.SiteTerms.GetTerm("Username")
            Me.PasswordLabel.Text = Content.SiteTerms.GetTerm("Password")
            Me.PasswordConfirmLabel.Text = Content.SiteTerms.GetTerm("ConfirmPassword")
            Me.rxvPassword.Text = String.Format("Must be at least {0} characters", WebAppSettings.PasswordMinimumLength.ToString())
            Me.rxvPassword.ErrorMessage = String.Format("Password must be at least {0} characters", WebAppSettings.PasswordMinimumLength)
            Me.rxvPassword.ValidationExpression = "[^\s]{" & WebAppSettings.PasswordMinimumLength.ToString() & ",}"

            Me.LoyaltyPointsUsedLabel.Text = Content.SiteTerms.GetTerm("LoyaltyPointsCredit")
            Me.LoyaltyPointsEarnedLabel.Text = Content.SiteTerms.GetTerm("LoyaltyPointsEarned")

            Dim settingsManager As New Datalayer.ComponentSettingsManager("8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0")
            Dim enableAccountCreation As Boolean = settingsManager.GetBooleanSetting("EnableAccountCreation")
            Dim requireAccountCreation As Boolean = settingsManager.GetBooleanSetting("RequireAccountCreation")
            Dim promptForLogin As Boolean = settingsManager.GetBooleanSetting("PromptForLogin")
            Dim enablePromotionalCodeEntry As Boolean = settingsManager.GetBooleanSetting("EnablePromotionalCodeEntry")
            Dim enableMailingListSignup = settingsManager.GetBooleanSetting("EnableMailingListSignup")

            Me.litShippingInstructions.Text = settingsManager.GetSetting("ShippingInstructions_HtmlData")
            Me.litBillingInstructions.Text = settingsManager.GetSetting("BillingInstructions_HtmlData")
            Me.litPaymentInstructions.Text = settingsManager.GetSetting("PaymentInstructions_HtmlData")
            Me.litGiftCertificateInstructions.Text = settingsManager.GetSetting("GiftCertificateInstructions_HtmlData")
            Me.litPromotionalCodeInstructions.Text = settingsManager.GetSetting("PromotionalCodeInstructions_HtmlData")
            Me.litAccountInstructions.Text = settingsManager.GetSetting("AccountInstructions_HtmlData")
            Me.litReviewInstructions.Text = settingsManager.GetSetting("ReviewInstructions_HtmlData")

            Me.pnlCoupons.Visible = enablePromotionalCodeEntry
            Me.chkMailingListSignup.Visible = enableMailingListSignup
            Me.chkMailingListSignup.Attributes.Add("rel", settingsManager.GetSetting("MailingList"))

            If SessionManager.IsUserAuthenticated Then
                Me.pnlPassword.Visible = False
            Else
                If promptForLogin AndAlso Request.QueryString("s") <> "new" Then
                    Response.Redirect("login.aspx")
                End If

                If Not enableAccountCreation Then
                    Me.pnlPassword.Visible = False
                End If

                If requireAccountCreation Then
                    Me.UsernameLabel.CssClass += " required"
                    Me.PasswordLabel.CssClass += " required"
                    Me.PasswordConfirmLabel.CssClass += " required"
                    Me.EmailAddressLabel.CssClass += " required"
                Else
                    Me.valRequiredUsername.Enabled = False
                    Me.valPassword.Enabled = False
                    Me.valPasswordConfirm.Enabled = False
                    Me.rxvPassword.Enabled = False

                    If Not WebAppSettings.ForceEmailAddressOnAnonymousCheckout Then
                        Me.EmailAddressRequiredFieldValidator.Enabled = False
                    Else
                        Me.EmailAddressLabel.CssClass += " required"
                    End If
                End If
            End If

            Dim Basket As Orders.Order = LoadBasket()
            If Basket.BillingAddress.IsEqualTo(Basket.ShippingAddress) Then
                chkBillToSame.Checked = True
                Me.pnlBilling.Visible = False
            Else
                chkBillToSame.Checked = False
                Me.pnlBilling.Visible = True
            End If

            InitializeShippingAddress()
            InitializeBillingAddress()

            LoadAddresses(Basket)

            SetDefaultShippingMethod(Basket)
            LoadTotals(Basket)


            CheckForNonShippingOrder(Basket)
            LoadItemsGridView(Basket)

            Me.CouponGrid.DataSource = Basket.Coupons
            Me.CouponGrid.DataBind()

            'set affiliate id
            Dim affid As String = Contacts.Affiliate.GetCurrentAffiliateID()
            If Not String.IsNullOrEmpty(affid) Then
                Basket.AffiliateID = affid
                Orders.Order.Update(Basket)
            End If


            Dim c As New BusinessRules.OrderTaskContext()
            c.Order = SessionManager.CurrentShoppingCart()
            c.UserId = SessionManager.GetCurrentUserId()
            BusinessRules.Workflow.RunByName(CType(c, BusinessRules.TaskContext), "Checkout Started")
            For Each errorMessage As BusinessRules.WorkflowMessage In c.Errors
                EventLog.LogEvent(errorMessage.Name, errorMessage.Description, Metrics.EventLogSeverity.Error)
                If errorMessage.CustomerVisible Then
                    MessageBox1.ShowError(errorMessage.Description)
                End If
            Next
        End If
    End Sub

    ' Needed to show validation error for password field if user account creation is enabled, but not required
    ' Also, validates password strength
    Protected Sub cstPassword_ServerValidate(ByVal sender As Object, ByVal e As ServerValidateEventArgs) Handles cstPassword.ServerValidate
        Dim settingsManager As New Datalayer.ComponentSettingsManager("8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0")
        Dim enableAccountCreation As Boolean = settingsManager.GetBooleanSetting("EnableAccountCreation")
        Dim requireAccountCreation As Boolean = settingsManager.GetBooleanSetting("RequireAccountCreation")

        If Not String.IsNullOrEmpty(Me.UsernameField.Text) Then
            If enableAccountCreation AndAlso Not requireAccountCreation Then
                If Me.PasswordField.Text.Trim().Length < WebAppSettings.PasswordMinimumLength Then
                    cstPassword.ErrorMessage = String.Format("Password must be at least {0} characters", WebAppSettings.PasswordMinimumLength.ToString())
                    e.IsValid = False
                End If
            End If
            If Not Membership.UserAccount.IsPasswordStrong(Me.PasswordField.Text) Then
                cstPassword.ErrorMessage = "Password must contain at least one letter and one number"
                e.IsValid = False
            End If
        End If
    End Sub

    Protected Sub Page_LoadComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LoadComplete
        Me.pnlGiftCertificate.Visible = Me.ucGiftCertificates.Visible

        ' preselect payment method if there is only one
        If BVSoftware.Bvc5.Core.Payment.AvailablePayments.EnabledMethods().Where(Function(pm) pm.MethodId <> WebAppSettings.PaymentIdCash).Count = 1 + If(Me.ucGiftCertificates.Visible, 1, 0) + If(WebAppSettings.LoyaltyPointsEnabled, 1, 0) Then
            Dim paymentRadioButtons As New Generic.List(Of RadioButton)
            BVSoftware.Bvc5.Core.Controls.BVBaseControl.FindControlsByType(Me.Payment.Controls, paymentRadioButtons)
            paymentRadioButtons.First(Function(c) c.Visible = True).Checked = True

            ValidateSelections()    ' explicitly call this to uncheck payment radio buttons if a gift certificate value is greater than the order total
        End If
    End Sub

    Protected Sub btnAddCoupon_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddCoupon.Click
        MessageBox1.ClearMessage()
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        Dim couponResult As BVOperationResult = Basket.AddCouponCode(Me.CouponField.Text.Trim, True)
        If couponResult.Success = False Then
            MessageBox1.ShowError(couponResult.Message)
        Else
            UpdateShipping()    ' reload shipping rates to catch a newly applied shipping discount coupon

            Me.CouponGrid.DataSource = Basket.Coupons
            Me.CouponGrid.DataBind()
            Me.CouponField.Text = String.Empty

            LoadItemsGridView(Basket)
        End If
    End Sub

    Protected Sub CouponGrid_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles CouponGrid.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim btnDeleteCoupon As ImageButton = e.Row.FindControl("btnDeleteCoupon")
            If btnDeleteCoupon IsNot Nothing Then
                btnDeleteCoupon.ImageUrl = PersonalizationServices.GetThemedButton("x")
            End If
        End If
    End Sub

    Protected Sub CouponGrid_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles CouponGrid.RowDeleting
        Me.MessageBox1.ClearMessage()
        Dim code As String = String.Empty
        code = CStr(Me.CouponGrid.DataKeys(e.RowIndex).Value)
        If code <> String.Empty Then
            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
            Basket.RemoveCouponCode(code)
            SessionManager.InvalidateCachedCart()   ' reload order and shipping rates to catch a newly deleted shipping discount coupon
            UpdateShipping()

            Me.CouponGrid.DataSource = Basket.Coupons
            Me.CouponGrid.DataBind()
            Me.CouponField.Text = String.Empty

            LoadItemsGridView(Basket)
        End If
    End Sub

    Private Function LoadBasket() As Orders.Order
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        If Basket IsNot Nothing Then

            If Basket.Items.Count = 0 Then
                Response.Redirect("~/Default.aspx")
            End If

            If Page.IsPostBack Then ' save unnecessary API calls
                Shipping.LoadShippingMethodsForOrder(Basket, Me.ShippingpostalCodeField.Text)
            End If

            ' Shipping.ShippingProvider.GetFilteredRates (or an underlying method like GetRates) appears to be mucking with the Order object causing the choices & modifiers to lose their affect on the price. This appears to only be a problem on first visit of the checkout page until a shipping address has been entered. The fix here is to force a reload of the cart. -- actually it might be Order.ApplyShippingRate() which in turn calls Order.RecalculateProductPrices()
            SessionManager.InvalidateCachedCart()
            Basket = SessionManager.CurrentShoppingCart

            Me.SpecialInstructions.Text = Basket.Instructions

            If Basket.ShippingMethodId <> String.Empty Then
                Shipping.SetShippingMethod(Basket.ShippingMethodUniqueKey)
            End If
        End If
        Return Basket
    End Function

    Private Sub ReloadShipping(ByVal Basket As Orders.Order)
        If Basket Is Nothing Then
            Basket = SessionManager.CurrentShoppingCart
        End If
        If Basket IsNot Nothing Then
            Basket.SetShippingAddress(GetShippingAsAddress())

            ' clear selected shipping method
            Basket.ShippingMethodId = String.Empty
            Basket.ShippingProviderId = String.Empty
            Basket.ShippingProviderServiceCode = String.Empty

            If Me.chkBillToSame.Checked Then
                LoadBillingFromAddress(GetShippingAsAddress)
            End If
            Basket.BillingAddress = GetBillingAsAddress()

            Orders.Order.Update(Basket)
            Shipping.LoadShippingMethodsForOrder(Basket, Me.ShippingpostalCodeField.Text)
            SetDefaultShippingMethod(Basket)
        End If
    End Sub

    Private Sub LoadAddresses(ByVal Basket As Orders.Order)
        If SessionManager.IsUserAuthenticated = True Then
            Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
            If u IsNot Nothing Then
                Dim isBasketDirty As Boolean = False

                If Not Basket.BillingAddress.IsEmpty() Then
                    LoadBillingFromAddress(Basket.BillingAddress)
                ElseIf u.BillingAddress IsNot Nothing AndAlso Not u.BillingAddress.IsEmpty() Then
                    LoadBillingFromAddress(u.BillingAddress)
                    Basket.BillingAddress = u.BillingAddress
                    isBasketDirty = True
                End If

                If Not Basket.ShippingAddress.IsEmpty() Then
                    LoadShippingFromAddress(Basket.ShippingAddress)
                ElseIf u.ShippingAddress IsNot Nothing AndAlso Not u.ShippingAddress.IsEmpty() Then
                    LoadShippingFromAddress(u.ShippingAddress)
                    Basket.SetShippingAddress(u.ShippingAddress)
                    isBasketDirty = True
                End If

                If isBasketDirty Then
                    Orders.Order.Update(Basket)
                End If

                If Page.IsPostBack Then ' save unnecessary API calls
                    ReloadShipping(Basket)
                End If

                'Load Account Email Address if logged in.
                Me.EmailAddressField.Visible = False
                Me.EmailAddressRequiredFieldValidator.Visible = False
                Me.BVRegularExpressionValidator1.Visible = False
                Me.EmailAddressText.Visible = True
                Me.EmailAddressText.Text = u.Email
                Me.EmailAddressLabel.AssociatedControlID = ""
            End If
        Else
            ' Enter Email Address if not logged in.
            Me.EmailAddressField.Visible = True
            If Not String.IsNullOrEmpty(Basket.UserEmail) Then
                Me.EmailAddressField.Text = Basket.UserEmail
            Else
                Me.EmailAddressField.Text = ""
            End If
            Me.EmailAddressRequiredFieldValidator.Visible = True
            Me.BVRegularExpressionValidator1.Visible = True
            Me.EmailAddressText.Visible = False
            Me.EmailAddressLabel.AssociatedControlID = "EmailAddressField"

            ' Repopulate address from order if already entered
            If Not Basket.BillingAddress.IsEmpty() Then
                LoadBillingFromAddress(Basket.BillingAddress)
            End If
            If Not Basket.ShippingAddress.IsEmpty() Then
                LoadShippingFromAddress(Basket.ShippingAddress)
            End If

            If Basket.BillingAddress.IsEqualTo(Basket.ShippingAddress) Then
                chkBillToSame.Checked = True
                Me.pnlBilling.Visible = False
            Else
                chkBillToSame.Checked = False
                Me.pnlBilling.Visible = True
            End If
        End If
    End Sub

    Private Sub SaveAddressesToUser()
        If SessionManager.IsUserAuthenticated = True Then
            Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
            If Not String.IsNullOrEmpty(u.Bvin) Then
                If u.BillingAddress.IsEmpty() Then
                    GetBillingAsAddress.CopyTo(u.BillingAddress)
                End If

                If u.ShippingAddress.IsEmpty() Then
                    GetShippingAsAddress.CopyTo(u.ShippingAddress)
                End If

                Membership.UserAccount.Update(u)
            End If
        End If
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
        If Me.ValidateCheckout() Then
            Dim result As Boolean = False
            Dim u As Membership.UserAccount = Nothing
            Dim s As Membership.CreateUserStatus = Membership.CreateUserStatus.None

            If SessionManager.IsUserAuthenticated Then
                u = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId())
                result = True
            Else
                Dim userName = Me.UsernameField.Text.Trim()
                If Not String.IsNullOrEmpty(userName) Then
                    If Me.PasswordField.Text.Trim().Length < WebAppSettings.PasswordMinimumLength Then
                        Exit Sub
                    End If

                    u = Membership.UserAccount.FindByUserName(userName)
                    If Not String.IsNullOrEmpty(u.Bvin) Then
                        s = Membership.CreateUserStatus.DuplicateUsername
                    Else
                        u.Email = Me.EmailAddressField.Text.Trim()
                        u.FirstName = Me.ShippingfirstNameField.Text.Trim()
                        u.LastName = Me.ShippinglastNameField.Text.Trim()
                        u.PasswordAnswer = String.Empty
                        u.PasswordHint = String.Empty
                        u.UserName = userName
                        u.PasswordFormat = WebAppSettings.PasswordDefaultEncryption
                        u.Password = Me.PasswordField.Text.Trim()
                        result = Membership.UserAccount.Insert(u, s)
                    End If
                Else
                    result = True
                End If
            End If

            If result = False Then
                Select Case s
                    Case Membership.CreateUserStatus.DuplicateUsername
                        MessageBox1.ShowError("That username already exists. Select another username.")
                        Exit Sub
                    Case Else
                        MessageBox1.ShowError("Unable to save user. Unknown error.")
                        Exit Sub
                End Select
            Else
                If u IsNot Nothing AndAlso Not String.IsNullOrEmpty(u.Bvin) Then
                    Me.BvinField.Value = u.Bvin
                    SessionManager.SetCurrentUserId(u.Bvin, True)
                End If
            End If

            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
            If Basket IsNot Nothing Then
                CheckForNewAddressesAndAddToAddressBook()

                If Me.chkBillToSame.Checked Then
                    LoadBillingFromAddress(GetShippingAsAddress)
                End If

                ' Save Information to Basket in Case Save as Order Fails
                Basket.BillingAddress = GetBillingAsAddress()
                Basket.SetShippingAddress(GetShippingAsAddress())
                SaveAddressesToUser()

                ' Save Shipping Selection
                Dim r As Shipping.ShippingRate = Shipping.FindSelectedRate(Basket)
                Basket.ApplyShippingRate(r)

                ' Save Payment Information                    
                Payment.SavePaymentInfo(Basket)

                If WebAppSettings.LoyaltyPointsEnabled Then
                    ' tag order to receive loyalty points
                    Basket.CustomPropertySet("Develisys", "ValidForLoyaltyPoints", Boolean.TrueString)

                    Dim pointsUsedCurrency As Decimal = 0D
                    If Decimal.TryParse(Basket.CustomPropertyGet("Develisys", "LoyaltyPointsDebitCurrency"), pointsUsedCurrency) AndAlso pointsUsedCurrency > 0 Then
                        Dim op As New Orders.OrderPayment()
                        op.PaymentMethodName = New Payment.Method.LoyaltyPoints().MethodName
                        op.PaymentMethodId = WebAppSettings.PaymentIdLoyaltyPoints
                        op.OrderID = Basket.Bvin

                        If Not Basket.AddPayment(op) Then
                            AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Plugins, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, "Loyalty Points", "Unable to save loyalty points payment to order")
                        End If
                    End If
                End If

                Basket.AffiliateID = Contacts.Affiliate.GetCurrentAffiliateID()
                Basket.Instructions = Me.SpecialInstructions.Text.Trim()
                Basket.UserEmail = Me.EmailAddressField.Text

                Orders.Order.Update(Basket)
                SubscribeUserToMailingList(Basket)

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
                    If BusinessRules.Workflow.RunByName(c, "Process New Order") = True Then
                        SessionManager.CurrentCartID = String.Empty
                        Response.Redirect("~/Receipt.aspx?id=" & Basket.Bvin)
                    Else
                        ' Show Errors                
                        For Each item As BusinessRules.WorkflowMessage In c.GetCustomerVisibleErrors
                            MessageBox1.ShowError(item.Description)
                        Next
                    End If
                End If
            End If
        End If
    End Sub

    Private Function ValidateSelections() As Boolean
        Dim result As Boolean = True

        If Me.chkBillToSame.Checked = False Then
            If Not ValidateBillingAddress() Then
                result = False
            End If
        End If

        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        Dim gcs As Collection(Of Catalog.GiftCertificate) = Basket.GetGiftCertificates()
        Dim totalValue As Double = 0D
        For Each item As Catalog.GiftCertificate In gcs
            totalValue += item.CurrentAmount
        Next

        Dim paymentFound As Boolean = False
        Basket.CalculateGrandTotalOnly(False, False)
        If (totalValue >= Basket.GrandTotal) Then
            paymentFound = True

            ' deselect all other payment methods
            Dim paymentRadioButtons As New Generic.List(Of RadioButton)
            BVSoftware.Bvc5.Core.Controls.BVBaseControl.FindControlsByType(Me.Payment.Controls, paymentRadioButtons)
            For Each rb As RadioButton In paymentRadioButtons
                rb.Checked = False
            Next
        End If

        If Not Shipping.IsValid Then
            result = False
        End If

        If (Not Payment.IsValid) AndAlso (Not paymentFound) Then
            For Each item As String In Payment.Errors
                MessageBox1.ShowError(item)
            Next
            result = False

            Me.cvPaymentMethod.IsValid = False
            Me.cvPaymentMethod.ErrorMessage = String.Empty
            Me.cvPaymentMethodDetail.IsValid = False
            Me.cvPaymentMethodDetail.ErrorMessage = String.Empty
            If Payment.Errors.Count = 1 AndAlso Payment.Errors(Payment.Errors.Count - 1) = "Please select a payment method." Then
                Me.cvPaymentMethod.ErrorMessage = "Required"
            Else
                For Each item As String In Payment.Errors
                    If Me.cvPaymentMethodDetail.ErrorMessage.Length > 0 Then
                        Me.cvPaymentMethodDetail.ErrorMessage += "<br/>"
                    End If

                    Me.cvPaymentMethodDetail.ErrorMessage += item
                Next
            End If
        Else
            paymentFound = True
        End If

        If Not paymentFound Then
            result = False
        End If

        Return result
    End Function

    Protected Sub btnKeepShopping_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnKeepShopping.Click
        Dim destination As String = "~"

        If SessionManager.CategoryLastId <> String.Empty Then
            Dim c As Catalog.Category = Catalog.Category.FindByBvin(SessionManager.CategoryLastId)
            If c IsNot Nothing Then
                If c.Bvin <> String.Empty Then
                    destination = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, Catalog.Category.FindAllLight())
                End If
            End If
        End If

        Response.Redirect(destination)
    End Sub

    Protected Sub chkBillToSame_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkBillToSame.CheckedChanged
        UpdateBilling()
        Me.pnlBilling.Visible = Not Me.chkBillToSame.Checked
        Me.pnlBilling.UpdateAfterCallBack = True
        Me.pnlShipping.UpdateAfterCallBack = True
        UpdateShippingVisibleRows()
    End Sub

    'needed to take tax into account when it is being calculated by billing address
    Protected Sub UpdateBilling()
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        If Me.chkBillToSame.Checked Then
            LoadBillingFromAddress(GetShippingAsAddress)
        End If
        Basket.BillingAddress = GetBillingAsAddress()
        Orders.Order.Update(Basket)
        LoadTotals(Basket)
    End Sub

#Region " Address Code "

    Public Sub InitializeShippingAddress()
        Me.ShippinglblStateError.Visible = False
        PopulateCountries(Me.ShippinglstCountry)
        If Me.ShippinglstCountry.Items.FindByValue(WebAppSettings.SiteCountryBvin) IsNot Nothing Then
            Me.ShippinglstCountry.ClearSelection()
            Me.ShippinglstCountry.SelectedValue = WebAppSettings.SiteCountryBvin
        End If
        PopulateRegions(WebAppSettings.SiteCountryBvin, Me.ShippinglstState, Me.ShippingstateField)
        PopulateCounties(Me.ShippinglstState.SelectedValue, Me.ShippingCountyField, Me.ShippinglstState)
        UpdateShippingVisibleRows()
    End Sub

    Public Sub InitializeBillingAddress()
        Me.BillinglblStateError.Visible = False
        PopulateCountries(Me.BillinglstCountry)
        If Me.BillinglstCountry.Items.FindByValue(WebAppSettings.SiteCountryBvin) IsNot Nothing Then
            Me.BillinglstCountry.ClearSelection()
            Me.BillinglstCountry.SelectedValue = WebAppSettings.SiteCountryBvin
        End If
        PopulateRegions(WebAppSettings.SiteCountryBvin, Me.BillinglstState, Me.BillingstateField)
        PopulateCounties(Me.BillinglstState.SelectedValue, Me.BillingCountyField, Me.BillinglstState)
        UpdateBillingVisibleRows()
    End Sub

    Private Sub PopulateCountries(ByVal lst As DropDownList)
        lst.DataSource = Content.Country.FindActive
        lst.DataValueField = "Bvin"
        lst.DataTextField = "DisplayName"
        lst.DataBind()
    End Sub

    Private Sub PopulateRegions(ByVal countryCode As String, ByVal lst As DropDownList, ByVal alt As TextBox)
        lst.Items.Clear()
        Try
            lst.DataSource = Content.Region.FindByCountry(countryCode).OrderBy(Function(r) r.Abbreviation)  ' sort by Abbreviation rather than Name
            lst.DataTextField = "abbreviation"
            lst.DataValueField = "bvin"
            lst.DataBind()

            If lst.Items.Count() < 1 Then
                lst.Visible = False
                alt.Visible = True
                If lst.Equals(ShippinglstState) Then
                    ShippingStateListRequiredFieldValidator.Enabled = False
                    ShippingStateListRequiredFieldValidator.Visible = False
                    ShippingStateLabel.AssociatedControlID = alt.ID
                ElseIf lst.Equals(BillinglstState) Then
                    BillinglstStateRequiredFieldValidator.Enabled = False
                    BillinglstStateRequiredFieldValidator.Visible = False
                    BillingStateLabel.AssociatedControlID = alt.ID
                End If
            Else
                lst.Visible = True
                alt.Visible = False
                If lst.Equals(ShippinglstState) Then
                    ShippingStateListRequiredFieldValidator.Enabled = True
                    ShippingStateListRequiredFieldValidator.Visible = True
                    ShippingStateLabel.AssociatedControlID = lst.ID
                ElseIf lst.Equals(BillinglstState) Then
                    BillinglstStateRequiredFieldValidator.Enabled = True
                    BillinglstStateRequiredFieldValidator.Visible = True
                    BillingStateLabel.AssociatedControlID = lst.ID
                End If
                lst.Items.Insert(0, New ListItem("--", ""))
            End If

        Catch Ex As Exception
            EventLog.LogEvent(Ex)
        End Try
    End Sub

    Private Sub PopulateCounties(ByVal regionID As String, ByVal countylst As DropDownList, ByVal statelst As DropDownList)
        countylst.Items.Clear()

        If statelst.Visible Then
            countylst.DataSource = Content.County.FindByRegion(regionID)
            countylst.DataTextField = "Name"
            countylst.DataValueField = "bvin"
            countylst.DataBind()

            If countylst.Items.Count < 1 Then
                countylst.Visible = False
                If countylst.Parent IsNot Nothing AndAlso (TypeOf (countylst.Parent) Is HtmlControl OrElse TypeOf (countylst.Parent) Is Control) Then
                    countylst.Parent.Visible = False
                End If
            Else
                countylst.Visible = True
                If countylst.Parent IsNot Nothing AndAlso (TypeOf (countylst.Parent) Is HtmlControl OrElse TypeOf (countylst.Parent) Is Control) Then
                    countylst.Parent.Visible = True
                End If
            End If
        Else
            countylst.Visible = False
            If countylst.Parent IsNot Nothing AndAlso (TypeOf (countylst.Parent) Is HtmlControl OrElse TypeOf (countylst.Parent) Is Control) Then
                countylst.Parent.Visible = False
            End If
        End If
    End Sub

    Private Sub UpdateShippingVisibleRows()

        Me.ShippingValFirstNameField.Enabled = WebAppSettings.ShipAddressRequireFirstName OrElse (Me.chkBillToSame.Checked AndAlso WebAppSettings.BillAddressRequireFirstName)
        Me.lblShippingFirstNameField.CssClass = If(Me.ShippingValFirstNameField.Enabled, " required", String.Empty)
        Me.ShippingvalLastName.Enabled = WebAppSettings.ShipAddressRequireLastName OrElse (Me.chkBillToSame.Checked AndAlso WebAppSettings.BillAddressRequireLastName)
        Me.lblShippingLastNameField.CssClass = If(Me.ShippingvalLastName.Enabled, "required", String.Empty)
        Me.ShippingvalAddress.Enabled = True
        Me.lblShippingaddress1Field.CssClass = "required"
        Me.ShippingvalCity.Enabled = True
        Me.lblShippingCityField.CssClass = "required"
        Me.ShippingStateLabel.CssClass = "required"
        Me.ShippingvalPostalCode.Enabled = True
        Me.ShippingPostalCodeLabel.CssClass = "required"
        Me.lblShipping1stCountry.CssClass = "required"

        If WebAppSettings.ShipAddressShowMiddleInitial = True OrElse (Me.chkBillToSame.Checked AndAlso WebAppSettings.BillAddressShowMiddleInitial) Then
            Me.ShippingMiddleInitialField.Visible = True
            Me.lblShippingMiddleInitialField.Visible = True
            Me.ShippingfirstNameField.CssClass = "forminput medium"
        Else
            Me.ShippingMiddleInitialField.Visible = False
            Me.lblShippingMiddleInitialField.Visible = False

            If Me.ShippingMiddleInitialField.Parent IsNot Nothing AndAlso TypeOf (Me.ShippingMiddleInitialField.Parent) Is HtmlControl Then
                Me.ShippingMiddleInitialField.Parent.Visible = False
            End If

            Me.ShippingfirstNameField.CssClass = "forminput"
        End If

        If WebAppSettings.ShipAddressShowCompany = True OrElse (Me.chkBillToSame.Checked AndAlso WebAppSettings.BillAddressShowCompany) Then
            Me.ShippingCompanyNameRow.Visible = True
            Me.ShippingvalCompany.Enabled = WebAppSettings.ShipAddressRequireCompany OrElse (Me.chkBillToSame.Checked AndAlso WebAppSettings.BillAddressRequireCompany)
            Me.lblShippingCompanyField.CssClass = If(Me.ShippingvalCompany.Enabled, "required", String.Empty)
        Else
            Me.ShippingvalCompany.Enabled = False
            Me.ShippingCompanyNameRow.Visible = False
        End If

        If WebAppSettings.ShipAddressShowPhone = True OrElse (Me.chkBillToSame.Checked AndAlso WebAppSettings.BillAddressShowPhone) Then
            Me.ShippingPhoneRow.Visible = True
            Me.ShippingvalPhone.Enabled = WebAppSettings.ShipAddressRequirePhone OrElse (Me.chkBillToSame.Checked AndAlso WebAppSettings.BillAddressRequirePhone)
            Me.lblShippingPhoneNumberField.CssClass = If(Me.ShippingvalPhone.Enabled, "required", String.Empty)
        Else
            Me.ShippingvalPhone.Enabled = False
            Me.ShippingPhoneRow.Visible = False
        End If

        If WebAppSettings.ShipAddressShowFax = True OrElse (Me.chkBillToSame.Checked AndAlso WebAppSettings.BillAddressShowFax) Then
            Me.ShippingFaxRow.Visible = True
            Me.ShippingvalFax.Enabled = WebAppSettings.ShipAddressRequireFax OrElse (Me.chkBillToSame.Checked AndAlso WebAppSettings.BillAddressRequireFax)
            Me.lblShippingFaxNumberField.CssClass = If(Me.ShippingvalFax.Enabled, "required", String.Empty)
        Else
            Me.ShippingvalFax.Enabled = False
            Me.ShippingFaxRow.Visible = False
        End If

        If WebAppSettings.ShipAddressShowWebSiteURL = True OrElse (Me.chkBillToSame.Checked AndAlso WebAppSettings.BillAddressRequireWebSiteURL) Then
            Me.ShippingWebSiteURLRow.Visible = True
            Me.ShippingvalWebSite.Enabled = WebAppSettings.ShipAddressRequireWebSiteURL OrElse (WebAppSettings.BillAddressRequireWebSiteURL)
            Me.lblShippingWebSiteURLField.CssClass = If(Me.ShippingvalWebSite.Enabled, "required", String.Empty)
        Else
            Me.ShippingvalWebSite.Enabled = False
            Me.ShippingWebSiteURLRow.Visible = False
        End If
    End Sub

    Private Sub UpdateBillingVisibleRows()

        Me.BillingValFirstNameField.Enabled = WebAppSettings.BillAddressRequireFirstName
        Me.lblBillingfirstNameField.CssClass = If(Me.BillingValFirstNameField.Enabled, "required", String.Empty)
        Me.BillingvalLastName.Enabled = WebAppSettings.BillAddressRequireLastName
        Me.lblBillinglastNameField.CssClass = If(Me.BillingvalLastName.Enabled, "required", String.Empty)
        Me.BillingvalAddress.Enabled = True
        Me.lblBillingaddress1Field.CssClass = "required"
        Me.BillingvalCity.Enabled = True
        Me.lblBillingcityField.CssClass = "required"
        Me.BillingStateLabel.CssClass = "required"
        Me.BillingvalPostalCode.Enabled = True
        Me.BillingpostalCodeLabel.CssClass = "required"
        Me.lblBillinglstCountry.CssClass = "required"

        If WebAppSettings.BillAddressShowMiddleInitial = True Then
            Me.BillingMiddleInitialField.Visible = True
            Me.lblBillingMiddleInitialField.Visible = True
            Me.BillingfirstNameField.CssClass = "forminput medium"
        Else
            Me.BillingMiddleInitialField.Visible = False
            Me.lblBillingMiddleInitialField.Visible = False

            If Me.BillingMiddleInitialField.Parent IsNot Nothing AndAlso TypeOf (Me.BillingMiddleInitialField.Parent) Is HtmlControl Then
                Me.BillingMiddleInitialField.Parent.Visible = False
            End If

            Me.BillingfirstNameField.CssClass = "forminput"
        End If

        If WebAppSettings.BillAddressShowCompany = True Then
            Me.BillingCompanyNameRow.Visible = True
            Me.BillingvalCompany.Enabled = WebAppSettings.BillAddressRequireCompany
            Me.lblBillingCompanyField.CssClass = If(Me.BillingvalCompany.Enabled, "required", String.Empty)
        Else
            Me.BillingvalCompany.Enabled = False
            Me.BillingCompanyNameRow.Visible = False
        End If

        If WebAppSettings.BillAddressShowPhone = True Then
            Me.BillingPhoneRow.Visible = True
            Me.BillingvalPhone.Enabled = WebAppSettings.BillAddressRequirePhone
            Me.lblBillingPhoneNumberField.CssClass = If(Me.BillingvalPhone.Enabled, "required", String.Empty)
        Else
            Me.BillingvalPhone.Enabled = False
            Me.BillingPhoneRow.Visible = False
        End If

        If WebAppSettings.BillAddressShowFax = True Then
            Me.BillingFaxRow.Visible = True
            Me.BillingvalFax.Enabled = WebAppSettings.BillAddressRequireFax
            Me.lblBillingFaxNumberField.CssClass = If(Me.BillingvalFax.Enabled, "required", String.Empty)
        Else
            Me.BillingvalFax.Enabled = False
            Me.BillingFaxRow.Visible = False
        End If

        If WebAppSettings.BillAddressShowWebSiteUrl = True Then
            Me.BillingWebSiteURLRow.Visible = True
            Me.BillingvalWebSite.Enabled = WebAppSettings.BillAddressRequireWebSiteURL
            Me.lblBillingWebSiteURLField.CssClass = If(Me.BillingvalWebSite.Enabled, "required", String.Empty)
        Else
            Me.BillingvalWebSite.Enabled = False
            Me.BillingWebSiteURLRow.Visible = False
        End If
    End Sub

    Public Function ValidateShippingAddress() As Boolean
        Dim result As Boolean = True
        Me.ShippinglblStateError.Visible = False

        Me.ShippingvalAddress.Validate()
        If Me.ShippingvalAddress.IsValid = False Then
            result = False
        End If
        Me.ShippingValFirstNameField.Validate()
        If Me.ShippingValFirstNameField.IsValid = False Then
            result = False
        End If
        Me.ShippingvalLastName.Validate()
        If Me.ShippingvalLastName.IsValid = False Then
            result = False
        End If
        Me.ShippingvalCity.Validate()
        If Me.ShippingvalCity.IsValid = False Then
            result = False
        End If
        Me.ShippingvalPostalCode.Validate()
        If Me.ShippingvalPostalCode.IsValid = False Then
            result = False
        End If

        If WebAppSettings.ShipAddressRequireCompany = True Then
            Me.ShippingvalCompany.Validate()
            If Me.ShippingvalCompany.IsValid = False Then
                result = False
            End If
        End If

        If WebAppSettings.ShipAddressRequirePhone = True Then
            Me.ShippingvalPhone.Validate()
            If Me.ShippingvalPhone.IsValid = False Then
                result = False
            End If
            If Me.ShippingPhoneNumberField.Text.Trim.Length < 7 Then
                result = False
                Me.ShippingvalPhone.IsValid = False
            End If

        End If

        If WebAppSettings.ShipAddressRequireFax = True Then
            Me.ShippingvalFax.Validate()
            If Me.ShippingvalFax.IsValid = False Then
                result = False
            End If
        End If

        If WebAppSettings.ShipAddressRequireWebSiteURL = True Then
            Me.ShippingvalWebSite.Validate()
            If Me.ShippingvalWebSite.IsValid = False Then
                result = False
            End If
        End If

        If Me.ShippinglstState.Items.Count > 1 Then
            If Me.ShippinglstState.SelectedIndex = 0 Then
                Me.ShippinglblStateError.Visible = True
                result = False
            End If
        End If

        Return result
    End Function

    Public Function ValidateBillingAddress() As Boolean
        Dim result As Boolean = True
        Me.BillinglblStateError.Visible = False

        Me.BillingvalAddress.Validate()
        If Me.BillingvalAddress.IsValid = False Then
            result = False
        End If
        Me.BillingValFirstNameField.Validate()
        If Me.BillingValFirstNameField.IsValid = False Then
            result = False
        End If
        Me.BillingvalLastName.Validate()
        If Me.BillingvalLastName.IsValid = False Then
            result = False
        End If
        Me.BillingvalCity.Validate()
        If Me.BillingvalCity.IsValid = False Then
            result = False
        End If
        Me.BillingvalPostalCode.Validate()
        If Me.BillingvalPostalCode.IsValid = False Then
            result = False
        End If

        If WebAppSettings.BillAddressRequireCompany = True Then
            Me.BillingvalCompany.Validate()
            If Me.BillingvalCompany.IsValid = False Then
                result = False
            End If
        End If

        If WebAppSettings.BillAddressRequirePhone = True Then
            Me.BillingvalPhone.Validate()
            If Me.BillingvalPhone.IsValid = False Then
                result = False
            End If
            If Me.BillingPhoneNumberField.Text.Trim.Length < 7 Then
                result = False
                Me.BillingvalPhone.IsValid = False
            End If

        End If

        If WebAppSettings.BillAddressRequireFax = True Then
            Me.BillingvalFax.Validate()
            If Me.BillingvalFax.IsValid = False Then
                result = False
            End If
        End If

        If WebAppSettings.BillAddressRequireWebSiteURL = True Then
            Me.BillingvalWebSite.Validate()
            If Me.BillingvalWebSite.IsValid = False Then
                result = False
            End If
        End If

        If Me.BillinglstState.Items.Count > 1 Then
            If Me.BillinglstState.SelectedIndex = 0 Then
                Me.BillinglblStateError.Visible = True
                result = False
            End If
        End If

        Return result
    End Function

    Public Sub LoadShippingFromAddress(ByVal a As Contacts.Address)
        InitializeShippingAddress()
        If Not a Is Nothing Then
            Me.ShippingAddressBvin.Value = a.Bvin
            If Me.ShippinglstCountry.Items.FindByValue(a.CountryBvin) IsNot Nothing Then
                Me.ShippinglstCountry.ClearSelection()
                Me.ShippinglstCountry.Items.FindByValue(a.CountryBvin).Selected = True
            End If
            Me.PopulateRegions(Me.ShippinglstCountry.SelectedValue, Me.ShippinglstState, Me.ShippingstateField)
            If Me.ShippinglstState.Items.Count > 0 Then
                Me.ShippinglstState.ClearSelection()
                If Me.ShippinglstState.Items.FindByValue(a.RegionBvin) IsNot Nothing Then
                    Me.ShippinglstState.Items.FindByValue(a.RegionBvin).Selected = True
                End If
            End If
            Me.PopulateCounties(Me.ShippinglstState.SelectedValue, Me.ShippingCountyField, Me.ShippinglstState)
            If Me.ShippingCountyField.Items.Count > 0 Then
                Me.ShippingCountyField.ClearSelection()
                If Me.ShippingCountyField.Items.FindByValue(a.CountyBvin) IsNot Nothing Then
                    Me.ShippingCountyField.Items.FindByValue(a.CountyBvin).Selected = True
                End If
            End If

            Me.ShippingstateField.Text = a.RegionName
            Me.ShippingfirstNameField.Text = a.FirstName
            Me.ShippingMiddleInitialField.Text = a.MiddleInitial
            Me.ShippinglastNameField.Text = a.LastName
            Me.ShippingCompanyField.Text = a.Company
            Me.Shippingaddress1Field.Text = a.Line1
            Me.Shippingaddress2Field.Text = a.Line2
            Me.ShippingcityField.Text = a.City
            Me.ShippingpostalCodeField.Text = a.PostalCode
            Me.ShippingPhoneNumberField.Text = a.Phone
            Me.ShippingFaxNumberField.Text = a.Fax
            Me.ShippingWebSiteURLField.Text = a.WebSiteUrl
        End If
    End Sub

    Public Sub LoadBillingFromAddress(ByVal a As Contacts.Address)
        InitializeBillingAddress()
        If Not a Is Nothing Then
            Me.BillingAddressBvin.Value = a.Bvin
            If Me.BillinglstCountry.Items.FindByValue(a.CountryBvin) IsNot Nothing Then
                Me.BillinglstCountry.ClearSelection()
                Me.BillinglstCountry.Items.FindByValue(a.CountryBvin).Selected = True
            End If
            Me.PopulateRegions(Me.BillinglstCountry.SelectedValue, Me.BillinglstState, Me.BillingstateField)
            If Me.BillinglstState.Items.Count > 0 Then
                Me.BillinglstState.ClearSelection()
                If Me.BillinglstState.Items.FindByValue(a.RegionBvin) IsNot Nothing Then
                    Me.BillinglstState.Items.FindByValue(a.RegionBvin).Selected = True
                End If
            End If
            Me.PopulateCounties(Me.BillinglstState.SelectedValue, Me.BillingCountyField, Me.ShippinglstState)
            If Me.BillingCountyField.Items.Count > 0 Then
                Me.BillingCountyField.ClearSelection()
                If Me.BillingCountyField.Items.FindByValue(a.CountyBvin) IsNot Nothing Then
                    Me.BillingCountyField.Items.FindByValue(a.CountyBvin).Selected = True
                End If
            End If

            Me.BillingstateField.Text = a.RegionName
            Me.BillingfirstNameField.Text = a.FirstName
            Me.BillingMiddleInitialField.Text = a.MiddleInitial
            Me.BillinglastNameField.Text = a.LastName
            Me.BillingCompanyField.Text = a.Company
            Me.Billingaddress1Field.Text = a.Line1
            Me.Billingaddress2Field.Text = a.Line2
            Me.BillingcityField.Text = a.City
            Me.BillingpostalCodeField.Text = a.PostalCode
            Me.BillingPhoneNumberField.Text = a.Phone
            Me.BillingFaxNumberField.Text = a.Fax
            Me.BillingWebSiteURLField.Text = a.WebSiteUrl
        End If
    End Sub

    Public Function GetShippingAsAddress() As Contacts.Address
        Dim a As New Contacts.Address
        If ShippinglstCountry.Items.Count > 0 Then
            a.CountryBvin = ShippinglstCountry.SelectedValue
            a.CountryName = ShippinglstCountry.SelectedItem.ToString
        Else
            a.CountryBvin = ""
            a.CountryName = "Unknown"
        End If
        If ShippinglstState.Items.Count > 0 Then
            a.RegionName = ShippinglstState.SelectedItem.Text
            a.RegionBvin = ShippinglstState.SelectedItem.Value
        Else
            a.RegionName = ShippingstateField.Text.Trim()
            a.RegionBvin = ""
        End If
        If Me.ShippingCountyField.Items.Count > 0 Then
            a.CountyBvin = Me.ShippingCountyField.SelectedValue
            a.CountyName = Me.ShippingCountyField.SelectedItem.Text
        Else
            a.CountyBvin = String.Empty
            a.CountyName = String.Empty
        End If
        a.FirstName = Me.ShippingfirstNameField.Text.Trim
        a.MiddleInitial = Me.ShippingMiddleInitialField.Text.Trim
        a.LastName = Me.ShippinglastNameField.Text.Trim
        a.Company = Me.ShippingCompanyField.Text.Trim
        a.Line1 = Me.Shippingaddress1Field.Text.Trim
        a.Line2 = Me.Shippingaddress2Field.Text.Trim
        a.City = Me.ShippingcityField.Text.Trim
        a.PostalCode = Me.ShippingpostalCodeField.Text.Trim
        a.Phone = Me.ShippingPhoneNumberField.Text.Trim
        a.Fax = Me.ShippingFaxNumberField.Text.Trim
        a.WebSiteUrl = Me.ShippingWebSiteURLField.Text.Trim
        If Me.ShippingAddressBvin.Value <> String.Empty Then
            a.Bvin = Me.ShippingAddressBvin.Value
        End If
        Return a
    End Function

    Public Function GetBillingAsAddress() As Contacts.Address
        If Me.chkBillToSame.Checked Then
            Return GetShippingAsAddress()
        End If

        Dim a As New Contacts.Address
        If BillinglstCountry.Items.Count > 0 Then
            a.CountryBvin = BillinglstCountry.SelectedValue
            a.CountryName = BillinglstCountry.SelectedItem.ToString
        Else
            a.CountryBvin = ""
            a.CountryName = "Unknown"
        End If
        If BillinglstState.Items.Count > 0 Then
            a.RegionName = BillinglstState.SelectedItem.Text
            a.RegionBvin = BillinglstState.SelectedItem.Value
        Else
            a.RegionName = BillingstateField.Text.Trim()
            a.RegionBvin = ""
        End If
        If Me.BillingCountyField.Items.Count > 0 Then
            a.CountyBvin = Me.BillingCountyField.SelectedValue
            a.CountyName = Me.BillingCountyField.SelectedItem.Text
        Else
            a.CountyBvin = String.Empty
            a.CountyName = String.Empty
        End If
        a.FirstName = Me.BillingfirstNameField.Text.Trim
        a.MiddleInitial = Me.BillingMiddleInitialField.Text.Trim
        a.LastName = Me.BillinglastNameField.Text.Trim
        a.Company = Me.BillingCompanyField.Text.Trim
        a.Line1 = Me.Billingaddress1Field.Text.Trim
        a.Line2 = Me.Billingaddress2Field.Text.Trim
        a.City = Me.BillingcityField.Text.Trim
        a.PostalCode = Me.BillingpostalCodeField.Text.Trim
        a.Phone = Me.BillingPhoneNumberField.Text.Trim
        a.Fax = Me.BillingFaxNumberField.Text.Trim
        a.WebSiteUrl = Me.BillingWebSiteURLField.Text.Trim
        If Me.BillingAddressBvin.Value <> String.Empty Then
            a.Bvin = Me.BillingAddressBvin.Value
        End If
        Return a
    End Function

    Protected Sub LoadPostalRegex(ByVal addressType As Controls.AddressTypes)
        Dim country As Content.Country = Nothing
        Dim postalCodeRegularExpressionValidator As Controls.BVRegularExpressionValidator = Nothing
        If addressType = BVSoftware.Bvc5.Core.Controls.AddressTypes.Shipping Then
            country = Content.Country.FindByBvin(ShippinglstCountry.SelectedValue)
            postalCodeRegularExpressionValidator = ShippingPostalCodeBVRegularExpressionValidator
        Else
            country = Content.Country.FindByBvin(BillinglstCountry.SelectedValue)
            postalCodeRegularExpressionValidator = BillingPostalCodeBVRegularExpressionValidator
        End If

        If country IsNot Nothing AndAlso (Not String.IsNullOrEmpty(country.Bvin)) Then
            If String.IsNullOrEmpty(country.GetStoreSidePostalValidationRegex()) Then
                postalCodeRegularExpressionValidator.Enabled = False
            Else
                postalCodeRegularExpressionValidator.Enabled = True
            End If
            postalCodeRegularExpressionValidator.ValidationExpression = country.GetStoreSidePostalValidationRegex()
        Else
            postalCodeRegularExpressionValidator.ValidationExpression = String.Empty
            postalCodeRegularExpressionValidator.Enabled = False
        End If
        postalCodeRegularExpressionValidator.UpdateAfterCallBack = True
    End Sub

    Protected Sub ShippinglstCountry_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles ShippinglstCountry.Load
        LoadPostalRegex(BVSoftware.Bvc5.Core.Controls.AddressTypes.Shipping)
    End Sub

    Private Sub ShippinglstCountry_SelectedIndexChanged(ByVal Sender As Object, ByVal E As EventArgs) Handles ShippinglstCountry.SelectedIndexChanged
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        PopulateRegions(ShippinglstCountry.SelectedItem.Value, Me.ShippinglstState, Me.ShippingstateField)
        If Me.ShippinglstState.SelectedItem IsNot Nothing Then
            PopulateCounties(Me.ShippinglstState.SelectedItem.Value, Me.ShippingCountyField, Me.ShippinglstState)
        Else
            PopulateCounties("", Me.ShippingCountyField, Me.ShippinglstState)
        End If

        ReloadShipping(Basket)
        ShippinglstState.UpdateAfterCallBack = True
        ShippingstateField.UpdateAfterCallBack = True
        ShippingCountyField.UpdateAfterCallBack = True
        Shipping.AutoUpdateAfterCallBack()
        Me.ShippingpostalCodeField.UpdateAfterCallBack = True
        LoadTotals(Basket)

        LoadPostalRegex(BVSoftware.Bvc5.Core.Controls.AddressTypes.Shipping)

        Me.Shippingaddress1Field.Focus()
    End Sub

    Protected Sub ShippinglstState_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ShippinglstState.SelectedIndexChanged

        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        PopulateCounties(ShippinglstState.SelectedValue, Me.ShippingCountyField, Me.ShippinglstState)
        ReloadShipping(Basket)
        ShippingCountyField.UpdateAfterCallBack = True
        Shipping.AutoUpdateAfterCallBack()
        Me.ShippingpostalCodeField.UpdateAfterCallBack = True
        LoadTotals(Basket)

        Me.ShippingpostalCodeField.Focus()
    End Sub

    Protected Sub ShippingCountyField_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ShippingCountyField.SelectedIndexChanged
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        ReloadShipping(Basket)
        Shipping.AutoUpdateAfterCallBack()
        Me.ShippingpostalCodeField.UpdateAfterCallBack = True
        LoadTotals(Basket)

        Me.ShippingPhoneNumberField.Focus()
    End Sub

    Protected Sub BillingCountyField_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles BillingCountyField.SelectedIndexChanged
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        UpdateBilling()
        Me.BillingpostalCodeField.UpdateAfterCallBack = True
        LoadTotals(Basket)

        Me.BillingPhoneNumberField.Focus()
    End Sub

    Protected Sub BillinglstCountry_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles BillinglstCountry.Load
        LoadPostalRegex(BVSoftware.Bvc5.Core.Controls.AddressTypes.Billing)
    End Sub

    Private Sub BillinglstCountry_SelectedIndexChanged(ByVal Sender As Object, ByVal E As EventArgs) Handles BillinglstCountry.SelectedIndexChanged
        PopulateRegions(BillinglstCountry.SelectedItem.Value, Me.BillinglstState, Me.BillingstateField)

        If Me.BillinglstState.SelectedItem IsNot Nothing Then
            PopulateCounties(Me.BillinglstState.SelectedItem.Value, Me.BillingCountyField, Me.BillinglstState)
        Else
            PopulateCounties("", Me.BillingCountyField, Me.BillinglstState)
        End If

        BillinglstState.UpdateAfterCallBack = True
        BillingstateField.UpdateAfterCallBack = True
        BillingCountyField.UpdateAfterCallBack = True
        LoadPostalRegex(BVSoftware.Bvc5.Core.Controls.AddressTypes.Billing)

        Me.BillingfirstNameField.Focus()
    End Sub

    Protected Sub BillinglstState_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles BillinglstState.SelectedIndexChanged
        PopulateCounties(BillinglstState.SelectedValue, Me.BillingCountyField, Me.BillinglstState)
        BillingCountyField.UpdateAfterCallBack = True

        Me.BillingpostalCodeField.Focus()
        UpdateBilling()
    End Sub

    Protected Sub ShippingpostalCodeField_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ShippingpostalCodeField.TextChanged
        Me.ShippingPostalCodeBVRegularExpressionValidator.Validate()
        UpdateShipping()

        Me.Shipping.SetFocus()
    End Sub

    Protected Sub BillingpostalCodeField_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles BillingpostalCodeField.TextChanged
        Me.BillingPostalCodeBVRegularExpressionValidator.Validate()
        UpdateBilling()
    End Sub

    Protected Sub UpdateShipping()
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        ReloadShipping(Basket)
        Me.ShippingpostalCodeField.UpdateAfterCallBack = True
        Shipping.AutoUpdateAfterCallBack()
        LoadTotals(Basket)
    End Sub

#End Region


    Public Sub AddressSelected(ByVal addressType As String, ByVal address As Contacts.Address) Handles ucAddressBookSimpleShipping.AddressSelected, ucAddressBookSimpleBilling.AddressSelected
        If String.Compare(addressType, "Billing", True) = 0 Then
            LoadBillingFromAddress(address)
            Me.pnlBilling.Visible = True
            Me.chkBillToSame.Checked = False
            UpdateBilling()
        ElseIf String.Compare(addressType, "Shipping", True) = 0 Then
            LoadShippingFromAddress(address)
            pnlShipping.UpdateAfterCallBack = True
            UpdateShipping()
        End If
    End Sub

    Protected Sub CheckForNewAddressesAndAddToAddressBook()
        If SessionManager.IsUserAuthenticated Then
            Dim user As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
            If user.Bvin <> String.Empty Then
                user.CheckIfNewAddressAndAdd(GetShippingAsAddress())
                If Not Me.chkBillToSame.Checked Then
                    user.CheckIfNewAddressAndAdd(GetBillingAsAddress())
                End If
            End If
        End If
    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If Not Page.IsPostBack Then
            If SessionManager.IsUserAuthenticated Then
                Me.SetFocus(ShippingfirstNameField)
            Else
                Me.SetFocus(EmailAddressField)
            End If
        End If
    End Sub

    Protected Sub LoadTotals(ByVal Basket As Orders.Order)
        If Basket Is Nothing Then
            Basket = SessionManager.CurrentShoppingCart
        End If
        Basket.CalculateTax()
        Orders.Order.Update(Basket)
        If Basket.OrderDiscounts > 0 Then
            OrderDiscountsRow.Visible = True
            SubTotalField.CssClass = "MarkDownPrice"
        Else
            OrderDiscountsRow.Visible = False
        End If
        OrderDiscountsField.Text = "-" & Basket.OrderDiscounts.ToString("c")
        SubTotalField.Text = Basket.SubTotal.ToString("c")
        TaxTotalField.Text = Basket.TaxTotal.ToString("c")
        ShippingTotalField.Text = (Basket.ShippingTotal - Basket.ShippingDiscounts).ToString("c")
        HandlingTotalField.Text = Basket.HandlingTotal.ToString("c")
        GrandTotalField.Text = Basket.GrandTotal.ToString("c")

        Me.LoadGiftCertificatesAndLoyaltyPoints(Basket)
    End Sub

    Protected Sub LoadGiftCertificatesAndLoyaltyPoints(ByVal o As Orders.Order)
        Dim amountToPay As Decimal = o.GrandTotal

        If WebAppSettings.LoyaltyPointsEnabled Then
            ' re-add the user to the order in the event of a workflow step failure (e.g. credit card authorization failure)
            If String.IsNullOrEmpty(o.UserID) Then
                o.UserID = SessionManager.GetCurrentUserId()
            End If

            Dim lpos As New Membership.LoyaltyPointsOrderSummary(o)

            If SessionManager.IsUserAuthenticated Then
                Me.trLoyaltyPointsEarned.Visible = True

                If lpos.AvailablePointsCurrency > 0 AndAlso amountToPay > 0 Then
                    Me.trLoyaltyPointsUsed.Visible = True

                    Me.LoyaltyPointsUsedField.Text = lpos.UsedPoints.ToString()
                    Me.LoyaltyPointsUsedCurrencyField.Text = (-1 * lpos.UsedPointsCurrency).ToString("c")

                    amountToPay -= lpos.UsedPointsCurrency
                Else
                    Me.trLoyaltyPointsUsed.Visible = False
                End If
            Else
                Me.trLoyaltyPointsUsed.Visible = False
                Me.trLoyaltyPointsEarned.Visible = (Me.UsernameLabel.CssClass.EndsWith("required"))
            End If

            Me.LoyaltyPointsEarnedField.Text = lpos.EarnedPoints.ToString()
            Me.LoyaltyPointsEarnedCurrencyField.Text = lpos.EarnedPointsCurrency.ToString("c")

            Orders.Order.Update(o)  ' save order with new LoyaltyPointsDebit calculations
        Else
            Me.trLoyaltyPointsUsed.Visible = False
            Me.trLoyaltyPointsEarned.Visible = False
        End If

        ' subtract gift certificate(s)
        Dim amountAfterLoyaltyDeduction As Decimal = amountToPay
        If amountToPay > 0 Then
            If o.GiftCertificates.Count > 0 Then
                Dim giftCertificateAmount As Decimal = o.GetGiftCertificates().Sum(Function(gc) gc.CurrentAmount)
                If giftCertificateAmount > 0 Then
                    amountToPay -= giftCertificateAmount

                    If amountToPay < 0 Then
                        amountToPay = 0
                        giftCertificateAmount = amountAfterLoyaltyDeduction
                    End If

                    Me.GiftCertificateField.Text = (-1 * giftCertificateAmount).ToString("c")
                    Me.trGiftCertificateRow.Visible = True
                Else
                    Me.trGiftCertificateRow.Visible = False
                End If
            Else
                Me.trGiftCertificateRow.Visible = False
            End If
        Else
            'the entire order is covered by the loyalty points, so remove the gift certificates from the order
            o.GiftCertificates.Clear()
            Payment.SavePaymentInfo(o)
            Orders.Order.Update(o)
            SessionManager.InvalidateCachedCart()
            ucGiftCertificates.BindGiftCertificatesGrid()
            Me.trGiftCertificateRow.Visible = False
        End If

        Me.AmountDueField.Text = amountToPay.ToString("c")

        ' reload payment methods with loyalty points and gift certificates credited
        Payment.LoadPaymentMethods(amountToPay)
    End Sub

    Protected Sub CertificatesChanged() Handles ucGiftCertificates.CertificatesChanged
        LoadTotals(SessionManager.CurrentShoppingCart())
    End Sub

    Protected Sub ShippingMethodChanged() Handles Shipping.ShippingMethodChanged
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        Dim r As Shipping.ShippingRate = Shipping.FindSelectedRate(Basket)
        If Basket.ApplyShippingRate(r) AndAlso Orders.Order.Update(Basket) Then
            SessionManager.SetSessionString("LastShippingRateUniqueKey", r.UniqueKey)

            ' Calling Basket.ApplyShippingRate() after a product price has already been calculated seems to result in a base product price (no modifiers) less discounts. In other words, too low. To 'solve' this problem we force a reload of the order.
            SessionManager.InvalidateCachedCart()
            Basket = SessionManager.CurrentShoppingCart
        End If
        LoadTotals(Basket)
    End Sub

    Protected Sub LoadItemsGridView(ByVal o As Orders.Order)
        ' show/hide product thumbnail images based on setting
        If Not Page.IsPostBack Then
            For Each column As DataControlField In Me.ItemsGridView.Columns
                If String.IsNullOrEmpty(column.HeaderText) Then
                    If WebAppSettings.HideCartImages Then
                        column.Visible = False
                    Else
                        column.HeaderText = "Product"
                    End If
                ElseIf column.HeaderText = "Product" Then
                    If Not WebAppSettings.HideCartImages Then
                        column.HeaderText = String.Empty
                    End If
                End If
            Next
        End If

        Me.ItemsGridView.DataSource = o.Items
        Me.ItemsGridView.DataBind()

        If Page.IsPostBack Then
            If Not _InputsAndModifiersLoaded Then
                ViewUtilities.GetInputsAndModifiersForLineItemDescription(Me.Page, ItemsGridView)
            End If
        End If
    End Sub

    Protected Sub ItemGridView_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ItemsGridView.DataBound
        ViewUtilities.DisplayKitInLineItem(Me.Page, ItemsGridView, True)
        ViewUtilities.GetInputsAndModifiersForLineItemDescription(Me.Page, ItemsGridView)
        _InputsAndModifiersLoaded = True
    End Sub

    Protected Sub ItemsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles ItemsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lineItem As Orders.LineItem = CType(e.Row.DataItem, Orders.LineItem)

            If lineItem IsNot Nothing Then

                Dim ImageField As Image = CType(e.Row.FindControl("ImageField"), Image)
                Dim SKUField As Label = CType(e.Row.FindControl("SKUField"), Label)
                Dim description As Label = CType(e.Row.FindControl("DescriptionField"), Label)
                If lineItem.AssociatedProduct IsNot Nothing Then
                    If ImageField IsNot Nothing Then
                        ImageField.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(lineItem.AssociatedProduct.ImageFileSmall, True))

                        ImageField.AlternateText = HttpUtility.HtmlEncode(lineItem.AssociatedProduct.ImageFileSmallAlternateText)
                        ViewUtilities.ForceImageSize(ImageField, lineItem.AssociatedProduct.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)

                        If SKUField IsNot Nothing Then
                            SKUField.Text = lineItem.AssociatedProduct.Sku
                        End If

                        If description IsNot Nothing Then
                            description.Text = lineItem.AssociatedProduct.ProductName
                        End If
                    Else
                        If SKUField IsNot Nothing Then
                            SKUField.Text = lineItem.ProductSku
                        End If

                        If description IsNot Nothing Then
                            description.Text = lineItem.ProductName

                        End If
                    End If

                End If

                Dim totalLabel As Literal = e.Row.FindControl("TotalLabel")
                totalLabel.Text = lineItem.LineTotal.ToString("c")

                Dim totalWithoutDiscountsLabel As Literal = e.Row.FindControl("TotalWithoutDiscountsLabel")
                If lineItem.LineTotal <> lineItem.LineTotalWithoutDiscounts Then
                    totalWithoutDiscountsLabel.Visible = True
                    totalWithoutDiscountsLabel.Text = lineItem.LineTotalWithoutDiscounts.ToString("c")
                Else
                    totalWithoutDiscountsLabel.Visible = False
                End If
            End If
        End If
    End Sub

    Protected Sub CheckForNonShippingOrder(ByVal Basket As Orders.Order)
        If WebAppSettings.HideShippingAddressForNonShippingOrders Then
            If Not Basket.HasShippingItems Then
                BillToSection.Visible = False
                chkBillToSame.Checked = True
                ShipToHeader.InnerText = "Bill To:"
            End If
        End If

        If WebAppSettings.HideShippingControlsForNonShippingOrders Then
            If Not Basket.HasShippingItems Then
                ShippingSection.Visible = False
            End If
        End If
    End Sub


    Protected Sub ShippingAddress1Field_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Shippingaddress1Field.TextChanged
        UpdateShipping()
    End Sub

    Private Function SetDefaultShippingMethod(ByVal o As Orders.Order) As Boolean
        Dim result As Boolean = False

        ' if we don't have any shipping rates, get them
        If SessionManager.LastShippingRates.Count = 0 OrElse Not Page.IsPostBack Then
            Shipping.LoadShippingMethodsForOrder(o, o.ShippingAddress.PostalCode)
        End If

        ' try to set existing shipping rate from order (if it exists)
        If Not String.IsNullOrEmpty(o.ShippingMethodUniqueKey) OrElse Not String.IsNullOrEmpty(SessionManager.GetSessionString("LastShippingRateUniqueKey")) Then
            If Not String.IsNullOrEmpty(o.ShippingMethodUniqueKey) Then
                Shipping.SetShippingMethod(o.ShippingMethodUniqueKey)
            Else
                Shipping.SetShippingMethod(SessionManager.GetSessionString("LastShippingRateUniqueKey"))
            End If

            Dim rate As Shipping.ShippingRate = Shipping.FindSelectedRate(o)
            If rate IsNot Nothing AndAlso (rate.UniqueKey = o.ShippingMethodUniqueKey OrElse String.IsNullOrEmpty(o.ShippingMethodUniqueKey)) Then
                ShippingMethodChanged()
                result = True
            End If
        End If

        If result = False Then
            If SessionManager.LastShippingRates.Count > 0 Then
                Dim selectedRate As Shipping.ShippingRate = Shipping.FindSelectedRate(o)
                If selectedRate Is Nothing Then
                    ' if we have shipping rates and a user has not yet selected one, pre-select the first (lowest) rate
                    Shipping.SetShippingMethod(SessionManager.LastShippingRates(0).UniqueKey)
                    ShippingMethodChanged()
                Else
                    ' apply selected rate to order
                    ShippingMethodChanged()
                End If

                result = True
            End If
        End If

        Return result
    End Function

    Private Function SubscribeUserToMailingList(ByVal o As Orders.Order) As Boolean
        Dim result As Boolean = False

        If Me.chkMailingListSignup.Visible = True Then
            Dim listId As String = Me.chkMailingListSignup.Attributes("rel")
            If Me.chkMailingListSignup.Checked AndAlso Not String.IsNullOrEmpty(listId) Then
                Dim mm As New Contacts.MailingListMember()
                mm.EmailAddress = o.UserEmail
                mm.FirstName = o.BillingAddress.FirstName
                mm.LastName = o.BillingAddress.LastName
                mm.ListId = listId

                result = Contacts.MailingListMember.Insert(mm)
            End If
        End If

        Return result
    End Function

    Private Function ValidateCheckout() As Boolean
        Dim result As Boolean = True

        If Not Page.IsValid Then
            result = False
        End If

        SetValidationClasses()

        Me.cvSiteTermsAgreement.IsValid = Me.SiteTermsAgreement1.IsValid
        If Not Me.cvSiteTermsAgreement.IsValid Then
            result = False

            Me.cvSiteTermsAgreement.ErrorMessage = Content.SiteTerms.GetTerm("SiteTermsAgreementError")
            MessageBox1.ShowError(Content.SiteTerms.GetTerm("SiteTermsAgreementError"))

            If Not Me.pnlSiteTermsAgreement.CssClass.Contains("error") Then
                Me.pnlSiteTermsAgreement.CssClass += " error"
            End If
        Else
            ' log that customer agreed to site terms
            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
            If WebAppSettings.DisplaySiteTermsToCustomerUponCheckout Then
                Basket.CustomPropertySet("Develisys", "AgreedToTerms", Boolean.TrueString)
            Else
                Basket.CustomPropertySet("Develisys", "AgreedToTerms", Boolean.FalseString)
            End If
        End If

        If Not Me.ValidateSelections() Then
            result = False
        End If

        Return result
    End Function

    Private Sub SetValidationClasses()
        Dim validators As New List(Of BaseValidator)
        BVSoftware.Bvc5.Core.Controls.BVBaseControl.FindControlsByType(Me.Controls, validators)

        Dim labels As New List(Of Label)
        BVSoftware.Bvc5.Core.Controls.BVBaseControl.FindControlsByType(Me.Controls, labels)

        ' clear error class from previous validation(s)
        For Each validator In validators
            Dim c As Control = BVSoftware.Bvc5.Core.Controls.BVBaseControl.FindControlRecursive(Me, validator.ControlToValidate)

            If TypeOf c Is TextBox _
                OrElse TypeOf c Is DropDownList _
                OrElse TypeOf c Is CheckBox Then

                Dim wc As WebControl = CType(c, WebControl)
                If validator.IsValid Then
                    wc.CssClass = wc.CssClass.Replace(" " + validator.CssClass, String.Empty)
                End If
            End If

            Dim lbl As Label = labels.Find(Function(label) label.AssociatedControlID = c.ID)
            If lbl IsNot Nothing Then
                If validator.IsValid Then
                    lbl.CssClass = lbl.CssClass.Replace(" " + validator.CssClass, String.Empty)
                End If
            End If
        Next

        ' set error class
        For Each validator In validators
            Dim c As Control = BVSoftware.Bvc5.Core.Controls.BVBaseControl.FindControlRecursive(Me, validator.ControlToValidate)

            If TypeOf c Is TextBox _
                OrElse TypeOf c Is DropDownList _
                OrElse TypeOf c Is CheckBox Then

                Dim wc As WebControl = CType(c, WebControl)
                If Not validator.IsValid Then
                    If Not wc.CssClass.Contains(validator.CssClass) Then
                        wc.CssClass += " " + validator.CssClass
                    End If
                End If
            End If

            Dim lbl As Label = labels.Find(Function(label) label.AssociatedControlID = c.ID)
            If lbl IsNot Nothing Then
                If Not validator.IsValid Then
                    If Not lbl.CssClass.Contains(validator.CssClass) Then
                        lbl.CssClass += " " + validator.CssClass
                    End If
                End If
            End If
        Next
    End Sub

    <WebMethod(EnableSession:=True)> _
    Public Shared Function DoesEmailExist(ByVal email As String) As Boolean
        Dim result As Boolean = False

        If Not HttpContext.Current.Session.IsNewSession AndAlso SessionManager.CurrentUserHasCart() Then
            Dim u As Membership.UserAccount = Membership.UserAccount.FindByEmail(email.Trim())
            If u.Email.ToLower().Trim() = email.ToLower().Trim() Then
                result = True
            End If

            ' save email address to cart for future marketing use (e.g. cart abandonment) if cart does not already have an email address
            Dim o As Orders.Order = SessionManager.CurrentShoppingCart()
            If String.IsNullOrEmpty(o.UserEmail) Then
                o.UserEmail = email
                Orders.Order.Update(o)
            End If
        Else
            Throw New HttpException(403, "Forbidden")
        End If

        Return result
    End Function

End Class
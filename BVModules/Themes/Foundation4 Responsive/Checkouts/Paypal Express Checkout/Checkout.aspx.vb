Imports BVSoftware.Bvc5.Core
Imports BVSoftware.PaypalWebServices
Imports PayPal.PayPalAPIInterfaceService
Imports PayPal.PayPalAPIInterfaceService.Model
Imports System.Collections.ObjectModel
Imports System.Linq

Partial Class BVModules_Themes_Foundation4_Responsive_Checkouts_Paypal_Express_Checkout_Checkout
    Inherits BaseStorePage

    Private _InputsAndModifiersLoaded As Boolean = False

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Checkout.master")
        Me.Title = "Checkout"
    End Sub

    Protected Sub CheckoutImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CheckoutImageButton.Click
        If Page.IsValid Then
            If Not SiteTermsAgreement1.IsValid Then
                MessageBox1.ShowError(Content.SiteTerms.GetTerm("SiteTermsAgreementError"))
            Else
                Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart

                ' Save Shipping Selection
                Dim r As Shipping.ShippingRate = Shipping.FindSelectedRate(Basket)
                Basket.ApplyShippingRate(r)

                ' Save Payment Information
                SavePaymentInfo(Basket)

                Basket.Instructions = SpecialInstructions.Text
                Orders.Order.Update(Basket)

                ' Save as Order
                Dim c As New BusinessRules.OrderTaskContext
                c.UserId = SessionManager.GetCurrentUserId
                c.Order = Basket

                If BusinessRules.Workflow.RunByName(c, "Process New Order") Then
                    SessionManager.CurrentCartID = String.Empty
                    Response.Redirect("~/Receipt.aspx?id=" & Basket.Bvin)
                Else
                    ' Show Errors                
                    For Each item As BusinessRules.WorkflowMessage In c.GetCustomerVisibleErrors()
                        MessageBox1.ShowError(item.Description)
                    Next
                End If
            End If
        End If
    End Sub

    Private Sub DisplayPaypalExpressMode()
        If (Request.QueryString("token") IsNot Nothing) AndAlso (Request.QueryString("token") <> String.Empty) Then
            Dim ppAPI As BVSoftware.PaypalWebServices.PayPalAPI = Utilities.PaypalExpressUtilities.GetPaypalAPI()
            Dim failed As Boolean = False
            Dim ppResponse As GetExpressCheckoutDetailsResponseType = Nothing
            Dim o As Orders.Order = SessionManager.CurrentShoppingCart
            Try
                If Not GetExpressCheckoutDetails(ppAPI, ppResponse, o) Then
                    If Not GetExpressCheckoutDetails(ppAPI, ppResponse, o) Then
                        failed = True
                        EventLog.LogEvent("Paypal Express Checkout", "GetExpressCheckoutDetails call failed. Detailed Errors will follow. ", Metrics.EventLogSeverity.Error)
                        For Each ppError As ErrorType In ppResponse.Errors
                            EventLog.LogEvent("Paypal error number: " & ppError.ErrorCode, "Paypal Error: '" & ppError.ShortMessage & "' Message: '" & ppError.LongMessage & "' " & _
                            " Values passed to GetExpressCheckoutDetails: Token: " & Request.QueryString("token"), Metrics.EventLogSeverity.Error)
                        Next
                        MessageBox1.ShowError("An error occurred during the Paypal Express checkout. No charges have been made. Please try again.")
                        CheckoutImageButton.Visible = False
                    End If
                End If
            Finally
                EditAddressLinkButton.Visible = True
                If o.CustomProperties("PaypalAddressOverride") IsNot Nothing Then
                    If o.CustomProperties("PaypalAddressOverride").Value = "1" Then
                        EditAddressLinkButton.Visible = False
                    End If
                End If

                o.CustomProperties.Add("bvsoftware", "PayerID", Request.QueryString("PayerID"))
                If Not failed Then
                    If ppResponse IsNot Nothing AndAlso ppResponse.GetExpressCheckoutDetailsResponseDetails IsNot Nothing AndAlso ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo IsNot Nothing Then
                        o.UserEmail = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Payer

                        If (String.IsNullOrEmpty(PhoneNumberLabel.Text) AndAlso _
                            Not String.IsNullOrEmpty(o.ShippingAddress.Phone)) Then
                            PhoneNumberLabel.Text = o.ShippingAddress.Phone
                            ' 5.7 commented out | o.ShippingAddress.Phone = ppResponse.GetExpressCheckoutDetailsResponseDetails.ContactPhone
                        End If

                    End If
                End If
                Orders.Order.Update(o)
                ppAPI = Nothing
            End Try
        Else
            Response.Redirect("~/Default.aspx")
        End If

    End Sub

    Protected Function GetExpressCheckoutDetails(ByVal ppAPI As BVSoftware.PaypalWebServices.PayPalAPI, ByRef ppResponse As GetExpressCheckoutDetailsResponseType, ByVal o As Orders.Order) As Boolean
        ppResponse = ppAPI.GetExpressCheckoutDetails(Request.QueryString("token"))
        If ppResponse.Ack = AckCodeType.SUCCESS OrElse ppResponse.Ack = AckCodeType.SUCCESSWITHWARNING Then
            EmailLabel.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Payer
            'If user already entered name and/or company, do not overwrite them with name from PayPal account
            If Not String.IsNullOrEmpty(o.ShippingAddress.FirstName) AndAlso Not String.IsNullOrEmpty(o.ShippingAddress.LastName) Then
                FirstNameLabel.Text = o.ShippingAddress.FirstName
                MiddleInitialLabel.Text = o.ShippingAddress.MiddleInitial
                LastNameLabel.Text = o.ShippingAddress.LastName
                CompanyLabel.Text = o.ShippingAddress.Company
            Else
                FirstNameLabel.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.PayerName.FirstName
                If Not String.IsNullOrEmpty(ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.PayerName.MiddleName) Then
                    MiddleInitialLabel.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.PayerName.MiddleName.Chars(0)
                Else
                    MiddleInitialLabel.Text = String.Empty
                End If
                LastNameLabel.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.PayerName.LastName
                CompanyLabel.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.PayerBusiness
            End If

            StreetAddress1Label.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.Street1
            StreetAddress2Label.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.Street2
            CountryLabel.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.CountryName
            ViewState("CountryCode") = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.Country.ToString()
            CityLabel.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.CityName
            StateLabel.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.StateOrProvince
            ZipLabel.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.PostalCode

            Dim addr As Contacts.Address = Me.GetAddress()

            ' Populate counties
            Me.PopulateCounties(addr.RegionBvin, o)
            If ddCounty.SelectedItem IsNot Nothing Then
                addr.CountyBvin = ddCounty.SelectedValue
                addr.CountyName = ddCounty.SelectedItem.Text
            End If

            ' Save shipping info to cart
            o.SetShippingAddress(addr)
            If Not o.BillingAddress.IsValid() Then
                o.BillingAddress = addr
            End If

            ' Reload totals to calculate tax based on county
            LoadTotals(o)

            ' 5.7 fix PhoneNumberLabel.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.ContactPhone
            If String.IsNullOrEmpty(ppResponse.GetExpressCheckoutDetailsResponseDetails.ContactPhone) Then
                PhoneNumberLabel.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.ContactPhone
            Else
                PhoneNumberLabel.Text = ppResponse.GetExpressCheckoutDetailsResponseDetails.ContactPhone
            End If

            If ppResponse.GetExpressCheckoutDetailsResponseDetails.PayerInfo.Address.AddressStatus = AddressStatusCodeType.CONFIRMED Then
                AddressStatusLabel.Text = "Confirmed"
            Else
                AddressStatusLabel.Text = "Unconfirmed"
            End If
            Return True
        Else
            Return False
        End If
    End Function

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
        Me.CheckoutImageButton.Visible = True
        If Not Page.IsPostBack Then
            CheckoutImageButton.ImageUrl = PersonalizationServices.GetThemedButton("PlaceOrder")
            Me.btnKeepShopping.ImageUrl = PersonalizationServices.GetThemedButton("ContinueShopping")
            DisplayPaypalExpressMode()
            Dim o As Orders.Order = SessionManager.CurrentShoppingCart
            Me.SpecialInstructions.Text = o.Instructions
            If Not SetDefaultShippingMethod(o) Then
                LoadTotals(o)
            Else
                LoadGiftCertificatesAndLoyaltyPoints(o)
            End If
            'Shipping.LoadShippingMethodsForOrder(o, o.ShippingAddress.PostalCode)
            'LoadShippingMethodsForOrder()
            LoadItemsGridView(o)

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
            ' if we have shipping rates and a user has not yet selected one, pre-select the first (lowest) rate
            If SessionManager.LastShippingRates.Count > 0 AndAlso Shipping.FindSelectedRate(o) Is Nothing Then
                Shipping.SetShippingMethod(SessionManager.LastShippingRates(0).UniqueKey)
                ShippingMethodChanged()
                result = True
            End If
        End If

        Return result
    End Function

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
                Me.trLoyaltyPointsEarned.Visible = (Not String.IsNullOrEmpty(o.UserID))
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
            Orders.Order.Update(o)
            SessionManager.InvalidateCachedCart()
            Me.trGiftCertificateRow.Visible = False
        End If

        Me.AmountDueField.Text = amountToPay.ToString("c")
    End Sub

    Protected Sub LoadItemsGridView(ByVal o As Orders.Order)
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
                Dim pnlImage As Panel = CType(e.Row.FindControl("pnlImage"), Panel)
                Dim ImageField As Image = CType(e.Row.FindControl("ImageField"), Image)
                Dim SKUField As Label = CType(e.Row.FindControl("SKUField"), Label)
                Dim description As Label = CType(e.Row.FindControl("DescriptionField"), Label)
                If lineItem.AssociatedProduct IsNot Nothing Then
                    If ImageField IsNot Nothing Then
                        If WebAppSettings.HideCartImages AndAlso pnlImage IsNot Nothing Then
                            pnlImage.Visible = False
                        Else
                            ImageField.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(lineItem.AssociatedProduct.ImageFileSmall, True))

                            ImageField.AlternateText = HttpUtility.HtmlEncode(lineItem.AssociatedProduct.ImageFileSmallAlternateText)
                            ViewUtilities.ForceImageSize(ImageField, lineItem.AssociatedProduct.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)
                        End If

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

    Private Function GetAddress() As Contacts.Address
        Dim a As New Contacts.Address
        Dim country As Content.Country = Content.Country.FindByISOCode(ViewState("CountryCode"))
        If country.Bvin = String.Empty Then
            MessageBox1.ShowError("Could not retreive address properly, country could not be found.")
            CheckoutImageButton.Enabled = False
        Else
            CheckoutImageButton.Enabled = True
        End If

        If Not country.Active Then
            MessageBox1.ShowError("This country is not active for this store.")
            CheckoutImageButton.Enabled = False
        Else
            CheckoutImageButton.Enabled = True
        End If

        If (country.Bvin <> String.Empty) AndAlso (country.Active) Then
            a.CountryBvin = country.Bvin
            a.CountryName = country.DisplayName
            a.RegionName = StateLabel.Text
            For Each region As Content.Region In Content.Region.FindByCountry(country.Bvin)
                If (String.Compare(region.Abbreviation, a.RegionName, True) = 0) OrElse (String.Compare(region.Name, a.RegionName, True) = 0) Then
                    a.RegionBvin = region.Bvin
                    a.RegionName = region.Abbreviation
                End If
            Next
            a.FirstName = FirstNameLabel.Text
            a.MiddleInitial = MiddleInitialLabel.Text
            a.LastName = LastNameLabel.Text
            a.Company = CompanyLabel.Text
            a.Line1 = StreetAddress1Label.Text
            a.Line2 = StreetAddress2Label.Text
            a.City = CityLabel.Text
            a.PostalCode = ZipLabel.Text
            a.Phone = PhoneNumberLabel.Text
            a.Fax = ""
            a.WebSiteUrl = ""
            If ddCounty.SelectedItem IsNot Nothing Then
                a.CountyName = ddCounty.SelectedItem.Text
                a.CountyBvin = ddCounty.SelectedValue
            End If
            Return a
        Else
            Return Nothing
        End If
    End Function


    Private Sub SavePaymentInfo(ByVal o As Orders.Order)
        Dim p As New Orders.OrderPayment
        p.OrderID = o.Bvin
        p.AuditDate = DateTime.Now
        p.PaymentMethodName = "Paypal Express"
        p.PaymentMethodId = WebAppSettings.PaymentIdPaypalExpress
        Dim val As String = Request.QueryString("PayerId")
        If Not String.IsNullOrEmpty(val) Then
            ' This is to fix a bug with paypal returning multiple payerId's
            p.CustomProperties.Add("bvsoftware", "PayerID", val.Split(",")(0))
        End If
        o.AddPayment(p)
    End Sub

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        If Not WebAppSettings.PaypalAllowUnconfirmedAddresses Then
            If String.Compare(AddressStatusLabel.Text, "Unconfirmed", True) = 0 Then
                args.IsValid = False
            Else
                args.IsValid = True
            End If
        End If
    End Sub

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

    Protected Sub EditAddressLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles EditAddressLinkButton.Click
        Dim c As New BusinessRules.OrderTaskContext()
        c.Order = SessionManager.CurrentShoppingCart
        c.UserId = SessionManager.GetCurrentUserId()
        c.Inputs.Add("bvsoftware", "Mode", "PaypalExpress")

        Dim task As New BusinessRules.OrderTasks.StartPaypalExpressCheckout()
        If Not task.Execute(c) Then
            For Each item As BusinessRules.WorkflowMessage In c.GetCustomerVisibleErrors()
                MessageBox1.ShowError(item.Description)
            Next
        End If
    End Sub

    Protected Sub ddCounty_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddCounty.SelectedIndexChanged
        Dim basket As Orders.Order = SessionManager.CurrentShoppingCart
        basket.SetShippingAddress(GetAddress())
        LoadTotals(basket)
    End Sub

    Private Sub PopulateCounties(ByVal regionID As String, ByVal o As Orders.Order)
        ddCounty.Items.Clear()

        ddCounty.DataSource = Content.County.FindByRegion(regionID)
        ddCounty.DataTextField = "Name"
        ddCounty.DataValueField = "bvin"
        ddCounty.DataBind()

        If ddCounty.Items.Count < 1 Then
            ddCounty.Visible = False
            If ddCounty.Parent IsNot Nothing AndAlso (TypeOf (ddCounty.Parent) Is HtmlControl OrElse TypeOf (ddCounty.Parent) Is Control) Then
                ddCounty.Parent.Visible = False
            End If
        Else
            ddCounty.Visible = True
            If ddCounty.Parent IsNot Nothing AndAlso (TypeOf (ddCounty.Parent) Is HtmlControl OrElse TypeOf (ddCounty.Parent) Is Control) Then
                ddCounty.Parent.Visible = True
            End If
        End If

        If ddCounty.Items.FindByValue(o.ShippingAddress.CountyBvin) IsNot Nothing Then
            ddCounty.SelectedValue = o.ShippingAddress.CountyBvin
        End If

    End Sub

End Class

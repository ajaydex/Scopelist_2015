Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Checkouts_One_Page_Checkout_Checkout
    Inherits BaseStoreCheckoutPage

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
        If Not Page.IsPostBack Then


            If WebAppSettings.AvalaraEnabled Then
                Me.ShippingAddress1Field.AutoPostBack = True
            End If

            'Me.btnSubmit.ImageUrl = PersonalizationServices.GetThemedButton("PlaceOrder")
            'Me.btnKeepShopping.ImageUrl = PersonalizationServices.GetThemedButton("ContinueShopping")


            Dim Basket As Orders.Order = LoadBasket()
            If Basket.BillingAddress.IsEqualTo(Basket.ShippingAddress) Then
                chkBillToSame.Checked = True
            Else
                chkBillToSame.Checked = False
            End If

            InitializeShippingAddress()
            InitializeBillingAddress()

            LoadAddresses(Basket)
            LoadTotals(Basket)

            CheckForNonShippingOrder(Basket)

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

    Private Function LoadBasket() As Orders.Order
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        If Basket IsNot Nothing Then

            If Basket.Items.Count = 0 Then
                Response.Redirect("~/Default.aspx")
            End If

            Payment.LoadPaymentMethods(Basket.GrandTotal)

            Shipping.LoadShippingMethodsForOrder(Basket, Me.ShippingpostalCodeField.Text)

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
            Orders.Order.Update(Basket)
            Shipping.LoadShippingMethodsForOrder(Basket, Me.ShippingpostalCodeField.Text)
            If Basket.ShippingMethodId <> String.Empty Then
                Shipping.SetShippingMethod(Basket.ShippingMethodUniqueKey)
            Else

            End If
        End If
    End Sub

    Private Sub LoadAddresses(ByVal Basket As Orders.Order)
        If SessionManager.IsUserAuthenticated = True Then
            Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
            If u IsNot Nothing Then
                LoadBillingFromAddress(u.BillingAddress)
                LoadShippingFromAddress(u.ShippingAddress)
                ReloadShipping(Basket)
            End If
        End If
    End Sub

    Private Sub SaveAddressesToUser()
        If SessionManager.IsUserAuthenticated = True Then
            Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
            If u IsNot Nothing Then
                GetBillingAsAddress.CopyTo(u.BillingAddress)
                GetShippingAsAddress.CopyTo(u.ShippingAddress)
                Membership.UserAccount.Update(u)
            End If
        End If
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click                
        If Page.IsValid Then
            If Not Me.SiteTermsAgreement1.IsValid Then
                MessageBox1.ShowError(Content.SiteTerms.GetTerm("SiteTermsAgreementError"))
            Else
                If Me.ValidateSelections() Then
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

                        Basket.AffiliateID = Contacts.Affiliate.GetCurrentAffiliateID()
                        Basket.Instructions = Me.SpecialInstructions.Text.Trim()
                        Basket.UserEmail = EmailAddressEntry1.GetUserEmail

                        Orders.Order.Update(Basket)

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
            End If
        End If
    End Sub

    Private Function ValidateSelections() As Boolean
        Dim result As Boolean = True

        If Me.chkBillToSame.Checked = False Then
            If Not ValidateBillingAddress() Then
                MessageBox1.ShowWarning("Billing address is invalid!")
                Return False
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
        End If

        If Not Shipping.IsValid Then
            MessageBox1.ShowError("Please Select a Shipping Method")
            result = False
        End If

        If (Not Payment.IsValid) AndAlso (Not paymentFound) Then
            For Each item As String In Payment.Errors
                MessageBox1.ShowError(item)
            Next
            result = False
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

    'Protected Sub chkBillToSame_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkBillToSame.CheckedChanged
    '    If chkBillToSame.Checked Then
    '        LoadBillingFromAddress(GetShippingAsAddress)            
    '    End If
    'End Sub


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
            lst.DataSource = Content.Region.FindByCountry(countryCode)
            lst.DataTextField = "abbreviation"
            lst.DataValueField = "bvin"
            lst.DataBind()

            If lst.Items.Count() < 1 Then
                lst.Visible = False
                alt.Visible = True
                If lst.Equals(ShippinglstState) Then
                    ShippingStateListRequiredFieldValidator.Enabled = False
                    ShippingStateListRequiredFieldValidator.Visible = False                    
                ElseIf lst.Equals(BillinglstState) Then
                    'BillinglstStateRequiredFieldValidator.Enabled = False
                    'BillinglstStateRequiredFieldValidator.Visible = False                    
                End If
            Else
                lst.Visible = True
                alt.Visible = False
                If lst.Equals(ShippinglstState) Then
                    ShippingStateListRequiredFieldValidator.Enabled = True
                    ShippingStateListRequiredFieldValidator.Visible = True                    
                ElseIf lst.Equals(BillinglstState) Then
                    'BillinglstStateRequiredFieldValidator.Enabled = True
                    'BillinglstStateRequiredFieldValidator.Visible = True                    
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
            Else
                countylst.Visible = True
            End If
        Else
            countylst.Visible = False
        End If        
    End Sub

    Private Sub UpdateShippingVisibleRows()

        Me.ShippingValFirstNameField.Enabled = WebAppSettings.ShipAddressRequireFirstName
        Me.ShippingvalLastName.Enabled = WebAppSettings.ShipAddressRequireLastName
        Me.ShippingvalAddress.Enabled = True
        Me.ShippingvalCity.Enabled = True
        Me.ShippingvalPostalCode.Enabled = True

        If WebAppSettings.ShipAddressShowMiddleInitial = True Then
            Me.ShippingMiddleInitialField.Visible = True
        Else
            Me.ShippingMiddleInitialField.Visible = False
        End If

        If WebAppSettings.ShipAddressShowCompany = True Then
            Me.ShippingCompanyNameRow.Visible = True
            Me.ShippingvalCompany.Enabled = WebAppSettings.ShipAddressRequireCompany
        Else
            Me.ShippingvalCompany.Enabled = False
            Me.ShippingCompanyNameRow.Visible = False
        End If

        If WebAppSettings.ShipAddressShowPhone = True Then
            Me.ShippingPhoneRow.Visible = True
            Me.ShippingvalPhone.Enabled = WebAppSettings.ShipAddressRequirePhone
        Else
            Me.ShippingvalPhone.Enabled = False
            Me.ShippingPhoneRow.Visible = False
        End If

        If WebAppSettings.ShipAddressShowFax = True Then
            Me.ShippingFaxRow.Visible = True
            Me.ShippingvalFax.Enabled = WebAppSettings.ShipAddressRequireFax
        Else
            Me.ShippingvalFax.Enabled = False
            Me.ShippingFaxRow.Visible = False
        End If

        If WebAppSettings.ShipAddressShowWebSiteURL = True Then
            Me.ShippingWebSiteURLRow.Visible = True
            Me.ShippingvalWebSite.Enabled = WebAppSettings.ShipAddressRequireWebSiteURL
        Else
            Me.ShippingvalWebSite.Enabled = False
            Me.ShippingWebSiteURLRow.Visible = False
        End If
    End Sub

    Private Sub UpdateBillingVisibleRows()

        Me.BillingValFirstNameField.Enabled = WebAppSettings.BillAddressRequireFirstName
        Me.BillingvalLastName.Enabled = WebAppSettings.BillAddressRequireLastName
        Me.BillingvalAddress.Enabled = True
        Me.BillingvalCity.Enabled = True
        Me.BillingvalPostalCode.Enabled = True

        If WebAppSettings.BillAddressShowMiddleInitial = True Then
            Me.BillingMiddleInitialField.Visible = True
        Else
            Me.BillingMiddleInitialField.Visible = False
        End If

        If WebAppSettings.BillAddressShowCompany = True Then
            Me.BillingCompanyNameRow.Visible = True
            Me.BillingvalCompany.Enabled = WebAppSettings.BillAddressRequireCompany
        Else
            Me.BillingvalCompany.Enabled = False
            Me.BillingCompanyNameRow.Visible = False
        End If

        If WebAppSettings.BillAddressShowPhone = True Then
            Me.BillingPhoneRow.Visible = True
            Me.BillingvalPhone.Enabled = WebAppSettings.BillAddressRequirePhone
        Else
            Me.BillingvalPhone.Enabled = False
            Me.BillingPhoneRow.Visible = False
        End If

        If WebAppSettings.BillAddressShowFax = True Then
            Me.BillingFaxRow.Visible = True
            Me.BillingvalFax.Enabled = WebAppSettings.BillAddressRequireFax
        Else
            Me.BillingvalFax.Enabled = False
            Me.BillingFaxRow.Visible = False
        End If

        If WebAppSettings.BillAddressShowWebSiteUrl = True Then
            Me.BillingWebSiteURLRow.Visible = True
            Me.BillingvalWebSite.Enabled = WebAppSettings.BillAddressRequireWebSiteURL
        Else
            Me.BillingvalWebSite.Enabled = False
            Me.BillingWebSiteURLRow.Visible = False
        End If

        Me.BillingvalAddress.Enabled = False
        Me.BillingvalCity.Enabled = False
        Me.BillingvalCompany.Enabled = False
        Me.BillingvalFax.Enabled = False
        Me.BillingValFirstNameField.Enabled = False
        Me.BillingvalLastName.Enabled = False
        Me.BillingvalPhone.Enabled = False
        Me.BillingvalPostalCode.Enabled = False
        Me.BillingvalWebSite.Enabled = False        
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
    End Sub

    Protected Sub ShippinglstState_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ShippinglstState.SelectedIndexChanged

        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        PopulateCounties(ShippinglstState.SelectedValue, Me.ShippingCountyField, Me.ShippinglstState)
        ReloadShipping(Basket)
        ShippingCountyField.UpdateAfterCallBack = True
        Shipping.AutoUpdateAfterCallBack()
        Me.ShippingpostalCodeField.UpdateAfterCallBack = True
        LoadTotals(Basket)

    End Sub

    Protected Sub ShippingCountyField_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ShippingCountyField.SelectedIndexChanged
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        ReloadShipping(Basket)
        Shipping.AutoUpdateAfterCallBack()
        Me.ShippingpostalCodeField.UpdateAfterCallBack = True
        LoadTotals(Basket)
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
    End Sub

    Protected Sub BillinglstState_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles BillinglstState.SelectedIndexChanged
        PopulateCounties(BillinglstState.SelectedValue, Me.BillingCountyField, Me.BillinglstState)
        BillingCountyField.UpdateAfterCallBack = True
    End Sub

    Protected Sub ShippingpostalCodeField_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ShippingpostalCodeField.TextChanged
        Me.ShippingPostalCodeBVRegularExpressionValidator.Validate()
        UpdateShipping()
    End Sub

    Protected Sub UpdateShipping()
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        ReloadShipping(Basket)
        Me.ShippingpostalCodeField.UpdateAfterCallBack = True
        Shipping.AutoUpdateAfterCallBack()
        LoadTotals(Basket)
    End Sub

#End Region

    Protected Sub LoginCompleted(ByVal sender As Object, ByVal args As Controls.LoginCompleteEventArgs) Handles LoginControl1.LoginCompleted
        Response.Redirect(PersonalizationServices.GetCheckoutUrl(SessionManager.GetCurrentUserId))
    End Sub

    Public Sub AddressSelected(ByVal addressType As String, ByVal address As Contacts.Address) Handles AddressBook1.AddressSelected
        If String.Compare(addressType, "Billing", True) = 0 Then
            LoadBillingFromAddress(address)
            'Me.pnlBilling.Visible = True
            'Me.chkBillToSame.UpdateAfterCallBack = True
            'Me.chkBillToSame.Checked = False
            'pnlBilling.UpdateAfterCallBack = True
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
            Me.SetFocus(ShippingfirstNameField)
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
        OrderDiscountsField.Text = "-" & Basket.OrderDiscounts.ToString("c") & "<br />" & (Basket.SubTotal - Basket.OrderDiscounts).ToString("c")
        OrderDiscountsField.UpdateAfterCallBack = True
        SubTotalField.Text = Basket.SubTotal.ToString("c")
        SubTotalField.UpdateAfterCallBack = True
        TaxTotalField.Text = Basket.TaxTotal.ToString("c")
        TaxTotalField.UpdateAfterCallBack = True
        ShippingTotalField.Text = (Basket.ShippingTotal - Basket.ShippingDiscounts).ToString("c")
        ShippingTotalField.UpdateAfterCallBack = True
        HandlingTotalField.Text = Basket.HandlingTotal.ToString("c")
        HandlingTotalField.UpdateAfterCallBack = True
        GrandTotalField.Text = Basket.GrandTotal.ToString("c")
        GrandTotalField.UpdateAfterCallBack = True
    End Sub

    Protected Sub ShippingMethodChanged() Handles Shipping.ShippingMethodChanged
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        Dim r As Shipping.ShippingRate = Shipping.FindSelectedRate(Basket)
        Basket.ApplyShippingRate(r)
        LoadTotals(Basket)
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

   
    Protected Sub ShippingAddress1Field_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ShippingAddress1Field.TextChanged
        UpdateShipping()
    End Sub

End Class

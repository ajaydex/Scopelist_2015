Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core
Imports BVSoftware.BVC5.Core.Shipping

Partial Class BVModules_Controls_CartShippingCalculator
    Inherits System.Web.UI.UserControl

    Private Const CLOSE_TEXT As String = "[Close]"
    Private Const CHANGE_TEXT As String = "[Change]"

    Private _DisplayTax As Boolean = False
    Private _DisplayHandling As Boolean = False

#Region " Properties "

    Public Property DisplayTax As Boolean
        Get
            Return Me._DisplayTax
        End Get
        Set(value As Boolean)
            Me._DisplayTax = value
        End Set
    End Property

    Public Property DisplayHandling As Boolean
        Get
            Return Me._DisplayHandling
        End Get
        Set(value As Boolean)
            Me._DisplayHandling = value
        End Set
    End Property

#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If WebAppSettings.DisplayShippingCalculatorInShoppingCart Then
            Me.ucShipping.AutoUpdateAfterCallBack()
            If Not Page.IsPostBack Then
                lstCountry.DataSource = Content.Country.FindActive()
                lstCountry.DataBind()
                SetCountry(WebAppSettings.SiteCountryBvin)
                PopulateDefaults()
                Me.btnGetRates.ImageUrl = PersonalizationServices.GetThemedButton("GetRates")

                Me.btnClose.ImageUrl = PersonalizationServices.GetThemedButton("x")
                Me.trTaxTotal.Visible = Me.DisplayTax
                Me.trHandlingTotal.Visible = Me.DisplayHandling AndAlso (WebAppSettings.HandlingAmount > 0)
                Me.pnlShipping.Visible = False
                Me.pnlShippingMethod.Visible = False

                If SetDefaultShippingMethod(SessionManager.CurrentShoppingCart()) Then
                    SessionManager.InvalidateCachedCart()
                    ' calculate totals logic moved to PreRender method to catch coupon code changes
                Else
                    Me.pnlShipping.Visible = True
                    Me.btnChange.Text = CLOSE_TEXT
                    Me.lblShippingMethod.Text = "No Shipping Method Selected"
                    Me.GrandTotalField.Text = "---"
                End If
            End If

            City.Visible = Me.CityIsRequired
            CityFieldRequired.Enabled = Me.CityIsRequired
            State.Visible = Me.RegionIsRequired
            PostalCode.Visible = Me.PostalCodeIsRequired()
        Else
            Me.Visible = False
        End If
    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart()

        ' check if shipping method was cleared (Order.ClearShippingMethod), usually a result of updating item quantities or adding/removing an item from the cart
        If SessionManager.LastShippingRates.Count > 0 AndAlso String.IsNullOrEmpty(Basket.ShippingMethodUniqueKey) Then
            ' clear the cached shipping rates to force an update
            SessionManager.LastShippingRates = New Utilities.SortableCollection(Of Shipping.ShippingRate)
            SetDefaultShippingMethod(Basket)
        End If

        ' calculate totals logic moved here to catch coupon code changes
        Dim rate As Shipping.ShippingRate = ucShipping.FindSelectedRate(SessionManager.CurrentShoppingCart())
        If rate IsNot Nothing Then
            Me.lblShippingMethod.Text = rate.DisplayName
            If rate.ProviderId = "NOSHIPPING" Then
                Me.btnChange.Visible = False
            End If
        End If
        LoadTotals(SessionManager.CurrentShoppingCart())
    End Sub

#Region " Dropdown Handlers "

    Private Sub SetCountry(ByVal bvin As String)
        If Me.lstCountry.Items.FindByValue(bvin) IsNot Nothing Then
            Me.lstCountry.ClearSelection()
            Me.lstCountry.Items.FindByValue(bvin).Selected = True
            LoadRegions()
        End If
    End Sub

    Private Sub LoadRegions()
        Dim regions As Collection(Of Content.Region) = Content.Region.FindByCountry(Me.lstCountry.SelectedValue)
        If regions.Count > 0 Then
            Me.RegionField.Visible = False
            Me.RegionField.Text = String.Empty
            Me.lstRegion.Visible = True

            Me.lstRegion.DataSource = Content.Region.FindByCountry(Me.lstCountry.SelectedValue)
            Me.lstRegion.DataTextField = "Name"
            Me.lstRegion.DataValueField = "bvin"
            Me.lstRegion.DataBind()
            Me.lstRegion.Items.Insert(0, New ListItem("- select -", ""))
            Me.lstRegion.SelectedIndex = 0
        Else
            Me.RegionField.Visible = True
            Me.lstRegion.Visible = False
            Me.lstRegion.ClearSelection()
        End If
    End Sub

    Private Sub SetRegion(ByVal bvin As String)
        If Me.lstRegion.Items.FindByValue(bvin) IsNot Nothing Then
            Me.lstRegion.ClearSelection()
            Me.lstRegion.Items.FindByValue(bvin).Selected = True
        End If
    End Sub

    Protected Sub lstCountry_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles lstCountry.Load
        LoadPostalRegex()
    End Sub

    Protected Sub lstCountry_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lstCountry.SelectedIndexChanged
        LoadRegions()
        LoadPostalRegex()
        Me.btnGetRates_Click(Nothing, Nothing)
    End Sub

    Protected Sub LoadPostalRegex()
        Dim country As Content.Country = Content.Country.FindByBvin(lstCountry.SelectedValue)
        Dim postalCodeRegularExpressionValidator As Controls.BVRegularExpressionValidator = PostalCodeBVRegularExpressionValidator

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

#End Region

    Private Sub PopulateDefaults()
        If SessionManager.CurrentUserHasCart Then
            Dim basket As Orders.Order = SessionManager.CurrentShoppingCart
            If basket.ShippingAddress.CountryBvin <> String.Empty Then
                SetCountry(basket.ShippingAddress.CountryBvin)
            End If
            If basket.ShippingAddress.RegionBvin <> String.Empty Then
                SetRegion(basket.ShippingAddress.RegionBvin)
            Else
                Me.RegionField.Text = basket.ShippingAddress.RegionName
            End If
            Me.CityField.Text = basket.ShippingAddress.City
            Me.ZipCodeField.Text = basket.ShippingAddress.PostalCode
        End If
    End Sub

    Protected Sub btnGetRates_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGetRates.Click
        Page.Validate("Address")
        If Page.IsValid Then
            Me.pnlShippingMethod.Visible = Page.IsValid
            GetRates()
            If String.IsNullOrEmpty(SessionManager.CurrentShoppingCart().ShippingMethodUniqueKey) Then
                Me.lblShippingMethod.Text = "No Shipping Method Selected"
                Me.ShippingTotalField.Text = String.Empty
            End If
        End If
    End Sub

    Private Sub GetRates()
        If SessionManager.CurrentUserHasCart = True Then
            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
            If Basket IsNot Nothing Then
                Basket.ShippingAddress.PostalCode = Me.ZipCodeField.Text.Trim
                Basket.ShippingAddress.CountryBvin = Me.lstCountry.SelectedValue
                If Me.lstCountry.SelectedItem IsNot Nothing Then
                    Basket.ShippingAddress.CountryName = Me.lstCountry.SelectedItem.Text
                End If
                Basket.ShippingAddress.RegionBvin = Me.lstRegion.SelectedValue
                If Me.lstRegion.Visible = True Then
                    If Me.lstRegion.SelectedItem IsNot Nothing Then
                        Basket.ShippingAddress.RegionName = Me.lstRegion.SelectedItem.Text
                    End If
                Else
                    Basket.ShippingAddress.RegionName = Me.RegionField.Text
                End If
                
                Basket.ShippingAddress.City = Me.CityField.Text
                Basket.ShippingAddress.PostalCode = Me.ZipCodeField.Text
                Orders.Order.Update(Basket)

                Me.ucShipping.LoadShippingMethodsForOrder(Basket, Basket.ShippingAddress.PostalCode)
                Me.message.Visible = False
            End If
        End If
    End Sub

    Protected Function RegionIsRequired() As Boolean
        For Each method As ShippingMethod In ShippingMethod.FindAllByCountry(Me.lstCountry.SelectedValue)
            Dim provider As ShippingProvider = Nothing
            provider = AvailableProviders.FindProviderById(method.ShippingProviderId)
            If provider IsNot Nothing Then
                If provider.RequiresState(method.Bvin) Then
                    Return True
                Else
                    Dim notRegions As Collection(Of Content.Region) = ShippingMethod.FindNotRegions(method.Bvin)
                    If notRegions.Count > 0 Then
                        Return True
                    End If
                End If
            End If
        Next
        Return False
    End Function

    Protected Function CityIsRequired() As Boolean
        For Each method As ShippingMethod In ShippingMethod.FindAllByCountryAndRegion(Me.lstCountry.SelectedValue, Me.lstRegion.SelectedValue)
            Dim provider As ShippingProvider = Nothing
            provider = AvailableProviders.FindProviderById(method.ShippingProviderId)
            If provider IsNot Nothing Then
                If provider.RequiresCity(method.Bvin) Then
                    Return True
                End If
            End If
        Next
        Return False
    End Function

    Protected Function PostalCodeIsRequired() As Boolean
        For Each method As ShippingMethod In ShippingMethod.FindAllByCountryAndRegion(Me.lstCountry.SelectedValue, Me.lstRegion.SelectedValue)
            Dim provider As ShippingProvider = Nothing
            provider = AvailableProviders.FindProviderById(method.ShippingProviderId)
            If provider IsNot Nothing Then
                If provider.RequiresPostalCode(method.Bvin) Then
                    Return True
                End If
            End If
        Next
        Return False
    End Function

    ' copied from new One Page Checkout
    Protected Sub ShippingMethodChanged() Handles ucShipping.ShippingMethodChanged
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        Dim r As Shipping.ShippingRate = ucShipping.FindSelectedRate(Basket)

        If Basket.ApplyShippingRate(r) AndAlso Orders.Order.Update(Basket) Then
            SessionManager.SetSessionString("LastShippingRateUniqueKey", r.UniqueKey)

            ' Calling Basket.ApplyShippingRate() after a product price has already been calculated seems to result in a base product price (no modifiers) less discounts. In other words, too low. To 'solve' this problem we force a reload of the order.
            SessionManager.InvalidateCachedCart()
            Basket = SessionManager.CurrentShoppingCart
        End If

        LoadTotals(Basket)
    End Sub

    ' copied from new One Page Checkout
    Protected Sub LoadTotals(ByVal Basket As Orders.Order)
        If Basket Is Nothing Then
            Basket = SessionManager.CurrentShoppingCart
        End If
        Basket.CalculateTax()
        Orders.Order.Update(Basket)
        'If Basket.OrderDiscounts > 0 Then
        '    OrderDiscountsRow.Visible = True
        '    SubTotalField.CssClass = "MarkDownPrice"
        'Else
        '    OrderDiscountsRow.Visible = False
        'End If
        'OrderDiscountsField.Text = "-" & Basket.OrderDiscounts.ToString("c") & "<br />" & (Basket.SubTotal - Basket.OrderDiscounts).ToString("c")
        'OrderDiscountsField.UpdateAfterCallBack = True
        'SubTotalField.Text = Basket.SubTotal.ToString("c")
        'SubTotalField.UpdateAfterCallBack = True
        TaxTotalField.Text = Basket.TaxTotal.ToString("c")
        TaxTotalField.UpdateAfterCallBack = True
        ShippingTotalField.Text = (Basket.ShippingTotal - Basket.ShippingDiscounts).ToString("c")
        ShippingTotalField.UpdateAfterCallBack = True
        HandlingTotalField.Text = Basket.HandlingTotal.ToString("c")
        HandlingTotalField.UpdateAfterCallBack = True
        'GrandTotalField.Text = Basket.GrandTotal.ToString("c")
        Dim total As Decimal = ((Basket.SubTotal - Basket.OrderDiscounts) + (Basket.ShippingTotal - Basket.ShippingDiscounts)).ToString("c") ' estimated grand total (excludes handling, taxes, and post order adjustment)
        If Me.DisplayTax Then
            total += Basket.TaxTotal
        End If
        If Me.DisplayHandling Then
            total += Basket.HandlingTotal
        End If
        GrandTotalField.Text = total.ToString("c")
        GrandTotalField.UpdateAfterCallBack = True
    End Sub

    ' copied from new One Page Checkout
    Private Function SetDefaultShippingMethod(ByVal o As Orders.Order) As Boolean
        Dim result As Boolean = False

        ' if we don't have any shipping rates, get them
        If SessionManager.LastShippingRates.Count = 0 OrElse Not Page.IsPostBack Then
            ucShipping.LoadShippingMethodsForOrder(o, o.ShippingAddress.PostalCode)
        End If

        ' try to set existing shipping rate from order (if it exists)
        If Not String.IsNullOrEmpty(o.ShippingMethodUniqueKey) OrElse Not String.IsNullOrEmpty(SessionManager.GetSessionString("LastShippingRateUniqueKey")) Then
            If Not String.IsNullOrEmpty(o.ShippingMethodUniqueKey) Then
                ucShipping.SetShippingMethod(o.ShippingMethodUniqueKey)
            Else
                ucShipping.SetShippingMethod(SessionManager.GetSessionString("LastShippingRateUniqueKey"))
            End If

            Dim rate As Shipping.ShippingRate = ucShipping.FindSelectedRate(o)
            If rate IsNot Nothing AndAlso (rate.UniqueKey = o.ShippingMethodUniqueKey OrElse String.IsNullOrEmpty(o.ShippingMethodUniqueKey)) Then
                ShippingMethodChanged()
                result = True
            End If
        End If

        If result = False Then
            ' if we have shipping rates and a user has not yet selected one, pre-select the first (lowest) rate
            If SessionManager.LastShippingRates.Count > 0 AndAlso ucShipping.FindSelectedRate(o) Is Nothing Then
                ucShipping.SetShippingMethod(SessionManager.LastShippingRates(0).UniqueKey)
                ShippingMethodChanged()
                result = True
            End If
        End If

        Return result
    End Function

    Protected Sub btnChange_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnChange.Click, btnClose.Click
        Me.pnlShipping.Visible = Not Me.pnlShipping.Visible

        If Me.pnlShipping.Visible Then
            Me.btnChange.Text = CLOSE_TEXT
        Else
            Me.btnChange.Text = CHANGE_TEXT
        End If

        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart()
        If Not String.IsNullOrEmpty(Basket.ShippingMethodUniqueKey) Then
            Me.ucShipping.SetShippingMethod(Basket.ShippingMethodUniqueKey)

            Me.pnlShippingMethod.Visible = True
        Else
            Me.pnlShippingMethod.Visible = False
        End If
    End Sub

End Class
Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.Shipping

' Partial Code For This File Contributed By Andy Miller - http://structured-solutions.net/

Partial Class EstimateShipping
    Inherits BaseStorePage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Popup.master")
    End Sub

    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            lstCountry.DataSource = Content.Country.FindActive()
            lstCountry.DataBind()
            SetCountry(WebAppSettings.SiteCountryBvin)
            PopulateDefaults()
            Me.btnGetRates.ImageUrl = PersonalizationServices.GetThemedButton("GetRates")
        End If

        City.Visible = Me.CityIsRequired
        CityFieldRequired.Enabled = Me.CityIsRequired
        State.Visible = Me.RegionIsRequired        
        ZipCodeField.Visible = Me.PostalCodeIsRequired()
        ZipCodeRequired.Enabled = Me.PostalCodeIsRequired()

        PostalCode.Visible = Me.PostalCodeIsRequired()
        lstRegion.AutoPostBack = True

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
            Me.lstRegion.Visible = True
            Me.txtRegion.Visible = False
            Me.StateFieldRequired.Enabled = False

            Me.lstRegion.DataSource = Content.Region.FindByCountry(Me.lstCountry.SelectedValue)
            Me.lstRegion.DataTextField = "Name"
            Me.lstRegion.DataValueField = "bvin"
            Me.lstRegion.DataBind()
        Else
            Me.lstRegion.Visible = False
            Me.txtRegion.Visible = True
            Me.StateFieldRequired.Enabled = True
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
            ElseIf basket.ShippingAddress.RegionName <> String.Empty Then
                Me.txtRegion.Text = basket.ShippingAddress.RegionName
            End If
            Me.CityField.Text = basket.ShippingAddress.City
            Me.ZipCodeField.Text = basket.ShippingAddress.PostalCode
            GetRates()
        End If
    End Sub

    Protected Sub btnGetRates_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGetRates.Click
        Me.lstShippingRates.Visible = False
        If Page.IsValid Then
            GetRates()
        End If
    End Sub

    Private Sub GetRates()
        If SessionManager.CurrentUserHasCart = True Then
            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
            If Basket IsNot Nothing Then
                Basket.ShippingAddress.PostalCode = Me.ZipCodeField.Text.Trim()
                Basket.ShippingAddress.CountryBvin = Me.lstCountry.SelectedValue
                If Me.lstCountry.SelectedItem IsNot Nothing Then
                    Basket.ShippingAddress.CountryName = Me.lstCountry.SelectedItem.Text
                End If
                If Me.lstRegion.Visible Then
                    Basket.ShippingAddress.RegionBvin = Me.lstRegion.SelectedValue
                    If Me.lstRegion.SelectedItem IsNot Nothing Then
                        Basket.ShippingAddress.RegionName = Me.lstRegion.SelectedItem.Text
                    End If
                ElseIf Me.txtRegion.Visible Then
                    Basket.ShippingAddress.RegionBvin = ""
                    Basket.ShippingAddress.RegionName = Me.txtRegion.Text.Trim()
                End If
                
                Basket.ShippingAddress.City = Me.CityField.Text
                Basket.ShippingAddress.PostalCode = Me.ZipCodeField.Text
                Orders.Order.Update(Basket)

                Dim Rates As Utilities.SortableCollection(Of Shipping.ShippingRate)
                Rates = Basket.FindAvailableShippingRates()

                If Rates.Count < 1 Then
                    Me.message.Text = "Unable to estimate at this time"
                    Me.message.Visible = True
                    Me.lstShippingRates.Visible = False
                End If
                Me.lstShippingRates.DataSource = Rates
                Me.lstShippingRates.DataBind()
                Me.lstShippingRates.Visible = True
                Me.message.Visible = False
            End If
        End If
    End Sub

    Protected Function RegionIsRequired() As Boolean
        For Each method As ShippingMethod In ShippingMethod.FindAllByCountry(Me.lstCountry.SelectedValue)
            Dim provider As ShippingProvider = AvailableProviders.FindProviderById(method.ShippingProviderId)
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
            Dim provider As ShippingProvider = AvailableProviders.FindProviderById(method.ShippingProviderId)
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
            Dim provider As ShippingProvider = AvailableProviders.FindProviderById(method.ShippingProviderId)
            If provider IsNot Nothing Then
                If provider.RequiresPostalCode(method.Bvin) Then
                    Return True
                End If
            End If
        Next
        Return False
    End Function

End Class

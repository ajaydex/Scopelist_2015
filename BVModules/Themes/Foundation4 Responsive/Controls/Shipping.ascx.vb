Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_Shipping
    Inherits System.Web.UI.UserControl

    Public Event ShippingMethodChanged()

    Private _tabIndex As Integer = -1
    Public Property TabIndex() As Integer
        Get
            Return _tabIndex
        End Get
        Set(ByVal value As Integer)
            _tabIndex = value
        End Set
    End Property

    Public Sub LoadShippingMethodsForOrder(ByVal o As Orders.Order, ByVal Zip As String)
        Me.ShippingMessage.Text = String.Empty

        Me.ShippingRatesList.Items.Clear()

        If o.HasShippingItems = False Then
            Dim li As New ListItem(Content.SiteTerms.GetTerm("NoShippingRequired"), "NOSHIPPING")
            li.Selected = True
            Me.ShippingRatesList.Items.Add(li)
        Else
            If AddressIsValid(o.ShippingAddress) Then
                ' Shipping Methods
                Dim Rates As Utilities.SortableCollection(Of Shipping.ShippingRate)
                Rates = o.FindAvailableShippingRates()
                SessionManager.LastShippingRates = Rates
                Me.ShippingRatesList.DataTextField = "RateAndNameForDisplay"
                Me.ShippingRatesList.DataValueField = "UniqueKey"
                Me.ShippingRatesList.DataSource = Rates
                Me.ShippingRatesList.DataBind()

                If Me.TabIndex <> -1 Then
                    ShippingRatesList.TabIndex = Me.TabIndex
                End If

                If ShippingRatesList.Items.Count = 0 Then
                    ShippingMessage.Text = Content.SiteTerms.GetTerm("NoValidShippingMethods")
                End If
            End If
        End If
    End Sub

    Public Sub SetShippingMethod(ByVal key As String)
        If ShippingRatesList.Items.FindByValue(key) IsNot Nothing Then
            ShippingRatesList.ClearSelection()
            ShippingRatesList.Items.FindByValue(key).Selected = True
        End If
    End Sub

    Public Function FindSelectedRate(ByVal o As Orders.Order) As Shipping.ShippingRate
        Dim result As Shipping.ShippingRate = Nothing

        If o.HasShippingItems = False Then
            result = New Shipping.ShippingRate
            result.DisplayName = "No Shipping Required"
            result.ProviderId = "NOSHIPPING"
            result.ProviderServiceCode = "NOSHIPPING"
            result.Rate = 0D
            result.RateAndNameForDisplay = "No Shipping Required"
            result.ShippingMethodId = "NOSHIPPING"
            result.UniqueKey = "NOSHIPPING"
        Else
            Dim rates As Utilities.SortableCollection(Of Shipping.ShippingRate) = SessionManager.LastShippingRates
            If (rates Is Nothing) OrElse (rates.Count < 1) Then
                rates = o.FindAvailableShippingRates()
            End If

            For Each r As Shipping.ShippingRate In rates
                If r.UniqueKey = Me.ShippingRatesList.SelectedValue Then
                    result = r
                    Exit For
                End If
            Next
        End If

        Return result
    End Function

    Public Function IsValid() As Boolean
        If (Me.ShippingRatesList.SelectedItem Is Nothing) Then
            Return False
        Else
            Return True
        End If
    End Function

    Public Sub AutoUpdateAfterCallBack()
        Me.ShippingRatesList.AutoUpdateAfterCallBack = True
        Me.ShippingMessage.AutoUpdateAfterCallBack = True
    End Sub

    Public Sub SetFocus()
        Me.Page.SetFocus(Me.ShippingRatesList)
    End Sub

    Protected Sub ShippingRatesList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ShippingRatesList.SelectedIndexChanged
        RaiseEvent ShippingMethodChanged()
    End Sub

    Protected Function AddressIsValid(ByVal address As Contacts.Address) As Boolean
        If RegionIsRequired(address) AndAlso (String.IsNullOrEmpty(address.RegionBvin) AndAlso String.IsNullOrEmpty(address.RegionName)) Then
            Me.ShippingMessage.Text = "Select a region name to calculate shipping"
            Return False
        ElseIf CityIsRequired(address) AndAlso String.IsNullOrEmpty(address.City) Then
            Me.ShippingMessage.Text = "Enter a city name to calculate shipping"
            Return False
        ElseIf PostalCodeIsRequired(address) AndAlso String.IsNullOrEmpty(address.PostalCode) Then
            Me.ShippingMessage.Text = "Enter a postal code to calculate shipping"
            Return False
        Else
            Return True
        End If
    End Function

    Protected Function RegionIsRequired(ByVal address As Contacts.Address) As Boolean
        For Each method As Shipping.ShippingMethod In Shipping.ShippingMethod.FindAllByCountry(address.CountryBvin)
            Dim provider As Shipping.ShippingProvider = Nothing
            provider = Shipping.AvailableProviders.FindProviderById(method.ShippingProviderId)
            If provider IsNot Nothing Then
                If provider.RequiresState(method.Bvin) Then
                    Return True
                End If
            End If
        Next
        Return False
    End Function

    Protected Function CityIsRequired(ByVal address As Contacts.Address) As Boolean
        For Each method As Shipping.ShippingMethod In Shipping.ShippingMethod.FindAllByCountryAndRegion(address.CountryBvin, address.RegionBvin)
            Dim provider As Shipping.ShippingProvider = Nothing
            provider = Shipping.AvailableProviders.FindProviderById(method.ShippingProviderId)
            If provider IsNot Nothing Then
                If provider.RequiresCity(method.Bvin) Then
                    Return True
                End If
            End If
        Next
        Return False
    End Function

    Protected Function PostalCodeIsRequired(ByVal address As Contacts.Address) As Boolean
        For Each method As Shipping.ShippingMethod In Shipping.ShippingMethod.FindAllByCountryAndRegion(address.CountryBvin, address.RegionBvin)
            Dim provider As Shipping.ShippingProvider = Nothing
            provider = Shipping.AvailableProviders.FindProviderById(method.ShippingProviderId)
            If provider IsNot Nothing Then
                If provider.RequiresPostalCode(method.Bvin) Then
                    Return True
                End If
            End If
        Next
        Return False
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim script As String = "function RetrievingRates() {" & _
            "var e = document.getElementById('" & Me.ShippingRatesList.ClientID & "');" & _
            "if (e != null) e.innerText = 'Retrieving rates...';" & _
            "var e = document.getElementById('" & Me.ShippingMessage.ClientID & "');" & _
            "if (e != null) e.innerText = 'Retrieving rates...';" & _
            "}"
        Page.ClientScript.RegisterClientScriptBlock(Me.GetType(), script, script, True)

        Dim count As Integer = ShippingRatesList.Items.Count

        script = "function ShippingChanging(isDisabled){ "
        For i As Integer = 0 To count - 1
            Dim itemName As String = "item" & i.ToString()
            script &= "var " & itemName & " = document.getElementById('" & ShippingRatesList.ClientID & "_" & i.ToString() & "');"
            script &= "if (" & itemName & " != null){"
            script &= "  " & itemName & ".disabled = isDisabled;"
            script &= "}"
        Next
        script &= "}"
        Page.ClientScript.RegisterClientScriptBlock(Me.GetType(), "ShippingChanging", script, True)

        If Me.ShippingRatesList.Items.Count = 1 Then
            Dim o As Orders.Order = SessionManager.CurrentShoppingCart()
            Me.ShippingRatesList.SelectedIndex = 0
            o.ApplyShippingRate(Me.FindSelectedRate(o))
            Orders.Order.Update(o)
            RaiseEvent ShippingMethodChanged()
        End If
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        ShippingLiteral.Text = Content.SiteTerms.GetTerm("ShippingTermsAndConditions")
        ShippingHyperLink.Attributes.Add("onclick", "javascript:window.open('" & Page.ResolveUrl("~/ShippingTerms.aspx") & "','Policy','width=400, height=500, menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no')")
        ShippingHyperLink.NavigateUrl = "javascript:void(0);"
    End Sub
End Class

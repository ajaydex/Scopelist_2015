Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_StoreAddressEditor
    Inherits System.Web.UI.UserControl

    Private _Initialized As Boolean = False

    Private _ShowAddressLine2 As Boolean = True
    Private _ShowAddressLine3 As Boolean = True
    Private _ShowCompanyName As Boolean = True
    Private _ShowCounty As Boolean = True
    Private _ShowFaxNumber As Boolean = False
    Private _ShowMiddleInitial As Boolean = True
    Private _ShowNickName As Boolean = False
    Private _ShowPhoneNumber As Boolean = True
    Private _ShowWebSiteURL As Boolean = False

    Private _RequireAddress As Boolean = True
    Private _RequireCity As Boolean = True
    Private _RequireCompany As Boolean = False
    Private _RequireFax As Boolean = False
    Private _RequireFirstName As Boolean = True
    Private _RequireLastName As Boolean = True
    Private _RequireNickName As Boolean = False
    Private _RequirePhone As Boolean = False
    Private _RequirePostalCode As Boolean = True
    Private _RequireRegion As Boolean = True
    Private _RequireWebSiteURL As Boolean = False

    Private _TabOrderOffSet As Integer = 100

    Public Property ShowAddressLine2() As Boolean
        Get
            Return _ShowAddressLine2
        End Get
        Set(ByVal value As Boolean)
            _ShowAddressLine2 = value
        End Set
    End Property
    Public Property ShowAddressLine3() As Boolean
        Get
            Return _ShowAddressLine3
        End Get
        Set(ByVal value As Boolean)
            _ShowAddressLine3 = value
        End Set
    End Property
    Public Property ShowCompanyName() As Boolean
        Get
            Return _ShowCompanyName
        End Get
        Set(ByVal Value As Boolean)
            _ShowCompanyName = Value
        End Set
    End Property
    Public Property ShowCounty() As Boolean
        Get
            Return _ShowCounty
        End Get
        Set(ByVal value As Boolean)
            _ShowCounty = value
            'Me.lstState.AutoPostBack = value
        End Set
    End Property
    Public Property ShowFaxNumber() As Boolean
        Get
            Return _ShowFaxNumber
        End Get
        Set(ByVal Value As Boolean)
            _ShowFaxNumber = Value
        End Set
    End Property
    Public Property ShowMiddleInitial() As Boolean
        Get
            Return _ShowMiddleInitial
        End Get
        Set(ByVal Value As Boolean)
            _ShowMiddleInitial = Value
        End Set
    End Property
    Public Property ShowNickName() As Boolean
        Get
            Return _ShowNickName
        End Get
        Set(ByVal value As Boolean)
            _ShowNickName = value
        End Set
    End Property
    Public Property ShowPhoneNumber() As Boolean
        Get
            Return _ShowPhoneNumber
        End Get
        Set(ByVal Value As Boolean)
            _ShowPhoneNumber = Value
        End Set
    End Property
    Public Property ShowWebSiteURL() As Boolean
        Get
            Return _ShowWebSiteURL
        End Get
        Set(ByVal Value As Boolean)
            _ShowWebSiteURL = Value
        End Set
    End Property

    Public Property RequireAddress() As Boolean
        Get
            Return _RequireAddress
        End Get
        Set(ByVal Value As Boolean)
            _RequireAddress = Value
        End Set
    End Property
    Public Property RequireCity() As Boolean
        Get
            Return _RequireCity
        End Get
        Set(ByVal Value As Boolean)
            _RequireCity = Value
        End Set
    End Property
    Public Property RequireCompany() As Boolean
        Get
            Return _RequireCompany
        End Get
        Set(ByVal Value As Boolean)
            _RequireCompany = Value
        End Set
    End Property
    Public Property RequireFax() As Boolean
        Get
            Return _RequireFax
        End Get
        Set(ByVal Value As Boolean)
            _RequireFax = Value
        End Set
    End Property
    Public Property RequireFirstName() As Boolean
        Get
            Return _RequireFirstName
        End Get
        Set(ByVal Value As Boolean)
            _RequireFirstName = Value
        End Set
    End Property
    Public Property RequireLastName() As Boolean
        Get
            Return _RequireLastName
        End Get
        Set(ByVal Value As Boolean)
            _RequireLastName = Value
        End Set
    End Property
    Public Property RequireNickName() As String
        Get
            Return _RequireNickName
        End Get
        Set(ByVal value As String)
            _RequireNickName = value
        End Set
    End Property
    Public Property RequirePhone() As Boolean
        Get
            Return _RequirePhone
        End Get
        Set(ByVal Value As Boolean)
            _RequirePhone = Value
        End Set
    End Property
    Public Property RequirePostalCode() As Boolean
        Get
            Return _RequirePostalCode
        End Get
        Set(ByVal Value As Boolean)
            _RequirePostalCode = Value
        End Set
    End Property
    Public Property RequireRegion() As Boolean
        Get
            Return _RequireRegion
        End Get
        Set(ByVal Value As Boolean)
            _RequireRegion = Value
        End Set
    End Property
    Public Property RequireWebSiteURL() As Boolean
        Get
            Return _RequireWebSiteURL
        End Get
        Set(ByVal Value As Boolean)
            _RequireWebSiteURL = Value
        End Set
    End Property


    Public ReadOnly Property CountryName() As String
        Get
            Return Me.lstCountry.SelectedItem.Text
        End Get
    End Property
    Public Property CountryCode() As String
        Get
            Return Me.lstCountry.SelectedValue
        End Get
        Set(ByVal Value As String)

            If Me.lstCountry.Items.FindByValue(Value) IsNot Nothing Then
                Me.lstCountry.ClearSelection()
                Me.lstCountry.Items.FindByValue(Value).Selected = True
            End If
            Me.PopulateRegions(Me.lstCountry.SelectedValue)
        End Set
    End Property
    Public Property NickName() As String
        Get
            Return Me.NickNameField.Text.Trim
        End Get
        Set(ByVal value As String)
            Me.NickNameField.Text = value
        End Set
    End Property
    Public Property FirstName() As String
        Get
            Return Me.firstNameField.Text.Trim
        End Get
        Set(ByVal Value As String)
            Me.firstNameField.Text = Value.Trim
        End Set
    End Property
    Public Property MiddleInitial() As String
        Get
            Return MiddleInitialField.Text.Trim
        End Get
        Set(ByVal Value As String)
            MiddleInitialField.Text = Value.Trim
        End Set
    End Property
    Public Property LastName() As String
        Get
            Return lastNameField.Text.Trim
        End Get
        Set(ByVal Value As String)
            lastNameField.Text = Value.Trim
        End Set
    End Property
    Public Property CompanyName() As String
        Get
            Return CompanyField.Text.Trim
        End Get
        Set(ByVal Value As String)
            CompanyField.Text = Value.Trim
        End Set
    End Property
    Public Property StreetLine1() As String
        Get
            Return address1Field.Text.Trim
        End Get
        Set(ByVal Value As String)
            address1Field.Text = Value.Trim
        End Set
    End Property
    Public Property StreetLine2() As String
        Get
            Return address2Field.Text.Trim
        End Get
        Set(ByVal Value As String)
            address2Field.Text = Value.Trim
        End Set
    End Property
    Public Property StreetLine3() As String
        Get
            Return address3Field.Text.Trim
        End Get
        Set(ByVal Value As String)
            address3Field.Text = Value.Trim
        End Set
    End Property
    Public Property City() As String
        Get
            Return cityField.Text.Trim
        End Get
        Set(ByVal Value As String)
            cityField.Text = Value.Trim
        End Set
    End Property
    Public Property StateName() As String
        Get
            If lstState.Items.Count > 0 Then
                Return lstState.SelectedItem.Text
            Else
                Return stateField.Text.Trim
            End If
        End Get
        Set(ByVal Value As String)
            stateField.Text = Value.Trim
        End Set
    End Property
    Public Property StateCode() As String
        Get
            If Me.lstState.Items.Count > 0 Then
                Return lstState.SelectedValue
            Else
                Return ""
            End If
        End Get
        Set(ByVal Value As String)
            If Me.lstState.Items.FindByValue(Value) IsNot Nothing Then
                Me.lstState.ClearSelection()
                Me.lstState.Items.FindByValue(Value).Selected = True
            End If
        End Set
    End Property
    Public Property PostalCode() As String
        Get
            Return postalCodeField.Text.Trim
        End Get
        Set(ByVal Value As String)
            postalCodeField.Text = Value.Trim
        End Set
    End Property
    Public Property PhoneNumber() As String
        Get
            Return PhoneNumberField.Text.Trim
        End Get
        Set(ByVal Value As String)
            PhoneNumberField.Text = Value.Trim
        End Set
    End Property
    Public Property FaxNumber() As String
        Get
            Return Me.FaxNumberField.Text.Trim
        End Get
        Set(ByVal Value As String)
            Me.FaxNumberField.Text = Value
        End Set
    End Property
    Public Property WebSiteURL() As String
        Get
            Return Me.WebSiteURLField.Text.Trim
        End Get
        Set(ByVal Value As String)
            Me.WebSiteURLField.Text = Value
        End Set
    End Property
    Public Property CountyCode() As String
        Get
            Return Me.CountyField.SelectedValue
        End Get
        Set(ByVal value As String)
            If Me.CountyField.Items.FindByValue(value) IsNot Nothing Then
                Me.CountyField.ClearSelection()
                Me.CountyField.Items.FindByValue(value).Selected = True
            End If
        End Set
    End Property
    Public ReadOnly Property CountyName() As String
        Get
            Return Me.CountyField.SelectedItem.Text
        End Get
    End Property

    Public Property TabOrderOffSet() As Integer
        Get
            Return _TabOrderOffSet
        End Get
        Set(ByVal Value As Integer)
            _TabOrderOffSet = Value
        End Set
    End Property

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        Me.lstState.AutoPostBack = True

        If Not Page.IsPostBack Then
            InitializeAddress()

            Me.lstCountry.TabIndex = Convert.ToInt16(_TabOrderOffSet + 0)
            Me.NickNameField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 1)
            Me.firstNameField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 2)
            Me.MiddleInitialField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 3)
            Me.lastNameField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 4)
            Me.CompanyField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 5)
            Me.address1Field.TabIndex = Convert.ToInt16(_TabOrderOffSet + 6)
            Me.address2Field.TabIndex = Convert.ToInt16(_TabOrderOffSet + 7)
            Me.address3Field.TabIndex = Convert.ToInt16(_TabOrderOffSet + 8)
            Me.cityField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 9)
            Me.lstState.TabIndex = Convert.ToInt16(_TabOrderOffSet + 10)
            Me.stateField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 11)
            Me.postalCodeField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 12)
            Me.CountyField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 13)
            Me.PhoneNumberField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 14)
            Me.FaxNumberField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 15)
            Me.WebSiteURLField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 16)

            valAddress.Enabled = _RequireAddress
            valCity.Enabled = _RequireCity
            valCompany.Enabled = _RequireCompany
            valFax.Enabled = _RequireFax
            ValFirstNameField.Enabled = _RequireFirstName
            valLastName.Enabled = _RequireLastName
            valNickName.Enabled = _RequireNickName
            valPhone.Enabled = _RequirePhone
            valPostalCode.Enabled = _RequirePostalCode
            valWebSite.Enabled = _RequireWebSiteURL
        End If
        UpdateVisibleRows()
    End Sub

    Public Function Validate() As Boolean
        Dim result As Boolean = True

        If _RequireAddress = True Then
            Me.valAddress.Validate()
            If Me.valAddress.IsValid = False Then
                result = False
            End If
        End If

        If _RequireNickName = True Then
            Me.valNickName.Validate()
            If Me.valNickName.IsValid = False Then
                result = False
            End If
        End If

        If _RequireFirstName = True Then
            Me.ValFirstNameField.Validate()
            If Me.ValFirstNameField.IsValid = False Then
                result = False
            End If
        End If

        If _RequireLastName = True Then
            Me.valLastName.Validate()
            If Me.valLastName.IsValid = False Then
                result = False
            End If
        End If

        If _RequireCity = True Then
            Me.valCity.Validate()
            If Me.valCity.IsValid = False Then
                result = False
            End If
        End If

        If _RequirePostalCode = True Then
            Me.valPostalCode.Validate()
            If Me.valPostalCode.IsValid = False Then
                result = False
            End If
        End If


        If _RequireCompany = True Then
            Me.valCompany.Validate()
            If Me.valCompany.IsValid = False Then
                result = False
            End If
        End If

        If _RequirePhone = True Then
            Me.valPhone.Validate()
            If Me.valPhone.IsValid = False Then
                result = False
            End If
            If Me.PhoneNumberField.Text.Trim.Length < 7 Then
                result = False
                Me.valPhone.IsValid = False
            End If

        End If

        If _RequireFax = True Then
            Me.valFax.Validate()
            If Me.valFax.IsValid = False Then
                result = False
            End If
        End If

        If _RequireWebSiteURL = True Then
            Me.valWebSite.Validate()
            If Me.valWebSite.IsValid = False Then
                result = False
            End If
        End If

        If _RequireRegion = True Then
            If Me.lstState.Items.Count > 1 Then
                If Me.lstState.SelectedIndex = 0 Then
                    'Me.lblStateError.Visible = True
                    result = False
                End If
            End If
        End If

        Return result
    End Function

    Public Sub LoadFromAddress(ByVal a As Contacts.Address)
        InitializeAddress()
        If Not a Is Nothing Then
            Me.AddressBvin.Value = a.Bvin
            If Me.lstCountry.Items.FindByValue(a.CountryBvin) IsNot Nothing Then
                Me.lstCountry.ClearSelection()
                Me.lstCountry.Items.FindByValue(a.CountryBvin).Selected = True
            End If
            Me.PopulateRegions(Me.lstCountry.SelectedValue)
            If Me.lstState.Items.Count > 0 Then
                Me.lstState.ClearSelection()
                If Me.lstState.Items.FindByValue(a.RegionBvin) IsNot Nothing Then
                    Me.lstState.Items.FindByValue(a.RegionBvin).Selected = True
                End If
            End If
            Me.PopulateCounties(Me.lstState.SelectedValue)
            If Me.CountyField.Items.Count > 0 Then
                Me.CountyField.ClearSelection()
                If Me.CountyField.Items.FindByValue(a.CountyBvin) IsNot Nothing Then
                    Me.CountyField.Items.FindByValue(a.CountyBvin).Selected = True
                End If
            End If

            Me.NickName = a.NickName
            Me.StateName = a.RegionName
            Me.FirstName = a.FirstName
            Me.MiddleInitial = a.MiddleInitial
            Me.LastName = a.LastName
            Me.CompanyName = a.Company
            Me.StreetLine1 = a.Line1
            Me.StreetLine2 = a.Line2
            Me.StreetLine3 = a.Line3
            Me.City = a.City
            Me.PostalCode = a.PostalCode
            Me.PhoneNumber = a.Phone
            Me.FaxNumber = a.Fax
            Me.WebSiteURL = a.WebSiteUrl
        End If
    End Sub

    Public Function GetAsAddress() As Contacts.Address
        Dim a As New Contacts.Address
        If lstCountry.Items.Count > 0 Then
            a.CountryBvin = lstCountry.SelectedValue
            a.CountryName = lstCountry.SelectedItem.ToString
        Else
            a.CountryBvin = ""
            a.CountryName = "Unknown"
        End If
        If lstState.Items.Count > 0 Then
            a.RegionName = lstState.SelectedItem.Text
            a.RegionBvin = lstState.SelectedItem.Value
        Else
            a.RegionName = stateField.Text.Trim()
            a.RegionBvin = ""
        End If
        If Me.CountyField.Items.Count > 0 Then
            a.CountyBvin = Me.CountyField.SelectedValue
            a.CountyName = Me.CountyField.SelectedItem.Text
        Else
            a.CountyBvin = String.Empty
            a.CountyName = String.Empty
        End If
        a.NickName = Me.NickName
        a.FirstName = Me.FirstName()
        a.MiddleInitial = Me.MiddleInitial()
        a.LastName = Me.LastName()
        a.Company = Me.CompanyName()
        a.Line1 = Me.StreetLine1()
        a.Line2 = Me.StreetLine2()
        a.Line3 = Me.StreetLine3
        a.City = Me.City()
        a.PostalCode = Me.PostalCode()
        a.Phone = Me.PhoneNumber()
        a.Fax = Me.FaxNumber
        a.WebSiteUrl = Me.WebSiteURL
        If Me.AddressBvin.Value <> String.Empty Then
            a.Bvin = Me.AddressBvin.Value
        End If
        Return a
    End Function

    Private Sub UpdateVisibleRows()

        Me.valNickName.Enabled = _RequireNickName
        Me.ValFirstNameField.Enabled = _RequireFirstName
        Me.valLastName.Enabled = _RequireLastName
        Me.valAddress.Enabled = _RequireAddress
        Me.valCity.Enabled = _RequireCity
        Me.valPostalCode.Enabled = _RequirePostalCode

        If _ShowNickName = True Then
            Me.NickNameRow.Visible = True
        Else
            Me.NickNameRow.Visible = False
        End If

        If _ShowMiddleInitial = True Then
            Me.MiddleInitialRow.Visible = True
        Else
            Me.MiddleInitialRow.Visible = False
        End If

        If _ShowCompanyName = True Then
            Me.CompanyNameRow.Visible = True
            Me.valCompany.Enabled = _RequireCompany
        Else
            Me.valCompany.Enabled = False
            Me.CompanyNameRow.Visible = False
        End If

        If _ShowPhoneNumber = True Then
            Me.PhoneRow.Visible = True
            Me.valPhone.Enabled = _RequirePhone
        Else
            Me.valPhone.Enabled = False
            Me.PhoneRow.Visible = False
        End If

        If _ShowFaxNumber = True Then
            Me.FaxRow.Visible = True
            Me.valFax.Enabled = _RequireFax
        Else
            Me.valFax.Enabled = False
            Me.FaxRow.Visible = False
        End If

        If _ShowWebSiteURL = True Then
            Me.WebSiteURLRow.Visible = True
            Me.valWebSite.Enabled = _RequireWebSiteURL
        Else
            Me.valWebSite.Enabled = False
            Me.WebSiteURLRow.Visible = False
        End If

        If _ShowCounty = True Then
            If Me.CountyField.Items.Count > 0 Then
                Me.CountyField.Visible = True
            Else
                Me.CountyField.Visible = False
            End If
        Else
            Me.CountyField.Visible = False
        End If

        If _ShowAddressLine2 = True Then
            Me.StreetLine2Row.Visible = True
        Else
            Me.StreetLine2Row.Visible = False
        End If

        If _ShowAddressLine3 = True Then
            Me.StreetLine3Row.Visible = True
        Else
            Me.StreetLine3Row.Visible = False
        End If

    End Sub

    Private Sub InitializeAddress()
        If Me._Initialized = False Then
            PopulateCountries()
            If Me.lstCountry.Items.FindByValue(WebAppSettings.SiteCountryBvin) IsNot Nothing Then
                Me.lstCountry.ClearSelection()
                Me.lstCountry.Items.FindByValue(WebAppSettings.SiteCountryBvin).Selected = True
            End If
            PopulateRegions(WebAppSettings.SiteCountryBvin)
            PopulateCounties(Me.lstState.SelectedValue)
            _Initialized = True
        End If
    End Sub

    Private Sub PopulateCountries()
        lstCountry.DataSource = Content.Country.FindActive
        lstCountry.DataValueField = "Bvin"
        lstCountry.DataTextField = "DisplayName"
        lstCountry.DataBind()
    End Sub

    Private Sub PopulateRegions(ByVal countryCode As String)
        lstState.Items.Clear()
        Try
            lstState.DataSource = Content.Region.FindByCountry(countryCode)
            lstState.DataTextField = "abbreviation"
            lstState.DataValueField = "bvin"
            lstState.DataBind()

            If lstState.Items.Count() < 1 Then
                lstState.Visible = False
                stateField.Visible = True
                ShippingStateListRequiredFieldValidator.Enabled = False
                ShippingStateListRequiredFieldValidator.Visible = False
                'ShippingStateRequiredFieldValidator.Enabled = _RequireRegion
                'ShippingStateRequiredFieldValidator.Visible = _RequireRegion
            Else
                lstState.Visible = True
                stateField.Visible = False
                If lstState.Equals(lstState) Then
                    ShippingStateListRequiredFieldValidator.Enabled = _RequireRegion
                    ShippingStateListRequiredFieldValidator.Visible = _RequireRegion
                    'ShippingStateRequiredFieldValidator.Enabled = False
                    'ShippingStateRequiredFieldValidator.Visible = False
                End If
                lstState.Items.Insert(0, New ListItem("--", ""))
            End If

        Catch Ex As Exception
            'EventLog.LogEvent(Ex)
        End Try
    End Sub

    Private Sub PopulateCounties(ByVal regionID As String)
        Me.CountyField.Items.Clear()
        Me.CountyField.DataSource = Content.County.FindByRegion(regionID)
        Me.CountyField.DataTextField = "Name"
        Me.CountyField.DataValueField = "bvin"
        Me.CountyField.DataBind()

        If Me.CountyField.Items.Count < 1 Then
            Me.CountyField.Visible = False
        Else
            If Me.ShowCounty = True Then
                Me.CountyField.Visible = True
            End If
        End If
    End Sub

    Private Sub lstCountry_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles lstCountry.Load
        LoadPostalRegex()
    End Sub

    Private Sub lstCountry_SelectedIndexChanged(ByVal Sender As Object, ByVal E As EventArgs) Handles lstCountry.SelectedIndexChanged
        PopulateRegions(lstCountry.SelectedItem.Value)
        Me.lstState.AutoUpdateAfterCallBack = True
        Me.stateField.AutoUpdateAfterCallBack = True
        LoadPostalRegex()
    End Sub

    Protected Sub lstState_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lstState.SelectedIndexChanged
        PopulateCounties(Me.lstState.SelectedValue)
        Me.CountyField.AutoUpdateAfterCallBack = True
        Me.CountyField.AutoUpdateAfterCallBack = True
    End Sub

    Public Sub SetFocus()
        Me.Page.SetFocus(Me.lstCountry)
    End Sub

    Public Sub Initialize(ByVal addressType As Controls.AddressTypes)
        If addressType = BVSoftware.Bvc5.Core.Controls.AddressTypes.Billing Then
            Me.ShowMiddleInitial = WebAppSettings.BillAddressShowMiddleInitial
            Me.ShowCompanyName = WebAppSettings.BillAddressShowCompany
            Me.ShowPhoneNumber = WebAppSettings.BillAddressShowPhone
            Me.ShowFaxNumber = WebAppSettings.BillAddressShowFax
            Me.ShowWebSiteURL = WebAppSettings.BillAddressShowWebSiteUrl
            Me.RequireCompany = WebAppSettings.BillAddressRequireCompany
            Me.RequireFax = WebAppSettings.BillAddressRequireFax
            Me.RequireFirstName = WebAppSettings.BillAddressRequireFirstName
            Me.RequireLastName = WebAppSettings.BillAddressRequireLastName
            Me.RequirePhone = WebAppSettings.BillAddressRequirePhone
            Me.RequireWebSiteURL = WebAppSettings.BillAddressRequireWebSiteURL
        ElseIf addressType = BVSoftware.Bvc5.Core.Controls.AddressTypes.Shipping Then
            Me.ShowMiddleInitial = WebAppSettings.ShipAddressShowMiddleInitial
            Me.ShowCompanyName = WebAppSettings.ShipAddressShowCompany
            Me.ShowPhoneNumber = WebAppSettings.ShipAddressShowPhone
            Me.ShowFaxNumber = WebAppSettings.ShipAddressShowFax
            Me.ShowWebSiteURL = WebAppSettings.ShipAddressShowWebSiteURL
            Me.RequireCompany = WebAppSettings.ShipAddressRequireCompany
            Me.RequireFax = WebAppSettings.ShipAddressRequireFax
            Me.RequireFirstName = WebAppSettings.ShipAddressRequireFirstName
            Me.RequireLastName = WebAppSettings.ShipAddressRequireLastName
            Me.RequirePhone = WebAppSettings.ShipAddressRequirePhone
            Me.RequireWebSiteURL = WebAppSettings.ShipAddressRequireWebSiteURL
        End If
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
End Class

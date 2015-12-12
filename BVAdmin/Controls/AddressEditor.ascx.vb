Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_AddressEditor
    Inherits System.Web.UI.UserControl

    Private _ShowMiddleInitial As Boolean = True
    Private _ShowCompanyName As Boolean = True
    Private _ShowPhoneNumber As Boolean = True
    Private _ShowFaxNumber As Boolean = False
    Private _ShowWebSiteURL As Boolean = False
    Private _ShowCounty As Boolean = False
    Private _ShowNickName As Boolean = True

    Private _RequireFirstName As Boolean = True
    Private _RequireLastName As Boolean = True
    Private _RequireCompany As Boolean = False
    Private _RequirePhone As Boolean = False
    Private _RequireFax As Boolean = False
    Private _RequireWebSiteURL As Boolean = False

    Private _RequireAddress As Boolean = True
    Private _RequireCity As Boolean = True
    Private _RequirePostalCode As Boolean = True
    Private _RequireRegion As Boolean = True

    Private _TabOrderOffSet As Integer = 100

    Public Property ShowMiddleInitial() As Boolean
        Get
            Return _ShowMiddleInitial
        End Get
        Set(ByVal Value As Boolean)
            _ShowMiddleInitial = Value
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
    Public Property ShowPhoneNumber() As Boolean
        Get
            Return _ShowPhoneNumber
        End Get
        Set(ByVal Value As Boolean)
            _ShowPhoneNumber = Value
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
    Public Property ShowWebSiteURL() As Boolean
        Get
            Return _ShowWebSiteURL
        End Get
        Set(ByVal Value As Boolean)
            _ShowWebSiteURL = Value
        End Set
    End Property
    Public Property ShowCounty() As Boolean
        Get
            Return _ShowCounty
        End Get
        Set(ByVal value As Boolean)
            _ShowCounty = value
            'Me.lstState.AutoCallBack = value
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
    Public Property RequireCompany() As Boolean
        Get
            Return _RequireCompany
        End Get
        Set(ByVal Value As Boolean)
            _RequireCompany = Value
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
    Public Property RequireFax() As Boolean
        Get
            Return _RequireFax
        End Get
        Set(ByVal Value As Boolean)
            _RequireFax = Value
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
            If lstState.Items.Count > 1 Then
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
            If Me.lstState.Items.Count > 1 Then
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

    Private _Initialized As Boolean = False

    'Used to automatically update shipping when zip code, state, or country changes
    Event AddressChanged()

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Not Page.IsPostBack Then
            InitializeAddress()

            Me.lblStateError.Visible = False

            Me.lstCountry.TabIndex = Convert.ToInt16(_TabOrderOffSet + 0)
            Me.NickNameField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 1)
            Me.firstNameField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 2)
            Me.MiddleInitialField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 3)
            Me.lastNameField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 4)
            Me.CompanyField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 5)
            Me.address1Field.TabIndex = Convert.ToInt16(_TabOrderOffSet + 6)
            Me.address2Field.TabIndex = Convert.ToInt16(_TabOrderOffSet + 7)
            Me.address3Field.TabIndex = Convert.ToInt16(_TabOrderOffSet + 7)
            Me.cityField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 8)
            Me.lstState.TabIndex = Convert.ToInt16(_TabOrderOffSet + 9)
            Me.stateField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 10)
            Me.postalCodeField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 11)
            Me.CountyField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 12)
            Me.PhoneNumberField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 13)
            Me.FaxNumberField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 14)
            Me.WebSiteURLField.TabIndex = Convert.ToInt16(_TabOrderOffSet + 15)

        End If
        UpdateVisibleRows()
    End Sub

    Public Function Validate() As Boolean
        Dim result As Boolean = True
        Me.lblStateError.Visible = False

        If _RequireAddress = True Then
            Me.valAddress.Validate()
            If Me.valAddress.IsValid = False Then
                result = False
            End If
        End If

        If _RequireFirstName = True Then
            Me.valFirstName.Validate()
            If Me.valFirstName.IsValid = False Then
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
                    Me.lblStateError.Visible = True
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
            Me.lstCountry.ClearSelection()
            If Me.lstCountry.Items.FindByValue(a.CountryBvin) IsNot Nothing Then
                Me.lstCountry.Items.FindByValue(a.CountryBvin).Selected = True
            End If
            Me.PopulateRegions(Me.lstCountry.SelectedValue)
            If Me.lstState.Items.Count > 1 Then
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
            Me.WebSiteURL = a.WebSiteURL
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
        If lstState.Items.Count > 1 Then
            a.RegionName = lstState.SelectedItem.Text
            a.RegionBvin = lstState.SelectedItem.Value
        Else
            a.RegionName = stateField.Text.Trim()
            a.RegionBvin = ""
        End If

        If Me.CountyField.Visible = True Then
            If Me.CountyField.Items.Count > 0 Then
                a.CountyBvin = Me.CountyField.SelectedValue
                a.CountryName = Me.CountyField.SelectedItem.Text
            Else
                a.CountyBvin = String.Empty
                a.CountyName = String.Empty
            End If
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
        a.WebSiteURL = Me.WebSiteURL
        If Me.AddressBvin.Value <> String.Empty Then
            a.Bvin = Me.AddressBvin.Value
        End If
        Return a
    End Function

    Private Sub UpdateVisibleRows()

        Me.valFirstName.Enabled = _RequireFirstName
        Me.valLastName.Enabled = _RequireLastName
        Me.valAddress.Enabled = _RequireAddress
        Me.valCity.Enabled = _RequireCity
        Me.valPostalCode.Enabled = _RequirePostalCode

        If _ShowMiddleInitial = True Then
            Me.MiddleInitialField.Visible = True
        Else
            Me.MiddleInitialField.Visible = False
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

        'If Me.CountyField.Items.Count > 0 Then
        '    Me.CountyField.Visible = True
        'Else
        '    Me.CountyField.Visible = False
        'End If

        Me.trNickNameRow.Visible = _ShowNickName

    End Sub

    Private Sub InitializeAddress()
        If Me._Initialized = False Then
            PopulateCountries()
            Me.lstCountry.ClearSelection()
            If Me.lstCountry.Items.FindByValue(WebAppSettings.SiteCountryBvin) IsNot Nothing Then
                Me.lstCountry.Items.FindByValue(WebAppSettings.SiteCountryBvin).Selected = True
                PopulateRegions(WebAppSettings.SiteCountryBvin)
            Else
                If Me.lstCountry.Items.Count > 0 Then
                    Me.lstCountry.Items.Item(0).Selected = True
                    PopulateRegions(Me.lstCountry.Items.Item(0).Value)
                End If
            End If

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
        Me.lstState.Items.Clear()
        Me.lstState.AppendDataBoundItems = True
        Me.lstState.Items.Add("")
        Me.lstState.DataSource = Content.Region.FindByCountry(countryCode)
        Me.lstState.DataTextField = "abbreviation"
        Me.lstState.DataValueField = "bvin"
        Me.lstState.DataBind()

        If lstState.Items.Count() < 2 Then
            Me.lstState.Visible = False
            stateField.Visible = True
        Else
            Me.lstState.Visible = True
            stateField.Visible = False
        End If
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
                CountyField.Visible = True
            End If
        End If
        Me.CountyField.UpdateAfterCallBack = True
    End Sub

    Private Sub lstCountry_SelectedIndexChanged(ByVal Sender As Object, ByVal E As EventArgs) Handles lstCountry.SelectedIndexChanged
        PopulateRegions(lstCountry.SelectedItem.Value)
        Me.lstState.UpdateAfterCallBack = True
        Me.stateField.UpdateAfterCallBack = True
        RaiseEvent AddressChanged()
    End Sub

    Protected Sub lstState_SelectedIndexChanged1(ByVal sender As Object, ByVal e As System.EventArgs) Handles lstState.SelectedIndexChanged
        PopulateCounties(Me.lstState.SelectedValue)                
        Me.stateField.UpdateAfterCallBack = True
        Me.CountyField.AutoCallBack = True
        RaiseEvent AddressChanged()
    End Sub

    Protected Sub countyField_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles CountyField.SelectedIndexChanged
        RaiseEvent AddressChanged()
    End Sub

    Protected Sub postalCodeField_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles postalCodeField.TextChanged
        RaiseEvent AddressChanged()
    End Sub

End Class

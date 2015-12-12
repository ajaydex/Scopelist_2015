Imports BVSoftware.BVC5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_SearchCriteria
    Inherits System.Web.UI.UserControl

    Public Class SearchCriteriaEventArgs
        Inherits EventArgs

        Private _Criteria As Catalog.ProductStoreSearchCriteria

        Public Property Criteria() As Catalog.ProductStoreSearchCriteria
            Get
                Return _Criteria
            End Get
            Set(ByVal value As Catalog.ProductStoreSearchCriteria)
                _Criteria = value
            End Set
        End Property

        Public Sub New()

        End Sub

        Public Sub New(ByVal searchCriteria As Catalog.ProductStoreSearchCriteria)
            _Criteria = searchCriteria
        End Sub

    End Class

    Public Property Keyword() As String
        Get
            Return Me.KeywordField.Text.Trim
        End Get
        Set(ByVal value As String)
            Me.KeywordField.Text = value
        End Set
    End Property

    Public Sub FocusKeyword()
        Me.KeywordField.Focus()
    End Sub

    Public Event SearchFired As EventHandler(Of SearchCriteriaEventArgs)

    Public Function GetCriteria() As Catalog.ProductStoreSearchCriteria
        Dim result As New Catalog.ProductStoreSearchCriteria

        result.Keyword = Me.KeywordField.Text.Trim

        If WebAppSettings.SearchShowCategory = True Then
            If CategoryField.SelectedValue <> String.Empty Then
                result.CategoryId = CategoryField.SelectedValue
            End If
        End If

        If WebAppSettings.SearchShowManufacturer = True Then
            If ManufacturerField.SelectedValue <> String.Empty Then
                result.ManufacturerId = ManufacturerField.SelectedValue
            End If
        End If

        If WebAppSettings.SearchShowPrice = True Then
            If Not String.IsNullOrEmpty(Me.PriceMaxField.Text.Trim()) AndAlso Not String.IsNullOrEmpty(Me.PriceMinField.Text.Trim()) Then
                If Decimal.TryParse(Me.PriceMinField.Text, result.MinPrice) = True Then
                    If Decimal.TryParse(Me.PriceMaxField.Text, result.MaxPrice) = False Then
                        result.MinPrice = -1D
                        result.MaxPrice = -1D
                    End If
                Else
                    result.MinPrice = -1D
                End If
            End If
        End If

        If WebAppSettings.SearchShowSort = True Then
            If Me.SortField.SelectedValue = "-1" Then
                result.SortBy = Catalog.ProductStoreSearchSortBy.NotSet
            Else
                result.SortBy = CType(Convert.ToInt32(Me.SortField.SelectedValue.Substring(0, 1)), Catalog.ProductStoreSearchSortBy)
            End If

            Select Case result.SortBy
                Case Catalog.ProductStoreSearchSortBy.ProductName, _
                    Catalog.ProductStoreSearchSortBy.SitePrice

                    If Me.SortField.SelectedValue.Length = 1 Then
                        result.SortOrder = Catalog.ProductSearchCriteriaSortOrder.Ascending
                    Else
                        result.SortOrder = Catalog.ProductSearchCriteriaSortOrder.Descending
                    End If

                Case Else
                    result.SortOrder = Catalog.ProductSearchCriteriaSortOrder.NotSet

            End Select
        End If

        If WebAppSettings.SearchShowVendor = True Then
            If VendorField.SelectedValue <> String.Empty Then
                result.VendorId = Me.VendorField.SelectedValue
            End If
        End If

        ParseCustomProperty(result, WebAppSettings.SearchProperty1, Me.PropertyList1, Me.PropertyField1)
        ParseCustomProperty(result, WebAppSettings.SearchProperty2, Me.PropertyList2, Me.PropertyField2)
        ParseCustomProperty(result, WebAppSettings.SearchProperty3, Me.PropertyList3, Me.PropertyField3)
        ParseCustomProperty(result, WebAppSettings.SearchProperty4, Me.PropertyList4, Me.PropertyField4)
        ParseCustomProperty(result, WebAppSettings.SearchProperty5, Me.PropertyList5, Me.PropertyField5)
        ParseCustomProperty(result, WebAppSettings.SearchProperty6, Me.PropertyList6, Me.PropertyField6)
        ParseCustomProperty(result, WebAppSettings.SearchProperty7, Me.PropertyList7, Me.PropertyField7)
        ParseCustomProperty(result, WebAppSettings.SearchProperty8, Me.PropertyList8, Me.PropertyField8)
        ParseCustomProperty(result, WebAppSettings.SearchProperty9, Me.PropertyList9, Me.PropertyField9)
        ParseCustomProperty(result, WebAppSettings.SearchProperty10, Me.PropertyList10, Me.PropertyField10)

        Return result
    End Function

    Private Sub ParseCustomProperty(ByVal result As Catalog.ProductStoreSearchCriteria, ByVal bvin As String, ByVal ddl As DropDownList, ByVal tb As TextBox)
        Dim pp As Catalog.ProductProperty = Catalog.ProductProperty.FindByBvin(bvin)
        Select Case pp.TypeCode
            Case Catalog.ProductPropertyType.MultipleChoiceField
                If ddl.SelectedValue <> String.Empty Then
                    result.CustomProperties.Add(New Catalog.ProductSearchCustomPropertyValue(bvin, ddl.SelectedValue))
                End If
            Case Catalog.ProductPropertyType.TextField
                If tb.Text.Trim <> String.Empty Then
                    result.CustomProperties.Add(New Catalog.ProductSearchCustomPropertyValue(bvin, tb.Text.Trim()))
                End If
        End Select
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click
        Dim criteria As Catalog.ProductStoreSearchCriteria = Me.GetCriteria()
        RaiseEvent SearchFired(Me, New SearchCriteriaEventArgs(criteria))
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.btnSearch.ImageUrl = PersonalizationServices.GetThemedButton("GoSearch")
            LoadSettings()
            Dim criteria As Catalog.ProductStoreSearchCriteria = SessionManager.StoreSearchCriteria
            If criteria IsNot Nothing Then
                LoadFromCriteria(criteria)
            End If
        End If
    End Sub

    Private Sub LoadFromCriteria(ByVal criteria As Catalog.ProductStoreSearchCriteria)
        KeywordField.Text = criteria.Keyword
        If criteria.SortBy <> Catalog.ProductStoreSearchSortBy.NotSet Then
            Select Case criteria.SortBy
                Case Catalog.ProductStoreSearchSortBy.CreationDate, _
                    Catalog.ProductStoreSearchSortBy.ManufacturerName, _
                    Catalog.ProductStoreSearchSortBy.Vendor

                    SortField.SelectedValue = criteria.SortOrder.ToString()

                Case Catalog.ProductStoreSearchSortBy.ProductName, _
                    Catalog.ProductStoreSearchSortBy.SitePrice

                    If criteria.SortOrder = Catalog.ProductSearchCriteriaSortOrder.Descending Then
                        SortField.SelectedValue = criteria.SortBy.ToString() + "0"
                    Else
                        SortField.SelectedValue = criteria.SortBy.ToString()
                    End If

                Case Else
                    If WebAppSettings.EnableAdvancedSearch Then
                        SortField.SelectedValue = Catalog.ProductStoreSearchSortBy.NotSet.ToString()  ' Best Match
                    Else
                        SortField.SelectedValue = Catalog.ProductStoreSearchSortBy.ProductName.ToString()
                    End If
            End Select
        Else
            If WebAppSettings.EnableAdvancedSearch Then
                SortField.SelectedValue = Catalog.ProductStoreSearchSortBy.NotSet.ToString()  ' Best Match
            Else
                SortField.SelectedValue = Catalog.ProductStoreSearchSortBy.ProductName.ToString()
            End If
        End If

        If Not String.IsNullOrEmpty(criteria.CategoryId) Then
            CategoryField.SelectedValue = criteria.CategoryId
        Else
            CategoryField.SelectedIndex = 0
        End If

        If Not String.IsNullOrEmpty(criteria.ManufacturerId) Then
            ManufacturerField.SelectedValue = criteria.ManufacturerId
        Else
            ManufacturerField.SelectedIndex = 0
        End If

        If Not String.IsNullOrEmpty(criteria.VendorId) Then
            VendorField.SelectedValue = criteria.VendorId
        Else
            VendorField.SelectedIndex = 0
        End If

        If criteria.MinPrice >= 0 Then
            PriceMinField.Text = criteria.MinPrice.ToString("c")
        Else
            PriceMinField.Text = String.Empty
        End If

        If criteria.MaxPrice >= 0 Then
            PriceMaxField.Text = criteria.MaxPrice.ToString("c")
        Else
            PriceMaxField.Text = String.Empty
        End If

        InitializeCustomProperty(criteria, WebAppSettings.SearchProperty1, Me.PropertyList1, Me.PropertyField1)
        InitializeCustomProperty(criteria, WebAppSettings.SearchProperty2, Me.PropertyList2, Me.PropertyField2)
        InitializeCustomProperty(criteria, WebAppSettings.SearchProperty3, Me.PropertyList3, Me.PropertyField3)
        InitializeCustomProperty(criteria, WebAppSettings.SearchProperty4, Me.PropertyList4, Me.PropertyField4)
        InitializeCustomProperty(criteria, WebAppSettings.SearchProperty5, Me.PropertyList5, Me.PropertyField5)
        InitializeCustomProperty(criteria, WebAppSettings.SearchProperty6, Me.PropertyList6, Me.PropertyField6)
        InitializeCustomProperty(criteria, WebAppSettings.SearchProperty7, Me.PropertyList7, Me.PropertyField7)
        InitializeCustomProperty(criteria, WebAppSettings.SearchProperty8, Me.PropertyList8, Me.PropertyField8)
        InitializeCustomProperty(criteria, WebAppSettings.SearchProperty9, Me.PropertyList9, Me.PropertyField9)
        InitializeCustomProperty(criteria, WebAppSettings.SearchProperty10, Me.PropertyList10, Me.PropertyField10)
    End Sub

    Private Sub InitializeCustomProperty(ByVal result As Catalog.ProductStoreSearchCriteria, ByVal bvin As String, ByVal ddl As DropDownList, ByVal tb As TextBox)
        For Each prop As Catalog.ProductSearchCustomPropertyValue In result.CustomProperties
            If prop.PropertyBvin = bvin Then
                Dim pp As Catalog.ProductProperty = Catalog.ProductProperty.FindByBvin(bvin)
                Select Case pp.TypeCode
                    Case Catalog.ProductPropertyType.MultipleChoiceField
                        ddl.SelectedValue = prop.PropertyValue
                    Case Catalog.ProductPropertyType.TextField
                        tb.Text = prop.PropertyValue
                End Select

                Exit For
            End If
        Next
    End Sub

    Private Sub LoadSettings()

        If WebAppSettings.SearchShowCategory = True Then
            Me.trCategory.Visible = True
            Me.CategoryField.Items.Add(New ListItem("- Any -", String.Empty))
            Dim cats As Collection(Of ListItem) = Catalog.Category.ListFullTreeWithIndents
            For Each li As ListItem In cats
                Me.CategoryField.Items.Add(li)
            Next
        Else
            Me.trCategory.Visible = False
        End If

        If WebAppSettings.SearchShowManufacturer = True Then
            Me.trManufacturer.Visible = True
            Me.ManufacturerField.Items.Add(New ListItem("- Any -", String.Empty))
            Dim mfg As Collection(Of Contacts.Manufacturer) = Contacts.Manufacturer.FindAll
            For Each m As Contacts.Manufacturer In mfg
                Me.ManufacturerField.Items.Add(New ListItem(m.DisplayName, m.Bvin))
            Next
        Else
            Me.trManufacturer.Visible = False
        End If

        If WebAppSettings.SearchShowPrice = True Then
            Me.trPriceRange.Visible = True
        Else
            Me.trPriceRange.Visible = False
        End If

        If WebAppSettings.SearchShowSort = True Then
            Me.trSort.Visible = True
        Else
            Me.trSort.Visible = False
        End If

        If WebAppSettings.SearchShowVendor = True Then
            Me.trVendor.Visible = True
            Me.VendorField.Items.Add(New ListItem("- Any -", String.Empty))
            Dim ven As Collection(Of Contacts.Vendor) = Contacts.Vendor.FindAll
            For Each v As Contacts.Vendor In ven
                Me.VendorField.Items.Add(New ListItem(v.DisplayName, v.Bvin))
            Next
        Else
            Me.trVendor.Visible = False
        End If

        LoadProperties()

        If Not WebAppSettings.EnableAdvancedSearch Then
            ' remove "Best Match" sort
            For Each li As ListItem In Me.SortField.Items
                If li.Value = "-1" Then
                    Me.SortField.Items.Remove(li)
                    Exit For
                End If
            Next
        End If
    End Sub

    Private Sub LoadProperties()
        Me.LoadCustomProperty(WebAppSettings.SearchProperty1, tr1, Property1Label, PropertyList1, PropertyField1)
        Me.LoadCustomProperty(WebAppSettings.SearchProperty2, tr2, Property2Label, PropertyList2, PropertyField2)
        Me.LoadCustomProperty(WebAppSettings.SearchProperty3, tr3, Property3Label, PropertyList3, PropertyField3)
        Me.LoadCustomProperty(WebAppSettings.SearchProperty4, tr4, Property4Label, PropertyList4, PropertyField4)
        Me.LoadCustomProperty(WebAppSettings.SearchProperty5, tr5, Property5Label, PropertyList5, PropertyField5)
        Me.LoadCustomProperty(WebAppSettings.SearchProperty6, tr6, Property6Label, PropertyList6, PropertyField6)
        Me.LoadCustomProperty(WebAppSettings.SearchProperty7, tr7, Property7Label, PropertyList7, PropertyField7)
        Me.LoadCustomProperty(WebAppSettings.SearchProperty8, tr8, Property8Label, PropertyList8, PropertyField8)
        Me.LoadCustomProperty(WebAppSettings.SearchProperty9, tr9, Property9Label, PropertyList9, PropertyField9)
        Me.LoadCustomProperty(WebAppSettings.SearchProperty10, tr10, Property10Label, PropertyList10, PropertyField10)
    End Sub

    Private Sub LoadCustomProperty(ByVal bvin As String, ByVal row As System.Web.UI.HtmlControls.HtmlContainerControl, ByVal propertyLabel As Label, ByVal ddl As DropDownList, ByVal tb As TextBox)
        If bvin <> String.Empty Then
            row.Visible = True
            Dim pp As Catalog.ProductProperty = Catalog.ProductProperty.FindByBvin(bvin)
            propertyLabel.Text = pp.DisplayName

            Select Case pp.TypeCode
                Case Catalog.ProductPropertyType.MultipleChoiceField
                    tb.Visible = False
                    ddl.Visible = True
                    ddl.Items.Add(New ListItem("- Any -", String.Empty))
                    For i As Integer = 0 To pp.Choices.Count - 1
                        ddl.Items.Add(New ListItem(pp.Choices(i).ChoiceName, pp.Choices(i).Bvin))
                    Next
                Case Catalog.ProductPropertyType.TextField
                    tb.Visible = True
                    ddl.Visible = False
                Case Else
                    ' Do nothing yet.
            End Select
        Else
            row.Visible = False
        End If
    End Sub

End Class
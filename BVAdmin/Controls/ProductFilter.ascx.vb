Imports BVSoftware.Bvc5.Core
Imports System.Xml.Serialization
Imports System.Collections.ObjectModel
Imports System.Linq

Partial Class BVAdmin_Controls_ProductFilter
    Inherits System.Web.UI.UserControl

    Protected ChoiceAndChoiceOptionList As Collection(Of Catalog.ProductChoiceAndChoiceOptionPair)

    Public Property DisplaySharedChoicesSection() As Boolean
        Get
            Return sharedChoicesPanel.Visible
        End Get
        Set(ByVal value As Boolean)
            sharedChoicesPanel.Visible = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            BindDropDownLists()            
            BindChoicesAndOptionsGrid()
        End If
    End Sub

    Public Sub LoadFilter(ByVal criteria As Catalog.ProductSearchCriteria)
        If criteria.Keyword <> String.Empty Then
            KeywordTextBox.Text = criteria.Keyword
        End If
        ExactMatchCheckBox.Checked = criteria.KeywordIsExact
        If criteria.VendorId <> String.Empty Then
            VendorDropDownList.SelectedValue = criteria.VendorId
        End If
        If criteria.ManufacturerId <> String.Empty Then
            ManufacturerDropDownList.SelectedValue = criteria.ManufacturerId
        End If
        If criteria.MaxPrice <> -1D Then
            ToPriceTextBox.Text = criteria.MaxPrice.ToString("c")
        End If
        If criteria.MinPrice <> -1D Then
            FromPriceTextBox.Text = criteria.MinPrice.ToString("c")
        End If
        If criteria.LastXNumberOfItemsAddedToStore <> -1D Then
            NumberOfItemsAddedToStoreTextBox.Text = criteria.LastXNumberOfItemsAddedToStore
        End If
        If criteria.ItemsAddedInLastXDays <> -1D Then
            ItemsAddedInThePastXDaysTextBox.Text = criteria.ItemsAddedInLastXDays
        End If
        If criteria.ProductTypeId <> String.Empty Then
            ProductTypeDropDownList.SelectedValue = criteria.ProductTypeId
        End If
        SortByDropDownList.SelectedValue = criteria.SortBy
        SortOrderDropDownList.SelectedValue = criteria.SortOrder
        ChoiceAndChoiceOptionList = criteria.ChoicesAndChoiceOptions
        BindChoicesAndOptionsGrid()
    End Sub

    Protected Sub BindDropDownLists()
        VendorDropDownList.DataSource = Contacts.Vendor.FindAll()
        VendorDropDownList.DataTextField = "DisplayName"
        VendorDropDownList.DataValueField = "bvin"
        VendorDropDownList.DataBind()

        ManufacturerDropDownList.DataSource = Contacts.Manufacturer.FindAll()
        ManufacturerDropDownList.DataTextField = "DisplayName"
        ManufacturerDropDownList.DataValueField = "bvin"
        ManufacturerDropDownList.DataBind()

        BindFilterDropDownList()

        ProductTypeDropDownList.DataSource = Catalog.ProductType.FindAll()
        ProductTypeDropDownList.DataTextField = "ProductTypeName"
        ProductTypeDropDownList.DataValueField = "bvin"
        ProductTypeDropDownList.DataBind()

        CategoryDropDownList.Items.AddRange(Catalog.Category.ListFullTreeWithIndents(True).ToArray())
        
        If WebAppSettings.DisableInventory Then
            InventoryStatusDropDownList.Items.Add(New ListItem("- Inventory Disabled -", ""))
            InventoryStatusDropDownList.Enabled = False
        Else
            InventoryStatusDropDownList.Items.Add(New ListItem("- Any -", ""))
            InventoryStatusDropDownList.Items.Add(New ListItem("Not Available", "0"))
            InventoryStatusDropDownList.Items.Add(New ListItem("Available", "1"))
        End If

        If DisplaySharedChoicesSection Then
            SharedChoiceDropDownList.DataSource = Catalog.ProductChoice.GetSharedProductChoices()
            SharedChoiceDropDownList.DataTextField = "Name"
            SharedChoiceDropDownList.DataValueField = "bvin"
            SharedChoiceDropDownList.DataBind()
            BindSharedChoiceOptionsDropDownList()
        End If        
    End Sub

    Protected Sub BindSharedChoiceOptionsDropDownList()
        SharedChoiceOptionDropDownList.DataSource = Catalog.ProductChoiceOption.FindByChoiceId(SharedChoiceDropDownList.SelectedValue)
        SharedChoiceOptionDropDownList.DataTextField = "DisplayText"
        SharedChoiceOptionDropDownList.DataValueField = "bvin"
        SharedChoiceOptionDropDownList.DataBind()
        SharedChoiceOptionDropDownList.Items.Insert(0, "Any")
    End Sub

    Protected Sub BindFilterDropDownList()
        FilterDropDownList.DataSource = Catalog.ProductFilter.FindAllFilters(Me.Page.AppRelativeVirtualPath)
        FilterDropDownList.DataTextField = "Name"
        FilterDropDownList.DataValueField = "bvin"
        FilterDropDownList.DataBind()
    End Sub

    Public Sub LoadCriteria(ByVal criteria As Catalog.ProductSearchCriteria)
        If KeywordTextBox.Text.Trim() <> String.Empty Then
            criteria.Keyword = KeywordTextBox.Text.Trim
            criteria.KeywordIsExact = ExactMatchCheckBox.Checked
        Else
            criteria.Keyword = Nothing
        End If

        If VendorDropDownList.SelectedValue <> "" Then
            criteria.VendorId = VendorDropDownList.SelectedValue
        Else
            criteria.VendorId = Nothing
        End If

        If ManufacturerDropDownList.SelectedValue <> "" Then
            criteria.ManufacturerId = ManufacturerDropDownList.SelectedValue
        Else
            criteria.ManufacturerId = Nothing
        End If

        If ToPriceTextBox.Text.Trim() <> "" Then
            Dim val As Decimal = 0D
            If Decimal.TryParse(ToPriceTextBox.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, val) Then
                criteria.MaxPrice = val
            Else
                criteria.MaxPrice = Nothing
            End If
        End If

        If FromPriceTextBox.Text.Trim() <> "" Then
            Dim val As Decimal = 0D
            If Decimal.TryParse(FromPriceTextBox.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, val) Then
                criteria.MinPrice = val
            Else
                criteria.MinPrice = Nothing
            End If
        End If

        If NumberOfItemsAddedToStoreTextBox.Text.Trim() <> "" Then
            Dim val As Integer = 0
            If Integer.TryParse(NumberOfItemsAddedToStoreTextBox.Text, val) Then
                criteria.LastXNumberOfItemsAddedToStore = val
            Else
                criteria.LastXNumberOfItemsAddedToStore = Nothing
            End If
        End If

        If ItemsAddedInThePastXDaysTextBox.Text.Trim() <> "" Then
            Dim val As Integer = 0
            If Integer.TryParse(ItemsAddedInThePastXDaysTextBox.Text, val) Then
                criteria.ItemsAddedInLastXDays = val                
            Else
                criteria.ItemsAddedInLastXDays = Nothing                
            End If
        End If

        If ProductTypeDropDownList.SelectedValue <> "" Then
            criteria.ProductTypeId = ProductTypeDropDownList.SelectedValue
        Else
            criteria.ProductTypeId = Nothing
        End If

        If CategoryDropDownList.SelectedValue <> "" Then
            criteria.CategoryId = CategoryDropDownList.SelectedValue
        Else
            criteria.CategoryId = Nothing
        End If

        criteria.SortBy = CType(SortByDropDownList.SelectedValue, Catalog.ProductSearchCriteriaSortBy)
        criteria.SortOrder = CType(SortOrderDropDownList.SelectedValue, Catalog.ProductSearchCriteriaSortOrder)
        criteria.ChoicesAndChoiceOptions = Me.ChoiceAndChoiceOptionList

        If StatusDropDownList.SelectedValue <> "" Then
            criteria.Status = [Enum].Parse(GetType(Catalog.ProductStatus), StatusDropDownList.SelectedValue)
        End If

        If InventoryStatusDropDownList.SelectedValue <> "" Then
            criteria.InventoryStatus = [Enum].Parse(GetType(Catalog.ProductInventoryStatus), InventoryStatusDropDownList.SelectedValue)
        End If

        criteria.DisplayInactiveProducts = True
    End Sub

    Protected Sub AddChoiceImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddChoiceImageButton.Click
        If ChoiceAndChoiceOptionList Is Nothing Then
            ChoiceAndChoiceOptionList = New Collection(Of Catalog.ProductChoiceAndChoiceOptionPair)
        End If

        Dim choiceOptions As Collection(Of Catalog.ProductChoiceOption)
        If SharedChoiceOptionDropDownList.SelectedValue = "Any" Then
            choiceOptions = Catalog.ProductChoiceOption.FindByChoiceId(SharedChoiceDropDownList.SelectedValue)
        Else
            choiceOptions = New Collection(Of Catalog.ProductChoiceOption)
            choiceOptions.Add(Catalog.ProductChoiceOption.FindByBvin(SharedChoiceOptionDropDownList.SelectedValue))
        End If

        Dim choice As Catalog.ProductChoice = Catalog.ProductChoice.FindByBvin(SharedChoiceDropDownList.SelectedValue)
        For Each choiceOption As Catalog.ProductChoiceOption In choiceOptions
            Dim choiceAndOptionPair As New Catalog.ProductChoiceAndChoiceOptionPair()
            choiceAndOptionPair.ChoiceId = choice.Bvin
            choiceAndOptionPair.ChoiceName = choice.Name
            choiceAndOptionPair.ChoiceOptionId = choiceOption.Bvin
            choiceAndOptionPair.ChoiceOptionName = choiceOption.DisplayText
            ChoiceAndChoiceOptionList.Add(choiceAndOptionPair)
        Next
        choiceOptions = Nothing
        BindChoicesAndOptionsGrid()
    End Sub

    Protected Overrides Sub LoadViewState(ByVal savedState As Object)
        If savedState IsNot Nothing Then
            Dim arr() As Object = DirectCast(savedState, Object())
            ChoiceAndChoiceOptionList = DirectCast(arr(1), Collection(Of Catalog.ProductChoiceAndChoiceOptionPair))
            MyBase.LoadViewState(arr(0))
        End If
    End Sub

    Protected Overrides Function SaveViewState() As Object
        Dim arr() As Object = New Object() {MyBase.SaveViewState(), ChoiceAndChoiceOptionList}
        Return arr
    End Function

    Protected Sub SharedChoiceDropDownList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles SharedChoiceDropDownList.SelectedIndexChanged
        BindSharedChoiceOptionsDropDownList()
    End Sub

    Protected Sub BindChoicesAndOptionsGrid()
        If ChoiceAndChoiceOptionList Is Nothing Then
            ChoiceAndChoiceOptionList = New Collection(Of Catalog.ProductChoiceAndChoiceOptionPair)
        End If
        ChoicesAndOptionsGridView.DataSource = ChoiceAndChoiceOptionList
        ChoicesAndOptionsGridView.DataKeyNames = New String() {"bvin"}
        ChoicesAndOptionsGridView.DataBind()
    End Sub

    Protected Sub ChoicesAndOptionsGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles ChoicesAndOptionsGridView.RowDeleting
        Dim key As String = ChoicesAndOptionsGridView.DataKeys(e.RowIndex).Value
        Dim indexToDelete As Integer = -1
        For i As Integer = 0 To (ChoiceAndChoiceOptionList.Count - 1)
            If ChoiceAndChoiceOptionList(i).Bvin = key Then
                indexToDelete = i
            End If
        Next
        If indexToDelete <> -1 Then
            ChoiceAndChoiceOptionList.RemoveAt(indexToDelete)
        End If
        BindChoicesAndOptionsGrid()
    End Sub

    Protected Sub LoadFilterLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LoadFilterLinkButton.Click
        Dim filter As Catalog.ProductFilter = Catalog.ProductFilter.FindByBvin(FilterDropDownList.SelectedValue)
        If filter IsNot Nothing Then
            If filter.Criteria <> String.Empty Then
                FilterNameTextBox.Text = filter.Name
                Dim xs As New XmlSerializer(GetType(Catalog.ProductSearchCriteria))
                Dim criteria As Catalog.ProductSearchCriteria
                Dim sr As New IO.StringReader(filter.Criteria)
                Try
                    criteria = DirectCast(xs.Deserialize(sr), Catalog.ProductSearchCriteria)
                Finally
                    sr.Close()
                End Try
                Me.LoadFilter(criteria)
            End If
        End If
    End Sub

    Protected Sub SaveFilterLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SaveFilterLinkButton.Click
        Dim filter As Catalog.ProductFilter
        filter = Catalog.ProductFilter.FindByName(FilterNameTextBox.Text, Me.Page.AppRelativeVirtualPath)
        Dim criteria As New Catalog.ProductSearchCriteria()
        Dim criteriaXml As String = String.Empty
        Me.LoadCriteria(criteria)
        Dim xs As New XmlSerializer(GetType(Catalog.ProductSearchCriteria))
        Dim sw As New IO.StringWriter()
        xs.Serialize(sw, criteria)
        Try
            criteriaXml = sw.ToString()
        Finally
            sw.Close()
        End Try

        If filter IsNot Nothing Then
            filter.Criteria = criteriaXml
            Catalog.ProductFilter.Update(filter)
        Else
            filter = New Catalog.ProductFilter()
            filter.Name = FilterNameTextBox.Text
            filter.Page = Me.Page.AppRelativeVirtualPath
            filter.Criteria = criteriaXml
            Catalog.ProductFilter.Insert(filter)
        End If
        BindFilterDropDownList()
    End Sub

    Protected Sub DeleteFilterLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles DeleteFilterLinkButton.Click
        Catalog.ProductFilter.Delete(FilterDropDownList.SelectedValue)
        BindFilterDropDownList()
    End Sub

    Protected Sub IsMonetary_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles MonetaryRegularExpressionValidator1.ServerValidate, MonetaryRegularExpressionValidator2.ServerValidate
        Dim val As Decimal = 0D
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub
End Class

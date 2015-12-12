
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_Sales
    Inherits BaseAdminPage

    Private Enum Modes
        ListView = 0
        EditView = 1
    End Enum

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Sales"
        Me.CurrentTab = AdminTabType.Marketing
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.MarketingView)
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MessageBox1.ClearMessage()
        If Not Page.IsPostBack() Then
            BindSalesGrid()
        End If
    End Sub

    Private Sub BindSalesGrid()
        SalesGridView.EditIndex = -1
        SalesGridView.DataSource = Marketing.Sale.GetAllSales()
        SalesGridView.DataKeyNames = New String() {"bvin"}
        SalesGridView.DataBind()
    End Sub

    Private Sub BindProductsGrid()
        Dim productIds As Collection(Of String) = DirectCast(ViewState("Sale"), Marketing.Sale).GetAllProducts()
        Dim products As New Collection(Of Catalog.Product)
        For Each productId As String In productIds
            Dim prod As Catalog.Product = Catalog.InternalProduct.FindByBvin(productId)
            If prod IsNot Nothing Then
                products.Add(prod)
            End If
        Next
        SelectedProductsGridView.DataSource = products
        SelectedProductsGridView.DataKeyNames = New String() {"bvin"}
        SelectedProductsGridView.DataBind()
    End Sub

    Private Sub BindCategoriesGrid()
        Dim categoryIds As Collection(Of String) = DirectCast(ViewState("Sale"), Marketing.Sale).GetAllCategories()
        Dim categories As New Collection(Of Catalog.Category)
        For Each categoryId As String In categoryIds
            Dim category As Catalog.Category = Catalog.Category.FindByBvin(categoryId)
            If (category IsNot Nothing) AndAlso (category.Bvin <> String.Empty) Then
                categories.Add(category)
            End If
        Next
        SelectedCategoriesGridView.DataSource = categories
        SelectedCategoriesGridView.DataKeyNames = New String() {"bvin"}
        SelectedCategoriesGridView.DataBind()
    End Sub

    Private Sub BindProductTypeGrid()
        Dim productTypeIds As Collection(Of String) = DirectCast(ViewState("Sale"), Marketing.Sale).GetAllProductTypes()
        Dim productTypes As New Collection(Of Catalog.ProductType)
        For Each productTypeId As String In productTypeIds
            Dim prodType As Catalog.ProductType = Catalog.ProductType.FindByBvin(productTypeId)
            If (prodType IsNot Nothing) AndAlso (prodType.Bvin <> String.Empty) Then
                productTypes.Add(prodType)
            End If
        Next

        SelectedProductTypeGridView.DataSource = productTypes
        SelectedProductTypeGridView.DataBind()

        ProductTypeGridView.DataSource = Catalog.ProductType.FindAll()
        ProductTypeGridView.DataBind()
    End Sub

    Protected Sub NewSaleImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles NewSaleImageButton.Click
        SalesMultiView.ActiveViewIndex = Modes.EditView
        SaleTypeRadioButtonList.Enabled = True
        Dim Sale As New Marketing.Sale
        InitializeForm(Sale)
        ViewState("Sale") = Sale
    End Sub

    Private Sub InitializeForm(ByVal Sale As Marketing.Sale)
        SaleNameTextBox.Text = Sale.Name
        SaleTypeRadioButtonList.SelectedIndex = Sale.SaleType
        DiscountTypeRadioButtonList.SelectedIndex = Sale.DiscountType
        Select Case Sale.DiscountType
            Case Marketing.DiscountTypes.AmountAboveSiteCost, Marketing.DiscountTypes.AmountOffList, Marketing.DiscountTypes.AmountOffSitePrice, Marketing.DiscountTypes.FixedAmount
                DiscountAmountTextBox.Text = Sale.Amount.ToString("c")
            Case Marketing.DiscountTypes.PercentageAboveSiteCost, Marketing.DiscountTypes.PercentageOffList, Marketing.DiscountTypes.PercentageOffSitePrice
                DiscountAmountTextBox.Text = (Sale.Amount / 100).ToString("p")
        End Select
        SaleBelowCostCheckBox.Checked = Sale.AllowSaleBelowCost
        StartDatePicker.SelectedDate = Sale.StartDate
        EndDatePicker.SelectedDate = Sale.EndDate
        DisplayProperContent()
    End Sub

    Protected Sub DisplayProperContent()
        If SaleTypeRadioButtonList.SelectedIndex = Marketing.SaleTypes.SpecificProducts Then
            ProductPickerRow.Visible = True
            CategoryPickerRow.Visible = False
            ProductTypePickerRow.Visible = False
            BindProductsGrid()
        ElseIf SaleTypeRadioButtonList.SelectedIndex = Marketing.SaleTypes.SpecificCategories Then
            ProductPickerRow.Visible = False
            CategoryPickerRow.Visible = True
            ProductTypePickerRow.Visible = False
            BindCategoriesGrid()
        ElseIf SaleTypeRadioButtonList.SelectedIndex = Marketing.SaleTypes.ProductType Then
            ProductPickerRow.Visible = False
            CategoryPickerRow.Visible = False
            ProductTypePickerRow.Visible = True
            BindProductTypeGrid()
        Else
            ProductPickerRow.Visible = False
            CategoryPickerRow.Visible = False
        End If
    End Sub

    Protected Sub SaleTypeRadioButtonList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles SaleTypeRadioButtonList.SelectedIndexChanged
        DisplayProperContent()
    End Sub

    Protected Sub SaveChangesImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveChangesImageButton.Click
        If Page.IsValid Then
            Dim Sale As Marketing.Sale = DirectCast(ViewState("Sale"), Marketing.Sale)
            Sale.Name = SaleNameTextBox.Text
            Sale.SaleType = SaleTypeRadioButtonList.SelectedIndex
            Sale.DiscountType = DiscountTypeRadioButtonList.SelectedIndex

            Select Case DirectCast(DiscountTypeRadioButtonList.SelectedIndex, Marketing.DiscountTypes)
                Case Marketing.DiscountTypes.AmountAboveSiteCost, Marketing.DiscountTypes.AmountOffList, Marketing.DiscountTypes.AmountOffSitePrice, Marketing.DiscountTypes.FixedAmount
                    Sale.Amount = Decimal.Parse(DiscountAmountTextBox.Text, System.Globalization.NumberStyles.Currency)
                Case Else
                    Sale.Amount = Decimal.Parse(DiscountAmountTextBox.Text.Replace(System.Globalization.CultureInfo.CurrentUICulture.NumberFormat.PercentSymbol, ""), System.Globalization.NumberStyles.Number)
            End Select

            Sale.AllowSaleBelowCost = SaleBelowCostCheckBox.Checked

            Sale.StartDate = StartDatePicker.SelectedDate
            Sale.EndDate = EndDatePicker.SelectedDate

            If (Sale.SaleType = Marketing.SaleTypes.StoreWide) Then
                Sale.ClearProducts()
                Sale.ClearCategories()
            End If

            If Sale.Bvin = String.Empty Then
                If Not Marketing.Sale.Insert(Sale) Then
                    MessageBox1.ShowError("An error occurred while inserting your sale into the database.")
                Else
                    MessageBox1.ShowOk("Sale was successfully saved to the database.")
                    SalesMultiView.ActiveViewIndex = Modes.ListView
                    BindSalesGrid()
                End If
            Else
                If Not Marketing.Sale.Update(Sale) Then
                    MessageBox1.ShowError("An error occurred while updating your sale in the database.")
                Else
                    MessageBox1.ShowOk("Sale was successfully saved to the database.")
                    SalesMultiView.ActiveViewIndex = Modes.ListView
                    BindSalesGrid()
                End If
            End If
        End If
        Marketing.SalesManager.LoadCurrentSales()
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        ViewState.Remove("Sale")
        SalesMultiView.ActiveViewIndex = Modes.ListView
        BindSalesGrid()
    End Sub

    Protected Sub SalesGridView_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles SalesGridView.RowEditing
        Dim Sale As Marketing.Sale = Marketing.Sale.FindByBvin(SalesGridView.DataKeys(e.NewEditIndex).Value)
        SalesMultiView.ActiveViewIndex = Modes.EditView
        SaleTypeRadioButtonList.Enabled = False
        ViewState("Sale") = Sale
        InitializeForm(Sale)
    End Sub

    Protected Sub SalesGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles SalesGridView.RowDeleting
        If Not Marketing.Sale.Delete(SalesGridView.DataKeys(e.RowIndex).Value) Then
            MessageBox1.ShowError("There was an error deleting your sale from the database.")
        Else
            MessageBox1.ClearMessage()
        End If
        BindSalesGrid()
        Marketing.SalesManager.LoadCurrentSales()
    End Sub

    Protected Sub AddProductsImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddProductsImageButton.Click
        Dim Sale As Marketing.Sale = DirectCast(ViewState("Sale"), Marketing.Sale)
        For Each Product As String In ProductPicker1.SelectedProducts
            Sale.AddProduct(Product)
        Next
        ViewState("Sale") = Sale
        BindProductsGrid()
    End Sub

    Protected Sub RemoveProductsImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemoveProductsImageButton.Click
        Dim Sale As Marketing.Sale = DirectCast(ViewState("Sale"), Marketing.Sale)
        For Each row As GridViewRow In SelectedProductsGridView.Rows
            Dim cb As CheckBox = CType(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
            If cb IsNot Nothing Then
                If cb.Checked Then
                    Sale.RemoveProduct(SelectedProductsGridView.DataKeys(row.RowIndex).Value)
                End If
            End If
        Next
        ViewState("Sale") = Sale
        BindProductsGrid()
    End Sub

    Protected Sub AddCategoriesImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddCategoriesImageButton.Click
        Dim Sale As Marketing.Sale = DirectCast(ViewState("Sale"), Marketing.Sale)
        For Each Category As String In CategoryPicker1.SelectedCategories
            Sale.AddCategory(Category)
        Next
        ViewState("Sale") = Sale
        BindCategoriesGrid()
    End Sub

    Protected Sub RemoveCategoriesImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemoveCategoriesImageButton.Click
        Dim Sale As Marketing.Sale = DirectCast(ViewState("Sale"), Marketing.Sale)
        For Each row As GridViewRow In SelectedCategoriesGridView.Rows
            Dim cb As CheckBox = CType(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
            If cb IsNot Nothing Then
                If cb.Checked Then
                    Sale.RemoveCategory(SelectedCategoriesGridView.DataKeys(row.RowIndex).Value)
                End If
            End If
        Next
        ViewState("Sale") = Sale
        BindCategoriesGrid()
    End Sub

    Protected Sub AddProductTypeImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddProductTypeImageButton.Click
        Dim Sale As Marketing.Sale = DirectCast(ViewState("Sale"), Marketing.Sale)
        For Each row As GridViewRow In ProductTypeGridView.Rows
            Dim cb As CheckBox = CType(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
            If cb IsNot Nothing Then
                If cb.Checked Then
                    Sale.AddProductType(ProductTypeGridView.DataKeys(row.RowIndex).Value)
                End If
            End If
        Next
        ViewState("Sale") = Sale
        BindProductTypeGrid()
    End Sub

    Protected Sub RemoveProductTypeImageButtonImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemoveProductTypeImageButtonImageButton.Click
        Dim Sale As Marketing.Sale = DirectCast(ViewState("Sale"), Marketing.Sale)
        For Each row As GridViewRow In SelectedProductTypeGridView.Rows
            Dim cb As CheckBox = CType(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
            If cb IsNot Nothing Then
                If cb.Checked Then
                    Sale.RemoveProductType(SelectedProductTypeGridView.DataKeys(row.RowIndex).Value)
                End If
            End If
        Next
        ViewState("Sale") = Sale
        BindProductTypeGrid()
    End Sub

    Protected Sub DiscountAmountCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles DiscountAmountCustomValidator.ServerValidate
        Dim val As Decimal = 0D

        Dim IsAmount As Boolean = False
        Select Case DirectCast(DiscountTypeRadioButtonList.SelectedIndex, Marketing.DiscountTypes)
            Case Marketing.DiscountTypes.AmountAboveSiteCost, Marketing.DiscountTypes.AmountOffList, Marketing.DiscountTypes.AmountOffSitePrice, Marketing.DiscountTypes.FixedAmount
                IsAmount = True
            Case Else
                IsAmount = False
        End Select

        If IsAmount Then
            If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, val) Then
                args.IsValid = True
            Else
                args.IsValid = False
            End If
        Else
            Dim newValue As String = args.Value.Replace(System.Globalization.CultureInfo.CurrentUICulture.NumberFormat.PercentSymbol, "")
            If Decimal.TryParse(newValue, System.Globalization.NumberStyles.Number, System.Threading.Thread.CurrentThread.CurrentUICulture, val) Then
                args.IsValid = True
            Else
                args.IsValid = False
            End If
        End If        
    End Sub
End Class

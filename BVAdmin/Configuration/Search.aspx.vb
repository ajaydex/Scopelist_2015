Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Configuration_Search
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            PopulateLists()
            LoadSettings()
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Search Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If SaveSettings() = True Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Sub PopulateLists()
        Dim items As New Collection(Of ListItem)
        items.Add(New ListItem("- NONE -", String.Empty))
        Dim props As Collection(Of Catalog.ProductProperty) = Catalog.ProductProperty.FindAll()
        For Each pp As Catalog.ProductProperty In props
            If (pp.TypeCode = Catalog.ProductPropertyType.MultipleChoiceField) Then 'Or (pp.TypeCode = Catalog.ProductPropertyType.TextField) Then
                items.Add(New ListItem(pp.DisplayName, pp.Bvin))
            End If
        Next

        For i As Integer = 0 To items.Count - 1            
            Me.Property1Field.Items.Add(New ListItem(items(i).Text, items(i).Value))
            Me.Property2Field.Items.Add(New ListItem(items(i).Text, items(i).Value))
            Me.Property3Field.Items.Add(New ListItem(items(i).Text, items(i).Value))
            Me.Property4Field.Items.Add(New ListItem(items(i).Text, items(i).Value))
            Me.Property5Field.Items.Add(New ListItem(items(i).Text, items(i).Value))
            Me.Property6Field.Items.Add(New ListItem(items(i).Text, items(i).Value))
            Me.Property7Field.Items.Add(New ListItem(items(i).Text, items(i).Value))
            Me.Property8Field.Items.Add(New ListItem(items(i).Text, items(i).Value))
            Me.Property9Field.Items.Add(New ListItem(items(i).Text, items(i).Value))
            Me.Property10Field.Items.Add(New ListItem(items(i).Text, items(i).Value))
        Next
    End Sub

    Private Sub LoadSettings()
        Me.chkShowCategory.Checked = WebAppSettings.SearchShowCategory
        Me.chkShowManufacturer.Checked = WebAppSettings.SearchShowManufacturer
        Me.chkShowPrice.Checked = WebAppSettings.SearchShowPrice
        Me.chkShowSort.Checked = WebAppSettings.SearchShowSort
        Me.chkShowVendor.Checked = WebAppSettings.SearchShowVendor
        Me.DisplayImagesCheckBox.Checked = WebAppSettings.SearchDisplayImages
        Me.DisplayPricesCheckBox.Checked = WebAppSettings.SearchDisplayPrice        
        Me.ItemsPerRowTextBox.Text = WebAppSettings.SearchItemsPerRow.ToString()
        Me.DisplaySkuCheckBox.Checked = WebAppSettings.SearchDisplaySku

        Me.SearchSkuCheckBox.Checked = WebAppSettings.SearchEnabledSKU
        Me.SearchProductNameCheckBox.Checked = WebAppSettings.SearchEnabledProductName
        Me.SearchProductTypeNameCheckbox.Checked = WebAppSettings.SearchEnabledProductTypeName
        Me.SearchShortDescriptionCheckBox.Checked = WebAppSettings.SearchEnabledShortDescription
        Me.SearchLongDescriptionCheckBox.Checked = WebAppSettings.SearchEnabledLongDescription
        Me.SearchMetaTitleCheckBox.Checked = WebAppSettings.SearchEnabledMetaTitle
        Me.SearchMetaDescriptionCheckBox.Checked = WebAppSettings.SearchEnabledMetaDescription
        Me.SearchMetaKeywordsCheckBox.Checked = WebAppSettings.SearchEnabledMetaKeywords
        Me.SearchKeywordsCheckBox.Checked = WebAppSettings.SearchEnabledKeywords
        Me.SearchProductChoiceCombinationsCheckBox.Checked = WebAppSettings.SearchEnabledProductChoiceCombinations

        Me.SearchSkuWeightTextBox.Text = WebAppSettings.SearchWeightProductSku.ToString("0")
        Me.txtProductNameWeight.Text = WebAppSettings.SearchWeightProductName.ToString("0")
        Me.SearchProductTypeNameWeightTextBox.Text = WebAppSettings.SearchWeightProductTypeName.ToString("0")
        Me.SearchShortDescriptionWeightTextBox.Text = WebAppSettings.SearchWeightProductShortDescription.ToString("0")
        Me.SearchLongDescriptionWeightTextBox.Text = WebAppSettings.SearchWeightProductLongDescription.ToString("0")
        Me.SearchMetaTitleWeightTextBox.Text = WebAppSettings.SearchWeightProductMetaTitle.ToString("0")
        Me.SearchMetaDescriptionWeightTextBox.Text = WebAppSettings.SearchWeightProductMetaDescription.ToString("0")
        Me.SearchMetaKeywordsWeightTextBox.Text = WebAppSettings.SearchWeightProductMetaKeywords.ToString("0")
        Me.SearchKeywordsWeightTextBox.Text = WebAppSettings.SearchWeightProductKeywords.ToString("0")


        SetList(Me.Property1Field, WebAppSettings.SearchProperty1)
        SetList(Me.Property2Field, WebAppSettings.SearchProperty2)
        SetList(Me.Property3Field, WebAppSettings.SearchProperty3)
        SetList(Me.Property4Field, WebAppSettings.SearchProperty4)
        SetList(Me.Property5Field, WebAppSettings.SearchProperty5)
        SetList(Me.Property6Field, WebAppSettings.SearchProperty6)
        SetList(Me.Property7Field, WebAppSettings.SearchProperty7)
        SetList(Me.Property8Field, WebAppSettings.SearchProperty8)
        SetList(Me.Property9Field, WebAppSettings.SearchProperty9)
        SetList(Me.Property10Field, WebAppSettings.SearchProperty10)

        Me.DisableBlankSearchTermsCheckBox.Checked = WebAppSettings.SearchDisableBlankSearchTerms
        Me.ResultsPerPageTextBox.Text = WebAppSettings.SearchItemsPerPage.ToString()
        Me.SearchRedirectToProductPage.Checked = WebAppSettings.SearchRedirectToProductPage
        Me.EnableAdvancedSearchCheckBox.Checked = WebAppSettings.EnableAdvancedSearch

        CheckSqlServerFullTextSearchStatus()
    End Sub

    Private Sub SetList(ByVal lst As DropDownList, ByVal val As String)
        If lst.Items.FindByValue(val) IsNot Nothing Then
            lst.ClearSelection()
            lst.Items.FindByValue(val).Selected = True
        End If
    End Sub

    Private Function SaveSettings() As Boolean
        Dim result As Boolean = True

        WebAppSettings.SearchShowCategory = Me.chkShowCategory.Checked
        WebAppSettings.SearchShowManufacturer = Me.chkShowManufacturer.Checked
        WebAppSettings.SearchShowPrice = Me.chkShowPrice.Checked
        WebAppSettings.SearchShowSort = Me.chkShowSort.Checked
        WebAppSettings.SearchShowVendor = Me.chkShowVendor.Checked
        WebAppSettings.SearchDisplayImages = Me.DisplayImagesCheckBox.Checked
        WebAppSettings.SearchItemsPerRow = Integer.Parse(Me.ItemsPerRowTextBox.Text)
        WebAppSettings.SearchDisplayPrice = Me.DisplayPricesCheckBox.Checked
        WebAppSettings.SearchDisplaySku = Me.DisplaySkuCheckBox.Checked

        WebAppSettings.SearchEnabledSKU = Me.SearchSkuCheckBox.Checked
        WebAppSettings.SearchEnabledProductName = Me.SearchProductNameCheckBox.Checked
        WebAppSettings.SearchEnabledProductTypeName = Me.SearchProductTypeNameCheckbox.Checked
        WebAppSettings.SearchEnabledShortDescription = Me.SearchShortDescriptionCheckBox.Checked
        WebAppSettings.SearchEnabledLongDescription = Me.SearchLongDescriptionCheckBox.Checked
        WebAppSettings.SearchEnabledMetaTitle = Me.SearchMetaTitleCheckBox.Checked
        WebAppSettings.SearchEnabledMetaDescription = Me.SearchMetaDescriptionCheckBox.Checked
        WebAppSettings.SearchEnabledMetaKeywords = Me.SearchMetaKeywordsCheckBox.Checked
        WebAppSettings.SearchEnabledKeywords = Me.SearchKeywordsCheckBox.Checked
        WebAppSettings.SearchEnabledProductChoiceCombinations = Me.SearchProductChoiceCombinationsCheckBox.Checked

        WebAppSettings.SearchWeightProductSku = Convert.ToDecimal(Me.SearchSkuWeightTextBox.Text)
        WebAppSettings.SearchWeightProductName = Convert.ToDecimal(Me.txtProductNameWeight.Text)
        WebAppSettings.SearchWeightProductTypeName = Convert.ToDecimal(Me.SearchProductTypeNameWeightTextBox.Text)
        WebAppSettings.SearchWeightProductShortDescription = Convert.ToDecimal(Me.SearchShortDescriptionWeightTextBox.Text)
        WebAppSettings.SearchWeightProductLongDescription = Convert.ToDecimal(Me.SearchLongDescriptionWeightTextBox.Text)
        WebAppSettings.SearchWeightProductMetaTitle = Convert.ToDecimal(Me.SearchMetaTitleWeightTextBox.Text)
        WebAppSettings.SearchWeightProductMetaDescription = Convert.ToDecimal(Me.SearchMetaDescriptionWeightTextBox.Text)
        WebAppSettings.SearchWeightProductMetaKeywords = Convert.ToDecimal(Me.SearchMetaKeywordsWeightTextBox.Text)
        WebAppSettings.SearchWeightProductKeywords = Convert.ToDecimal(Me.SearchKeywordsWeightTextBox.Text)
        WebAppSettings.SearchWeightProductSku = Convert.ToDecimal(Me.SearchSkuWeightTextBox.Text)
        WebAppSettings.SearchWeightProductSku = Convert.ToDecimal(Me.SearchSkuWeightTextBox.Text)

        WebAppSettings.SearchProperty1 = Me.Property1Field.SelectedValue
        WebAppSettings.SearchProperty2 = Me.Property2Field.SelectedValue
        WebAppSettings.SearchProperty3 = Me.Property3Field.SelectedValue
        WebAppSettings.SearchProperty4 = Me.Property4Field.SelectedValue
        WebAppSettings.SearchProperty5 = Me.Property5Field.SelectedValue
        WebAppSettings.SearchProperty6 = Me.Property6Field.SelectedValue
        WebAppSettings.SearchProperty7 = Me.Property7Field.SelectedValue
        WebAppSettings.SearchProperty8 = Me.Property8Field.SelectedValue
        WebAppSettings.SearchProperty9 = Me.Property9Field.SelectedValue
        WebAppSettings.SearchProperty10 = Me.Property10Field.SelectedValue

        WebAppSettings.SearchDisableBlankSearchTerms = Me.DisableBlankSearchTermsCheckBox.Checked
        WebAppSettings.SearchItemsPerPage = Integer.Parse(ResultsPerPageTextBox.Text)
        WebAppSettings.SearchRedirectToProductPage = Me.SearchRedirectToProductPage.Checked
        WebAppSettings.EnableAdvancedSearch = Me.EnableAdvancedSearchCheckBox.Checked

        Return result
    End Function

    Private Sub CheckSqlServerFullTextSearchStatus()
        Dim dr As New Datalayer.DataRequest()
        dr.ConnectionString = WebAppSettings.ConnectionString
        dr.CommandType = Data.CommandType.Text
        dr.Command = "SELECT " + _
            "SERVERPROPERTY('IsFullTextInstalled') AS IsFullTextInstalled, " + _
            "DATABASEPROPERTYEX(DB_NAME(), 'IsFulltextEnabled') AS IsFulltextEnabled, " + _
            "OBJECTPROPERTY(OBJECT_ID('bvc_Product'), 'TableHasActiveFulltextIndex') AS TableHasActiveFulltextIndex"

        Try
            Dim reader As Data.SqlClient.SqlDataReader = Datalayer.SqlDataHelper.ExecuteReader(dr)
            reader.Read()
            If Convert.ToInt32(reader("IsFullTextInstalled")) = 0 Then
                Me.SqlServerFullTextSearchStatus.Text = "The Full Text Search component of SQL Server is not installed. This is required to use the advanced search."
                DisableAdvancedSearch()
            Else
                If Convert.ToInt32(reader("IsFulltextEnabled")) = 0 Then
                    Me.SqlServerFullTextSearchStatus.Text = "Full text indexing is not enabled for this database. This is required to use the advanced search."
                    DisableAdvancedSearch()
                Else
                    If Convert.ToInt32(reader("TableHasActiveFulltextIndex")) = 0 Then
                        Me.SqlServerFullTextSearchStatus.Text = "No full text index has been configured for the bvc_Product table. This is required to use the advanced search."
                        DisableAdvancedSearch()
                    End If
                End If
            End If

        Catch ex As Exception
            Me.MessageBox1.ShowException(ex)
        End Try
    End Sub

    Private Sub DisableAdvancedSearch()
        WebAppSettings.EnableAdvancedSearch = False
        Me.EnableAdvancedSearchCheckBox.Checked = False
        Me.EnableAdvancedSearchCheckBox.Enabled = False
    End Sub
End Class

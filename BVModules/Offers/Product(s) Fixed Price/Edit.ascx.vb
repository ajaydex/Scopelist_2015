Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.IO
Imports System.Linq

Partial Class BVModules_Offers_Product_s__Fixed_Price_Edit
    Inherits OfferTemplate

    Protected Sub BindSelectedProductsGrid(ByVal products As Collection(Of String), ByVal updateAdd As Boolean, ByVal updateSubtract As Boolean)
        Dim rowValues As New Collection(Of String())

        If (updateAdd OrElse updateSubtract) Then
            For i As Integer = 0 To SelectedProductsGridView.Rows.Count() - 1
                Dim sku As String = SelectedProductsGridView.Rows(i).Cells(1).Text
                Dim column2 As String = DirectCast(SelectedProductsGridView.Rows(i).Cells(3).FindControl("discountTextbox"), TextBox).Text
                rowValues.Add(New String() {sku, column2})
            Next
        End If

        Dim actualProducts As New Collection(Of Catalog.Product)
        For i As Integer = products.Count - 1 To 0 Step -1
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(products(i))
            If p IsNot Nothing AndAlso Not String.IsNullOrEmpty(p.Bvin) Then
                actualProducts.Add(p)
            Else
                products.RemoveAt(i)
            End If
        Next

        SelectedProductsGridView.DataSource = actualProducts.Reverse()
        SelectedProductsGridView.DataKeyNames = New String() {"bvin"}
        SelectedProductsGridView.DataBind()

        For i As Integer = 0 To SelectedProductsGridView.Rows.Count - 1
            For j As Integer = 0 To rowValues.Count - 1
                Dim valuearray As String() = rowValues(j)
                If (String.Compare(valuearray(0), SelectedProductsGridView.Rows(i).Cells(1).Text) = 0) Then
                    DirectCast(SelectedProductsGridView.Rows(i).Cells(2).FindControl("discountTextbox"), TextBox).Text = valuearray(1)
                End If
            Next
        Next
    End Sub

    Protected Sub SelectedProductsGridView_RowDataBound(ByVal sender As Object, e As GridViewRowEventArgs) Handles SelectedProductsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim discountTextbox As TextBox = CType(e.Row.FindControl("discountTextbox"), TextBox)

            Dim p As Catalog.Product = CType(e.Row.DataItem, Catalog.Product)
            Dim lowAdjustment As Decimal = 0D

            Dim settings As Collection(Of ComponentSettingListItem) = SettingsManager.GetSettingList("Products")
            Dim lowDiscount As String = String.Empty
            For Each setting As ComponentSettingListItem In settings
                If setting.Setting1 = p.Bvin Then
                    lowDiscount = setting.Setting2
                End If
            Next

            If lowDiscount.Length > 0 Then
                If Decimal.TryParse(lowDiscount, lowAdjustment) Then

                    discountTextbox.Text = lowAdjustment.ToString()
                End If
            End If
        End If
    End Sub

    Protected Sub AddProductsImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddProductsImageButton.Click
        Dim products As Collection(Of String) = CType(ViewState("products"), Collection(Of String))
        If products Is Nothing Then
            products = New Collection(Of String)
        End If
        For Each product As String In ProductPicker2.SelectedProducts
            If Not products.Contains(product) Then
                products.Add(product)
            End If
        Next
        ViewState("products") = products
        BindSelectedProductsGrid(products, True, False)
    End Sub

    Protected Sub RemoveProductsImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemoveProductsImageButton.Click
        Dim products As Collection(Of String) = CType(ViewState("products"), Collection(Of String))
        If products IsNot Nothing Then
            For Each row As GridViewRow In SelectedProductsGridView.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    Dim checkbox As CheckBox = DirectCast(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
                    If checkbox.Checked Then
                        If products.Contains(SelectedProductsGridView.DataKeys(row.RowIndex).Value) Then
                            products.Remove(SelectedProductsGridView.DataKeys(row.RowIndex).Value)
                        End If
                    End If
                End If
            Next
        End If
        ViewState("products") = products
        BindSelectedProductsGrid(products, False, True)
    End Sub

    Public Overloads Overrides Sub Initialize()
        Dim settings As Collection(Of ComponentSettingListItem) = SettingsManager.GetSettingList("Products")
        Dim products As New Collection(Of String)

        For Each setting As ComponentSettingListItem In settings
            products.Add(setting.Setting1)
        Next

        BindSelectedProductsGrid(products, False, False)
        ViewState("products") = products
        OrderQuantityTextBox.Text = SettingsManager.GetIntegerSetting("OrderQuantity")

        If CInt(OrderQuantityTextBox.Text) = 0 Then
            OrderQuantityTextBox.Text = "1"
        End If
        OrderTotalTextBox.Text = SettingsManager.GetDecimalSetting("OrderTotal").ToString("c")
        If Decimal.Parse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency) = 0 Then
            Dim val As Decimal = 0.01D
            OrderTotalTextBox.Text = val.ToString("c")
        End If

        Dim orderTotalMax As Decimal = SettingsManager.GetDecimalSetting("OrderTotalMax")
        If orderTotalMax = Decimal.MaxValue OrElse orderTotalMax = 0 Then
            OrderTotalMaxTextBox.Text = String.Empty
        Else
            OrderTotalMaxTextBox.Text = orderTotalMax.ToString("c")
        End If
    End Sub

    Public Overrides Sub Save()
        'first clear out our product list        
        Dim products As Collection(Of String) = ViewState("products")
        If products IsNot Nothing Then
            SettingsManager.DeleteSettingList("Products")
            For i As Integer = 0 To products.Count - 1
                Dim item As New ComponentSettingListItem()
                item.Setting1 = products(i)
                item.Setting2 = DirectCast(SelectedProductsGridView.Rows(i).Cells(3).FindControl("discountTextbox"), TextBox).Text
                SettingsManager.InsertSettingListItem("Products", item, "Develisys", "Offer", "Product(s) Fixed Price")
            Next
        End If
        SettingsManager.SaveIntegerSetting("OrderQuantity", CInt(OrderQuantityTextBox.Text), "Develisys", "Offer", "Product(s) Fixed Price")
        SettingsManager.SaveDecimalSetting("OrderTotal", Decimal.Parse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency), "Develisys", "Offer", "Product(s) Fixed Price")

        Dim val As Decimal = 0
        If Decimal.TryParse(OrderTotalMaxTextBox.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, val) Then
            If val <= 0 Then
                val = Decimal.MaxValue
            End If
        Else
            val = Decimal.MaxValue
        End If
        SettingsManager.SaveDecimalSetting("OrderTotalMax", val, "Develisys", "Offer", "Product(s) Fixed Price")
    End Sub

    Public Overrides Sub Cancel()

    End Sub

    Protected Sub OrderTotalCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles OrderTotalCustomValidator.ServerValidate, OrderTotalMaxCustomValidator.ServerValidate
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, Nothing) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub OrderTotalMaxCustomValidator2_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles OrderTotalMaxCustomValidator2.ServerValidate
        Dim orderTotalMin As Decimal = 0
        Dim orderTotalMax As Decimal = 0

        If Decimal.TryParse(OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, orderTotalMin) Then
            If Decimal.TryParse(OrderTotalMaxTextBox.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, orderTotalMax) Then
                If orderTotalMax <= orderTotalMin Then
                    args.IsValid = False
                End If
            End If
        End If
    End Sub


    Protected Sub ProcessFile(ByVal sender As Object, ByVal e As EventArgs) Handles fileSave.Click
        If fileUpload.HasFile Then

            'Upload and open file
            fileUpload.PostedFile.SaveAs(Request.PhysicalApplicationPath + "/files/productfixedprice.txt")
            Dim importStream As StreamReader = File.OpenText(Request.PhysicalApplicationPath + "/files/productfixedprice.txt")
            Dim strLine As String

            'Get list of files (we must check against this to avoid duplicates)
            Dim settings As Collection(Of ComponentSettingListItem) = SettingsManager.GetSettingList("Products")
            Dim products As New Dictionary(Of String, String)
            For Each setting As ComponentSettingListItem In settings
                products.Add(setting.Setting1, setting.Bvin)
            Next

            'For debugging purposes:
            Dim rowNumber As Integer = 0
            Dim failureCount As Integer = 0
            Dim successCount As Integer = 0
            Dim fieldDelimiter As String = vbTab
            Dim errorSkus As New Collection(Of String)

            'Ignore header row
            strLine = importStream.ReadLine()

            'Read file
            While importStream.Peek <> -1

                strLine = importStream.ReadLine()
                Dim pieces() As String = strLine.Split(vbTab)

                If pieces.Length = 2 Then
                    Dim item As New ComponentSettingListItem()
                    Dim price As Decimal = -1
                    Decimal.TryParse(CType(pieces(1), String), price)
                    Dim sku As String = CType(pieces(0), String)
                    Dim p As Catalog.Product = Catalog.InternalProduct.FindBySku(sku)
                    If price <> -1 AndAlso p IsNot Nothing Then
                        If Not products.ContainsKey(p.Bvin) Then
                            item.Setting1 = p.Bvin
                            item.Setting2 = price.ToString()
                            SettingsManager.InsertSettingListItem("Products", item, "Develisys", "Offer", "Product(s) Fixed Price")
                        Else
                            item.Bvin = products(p.Bvin)
                            item.Setting1 = p.Bvin
                            item.Setting2 = price.ToString()
                            item.ListName = "Products"
                            item.ComponentID = Me.BlockId
                            SettingsManager.UpdateSettingListItem(item, "Develisys", "Offer", "Product(s) Fixed Price")
                        End If

                        successCount += 1
                    Else
                        failureCount += 1
                        errorSkus.Add(sku)
                    End If
                Else
                    If pieces.Length >= 1 Then
                        errorSkus.Add(CType(pieces(0), String))
                    End If
                    failureCount += 1
                End If

                rowNumber += 1
            End While

            'Show results
            If failureCount = 0 Then
                fileMsg.ShowOk("File successfully processed (" + rowNumber.ToString() + " products added or updated)")
            Else
                Dim errorSkuString As String = String.Join(", ", errorSkus.ToArray())
                fileMsg.ShowWarning("File processed with errors (" + successCount.ToString() + " items successfully added or updated, " + failureCount.ToString() + " errors)" + "<br />" + "Failed SKU's: " + errorSkuString)
            End If

            'Close the file
            importStream.Close()

            'Reload the data
            Initialize()

        End If
    End Sub

End Class

Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Catalog_FileVaultDetailsView
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString("id") Is Nothing Then
                Response.Redirect("~/BVAdmin/Catalog/default.aspx")
            Else
                ViewState("id") = Request.QueryString("id")
            End If
            BindProductsGrid()
            PopulateFileInfo()
        End If

        If Me.NewSkuField.Text <> String.Empty Then
            VariantsDisplay1.Initialize(False)
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "File Vault Edit"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub BindProductsGrid()
        ProductsGridView.DataSource = Catalog.InternalProduct.FindByAssociatedFile(ViewState("id"))
        ProductsGridView.DataBind()
    End Sub

    Protected Sub PopulateFileInfo()
        Dim file As Catalog.ProductFile = Catalog.ProductFile.FindByBvin(ViewState("id"))
        NameLabel.Text = file.FileName
        DescriptionTextBox.Text = file.ShortDescription
    End Sub

    Protected Sub ProductsGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles ProductsGridView.RowDeleting
        Dim key As String = ProductsGridView.DataKeys(e.RowIndex).Value
        Dim file As Catalog.ProductFile = Catalog.ProductFile.FindByBvin(ViewState("id"))
        Catalog.ProductFile.RemoveAssociatedProduct(file.Bvin, key)
        BindProductsGrid()
    End Sub

    Protected Sub btnBrowseProducts_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnBrowseProducts.Click
        Me.pnlProductPicker.Visible = Not Me.pnlProductPicker.Visible
        If Me.NewSkuField.Text.Trim.Length > 0 Then
            If Me.pnlProductPicker.Visible = True Then
                Me.ProductPicker1.Keyword = Me.NewSkuField.Text
                Me.ProductPicker1.LoadSearch()
            End If
        End If
    End Sub

    Private Sub AddProductBySku()
        Me.MessageBox1.ClearMessage()
        If Me.NewSkuField.Text.Trim.Length < 1 Then
            Me.MessageBox1.ShowWarning("Please enter a sku first.")
        Else
            Dim p As Catalog.Product = Catalog.InternalProduct.FindBySku(Me.NewSkuField.Text.Trim)
            If p IsNot Nothing Then
                If (p.Sku = String.Empty) OrElse (p.GlobalProduct.Saved = False) Then
                    Me.MessageBox1.ShowWarning("That product could not be located. Please check SKU.")
                Else
                    If p.ChoiceCombinations.Count > 0 Then
                        Me.pnlProductChoices.Visible = True
                        Me.VariantsDisplay1.BaseProduct = p
                    Else
                        Dim file As Catalog.ProductFile = Catalog.ProductFile.FindByBvin(ViewState("id"))
                        If file IsNot Nothing Then
                            If Catalog.ProductFile.AddAssociatedProduct(file.Bvin, p.Bvin, 0, 0) Then
                                Me.MessageBox1.ShowOk("Product Added!")
                            Else
                                Me.MessageBox1.ShowError("Product was not added correctly. Unknown Error")
                            End If
                        End If
                    End If
                End If
            End If
        End If
        BindProductsGrid()
    End Sub

    Protected Sub btnAddProductBySku_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddProductBySku.Click
        AddProductBySku()
    End Sub

    Protected Sub btnProductPickerCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnProductPickerCancel.Click
        Me.MessageBox1.ClearMessage()
        Me.pnlProductPicker.Visible = False
    End Sub

    Protected Sub btnProductPickerOkay_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnProductPickerOkay.Click
        Me.MessageBox1.ClearMessage()
        If Me.ProductPicker1.SelectedProducts.Count > 0 Then
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Me.ProductPicker1.SelectedProducts(0))
            If p IsNot Nothing Then
                Me.NewSkuField.Text = p.Sku
            End If
            AddProductBySku()
            Me.pnlProductPicker.Visible = False
        Else
            Me.MessageBox1.ShowWarning("Please select a product first.")
        End If
    End Sub

    Protected Sub ProductsGridView_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles ProductsGridView.RowUpdating
        If Page.IsValid() Then
            Dim key As String = ProductsGridView.DataKeys(e.RowIndex).Value
            Dim file As Catalog.ProductFile = Catalog.ProductFile.FindByBvinAndProductBvin(ViewState("id"), key)

            Dim row As GridViewRow = ProductsGridView.Rows(e.RowIndex)
            Dim tb As TextBox = CType(row.FindControl("MaxDownloadsTextBox"), TextBox)
            Dim tp As ASP.bvadmin_controls_timespanpicker_ascx = CType(row.FindControl("TimespanPicker"), ASP.bvadmin_controls_timespanpicker_ascx)

            If tb IsNot Nothing Then
                Dim val As Integer = 0
                If Integer.TryParse(tb.Text, val) Then
                    file.MaxDownloads = val
                Else
                    file.MaxDownloads = 0
                End If
            End If

            If tp IsNot Nothing Then
                file.SetMinutes(tp.Months, tp.Days, tp.Hours, tp.Minutes)
            End If

            If Catalog.ProductFile.Update(file) Then
                MessageBox1.ShowOk("File was successfully updated!")
            Else
                MessageBox1.ShowError("File update failed. Unknown error.")
            End If
            BindProductsGrid()
        End If
    End Sub

    Protected Sub ProductsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles ProductsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim key As String = ProductsGridView.DataKeys(e.Row.RowIndex).Value
            Dim file As Catalog.ProductFile = Catalog.ProductFile.FindByBvinAndProductBvin(ViewState("id"), key)

            Dim tb As TextBox = CType(e.Row.FindControl("MaxDownloadsTextBox"), TextBox)
            Dim tp As ASP.bvadmin_controls_timespanpicker_ascx = CType(e.Row.FindControl("TimespanPicker"), ASP.bvadmin_controls_timespanpicker_ascx)

            If tb IsNot Nothing Then
                tb.Text = file.MaxDownloads.ToString()
            End If

            If tp IsNot Nothing Then
                Dim minutes As Integer = file.AvailableMinutes
                tp.Months = minutes \ 43200
                minutes = minutes Mod 43200
                tp.Days = minutes \ 1440
                minutes = minutes Mod 1440
                tp.Hours = minutes \ 60
                minutes = minutes Mod 60
                tp.Minutes = minutes
            End If
        End If
    End Sub

    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveImageButton.Click
        Dim file As Catalog.ProductFile = Catalog.ProductFile.FindByBvin(ViewState("id"))
        If file IsNot Nothing Then
            file.ShortDescription = DescriptionTextBox.Text
            If Catalog.ProductFile.Update(file) Then
                MessageBox1.ShowOk("File updated!")
            Else
                MessageBox1.ShowError("An error occurred while trying to update the file")
            End If
        End If
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        Response.Redirect("~/BVAdmin/Catalog/FileVault.aspx")
    End Sub

    Protected Sub FileReplaceCancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles FileReplaceCancelImageButton.Click
        FilePicker1.Clear()
        ReplacePanel.Visible = False
    End Sub

    Protected Sub FileReplaceSaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles FileReplaceSaveImageButton.Click
        Dim file As Catalog.ProductFile = Catalog.ProductFile.FindByBvin(ViewState("id"))
        If file IsNot Nothing Then
            FilePicker1.DownloadOrLinkFile(file, MessageBox1)
            ReplacePanel.Visible = False
            PopulateFileInfo()
        Else
            MessageBox1.ShowError("An error occurred while trying to save the file.")
        End If
    End Sub

    Protected Sub ReplaceImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ReplaceImageButton.Click
        ReplacePanel.Visible = True
    End Sub

    Protected Sub btnCloseVariants_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCloseVariants.Click
        Me.MessageBox1.ClearMessage()
        Me.pnlProductChoices.Visible = False
    End Sub

    Protected Sub btnAddVariant_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddVariant.Click
        Me.MessageBox1.ClearMessage()
        Dim p As Catalog.Product = Me.VariantsDisplay1.GetSelectedProduct(Nothing)
        If p IsNot Nothing Then
            If Not VariantsDisplay1.IsValidCombination Then
                Me.MessageBox1.ShowError("This is not a valid combination")
            Else
                If p IsNot Nothing Then
                    Dim file As Catalog.ProductFile = Catalog.ProductFile.FindByBvin(ViewState("id"))
                    If file IsNot Nothing Then
                        If Catalog.ProductFile.AddAssociatedProduct(file.Bvin, p.Bvin, 0, 0) Then
                            Me.MessageBox1.ShowOk("Product Added!")
                        Else
                            Me.MessageBox1.ShowError("Product was not added correctly. Unknown Error")
                        End If
                    End If
                End If
                Me.pnlProductChoices.Visible = False
                BindProductsGrid()
                'Me.pnlProductPicker.Visible = False
            End If
        End If
    End Sub
End Class

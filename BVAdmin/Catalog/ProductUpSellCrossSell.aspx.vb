Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_ProductUpSellCrossSell
    Inherits BaseProductAdminPage

    Private Const _upSellProductsKey As String = "UpSellProducts"
    Private Const _crossSellProductsKey As String = "CrossSellProducts"
    Private Const _crossSells As String = "CrossSells"
    Private Const _upSells As String = "UpSells"


    Dim crossSells As Collection(Of Catalog.ProductCrossSell)
    Dim UpSells As Collection(Of Catalog.ProductUpSell)

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("id") Is Nothing Then
            Response.Redirect(DefaultCatalogPage)
        Else
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Request.QueryString("id"))
            If Not String.IsNullOrEmpty(p.ParentId) Then
                Response.Redirect(String.Format("{0}?id={1}", HttpContext.Current.Request.Url.AbsolutePath, p.ParentId))
            End If
            InitErrors()
            If Not Page.IsPostBack Then
                crossSells = Catalog.ProductCrossSell.FindByProductBvin(Request.QueryString("id"))
                Dim products As New BusinessEntityList(Of Catalog.Product)
                For Each crossSell As Catalog.ProductCrossSell In crossSells
                    products.Add(crossSell.GetCrossSellProduct())
                Next
                ViewState(_crossSells) = crossSells
                ViewState(_crossSellProductsKey) = products
                BindCrossSellsGridView(products)

                UpSells = Catalog.ProductUpSell.FindByProductBvin(Request.QueryString("id"))
                products = New BusinessEntityList(Of Catalog.Product)
                For Each upSell As Catalog.ProductUpSell In UpSells
                    products.Add(upSell.GetUpSellProduct())
                Next

                ViewState(_upSellProductsKey) = products
                ViewState(_upSells) = UpSells
                BindUpSellsGridView(products)
            End If
        End If
    End Sub

    Protected Sub InitErrors()
        MessageBox1.ClearMessage()
        MessageBox2.ClearMessage()
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Cross Sells/Up Sells"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub BindUpSellsGridView(ByVal products As BusinessEntityList(Of Catalog.Product))
        UpSellsGridView.DataSource = products
        UpSellsGridView.DataKeyNames = New String() {"bvin"}
        UpSellsGridView.DataBind()
    End Sub

    Protected Sub BindCrossSellsGridView(ByVal products As BusinessEntityList(Of Catalog.Product))
        CrossSellsGridView.DataSource = products
        CrossSellsGridView.DataKeyNames = New String() {"bvin"}
        CrossSellsGridView.DataBind()
    End Sub

    Protected Sub UpSellsAddImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles UpSellsAddImageButton.Click
        Dim products As BusinessEntityList(Of Catalog.Product) = CType(ViewState(_upSellProductsKey), BusinessEntityList(Of Catalog.Product))
        If products Is Nothing Then
            products = New BusinessEntityList(Of Catalog.Product)
        End If
        For Each productBvin As String In UpSellsProductPicker.SelectedProducts
            Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(productBvin)
            If Not products.Contains(product) Then
                products.Add(product)
            End If
        Next
        ViewState(_upSellProductsKey) = products
        BindUpSellsGridView(products)
    End Sub

    Protected Sub UpSellsRemoveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles UpSellsRemoveImageButton.Click
        Dim products As BusinessEntityList(Of Catalog.Product) = CType(ViewState(_upSellProductsKey), BusinessEntityList(Of Catalog.Product))
        If products IsNot Nothing Then
            For Each row As GridViewRow In UpSellsGridView.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    Dim checkbox As CheckBox = DirectCast(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
                    If checkbox.Checked Then
                        If products.Contains(Catalog.InternalProduct.FindByBvin(UpSellsGridView.DataKeys(row.RowIndex).Value)) Then
                            products.Remove(Catalog.InternalProduct.FindByBvin(UpSellsGridView.DataKeys(row.RowIndex).Value))
                        End If
                    End If
                End If
            Next
        End If
        ViewState(_upSellProductsKey) = products
        BindUpSellsGridView(products)
    End Sub

    Protected Sub CrossSellsAddImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CrossSellsAddImageButton.Click
        Dim products As BusinessEntityList(Of Catalog.Product) = CType(ViewState(_crossSellProductsKey), BusinessEntityList(Of Catalog.Product))
        If products Is Nothing Then
            products = New BusinessEntityList(Of Catalog.Product)
        End If
        For Each productBvin As String In CrossSellsProductPicker.SelectedProducts
            Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(productBvin)
            If Not products.Contains(product) Then
                products.Add(product)
            End If
        Next
        ViewState(_crossSellProductsKey) = products
        BindCrossSellsGridView(products)
    End Sub

    Protected Sub CrossSellsRemoveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CrossSellsRemoveImageButton.Click
        Dim products As BusinessEntityList(Of Catalog.Product) = CType(ViewState(_crossSellProductsKey), BusinessEntityList(Of Catalog.Product))
        If products IsNot Nothing Then
            For Each row As GridViewRow In CrossSellsGridView.Rows
                If row.RowType = DataControlRowType.DataRow Then
                    Dim checkbox As CheckBox = DirectCast(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
                    If checkbox.Checked Then
                        If products.Contains(Catalog.InternalProduct.FindByBvin(CrossSellsGridView.DataKeys(row.RowIndex).Value)) Then
                            products.Remove(Catalog.InternalProduct.FindByBvin(CrossSellsGridView.DataKeys(row.RowIndex).Value))
                        End If
                    End If
                End If
            Next
        End If
        ViewState(_crossSellProductsKey) = products
        BindCrossSellsGridView(products)
    End Sub

    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveImageButton.Click
        If Page.IsValid Then
            Save()
        End If
    End Sub

    Protected Overrides Function Save() As Boolean
        Dim success As Boolean = False
        Dim products As BusinessEntityList(Of Catalog.Product) = CType(ViewState(_crossSellProductsKey), BusinessEntityList(Of Catalog.Product))
        If products IsNot Nothing Then
            Dim descriptionOverrides(products.Count) As String
            For Each row As GridViewRow In CrossSellsGridView.Rows
                descriptionOverrides(row.RowIndex) = DirectCast(row.FindControl("DescriptionOverrideTextBox"), TextBox).Text.Trim()
            Next
            success = Catalog.ProductCrossSell.Insert(Request.QueryString("id"), products, descriptionOverrides)
        End If

        If success Then
            products = CType(ViewState(_upSellProductsKey), BusinessEntityList(Of Catalog.Product))
            If products IsNot Nothing Then
                Dim descriptionOverrides(products.Count) As String
                For Each row As GridViewRow In UpSellsGridView.Rows
                    descriptionOverrides(row.RowIndex) = DirectCast(row.FindControl("DescriptionOverrideTextBox"), TextBox).Text.Trim()
                Next
                success = Catalog.ProductUpSell.Insert(Request.QueryString("id"), products, descriptionOverrides)
            End If
        End If

        If success Then
            MessageBox1.ShowOk("Up Sells/Cross Sells were successfully saved.")
            MessageBox2.ShowOk("Up Sells/Cross Sells were successfully saved.")
        Else
            MessageBox1.ShowError("There was an error while trying to save your Up Sells/Cross Sells.")
            MessageBox2.ShowError("There was an error while trying to save your Up Sells/Cross Sells.")
        End If
        Return success
    End Function

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        Response.Redirect(DefaultCatalogPage)
    End Sub

    Protected Sub UpSellsGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles UpSellsGridView.RowCommand
        If e.CommandName = "MoveUp" Then
            Dim products As BusinessEntityList(Of Catalog.Product) = CType(ViewState(_upSellProductsKey), BusinessEntityList(Of Catalog.Product))
            products.MoveDown(e.CommandArgument)
            BindUpSellsGridView(products)
        ElseIf e.CommandName = "MoveDown" Then
            Dim products As BusinessEntityList(Of Catalog.Product) = CType(ViewState(_upSellProductsKey), BusinessEntityList(Of Catalog.Product))
            products.MoveUp(e.CommandArgument)
            BindUpSellsGridView(products)
        End If
    End Sub

    Protected Sub CrossSellsGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles CrossSellsGridView.RowCommand
        If e.CommandName = "MoveUp" Then
            Dim products As BusinessEntityList(Of Catalog.Product) = CType(ViewState(_crossSellProductsKey), BusinessEntityList(Of Catalog.Product))
            products.MoveDown(e.CommandArgument)
            BindCrossSellsGridView(products)
        ElseIf e.CommandName = "MoveDown" Then
            Dim products As BusinessEntityList(Of Catalog.Product) = CType(ViewState(_crossSellProductsKey), BusinessEntityList(Of Catalog.Product))
            products.MoveUp(e.CommandArgument)
            BindCrossSellsGridView(products)
        End If
    End Sub

    Protected Sub UpSellsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles UpSellsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            DirectCast(e.Row.FindControl("MoveUpButton"), ImageButton).CommandArgument = UpSellsGridView.DataKeys(e.Row.RowIndex).Value
            DirectCast(e.Row.FindControl("MoveDownButton"), ImageButton).CommandArgument = UpSellsGridView.DataKeys(e.Row.RowIndex).Value
            Dim product As Catalog.Product = DirectCast(e.Row.DataItem, Catalog.Product)
            For Each UpSell As Catalog.ProductUpSell In UpSells
                If UpSell.UpSellBvin = product.Bvin Then
                    DirectCast(e.Row.FindControl("DescriptionOverrideTextBox"), TextBox).Text = UpSell.DescriptionOverride
                    Exit For
                End If
            Next
        End If
    End Sub

    Protected Sub CrossSellsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles CrossSellsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            DirectCast(e.Row.FindControl("MoveUpButton"), ImageButton).CommandArgument = CrossSellsGridView.DataKeys(e.Row.RowIndex).Value
            DirectCast(e.Row.FindControl("MoveDownButton"), ImageButton).CommandArgument = CrossSellsGridView.DataKeys(e.Row.RowIndex).Value
            Dim product As Catalog.Product = DirectCast(e.Row.DataItem, Catalog.Product)
            For Each CrossSell As Catalog.ProductCrossSell In crossSells
                If CrossSell.CrossSellBvin = product.Bvin Then
                    DirectCast(e.Row.FindControl("DescriptionOverrideTextBox"), TextBox).Text = CrossSell.DescriptionOverride
                    Exit For
                End If
            Next
        End If
    End Sub

    Protected Sub UpSellsGridView_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs) Handles UpSellsGridView.DataBinding
        UpSells = Catalog.ProductUpSell.FindByProductBvin(Request.QueryString("id"))
    End Sub

    Protected Sub CrossSellsGridView_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs) Handles CrossSellsGridView.DataBinding
        crossSells = Catalog.ProductCrossSell.FindByProductBvin(Request.QueryString("id"))
    End Sub
End Class

Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Xml.Serialization

Partial Class BVAdmin_Catalog_Categories_AutomaticSelection
    Inherits BaseAdminPage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Criteria For Category"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub OkImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles OkImageButton.Click
        Dim criteria As New Catalog.ProductSearchCriteria()

        ProductFilter1.LoadCriteria(criteria)
        
        Dim products As Collection(Of Catalog.Product) = Catalog.InternalProduct.FindByCriteria(criteria)
        ProductsGridView.DataSource = products
        ProductsGridView.DataKeyNames = New String() {"bvin"}
        ProductsGridView.DataBind()
        ProductListPanel.Visible = True
    End Sub

    

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        Response.Redirect("~/BVAdmin/Catalog/Categories_Edit.aspx?id=" & HttpUtility.UrlEncode(CStr(ViewState("id"))))
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("id") IsNot Nothing Then
            ViewState("id") = Request.QueryString("id")
            If Request.QueryString("type") IsNot Nothing Then
                ViewState("type") = Request.QueryString("type")
            End If
            If Not Page.IsPostBack() Then
                Dim category As Catalog.Category = Catalog.Category.FindByBvin(CStr(ViewState("id")))
                'now we check to see if we have any criteria. if we do then we need to initialize the filter
                If category.Criteria.Trim() <> String.Empty Then
                    Dim xs As New XmlSerializer(GetType(Catalog.ProductSearchCriteria))
                    Dim criteria As Catalog.ProductSearchCriteria
                    Dim sr As New IO.StringReader(category.Criteria)
                    Try
                        criteria = DirectCast(xs.Deserialize(sr), Catalog.ProductSearchCriteria)
                    Finally
                        sr.Close()
                    End Try
                    ProductFilter1.LoadFilter(criteria)
                End If
            End If
        Else
            ' No bvin so send back to categories page
            Response.Redirect("Categories.aspx")
        End If
    End Sub

    Protected Sub SaveChangesImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveChangesImageButton.Click
        If ViewState("id") IsNot Nothing Then
            Dim category As Catalog.Category = Catalog.Category.FindByBvin(CStr(ViewState("id")))
            Dim criteria As New Catalog.ProductSearchCriteria()
            ProductFilter1.LoadCriteria(criteria)
            Dim xs As New XmlSerializer(GetType(Catalog.ProductSearchCriteria))
            Dim sw As New IO.StringWriter()
            xs.Serialize(sw, criteria)
            Try
                category.Criteria = sw.ToString()
            Finally
                sw.Close()
            End Try

            If Not Catalog.Category.Update(category) Then
                msg.ShowError("An error occurred while trying to update the category")
            Else
                'delete all the current items in the category and now insert the new ones
                If Catalog.Category.DeleteAllAssociatedProducts(CStr(ViewState("id"))) Then
                    For Each row As GridViewRow In ProductsGridView.Rows
                        Catalog.Category.AddProduct(category.Bvin, ProductsGridView.DataKeys(row.RowIndex).Value)
                    Next
                    Response.Redirect("~/BVAdmin/Catalog/Categories_Edit.aspx?id=" & HttpUtility.UrlEncode(CStr(ViewState("id"))))
                Else
                    msg.ShowError("An error occurred while trying to update the category")
                End If
            End If
        Else
            Response.Redirect("Categories.aspx")
        End If

    End Sub
End Class

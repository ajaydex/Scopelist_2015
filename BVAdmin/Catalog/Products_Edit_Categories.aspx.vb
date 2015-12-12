Imports BVSoftware.Bvc5.Core
Imports System.Data
Imports System.Collections.ObjectModel
Imports System.Collections.Generic
Imports System.Linq

Partial Class products_edit_categories
    Inherits BaseProductAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Product Categories"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack() Then

            Dim EditID As String = Request.QueryString("id")
            If EditID.Trim().Length < 1 Then
                msg.ShowError("Unable to load the requested product.")
            Else
                Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(EditID)
                If p IsNot Nothing Then
                    If Not String.IsNullOrEmpty(p.ParentId) Then
                        Response.Redirect(String.Format("{0}?id={1}", HttpContext.Current.Request.Url.AbsolutePath, p.ParentId))
                    End If
                    ViewState("ID") = EditID
                    lblProductName.Text = p.Sku & " " & p.ProductName
                Else
                    msg.ShowError("Unable to load the requested product.")
                End If
                p = Nothing
            End If

            LoadCategories()
        End If
    End Sub

    Sub LoadCategories()
        Me.ucCategoryTreeView.LoadSelectedCategories(Catalog.InternalProduct.GetCategories(Request.QueryString("ID")))
    End Sub

    Private Sub SaveSettings()
        Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Request.QueryString("id"))
        Dim currentCategories As Collection(Of String) = p.Categories
        Dim newCategories As Dictionary(Of String, String) = Me.ucCategoryTreeView.SelectedCategories

        ' remove unselected categories
        For Each categoryBvin As String In currentCategories
            If Not newCategories.ContainsKey(categoryBvin) Then
                If Not Catalog.Category.RemoveProduct(categoryBvin, p.Bvin) Then
                    msg.ShowError(String.Format("Unable to remove product from category: {0}", categoryBvin))
                End If
            End If
        Next

        ' add new categories
        For Each item As KeyValuePair(Of String, String) In newCategories
            If Not currentCategories.Contains(item.Key) Then
                If Not Catalog.Category.AddProduct(item.Key, p.Bvin) Then
                    msg.ShowError(String.Format("Unable to assign product to category: {0}", item.Value))
                End If
            End If
        Next
    End Sub

    Private Sub CancelButton_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelButton.Click
        Cancel()
    End Sub

    Private Sub SaveButton_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveButton.Click
        Save()
    End Sub

    Private Sub Cancel()
        Response.Redirect("Products_edit.aspx?id=" & ViewState("ID"))
    End Sub

    Protected Overrides Function Save() As Boolean
        Me.msg.ClearMessage()
        SaveSettings()
        LoadCategories()
        msg.ShowOk("Changes Saved!")
        Return True
    End Function

End Class
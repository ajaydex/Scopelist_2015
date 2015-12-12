Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_BabyRegistryDetails
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            BindItems(Request.QueryString("id"))
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Baby Registry Details"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub BindItems(ByVal bvin As String)
        Dim li As New Collection(Of Catalog.ListItem)
        li = Catalog.ListItem.FindByListBvin(bvin)

        Me.GridView1.DataSource = li
        Me.GridView1.DataBind()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim UpdateButton As System.Web.UI.WebControls.ImageButton
            UpdateButton = e.Row.FindControl("UpdateButton")
            If Not UpdateButton Is Nothing Then
                UpdateButton.ImageUrl = PersonalizationServices.GetThemedButton("Update")
            End If

            Dim DeleteButton As System.Web.UI.WebControls.ImageButton
            DeleteButton = e.Row.FindControl("DeleteButton")
            If Not DeleteButton Is Nothing Then
                DeleteButton.ImageUrl = PersonalizationServices.GetThemedButton("Delete")
            End If

            Dim AddToCartImageButton As ImageButton = e.Row.FindControl("AddToCartImageButton")
            If AddToCartImageButton IsNot Nothing Then
                AddToCartImageButton.ImageUrl = PersonalizationServices.GetThemedButton("AddToCart")
            End If

            Dim localItem As Catalog.ListItem = CType(e.Row.DataItem, Catalog.ListItem)

            Dim drpPriority As System.Web.UI.WebControls.DropDownList
            drpPriority = e.Row.FindControl("drpPriority")
            If Not drpPriority Is Nothing Then
                Dim priorities() As String = System.Enum.GetNames(GetType(Catalog.ListItem.Priorities))
                drpPriority.DataSource = priorities
                drpPriority.DataBind()

                If localItem.Priority = Catalog.ListItem.Priorities.Highest Then
                    drpPriority.SelectedIndex = 0
                ElseIf localItem.Priority = Catalog.ListItem.Priorities.High Then
                    drpPriority.SelectedIndex = 1
                ElseIf localItem.Priority = Catalog.ListItem.Priorities.Medium Then
                    drpPriority.SelectedIndex = 2
                ElseIf localItem.Priority = Catalog.ListItem.Priorities.Low Then
                    drpPriority.SelectedIndex = 3
                ElseIf localItem.Priority = Catalog.ListItem.Priorities.Lowest Then
                    drpPriority.SelectedIndex = 4
                End If
            End If

            Dim localP As Catalog.Product = Catalog.InternalProduct.FindByBvin(localItem.ProductBvin)
            If localP IsNot Nothing Then
                Dim imgProduct As HyperLink = e.Row.FindControl("imgProduct")
                Dim lnkProduct As HyperLink = e.Row.FindControl("lnkProduct")
                Dim lnkProductPrice As HyperLink = e.Row.FindControl("lnkProductPrice")
                If imgProduct IsNot Nothing Then
                    imgProduct.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(localP.ImageFileSmall, True))
                    imgProduct.NavigateUrl = Utilities.UrlRewriter.BuildUrlForProduct(localP, Me.Page.Request)
                End If
                If lnkProduct IsNot Nothing Then
                    lnkProduct.Text = localP.ProductName
                    lnkProduct.NavigateUrl = imgProduct.NavigateUrl
                End If
                If lnkProductPrice IsNot Nothing Then
                    lnkProductPrice.Text = localP.GetSitePriceForDisplay(localItem.GetProductPriceAdjustment())
                    lnkProduct.NavigateUrl = imgProduct.NavigateUrl
                End If
            End If
        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim deleteid As String = Me.GridView1.DataKeys(e.RowIndex).Value.ToString
        Catalog.ListItem.RemoveItemFromList(deleteid)
        BindItems(Request.QueryString("id"))
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Dim updateId As String = Me.GridView1.DataKeys(e.RowIndex).Value.ToString
        Dim listItem As Catalog.ListItem = Catalog.ListItem.FindByBvin(updateId)
        If listItem IsNot Nothing Then
            Dim quantityTextBox As TextBox = CType(GridView1.Rows(e.RowIndex).FindControl("txtDesiredQty"), TextBox)
            Dim drpPriority As DropDownList = CType(GridView1.Rows(e.RowIndex).FindControl("drpPriority"), DropDownList)
            If quantityTextBox IsNot Nothing Then
                Dim val As Integer = 0
                If Integer.TryParse(quantityTextBox.Text, val) Then
                    listItem.DesiredQuantity = val
                    If drpPriority IsNot Nothing Then
                        listItem.Priority = System.Enum.Parse(GetType(Catalog.ListItem.Priorities), drpPriority.SelectedValue)
                    End If
                    If Catalog.ListItem.UpdateItemInList(listItem) Then
                        MessageBox1.ShowOk(Content.SiteTerms.GetTerm("BabyRegistry") & " updated.")
                    Else
                        MessageBox1.ShowError("Error updating " & Content.SiteTerms.GetTerm("BabyRegistry"))
                    End If
                End If
            End If
        End If
        BindItems(Request.QueryString("id"))
    End Sub
End Class

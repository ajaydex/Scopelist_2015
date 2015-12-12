Imports BVSoftware.Bvc5.Core
Imports System.Data
Imports System.Collections.ObjectModel

Partial Class Kit_Edit_Categories
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Kit Categories"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack() Then

            Dim EditID As String
            EditID = Request.QueryString("id")
            If EditID.Trim.Length < 1 Then
                msg.ShowError("Unable to load the requested kit.")
            Else
                Dim p As New Catalog.Product
                p = Catalog.InternalProduct.FindByBvin(EditID)
                If Not p Is Nothing Then
                    ViewState("ID") = EditID
                    lblProductName.Text = p.Sku & " " & p.ProductName
                Else
                    msg.ShowError("Unable to load the requested kit.")
                End If
                p = Nothing
            End If

            LoadCategories()
        End If
    End Sub

    Sub LoadCategories()

        chkCategories.Items.Clear()

        Dim t As Collection(Of Catalog.Category) = Catalog.InternalProduct.GetCategories(Request.QueryString("ID"))
        Dim tree As Collection(Of ListItem) = Catalog.Category.ListFullTreeWithIndents(True)

        For Each li As ListItem In tree
            Me.chkCategories.Items.Add(li)
        Next

        For Each ca As Catalog.Category In t
            'Dim ca As Catalog.Category = Catalog.Category.FindByBvin(mydatarow.Item(0).ToString)
            For Each l As ListItem In chkCategories.Items
                If l.Value = ca.Bvin Then
                    l.Selected = True
                End If
            Next
        Next
    End Sub

    Private Sub SaveSettings()
        Catalog.Category.RemoveProductFromAll(Request.QueryString("id").ToString)
        Dim li As ListItem
        For Each li In chkCategories.Items
            If li.Selected = True Then
                Catalog.Category.AddProduct(li.Value, Request.QueryString("id").ToString)
            Else
                Catalog.Category.RemoveProduct(li.Value, Request.QueryString("id").ToString)
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
        Response.Redirect("Kit_Edit.aspx?id=" & ViewState("ID"))
    End Sub

    Protected Sub Save()
        SaveSettings()
        Response.Redirect("Kit_Edit.aspx?id=" & ViewState("ID"))
    End Sub
End Class

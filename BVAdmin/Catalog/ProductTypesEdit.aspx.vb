Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class Product_ProductTypes_Edit
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Types Edit"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Catalog

            Dim productID As String = String.Empty
            If Not Request.QueryString("ID") Is Nothing Then
                productID = Request.QueryString("id")
            Else
                msg.ShowError("No product type ID was found.")
            End If

            ViewState("ID") = productID
            LoadType()
        End If

    End Sub

    Private Sub LoadType()
        Dim prodType As New Catalog.ProductType
        prodType = Catalog.ProductType.FindByBvin(ViewState("ID"))
        If Not prodType Is Nothing Then

            Me.ProductTypeNameField.Text = prodType.ProductTypeName

            LoadPropertyLists()

            If Catalog.ProductType.FindCountOfProductsByType(prodType.Bvin) > 0 Then
                msg.ShowWarning("Editing this type will affect all existing products of this type. Any default values you set here will NOT overwrite existing products but any properties that you add or remove will affect existing products.")
            End If
        Else
			msg.ShowError("Unable to load Product Type ID " & ViewState("ID"))
        End If
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        ' Delete newly created item if user cancels so we don't leave a bunch of "new property"
        If Request("newmode") = 1 Then
            Catalog.ProductType.Delete(ViewState("ID"))
        End If
        Response.Redirect("ProductTypes.aspx")
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        msg.ClearMessage()
        Dim prodType As New Catalog.ProductType
        prodType = Catalog.ProductType.FindByBvin(ViewState("ID"))
        If Not prodType Is Nothing Then

            With prodType
                .ProductTypeName = Me.ProductTypeNameField.Text
            End With

            If Catalog.ProductType.Save(prodType) = True Then
                prodType = Nothing
                Response.Redirect("ProductTypes.aspx")
            Else
                prodType = Nothing
                msg.ShowError("Error: Couldn't Save Product Type!")
            End If
        Else
			msg.ShowError("Couldn't Load Product Type to Update!")
        End If

    End Sub

    Private Sub LoadPropertyLists()

        Me.lstProperties.DataSource = Catalog.ProductProperty.FindByProductType(ViewState("ID"))
        Me.lstProperties.DataTextField = "PropertyName"
        Me.lstProperties.DataValueField = "bvin"
        Me.lstProperties.DataBind()

        Me.lstAvailableProperties.DataSource = Catalog.ProductType.FindAvailablePropertiesForType(ViewState("ID"))
        Me.lstAvailableProperties.DataTextField = "PropertyName"
        Me.lstAvailableProperties.DataValueField = "bvin"
        Me.lstAvailableProperties.DataBind()
    End Sub

    Private Sub btnAddProperty_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddProperty.Click
        Dim prodType As Catalog.ProductType = Catalog.ProductType.FindByBvin(ViewState("ID"))

        Dim properties As Collections.Generic.List(Of Catalog.ProductProperty) = Catalog.ProductType.FindPropertiesForType(ViewState("ID"))
        Dim sortOrder As Integer = 0
        If properties.Count > 0 Then
            sortOrder = properties(properties.Count - 1).SortOrder + 1
        End If

        Dim indices() As Integer = lstAvailableProperties.GetSelectedIndices()
        For Each index As Integer In indices
            Catalog.ProductType.AddProperty(ViewState("ID"), lstAvailableProperties.Items(index).Value, sortOrder)
            sortOrder += 1
        Next

        Me.LoadPropertyLists()
    End Sub

    Private Sub btnRemoveProperty_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnRemoveProperty.Click
        Dim indices() As Integer = lstProperties.GetSelectedIndices()

        For Each index As Integer In indices
            Catalog.ProductType.RemoveProperty(ViewState("ID"), lstProperties.Items(index).Value)
        Next

        Me.LoadPropertyLists()
    End Sub

    Private Sub btnMovePropertyUp_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnMovePropertyUp.Click
        Dim selected As String = Me.lstProperties.SelectedValue
        Catalog.ProductType.MovePropertyUp(ViewState("ID"), selected)
        Me.LoadPropertyLists()
        For Each li As ListItem In Me.lstProperties.Items
            If li.Value = selected Then
                lstProperties.ClearSelection()
                li.Selected = True
            End If
        Next
    End Sub

    Private Sub btnMovePropertyDown_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnMovePropertyDown.Click
        Dim selected As String = Me.lstProperties.SelectedValue
        Catalog.ProductType.MovePropertyDown(ViewState("ID"), selected)
        Me.LoadPropertyLists()
        For Each li As ListItem In Me.lstProperties.Items
            If li.Value = selected Then
                lstProperties.ClearSelection()
                li.Selected = True
            End If
        Next
    End Sub
End Class

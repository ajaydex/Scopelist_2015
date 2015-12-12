Imports BVSoftware.Bvc5.Core

Partial Class Products_ProductTypes
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Types"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Catalog
            FillList()
        End If
    End Sub

    Private Sub FillList()
        Me.dgList.DataSource = Catalog.ProductType.FindAll()
        Me.dgList.DataBind()
    End Sub

    Private Sub btnNew_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Dim pt As New Catalog.ProductType
        If Catalog.ProductType.SaveAsNew(pt) Then
            Response.Redirect("~/BVAdmin/Catalog/ProductTypesEdit.aspx?newmode=1&id=" & pt.Bvin)
        Else
            msg.ShowError("Error while attempting to create new type.")
        End If
    End Sub

    Private Sub dgList_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgList.EditCommand
        Dim editID As String = dgList.DataKeys(e.Item.ItemIndex)
        Response.Redirect("~/BVAdmin/Catalog/ProductTypesEdit.aspx?id=" & editID)
    End Sub

    Private Sub dgList_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgList.DeleteCommand
        Dim deleteID As String = dgList.DataKeys(e.Item.ItemIndex)
        Catalog.ProductType.Delete(deleteID)
        FillList()
    End Sub

    Private Sub dgList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgList.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
            Dim deleteButton As ImageButton
            deleteButton = e.Item.FindControl("DeleteButton")
            If deleteButton IsNot Nothing Then
                If Catalog.ProductType.FindCountOfProductsByType(dgList.DataKeys(e.Item.ItemIndex)) > 0 Then
                    deleteButton.Visible = False
                Else
                    deleteButton.Visible = True
                End If
            End If
        End If
    End Sub
End Class



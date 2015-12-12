Imports BVSoftware.Bvc5.Core


Partial Class BVAdmin_Catalog_ProductTypeProperties
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Properties"
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
        Me.dgList.DataSource = Catalog.ProductProperty.FindAll
        Me.dgList.DataBind()
    End Sub

    Private Sub btnNew_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        msg.ClearMessage()

        Dim p As New Catalog.ProductProperty
        p.DisplayName = "New Property"
        p.TypeCode = lstProductType.SelectedValue
        If Catalog.ProductProperty.SaveAsNew(p) = True Then
            Response.Redirect("~/BVAdmin/Catalog/ProductTypePropertiesEdit.aspx?newmode=1&id=" & p.Bvin)
        Else
            msg.ShowError("Error while attempting to create new property.")
        End If
    End Sub

    Private Sub dgList_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgList.EditCommand
        Dim editID As String = dgList.DataKeys(e.Item.ItemIndex)
        Response.Redirect("~/BVAdmin/Catalog/ProductTypePropertiesEdit.aspx?id=" & editID)
    End Sub

    Private Sub dgList_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgList.DeleteCommand
        Dim deleteID As String = dgList.DataKeys(e.Item.ItemIndex)
        Catalog.ProductProperty.Delete(deleteID)
        FillList()
    End Sub
End Class
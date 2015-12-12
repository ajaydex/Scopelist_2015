Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_Kits
    Inherits BaseAdminPage

    Private criteriaSessionKey As String = "KitCriteria"

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Kits"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Response.Redirect("Kit_Edit.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.Session(criteriaSessionKey) = SimpleKitFilter.LoadProducts()
            Me.GridView1.PageSize = WebAppSettings.RowsPerPage
            Me.GridView1.DataBind()
            Me.GridView1.PageIndex = SessionManager.AdminKitGridPage
            Me.SimpleKitFilter.Focus()
        End If

        ' Make sure page index never goes above/below PageCount
        Dim countMinusOne As Integer = Me.GridView1.PageCount - 1
        If Me.GridView1.PageIndex > (countMinusOne) Then
            If countMinusOne >= 0 Then
                Me.GridView1.PageIndex = (countMinusOne)
            Else
                Me.GridView1.PageIndex = 0
            End If
            SessionManager.AdminKitGridPage = Me.GridView1.PageIndex
        End If

    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim p As Catalog.Product = CType(e.Row.DataItem, Catalog.Product)
            If p IsNot Nothing Then
                Dim chkActive As CheckBox = CType(e.Row.FindControl("chkActive"), CheckBox)
                If p.Status = Catalog.ProductStatus.Active Then
                    chkActive.Checked = True
                Else
                    chkActive.Checked = False
                End If
            End If
            DirectCast(e.Row.FindControl("CloneImageButton"), Anthem.ImageButton).CommandArgument = e.Row.RowIndex
        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.CatalogEdit) = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
            Catalog.InternalProduct.Delete(bvin)
        End If
        Me.Session(criteriaSessionKey) = SimpleKitFilter.LoadProducts()
        e.Cancel = True
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("Kit_Edit.aspx?id=" & bvin)
        e.Cancel = True
    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "Clone" Then
            Dim key As String = GridView1.DataKeys(Integer.Parse(e.CommandArgument)).Value
            Response.Redirect("~/BVAdmin/Catalog/ProductClone.aspx?id=" & HttpUtility.UrlEncode(key))
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource1.Selecting
        If e.ExecutingSelectCount Then
            e.InputParameters("rowCount") = HttpContext.Current.Items("RowCount")
            Dim count As Integer = CInt(HttpContext.Current.Items("RowCount"))
            If count = 1 Then
                Me.lblResults.Text = count & " kit found"
            Else
                Me.lblResults.Text = count & " kits found"
            End If
            HttpContext.Current.Items("RowCount") = Nothing
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If e.OutputParameters("RowCount") IsNot Nothing Then
            HttpContext.Current.Items("RowCount") = e.OutputParameters("RowCount")
        End If
    End Sub

    Protected Sub FilterChanged(ByVal criteria As Catalog.ProductSearchCriteria) Handles SimpleKitFilter.FilterChanged
        Me.Session(criteriaSessionKey) = criteria
        Me.GridView1.DataBind()
        Me.GridView1.UpdateAfterCallBack = True
    End Sub

    Protected Sub GoPressed(ByVal criteria As Catalog.ProductSearchCriteria) Handles SimpleKitFilter.GoPressed
        Me.Session(criteriaSessionKey) = criteria
        Me.GridView1.DataBind()
        Me.GridView1.UpdateAfterCallBack = True
    End Sub

    Protected Sub GridView1_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PageIndexChanged
        SessionManager.AdminKitGridPage = GridView1.PageIndex
    End Sub
End Class

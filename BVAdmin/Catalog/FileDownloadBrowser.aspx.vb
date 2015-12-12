Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Catalog_FileDownloadBrowser
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "File Download Browser"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        FileGridView.DataSource = Catalog.ProductFile.GetAllFilesInVault()
        FileGridView.DataKeyNames = New String() {"FileId", "ShortDescription", "FileName"}
        FileGridView.DataBind()
    End Sub

    Protected Sub FileGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles FileGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim anchor As HtmlAnchor = DirectCast(e.Row.Cells(1).FindControl("lnkChoose"), HtmlAnchor)
            anchor.HRef = "javascript:opener.closePopup('" & CStr(FileGridView.DataKeys(e.Row.RowIndex).Item(0)) & "','" & CStr(FileGridView.DataKeys(e.Row.RowIndex).Item(1)) & "','" & CStr(FileGridView.DataKeys(e.Row.RowIndex).Item(2)) & "');"
        End If
    End Sub
End Class

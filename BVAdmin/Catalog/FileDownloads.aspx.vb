Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_FileDownloads
    Inherits BaseAdminPage

    Protected Sub AddFileButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddFileButton.Click
        If Page.IsValid Then
            FilePicker1.DownloadOrLinkFile(Nothing, Me.MessageBox1)
            InitializeFileGrid()
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("id") Is Nothing Then
            Response.Redirect(DefaultCatalogPage)
        Else
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Request.QueryString("id"))
            If Not String.IsNullOrEmpty(p.ParentId) Then
                Response.Redirect(String.Format("{0}?id={1}", HttpContext.Current.Request.Url.AbsolutePath, p.ParentId))
            End If
            ViewState("id") = Request.QueryString("id")
            FilePicker1.ProductId = ViewState("id")
            InitializeFileGrid()
        End If
    End Sub

    Protected Sub InitializeFileGrid()
        FileGrid.DataSource = Catalog.ProductFile.FindByProductId(ViewState("id"))
        FileGrid.DataKeyNames = New String() {"Bvin"}
        FileGrid.DataBind()
    End Sub

    Protected Sub FileGrid_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles FileGrid.RowCommand
        If e.CommandName = "Download" Then
            Dim primaryKey As String = DirectCast(sender, GridView).DataKeys(CInt(e.CommandArgument)).Value
            Dim file As Catalog.ProductFile = Catalog.ProductFile.FindByBvin(primaryKey)

            If Not ViewUtilities.DownloadFile(file) Then
                MessageBox1.ShowError("The file to download could not be found.")
            End If
        End If
    End Sub

    Protected Sub FileGrid_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles FileGrid.RowDeleting

        If Not Catalog.ProductFile.RemoveAssociatedProduct(FileGrid.DataKeys(e.RowIndex).Value, ViewState("id")) Then
            MessageBox1.ShowError("An error occurred while trying to delete your file from the database.")
        End If
        InitializeFileGrid()
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "File Downloads"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

End Class

Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_FileVault
    Inherits BaseAdminPage


    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            BindFileGridView()
            FileGridView.PageSize = WebAppSettings.RowsPerPage
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "File Vault"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub BindFileGridView()
        FileGridView.DataBind()
    End Sub

    Protected Sub FileGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles FileGridView.RowDeleting
        Dim key As String = FileGridView.DataKeys(e.RowIndex).Value
        Catalog.ProductFile.Delete(key, Server.MapPath(Request.ApplicationPath))
        BindFileGridView()
        e.Cancel = True
    End Sub

    Protected Sub FileGridView_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles FileGridView.RowEditing
        Dim key As String = FileGridView.DataKeys(e.NewEditIndex).Value
        Response.Redirect("FileVaultDetailsView.aspx?id=" & HttpUtility.UrlEncode(key))
    End Sub

    Protected Sub AddNewImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddNewImageButton.Click
        If Page.IsValid Then
            FilePicker.DownloadOrLinkFile(Nothing, MessageBox1)
            BindFileGridView()
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource1.Selecting
        If e.ExecutingSelectCount Then
            e.InputParameters("rowCount") = HttpContext.Current.Items("RowCount")
            HttpContext.Current.Items("RowCount") = Nothing
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If e.OutputParameters("RowCount") IsNot Nothing Then
            HttpContext.Current.Items("RowCount") = e.OutputParameters("RowCount")
        End If
    End Sub

    Protected Sub ImportLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ImportLinkButton.Click
        Dim files As String() = System.IO.Directory.GetFiles(Server.MapPath(Request.ApplicationPath) & "\Files\")
        Dim errorOccurred As Boolean = False
        For Each fileName As String In files
            If Not fileName.ToLower().EndsWith(".config") Then
                Dim file As Catalog.ProductFile = New Catalog.ProductFile()
                file.FileName = System.IO.Path.GetFileName(fileName)
                file.ShortDescription = file.FileName                
                If Catalog.ProductFile.Save(file) Then
                    Try
                        Dim fileStream As New System.IO.FileStream(fileName, IO.FileMode.Open)
                        Try
                            If Catalog.ProductFile.SaveFile(file.Bvin, file.FileName, Server.MapPath(Request.ApplicationPath), fileStream) Then
                                fileStream.Close()
                                Try
                                    IO.File.Delete(fileName)
                                Catch ex As Exception
                                    errorOccurred = True
                                    EventLog.LogEvent(ex)
                                End Try
                            End If
                        Finally
                            Try
                                fileStream.Close()
                            Catch

                            End Try
                        End Try
                    Catch ex As Exception
                        errorOccurred = True
                        EventLog.LogEvent(ex)
                    End Try
                End If
            End If
        Next

        If errorOccurred Then
            MessageBox1.ShowError("An error occurred during import. Please check the event log.")
        Else
            MessageBox1.ShowOk("Files Imported Successfully.")
        End If

        BindFileGridView()
    End Sub
End Class

Imports BVSoftware.BVC5.Core

Partial Class BVAdmin_ImportExport
    Inherits BaseAdminPage

    Private ImportController As ImportExport.ImportTemplate = Nothing
    Private ExportController As ImportExport.ExportTemplate = Nothing

    Private Import As ImportExport.BaseImport = Nothing
    Private Export As ImportExport.BaseExport = Nothing

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Import/Export"
        'Me.CurrentTab = AdminTabType.Plugins
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogEdit)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim bvin As String = Request.QueryString("id")
        If Not String.IsNullOrEmpty(bvin) Then
            Me.Import = ImportExport.AvailableImportExports.FindImportByBvin(bvin)
            Me.Export = ImportExport.AvailableImportExports.FindExportByBvin(bvin)
        End If

        If Me.Export IsNot Nothing Then
            Me.lblExportTitle.Text = Me.Export.FeedName
            LoadExportController()
        Else
            Me.pnlExport.Visible = False
        End If

        If Me.Import IsNot Nothing Then
            Me.lblImportTitle.Text = Me.Import.ImportName
            LoadImportController()
        Else
            Me.pnlImport.Visible = False
        End If
    End Sub

    Protected Sub LoadImportController()
        Me.ImportController = CType(Content.ModuleController.LoadImportController(Me.Import.GetType(), Me), ImportExport.ImportTemplate)
        If Me.ImportController IsNot Nothing Then
            Me.ImportController.ID = "ImportEditor"
            Me.ImportController.BlockId = Me.Import.Bvin
            AddControlToPlaceholder(Me.ImportController, Me.ImportControllerPlaceHolder)
        End If
    End Sub

    Protected Sub LoadExportController()
        Me.ExportController = CType(Content.ModuleController.LoadExportController(Me.Export.GetType(), Me), ImportExport.ExportTemplate)
        If Me.ExportController IsNot Nothing Then
            Me.ExportController.ID = "ExportEditor"
            Me.ExportController.BlockId = Me.Export.Bvin
            AddControlToPlaceholder(Me.ExportController, Me.ExportControllerPlaceHolder)
        End If
    End Sub

    Protected Sub AddControlToPlaceholder(ByVal control As UserControl, ByVal placeholder As PlaceHolder)
        placeholder.Controls.Clear()
        placeholder.Controls.Add(control)
    End Sub

    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs) Handles btnExport.Click
       If Me.Export IsNot Nothing Then
            If Me.ExportController IsNot Nothing Then
                Me.ExportController.ApplyFormSettings(Me.Export)
            End If

            Try
                Me.Export.GenerateFeed()

                ' output file to browser
                Response.Clear()
                Response.ClearHeaders()
                Response.ContentType = Me.Export.ContentType
                Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", Me.Export.FileName))
                Response.TransmitFile(Me.Export.PhysicalFilePath)
                Response.Flush()

                ' delete file for security
                System.IO.File.Delete(Me.Export.PhysicalFilePath)

                Response.End()
            Catch ex As Exception
                Me.ucExportMessageBox.ShowException(ex)
            End Try
        Else
            Me.ucExportMessageBox.ShowError("Unable to find data exporter!")
        End If
    End Sub

    Protected Sub btnImport_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs) Handles btnImport.Click
        Me.btnImport.Enabled = True

        If Me.Import IsNot Nothing Then
            Me.Import.Messages.Clear()

            If Me.ImportController IsNot Nothing Then
                Me.ImportController.ApplyFormSettings(Me.Import)
            End If

            If Me.fuImport.HasFile Then
                Try
                    Me.Import.Import(Me.fuImport.FileContent)
                Catch ex As Exception
                    Me.ucImportMessageBox.ShowException(ex)
                End Try

                ' display messages
                For Each msg As Content.DisplayMessage In Me.Import.Messages
                    Me.ucImportMessageBox.ShowMessage(msg.Message, msg.MessageType)
                Next
            Else
                Me.ucImportMessageBox.ShowError("Please select an import file to upload.")
            End If
        Else
            Me.ucImportMessageBox.ShowError("Unable to find data importer!")
        End If
    End Sub

End Class
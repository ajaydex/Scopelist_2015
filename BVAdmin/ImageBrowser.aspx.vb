Imports BVSoftware.Bvc5.Core
Imports System.IO
Imports System.Data

Partial Class BVAdmin_ImageBrowser
    Inherits BaseAdminPage

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.None

            Me.rbResizeSmall.Text = "Resize to Small (" & WebAppSettings.ImagesSmallWidth & " x " & WebAppSettings.ImagesSmallHeight & ")"
            Me.rbResizeMedium.Text = "Resize to Medium (" & WebAppSettings.ImagesMediumWidth & " x " & WebAppSettings.ImagesMediumHeight & ")"
            Me.ResizeWidthField.Text = WebAppSettings.ImagesSmallWidth
            Me.ResizeHeightField.Text = WebAppSettings.ImagesSmallHeight


            If Request.Params("returnScript") IsNot Nothing Then
                SetReturnScriptLink(Request.Params("returnScript"))
            End If

            ' Look for start DIR request
            If Request.Params("StartDir") IsNot Nothing Then
                Dim startDir As String = Path.Combine(Request.PhysicalApplicationPath, Request.Params("StartDir"))
                If Directory.Exists(startDir) Then
                    SessionManager.ImageBrowserLastFolder = Request.Params("StartDir")
                Else
                    SessionManager.ImageBrowserLastFolder = WebAppSettings.ImageBrowserDefaultDirectory
                End If
            Else
                SessionManager.ImageBrowserLastFolder = WebAppSettings.ImageBrowserDefaultDirectory
            End If

        End If

        PopulateFileList(SessionManager.ImageBrowserLastFolder)

    End Sub

    Private Sub SetReturnScriptLink(ByVal functionName As String)

        Me.lnkChoose.HRef = "javascript:opener." & functionName
        Me.lnkChoose.HRef += "('"
        If ViewState("SelectedFile") IsNot Nothing Then
            Dim shortName As String = Path.Combine(SessionManager.ImageBrowserLastFolder, ViewState("SelectedFile"))
            If Request.QueryString("WebMode") = "1" Then
                shortName = shortName.Replace("\", "/")
            Else
                shortName = shortName.Replace("/", "\")
                shortName = shortName.Replace("\", "\\")
            End If

            Me.lnkChoose.HRef += shortName
        End If
        If Request.QueryString("id") IsNot Nothing Then
            Me.lnkChoose.HRef += "', '" + Request.QueryString("id")
        End If
        If Request.QueryString("id2") IsNot Nothing Then
            Me.lnkChoose.HRef += "', '" + Request.QueryString("id2")
        End If
        Me.lnkChoose.HRef += "');"
    End Sub

    Private Sub PopulateFileList(ByVal startDir As String)
        startDir = startDir.TrimStart("/")
        startDir = startDir.TrimStart("\")

        Dim physicalStart As String = Request.PhysicalApplicationPath
        physicalStart = Path.Combine(physicalStart, startDir)

        Dim parentDir As DirectoryInfo = Nothing
        Dim childDirs As DirectoryInfo() = Nothing
        Dim childFiles As FileInfo() = Nothing

        If Directory.Exists(physicalStart) = False Then
            physicalStart = Request.PhysicalApplicationPath
            physicalStart = Path.Combine(physicalStart, "images/")
        End If

        If Directory.Exists(physicalStart) = True Then

            parentDir = New DirectoryInfo(physicalStart)
            If parentDir IsNot Nothing Then
                childDirs = parentDir.GetDirectories
                childFiles = parentDir.GetFiles
            End If

            ' Up Folder Link
            Dim lastSlash As Integer = startDir.LastIndexOf("\")
            Dim location As String = ""
            If lastSlash > 0 Then
                location = startDir.Substring(0, lastSlash)
            Else
                location = ""
            End If

            Dim dt As New DataTable
            dt.Columns.Add("Link", System.Type.GetType("System.String"))
            dt.Columns.Add("CommandArgument", System.Type.GetType("System.String"))
            dt.Columns.Add("CommandName", System.Type.GetType("System.String"))
            dt.Columns.Add("LinkType", System.Type.GetType("System.String"))


            If startDir.Length > 0 Then

                Dim linkText As String = "<img src=""../Images/System/FileIcons/Folder.gif"" width=""16"" height=""16"" border=""0"">&nbsp;.."
                Dim cmdArg As String = location
                Dim dr As DataRow = dt.NewRow()
                dr.Item("Link") = linkText
                dr.Item("CommandArgument") = cmdArg
                dr.Item("CommandName") = ""
                dr.Item("LinkType") = "DIR"
                dt.Rows.Add(dr)
            End If

            For i As Integer = 0 To childDirs.Length - 1

                Dim linkText As String = "<img src=""../Images/System/FileIcons/Folder.gif"" width=""16"" height=""16"" border=""0"">&nbsp;" & childDirs(i).Name
                Dim cmdArg As String = Path.Combine(startDir, childDirs(i).Name)
                Dim dr As DataRow = dt.NewRow()
                dr.Item("Link") = linkText
                dr.Item("CommandArgument") = cmdArg
                dr.Item("CommandName") = ""
                dr.Item("LinkType") = "DIR"
                dt.Rows.Add(dr)
            Next

            For i As Integer = 0 To childFiles.Length - 1
                If Me.CheckExtension(childFiles(i).Extension) = True Then

                    Dim linkText As String = AddIconToFileName(childFiles(i).Name)
                    Dim cmdArg As String = childFiles(i).Name
                    Dim cmdName As String = childFiles(i).FullName
                    Dim dr As DataRow = dt.NewRow()
                    dr.Item("Link") = linkText
                    dr.Item("CommandArgument") = cmdArg
                    dr.Item("CommandName") = cmdName
                    dr.Item("LinkType") = "FILE"
                    dt.Rows.Add(dr)
                End If
            Next

            Me.FilesListRepeater.DataSource = dt
            Me.FilesListRepeater.DataBind()
        Else
            lblError.Text = "Folder Not Found"
        End If

    End Sub

    Private Function AddIconToFileName(ByVal fileName As String) As String
        Dim result As String = fileName

        Dim extension As String = Path.GetExtension(fileName)
        extension = extension.Trim(".")

        If File.Exists(Path.Combine(Request.PhysicalApplicationPath, "images\System\FileIcons\" & extension & ".gif")) = True Then
            Dim sb As New StringBuilder
            sb.Append("<img src=""../images/system/fileIcons/")
            sb.Append(extension)
            sb.Append(".gif")
            sb.Append(""" border=""0"" alt=""")
            sb.Append(fileName)
            sb.Append(""">&nbsp;")
            sb.Append(fileName)
            result = sb.ToString
        End If

        Return result
    End Function

    Private Sub btnUpload_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnUpload.Click
        lblError.Text = String.Empty
        Try
            ' Check File Extension
            Dim sFile As String
            sFile = Me.UploadFileField.PostedFile.FileName

            If sFile.Length < 1 Then
                lblError.Text = "Please enter a file name first to upload a new image."
            Else
                Dim sExtension As String = Path.GetExtension(sFile)

                Dim startDir As String = SessionManager.ImageBrowserLastFolder
                startDir.TrimStart("/")
                startDir.TrimStart("\")

                Dim SavePath As String = Path.Combine(Request.PhysicalApplicationPath, startDir)
                Dim SaveName As String = Path.Combine(SavePath, Path.GetFileName(sFile))
                If Me.chkRename.Checked = True Then
                    SaveName = Path.Combine(SavePath, RenameField.Text.Trim)
                End If

                If CheckExtension(sExtension) = True Then

                    If File.Exists(SaveName) = True Then
                        lblError.Text = "<strong>" & Path.GetFileName(sFile) & "</strong> already exists. Please delete it first."
                    Else

                        UploadFileField.PostedFile.SaveAs(SaveName)

                        If Me.rbResizeNone.Checked = False Then
                            Dim rwidth As Integer = 0
                            Dim rheight As Integer = 0

                            If rbResizeSmall.Checked = True Then
                                rwidth = WebAppSettings.ImagesSmallWidth
                                rheight = WebAppSettings.ImagesSmallHeight
                            ElseIf rbResizeMedium.Checked = True Then
                                rwidth = WebAppSettings.ImagesMediumWidth
                                rheight = WebAppSettings.ImagesMediumHeight
                            Else
                                rwidth = Me.ResizeWidthField.Text
                                rheight = Me.ResizeHeightField.Text
                            End If
                            Utilities.ImageHelper.ResizeImage(SaveName, SaveName, rheight, rwidth)
                        End If

                        If (Me.chkOptimize.Checked = True) And ((Path.GetExtension(SaveName).ToLower = ".jpg") Or (Path.GetExtension(SaveName).ToLower = ".jpeg")) Then
                            Dim quality As Integer = 100
                            While (Utilities.ImageHelper.GetImageInformation(SaveName).SizeInBytes > (lstOptimize.SelectedValue * 1024)) AndAlso quality > 0
                                Utilities.ImageHelper.CompressJpeg(SaveName, quality)
                                quality -= 10
                            End While
                        End If

                    End If
                Else
                    lblError.Text = "Unsupported File Type"
                End If

            End If


        Catch Ex As Exception
            lblError.Text = Ex.Message
        End Try

        PopulateFileList(SessionManager.ImageBrowserLastFolder)
    End Sub

    Public Function CheckExtension(ByVal sExt As String) As Boolean
        Dim result As Boolean = False

        If sExt.ToLower = ".jpg" Then
            result = True
        End If
        If sExt.ToLower = ".gif" Then
            result = True
        End If
        If sExt.ToLower = ".png" Then
            result = True
        End If

        Return result
    End Function

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDelete.Click
        lblError.Text = String.Empty
        DeleteCurrentFile()
        Me.PopulateFileList(SessionManager.ImageBrowserLastFolder)
    End Sub

    Private Sub DeleteCurrentFile()
        lblError.Text = String.Empty
        Dim fileToDelete As String = Path.Combine(Request.PhysicalApplicationPath, SessionManager.ImageBrowserLastFolder)
        fileToDelete = Path.Combine(fileToDelete, ViewState("SelectedFile"))
        If File.Exists(fileToDelete) = True Then
            File.Delete(fileToDelete)
        End If
        ClearCurrentImage()
    End Sub

    Private Sub SelectImage_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        SetCurrentImage(CType(sender, LinkButton).CommandArgument, CType(sender, LinkButton).CommandName)
        PopulateFileList(SessionManager.ImageBrowserLastFolder)
    End Sub

    Private Sub SelectDirectory_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        SessionManager.ImageBrowserLastFolder = CType(sender, LinkButton).CommandArgument
        ClearCurrentImage()
        PopulateFileList(CType(sender, LinkButton).CommandArgument)
    End Sub

    Private Sub SetCurrentImage(ByVal fileName As String, ByVal longName As String)

        ViewState("SelectedFile") = fileName

        Try
            Dim shortName As String = Path.Combine(SessionManager.ImageBrowserLastFolder, fileName)

            Me.imgPreview.ImageUrl = Path.Combine("~/", shortName).Replace("\", "/")

            Dim info As Utilities.ImageInfo = Utilities.ImageHelper.GetImageInformation(longName)
            Dim maxSizeInfo As Utilities.ImageInfo = Utilities.ImageHelper.GetProportionalImageDimensionsForImage(info, 215, 180)

            If info.Height > 180 OrElse info.Width > 215 Then
                Me.imgPreview.Width = maxSizeInfo.Width
                Me.imgPreview.Height = maxSizeInfo.Height
            Else
                Me.imgPreview.Width = info.Width
                Me.imgPreview.Height = info.Height
            End If

            Me.lblImageInfo.Text = fileName
            Me.lblImageInfo.Text += "<br>" & info.FormattedDimensions
            Me.lblImageInfo.Text += "<br>" & info.FormattedSize
        Catch ex As Exception
            'EventLog.LogEvent(ex)
        End Try

        SetReturnScriptLink(Request.Params("returnScript"))

    End Sub

    Private Sub ClearCurrentImage()
        ViewState("SelectedFile") = ""
        Me.imgPreview.ImageUrl = "~/images/System/NoImageAvailable.gif"
        Me.lblImageInfo.Text = "No File Selected"
    End Sub

    Private Sub FilesListRepeater_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles FilesListRepeater.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
            Dim btnFile As LinkButton
            btnFile = e.Item.FindControl("btnFile")
            If Not btnFile Is Nothing Then
                btnFile.Text = DataBinder.Eval(e.Item.DataItem, "Link")
                btnFile.CommandArgument = DataBinder.Eval(e.Item.DataItem, "CommandArgument")
                btnFile.CommandName = DataBinder.Eval(e.Item.DataItem, "CommandName")
                Dim fileType As String = DataBinder.Eval(e.Item.DataItem, "LinkType")
                If fileType = "DIR" Then
                    AddHandler btnFile.Click, AddressOf SelectDirectory_Click
                Else
                    AddHandler btnFile.Click, AddressOf SelectImage_Click
                End If
            End If
        End If
    End Sub

    Private Sub btnNewFolder_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewFolder.Click
        Me.lblError.Text = String.Empty
        Try

            Dim startDir As String = SessionManager.ImageBrowserLastFolder
            startDir.TrimStart("/")
            startDir.TrimStart("\")
            Dim SavePath As String = Path.Combine(Request.PhysicalApplicationPath, startDir)
            SavePath = Path.Combine(SavePath, Me.NewFolderField.Text.Trim)
            Directory.CreateDirectory(SavePath)
            PopulateFileList(SessionManager.ImageBrowserLastFolder)

        Catch ioex As IOException
            lblError.Text = "File IO exception: " & ioex.Message & " - Check ASPNET user account permissions."
        Catch ex As Exception
            lblError.Text = ex.Message
        End Try

    End Sub

    Private Sub btnFileCopy_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnFileCopy.Click
        lblError.Text = String.Empty

        If CopyFileTo(Me.FileCopyField.Text.Trim) = True Then
            lblError.Text = ("File Copied OK")
        End If
        PopulateFileList(SessionManager.ImageBrowserLastFolder)
    End Sub

    Private Function CopyFileTo(ByVal newFileName As String) As Boolean
        Dim result As Boolean = False

        Try

            Dim oldPath As String = Path.Combine(Request.PhysicalApplicationPath, SessionManager.ImageBrowserLastFolder)
            Dim oldFile As String = Path.Combine(oldPath, ViewState("SelectedFile"))
            Dim newFile As String = Path.Combine(oldPath, newFileName)

            File.Copy(oldFile, newFile)

            If File.Exists(newFile) = True Then
                result = True
            End If

        Catch ioex As IOException
            lblError.Text = "File IO exception: " & ioex.Message & " - Check ASPNET user account permissions."
        Catch ex As Exception
            lblError.Text = ex.Message
        End Try

        Return result
    End Function

    Private Sub btnFileRename_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnFileRename.Click
        If CopyFileTo(Me.FileRenameField.Text.Trim) = True Then
            DeleteCurrentFile()
            Dim longName As String = Path.Combine(Request.PhysicalApplicationPath, SessionManager.ImageBrowserLastFolder)
            longName = Path.Combine(longName, Me.FileRenameField.Text.Trim)
            SetCurrentImage(Me.FileRenameField.Text.Trim, longName)
        End If
        Me.PopulateFileList(SessionManager.ImageBrowserLastFolder)
    End Sub

End Class

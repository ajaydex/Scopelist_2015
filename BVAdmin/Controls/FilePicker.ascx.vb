Imports BVSoftware.BVC5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Controls_FilePicker
    Inherits System.Web.UI.UserControl

    Private _productId As String = String.Empty
    Public Property ProductId() As String
        Get
            Return _productId
        End Get
        Set(ByVal value As String)
            _productId = value
        End Set
    End Property

    Public Property DisplayShortDescription() As Boolean
        Get
            Return ShortDescriptionRow.Visible
        End Get
        Set(ByVal value As Boolean)
            ShortDescriptionRow.Visible = value
        End Set
    End Property

    Private Enum Mode
        NewUpload = 1
        DropDownList = 2
        FileBrowsed = 3
    End Enum

    Private _currentMode As Mode = Mode.NewUpload

    Protected Sub FileHasBeenSelectedCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles FileHasBeenSelectedCustomValidator.ServerValidate
        args.IsValid = True
        If Not NewFileUpload.HasFile Then
            If FilesDropDownList.Visible Then
                If FilesDropDownList.SelectedIndex = 0 Then
                    args.IsValid = False
                End If
            ElseIf FileSelectedTextBox.Visible Then
                If FileSelectedTextBox.Text.Trim() = String.Empty Then
                    args.IsValid = False
                End If
            Else
                'if we got here, then somehow FilesDropDownList and FileSelectedTextBox are both not visible
                args.IsValid = False
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.RegisterWindowScripts()
        NewFileUpload.Attributes.Add("onchange", "FillFilename(this, ['" & ShortDescriptionTextBox.ClientID & "']);")
        FilesDropDownList.Attributes.Add("onchange", "FillFilename(this, ['" & ShortDescriptionTextBox.ClientID & "']);")
        If Not Page.IsPostBack() Then
            InitializeFileLists()
        End If
        If NewFileUpload.HasFile Then
            _currentMode = Mode.NewUpload
        ElseIf FilesDropDownList.Visible Then
            _currentMode = Mode.DropDownList
        ElseIf FileSelectedTextBox.Visible Then
            _currentMode = Mode.FileBrowsed
        End If

        If Me.ProductId = String.Empty Then
            AvailableMinutesRow.Visible = False
            NumberDownloadsRow.Visible = False
        Else
            AvailableMinutesRow.Visible = True
            NumberDownloadsRow.Visible = True
        End If
    End Sub

    Protected Sub InitializeFileLists()
        If Catalog.ProductFile.GetFileCount() > 30 Then
            FilesDropDownList.Visible = False
            FileSelectedTextBox.Visible = True
            browseButton.Visible = True
        Else
            Dim files As Collection(Of Catalog.ProductFile.FileInfo) = Catalog.ProductFile.GetAllFilesInVault()
            FilesDropDownList.Visible = True
            FileSelectedTextBox.Visible = False
            browseButton.Visible = False

            Dim item As ListItem = FilesDropDownList.Items(0)
            FilesDropDownList.Items.Clear()
            FilesDropDownList.Items.Add(item)

            FilesDropDownList.DataSource = files
            FilesDropDownList.DataTextField = "CombinedDisplay"
            FilesDropDownList.DataValueField = "FileId"
            FilesDropDownList.DataBind()
        End If
    End Sub

    Private Sub RegisterWindowScripts()

        Dim sb As New StringBuilder

        sb.Append("var w;")
        sb.Append("function popUpWindow(parameters) {")
        sb.Append("w = window.open('FileDownloadBrowser.aspx' + parameters, null, 'height=480, width=640, scrollbars=yes');")
        sb.Append("}")

        sb.Append("function closePopup(id, shortDescription, fileName) {")
        sb.Append("w.close();")
        If FileSelectedTextBox.Visible Then
            sb.Append("document.getElementById('" & FileSelectedTextBox.ClientID & "').value = fileName;")
        End If
        If ShortDescriptionTextBox.Visible Then
            sb.Append("document.getElementById('" & ShortDescriptionTextBox.ClientID & "').value = shortDescription;")
        End If
        sb.Append("document.getElementById('" & FileIdHiddenField.ClientID & "').value = id;")
        sb.Append("}")

        sb.Append("String.prototype.trim = function() {")
        sb.Append("    a = this.replace(/^\s+/, '');")
        sb.Append("    return a.replace(/\s+$/, '');")
        sb.Append("};")

        sb.Append("function FillFilename(control, FieldsToFill){")
        sb.Append("    if (control.type == ""select-one""){")
        sb.Append("        if (control.selectedIndex != 0){")
        sb.Append("            for(i = 0; i < FieldsToFill.length; i++){")
        sb.Append("                document.getElementById(FieldsToFill[i]).value = control.options[control.selectedIndex].text.split(""["")[0].trim();")
        sb.Append("            }")
        sb.Append("        } else {")
        sb.Append("            for(i = 0; i < FieldsToFill.length; i++){")
        sb.Append("                document.getElementById(FieldsToFill[i]).value = """";")
        sb.Append("            }")
        sb.Append("        }")
        sb.Append("    } else {")
        sb.Append("        var arr = control.value.split(""\\"");")
        sb.Append("        for(i = 0; i < FieldsToFill.length; i++){")
        sb.Append("            document.getElementById(FieldsToFill[i]).value = arr[arr.length - 1];")
        sb.Append("        }")
        sb.Append("    }")
        sb.Append("}")

        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "WindowScripts", sb.ToString, True)
    End Sub

    Protected Sub DescriptionIsUniqueToProductCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles DescriptionIsUniqueToProductCustomValidator.ServerValidate
        args.IsValid = True
        Dim file As Catalog.ProductFile = Nothing
        If _currentMode = Mode.DropDownList Then
            'file = Catalog.ProductFile.FindByBvin(FilesDropDownList.SelectedValue)
        ElseIf _currentMode = Mode.FileBrowsed Then
            'file = Catalog.ProductFile.FindByBvin(FileIdHiddenField.Value)
        ElseIf _currentMode = Mode.NewUpload Then
            file = New Catalog.ProductFile()
        End If
        If file IsNot Nothing Then
            InitializeProductFile(file, False)
            Dim result As Collection(Of String) = Catalog.ProductFile.FindByFileNameAndDescription(file.FileName, ShortDescriptionTextBox.Text)
            If result.Count > 0 Then
                args.IsValid = False
            End If
        End If
    End Sub

    Protected Sub InitializeProductFile(ByVal file As Catalog.ProductFile, ByVal updateFileName As Boolean)
        If updateFileName Then
            Dim otherFile As Catalog.ProductFile = Nothing
            If _currentMode = Mode.DropDownList Then
                otherFile = Catalog.ProductFile.FindByBvin(FilesDropDownList.SelectedValue)
                file.Bvin = otherFile.Bvin
                file.FileName = otherFile.FileName
            ElseIf _currentMode = Mode.FileBrowsed Then
                otherFile = Catalog.ProductFile.FindByBvin(FileIdHiddenField.Value)
                file.Bvin = otherFile.Bvin
                file.FileName = otherFile.FileName
            ElseIf _currentMode = Mode.NewUpload Then
                file.FileName = System.IO.Path.GetFileName(NewFileUpload.FileName)
            End If
        Else
            If _currentMode = Mode.NewUpload Then
                file.FileName = System.IO.Path.GetFileName(NewFileUpload.FileName)
            End If
        End If
        
        If Me.DisplayShortDescription Then
            file.ShortDescription = ShortDescriptionTextBox.Text.Trim()
        End If

        If Me.ProductId <> String.Empty Then
            file.ProductId = Me.ProductId
            file.SetMinutes(AvailableForTimespanPicker.Months, AvailableForTimespanPicker.Days, AvailableForTimespanPicker.Hours, AvailableForTimespanPicker.Minutes)
            If NumberOfDownloadsTextBox.Text.Trim() <> String.Empty Then
                file.MaxDownloads = CInt(NumberOfDownloadsTextBox.Text)
            Else
                file.MaxDownloads = 0
            End If
        End If
    End Sub

    Public Sub Clear()
        ShortDescriptionTextBox.Text = ""
        AvailableForTimespanPicker.Months = 0
        AvailableForTimespanPicker.Days = 0
        AvailableForTimespanPicker.Hours = 0
        AvailableForTimespanPicker.Minutes = 0
        NumberOfDownloadsTextBox.Text = ""
    End Sub

    Protected Sub FileIsUniqueToProductCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles FileIsUniqueToProductCustomValidator.ServerValidate
        Dim files As Collection(Of Catalog.ProductFile) = Catalog.ProductFile.FindByProductId(Me.ProductId)
        args.IsValid = True
        For Each file As Catalog.ProductFile In files
            If _currentMode = Mode.DropDownList Then
                If file.Bvin = FilesDropDownList.SelectedValue Then
                    args.IsValid = False
                End If
            ElseIf _currentMode = Mode.FileBrowsed Then
                If file.Bvin = FileIdHiddenField.Value Then
                    args.IsValid = False
                End If
            End If
        Next
    End Sub

    Public Sub DownloadOrLinkFile(ByVal file As Catalog.ProductFile, ByVal MessageBox1 As ASP.bvadmin_controls_messagebox_ascx)
        'if they browsed a file then this overrides all other behavior
        If _currentMode = Mode.NewUpload Then
            If file Is Nothing Then
                file = New Catalog.ProductFile()
            End If
            InitializeProductFile(file, True)

            If Catalog.ProductFile.Save(file) Then
                If Catalog.ProductFile.SaveFile(file.Bvin, file.FileName, Server.MapPath(Request.ApplicationPath), NewFileUpload.FileContent) Then
                    MessageBox1.ShowOk("File saved to server successfully")
                Else
                    MessageBox1.ShowError("There was an error while trying to save your file to the file system. Please check your asp.net permissions.")
                End If
            Else
                MessageBox1.ShowError("There was an error while trying to save your file to the database.")
            End If

        ElseIf _currentMode = Mode.DropDownList Then
            If FilesDropDownList.SelectedValue.Trim() <> "" Then
                If file Is Nothing Then
                    file = New Catalog.ProductFile()
                End If
                InitializeProductFile(file, True)

                If Catalog.ProductFile.Save(file) Then
                    MessageBox1.ShowOk("File saved to server successfully")
                Else
                    MessageBox1.ShowError("There was an error while trying to save your file to the database.")
                End If
            End If
        ElseIf _currentMode = Mode.FileBrowsed Then
            If file Is Nothing Then
                file = New Catalog.ProductFile()                
            End If
            InitializeProductFile(file, True)
            If Catalog.ProductFile.Save(file) Then
                MessageBox1.ShowOk("File saved to server successfully")
            Else
                MessageBox1.ShowError("There was an error while trying to save your file to the database.")
            End If
        End If
        InitializeFileLists()
    End Sub
End Class

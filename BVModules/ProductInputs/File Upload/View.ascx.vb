Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVModules_ProductInputs_File_Upload_View
    Inherits ProductInputTemplate

    Protected required As Boolean
    Protected wrapText As Boolean

    Private generatedFileName As String

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            InputRequiredFieldValidator.Validate()
            Return InputRequiredFieldValidator.IsValid
        End Get
    End Property

    Private Sub LoadSettings()
        Me.displayName = SettingsManager.GetSetting("DisplayName")
        required = SettingsManager.GetBooleanSetting("Required")
    End Sub

    Protected Sub Display()
        If displayName <> String.Empty Then
            InputLabel.Visible = True
            InputLabel.Text = displayName
        Else
            InputLabel.Visible = False
        End If

        'do not require file upload if a file has already previously been selected
        If String.IsNullOrEmpty(ViewState("FileUpload")) Then
            InputRequiredFieldValidator.Enabled = required
        Else
            InputRequiredFieldValidator.Enabled = False
        End If

    End Sub

    Public Overrides Sub InitializeDisplay()
        LoadSettings()
        Display()
    End Sub

    Public Sub PageLoad(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        'upload the file on page load as GetValue is called three times
        If IsPostBack AndAlso InputFileUpload.HasFile Then
            Dim filename As String = Me.GetValue()
            InputFileUpload.SaveAs(filename.Replace(WebAppSettings.SiteStandardRoot, Request.PhysicalApplicationPath).Replace("/", "\"))
            Me.SetValue(filename)   'retain file in case we have a validation error so user will not have to re-upload it
        End If
    End Sub

    Public Overrides Function GetValue() As String
        'generate filename only if we have not already generated it (should only be on initial page load when the file is uploaded)
        If generatedFileName Is Nothing Then
            If InputFileUpload.HasFile Then
                generatedFileName = InputFileUpload.FileName
                Dim extensionStartPosition As Integer = InputFileUpload.FileName.LastIndexOf(".")
                generatedFileName = generatedFileName.Substring(0, extensionStartPosition) + "-" + Guid.NewGuid.ToString() + generatedFileName.Substring(extensionStartPosition)
                generatedFileName = WebAppSettings.SiteStandardRoot + "files/productinputs/" + generatedFileName
            ElseIf Not String.IsNullOrEmpty(ViewState("FileUpload")) Then
                'Retain initial file string if no file uploaded
                generatedFileName = ViewState("FileUpload")
            End If
        End If
        Return generatedFileName
    End Function

    Public Overrides Sub SetValue(ByVal value As String)
        If value IsNot Nothing AndAlso value <> String.Empty Then
            generatedFileName = value
            PreviousFile.Visible = True     'show previously uploaded file (visible only if there is one)
            If Me.IsViewableImage(value) Then
                imgPreviousFile.ImageUrl = value
            Else
                'if uploaded image is in a file format not viewable by a browser, show a default image with overlay text
                overlayText.Visible = True
                overlayText.Text = value.Split(".")(value.Split(".").Length - 1)
                imgPreviousFile.ImageUrl = "~/images/attachment.png"
            End If
            ViewState("FileUpload") = value                 'hold initial value in case user does not upload a new file
            InputRequiredFieldValidator.Enabled = False     'don't require file upload if a file has already previously been uploaded
        End If
    End Sub

    Private Function IsViewableImage(ByVal img As String) As Boolean
        Dim result As Boolean = False

        Dim viewableTypes As New List(Of String)(New String() {".jpg", ".jpeg", ".gif", ".png", ".svg", ".bmp"})
        For Each t As String In viewableTypes
            If img.EndsWith(t) Then
                result = True
                Exit For
            End If
        Next

        Return result
    End Function

End Class
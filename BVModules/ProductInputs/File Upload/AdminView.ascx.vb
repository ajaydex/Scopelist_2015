Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVModules_ProductInputs_File_Upload_AdminView
    Inherits ProductInputTemplate

    Protected required As Boolean

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            Return True
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

        'InputRequiredFieldValidator.Enabled = required
    End Sub

    Public Overrides Sub InitializeDisplay()
        LoadSettings()
        Display()
    End Sub

    Public Overrides Function GetValue() As String
        Return InputFileUpload.FileName
    End Function

    Public Overrides Sub SetValue(ByVal value As String)
        'not used in admin mode
    End Sub
End Class

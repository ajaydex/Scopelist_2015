Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVModules_ProductInputs_Text_Input_ProductInputView
    Inherits ProductInputTemplate

    Protected required As Boolean
    Protected wrapText As Boolean
    Protected numRows As Integer
    Protected numColumns As Integer

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            Return True
        End Get
    End Property

    Private Sub LoadSettings()
        Me.displayName = SettingsManager.GetSetting("DisplayName")
        required = SettingsManager.GetBooleanSetting("Required")
        wrapText = SettingsManager.GetBooleanSetting("WrapText")
        numRows = SettingsManager.GetIntegerSetting("Rows")
        numColumns = SettingsManager.GetIntegerSetting("Columns")
    End Sub

    Protected Sub Display()
        If displayName <> String.Empty Then
            InputLabel.Visible = True
            InputLabel.Text = displayName
        Else
            InputLabel.Visible = False
        End If

        'InputRequiredFieldValidator.Enabled = required

        InputTextBox.Rows = numRows
        If numRows = 1 Then
            InputTextBox.TextMode = TextBoxMode.SingleLine
        Else
            InputTextBox.TextMode = TextBoxMode.MultiLine
        End If
        InputTextBox.Columns = numColumns
        InputTextBox.Wrap = wrapText
    End Sub

    Public Overrides Sub InitializeDisplay()
        LoadSettings()
        Display()
    End Sub

    Public Overrides Function GetValue() As String
        Return InputTextBox.Text
    End Function

    Public Overrides Sub SetValue(ByVal value As String)
        'not used in admin mode
    End Sub
End Class

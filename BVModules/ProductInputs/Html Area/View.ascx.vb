Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVModules_ProductInputs_Text_Input_ProductInputView
    Inherits ProductInputTemplate

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub Display()
        HtmlAreaLiteral.Text = SettingsManager.GetSetting("Html")
    End Sub

    Public Overrides Sub InitializeDisplay()
        Display()
    End Sub

    Public Overrides Function GetValue() As String
        Return ""
    End Function

    Public Overrides Sub SetValue(ByVal value As String)
        'nothing to set
    End Sub
End Class

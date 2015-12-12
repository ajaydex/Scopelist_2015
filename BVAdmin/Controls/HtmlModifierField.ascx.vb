Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_HtmlModifierField
    Inherits Controls.ModificationControl(Of String)

    Private Enum Modes
        SetTo = 0
        AppendTo = 1
    End Enum

    Public Overloads Overrides Function ApplyChanges(ByVal item As String) As String
        If HtmlDropDownList.SelectedIndex = Modes.SetTo Then
            Return HtmlEditor.Text
        ElseIf HtmlDropDownList.SelectedIndex = Modes.AppendTo Then
            Return item & HtmlEditor.Text
        End If
        Return item
    End Function
End Class

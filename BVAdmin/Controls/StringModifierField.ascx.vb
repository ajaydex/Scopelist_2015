Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_StringModifierField
    Inherits Controls.ModificationControl(Of String)
    Implements Controls.ITextBoxBasedControl

    Private Enum Modes
        SetTo = 0
        AppendTo = 1
        RemoveFromEnd = 2
    End Enum

    Public Sub AddTextBoxAttribute(ByVal key As String, ByVal value As String) Implements BVSoftware.Bvc5.Core.Controls.ITextBoxBasedControl.AddTextBoxAttribute
        Me.StringTextBox.Attributes.Add(key, value)
    End Sub

    Public Overrides Function ApplyChanges(ByVal item As String) As String
        If Me.StringDropDownList.SelectedIndex = Modes.SetTo Then
            Return Me.StringTextBox.Text
        ElseIf Me.StringDropDownList.SelectedIndex = Modes.AppendTo Then
            Return item & Me.StringTextBox.Text
        ElseIf Me.StringDropDownList.SelectedIndex = Modes.RemoveFromEnd Then
            If item.EndsWith(Me.StringTextBox.Text) Then
                Return item.Remove(item.LastIndexOf(Me.StringTextBox.Text))
            End If
            Return item
        End If
        Return item
    End Function
End Class

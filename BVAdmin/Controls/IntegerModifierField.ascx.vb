Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_IntegerModifierField
    Inherits Controls.ModificationControl(Of Integer)
    Implements Controls.ITextBoxBasedControl

    Private Enum Modes
        SetTo = 0
        AddTo = 1
        SubtractFrom = 2
    End Enum

    Public Sub AddTextBoxAttribute(ByVal key As String, ByVal value As String) Implements BVSoftware.Bvc5.Core.Controls.ITextBoxBasedControl.AddTextBoxAttribute
        Me.IntegerTextBox.Attributes.Add(key, value)
    End Sub

    Public Overloads Overrides Function ApplyChanges(ByVal item As Integer) As Integer
        Dim val As Integer = 0
        If Integer.TryParse(Me.IntegerTextBox.Text, val) Then
            If Me.IntegerDropDownList.SelectedIndex = Modes.SetTo Then
                Return val
            ElseIf Me.IntegerDropDownList.SelectedIndex = Modes.AddTo Then
                Return (item + val)
            ElseIf Me.IntegerDropDownList.SelectedIndex = Modes.SubtractFrom Then
                Return (item - val)
            End If
        Else
            Return item
        End If
    End Function
End Class

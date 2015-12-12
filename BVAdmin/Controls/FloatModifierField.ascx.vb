Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_FloatModifierField
    Inherits Controls.ModificationControl(Of Double)
    Implements Controls.ITextBoxBasedControl

    Private Enum Modes
        SetTo = 0
        AddTo = 1
        SubtractFrom = 2
    End Enum

    Public Sub AddTextBoxAttribute(ByVal key As String, ByVal value As String) Implements BVSoftware.Bvc5.Core.Controls.ITextBoxBasedControl.AddTextBoxAttribute
        Me.FloatTextBox.Attributes.Add(key, value)
    End Sub

    Public Overloads Overrides Function ApplyChanges(ByVal item As Double) As Double
        If Me.FloatDropDownList.SelectedIndex = Modes.SetTo Then
            Dim val As Double = 0
            If Double.TryParse(Me.FloatTextBox.Text, val) Then
                Return val
            Else
                Return item
            End If
        ElseIf Me.FloatDropDownList.SelectedIndex = Modes.AddTo Then
            Dim val As Double = 0
            If Double.TryParse(Me.FloatTextBox.Text, val) Then
                Return (item + val)
            Else
                Return item
            End If
        ElseIf Me.FloatDropDownList.SelectedIndex = Modes.SubtractFrom Then
            Dim val As Double = 0
            If Double.TryParse(Me.FloatTextBox.Text, val) Then
                Return (item - val)
            Else
                Return item
            End If
        End If
    End Function
End Class

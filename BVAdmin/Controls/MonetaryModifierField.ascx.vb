Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_MonetaryModifierField
    Inherits Controls.ModificationControl(Of Decimal)
    Implements Controls.ITextBoxBasedControl

    Private Enum Modes
        SetTo = 0
        IncreaseByAmount = 1
        DecreaseByAmount = 2
        IncreaseByPercent = 3
        DecreaseByPercent = 4
    End Enum

    Public Sub AddTextBoxAttribute(ByVal key As String, ByVal value As String) Implements BVSoftware.Bvc5.Core.Controls.ITextBoxBasedControl.AddTextBoxAttribute
        MonetaryTextBox.Attributes.Add(key, value)
    End Sub

    Public Overloads Overrides Function ApplyChanges(ByVal item As Decimal) As Decimal
        Dim val As Decimal = 0
        If Decimal.TryParse(Me.MonetaryTextBox.Text, val) Then
            If Me.MonetaryDropDownList.SelectedIndex = Modes.SetTo Then
                Return val
            ElseIf Me.MonetaryDropDownList.SelectedIndex = Modes.IncreaseByAmount Then
                Return Utilities.Money.ApplyIncreasedAmount(item, val)
            ElseIf Me.MonetaryDropDownList.SelectedIndex = Modes.DecreaseByAmount Then
                Return Utilities.Money.ApplyDiscountAmount(item, val)
            ElseIf Me.MonetaryDropDownList.SelectedIndex = Modes.IncreaseByPercent Then
                Return Utilities.Money.ApplyIncreasedPercent(item, val)
            ElseIf Me.MonetaryDropDownList.SelectedIndex = Modes.DecreaseByPercent Then
                Return Utilities.Money.ApplyDiscountPercent(item, val)
            End If
        Else
            Return item
        End If
    End Function

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate

    End Sub
End Class

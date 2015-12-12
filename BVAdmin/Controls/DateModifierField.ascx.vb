Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_DateModifierField
    Inherits Controls.ModificationControl(Of Date)

    Private Enum Modes
        SetTo = 0
        AddDays = 1
        SubtractDays = 2
        AddMonths = 3
        SubtractMonths = 4
        AddYears = 5
        SubtractYears = 6
    End Enum

    Public Sub InitializeValue(ByVal val As String)
        Me.DateTextBox.Text = val
    End Sub

    Public Overrides Function ApplyChanges(ByVal item As Date) As Date
        Dim num As Integer = 0
        Try
            If DateDropDownList.SelectedIndex > Modes.SetTo Then
                If Not Integer.TryParse(DateTextBox.Text, num) Then
                    num = 0
                End If
            End If
            If DateDropDownList.SelectedIndex = Modes.SetTo Then
                Dim val As Date
                If Date.TryParse(DateTextBox.Text, val) Then
                    Return val
                Else
                    Return item
                End If
            ElseIf DateDropDownList.SelectedIndex = Modes.AddDays Then
                Return item.AddDays(num)
            ElseIf DateDropDownList.SelectedIndex = Modes.SubtractDays Then
                Return item.AddDays((num * -1))
            ElseIf DateDropDownList.SelectedIndex = Modes.AddMonths Then
                Return item.AddMonths(num)
            ElseIf DateDropDownList.SelectedIndex = Modes.SubtractMonths Then
                Return item.AddMonths((num * -1))
            ElseIf DateDropDownList.SelectedIndex = Modes.AddYears Then
                Return item.AddYears(num)
            ElseIf DateDropDownList.SelectedIndex = Modes.SubtractYears Then
                Return item.AddYears((num * -1))
            End If
        Catch ex As ArgumentOutOfRangeException
            Return item
        End Try
    End Function

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        If args.Value <> String.Empty Then
            If DateDropDownList.SelectedIndex = Modes.SetTo Then
                If Not Date.TryParse(args.Value, Nothing) Then
                    DirectCast(source, CustomValidator).ErrorMessage = "Field must be a valid date."
                    args.IsValid = False
                End If
            Else
                If Not Integer.TryParse(args.Value, Nothing) Then
                    DirectCast(source, CustomValidator).ErrorMessage = "Field must be a number"
                    args.IsValid = False
                End If
            End If
        End If
    End Sub
End Class

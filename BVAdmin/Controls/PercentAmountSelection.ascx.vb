
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_PercentAmountSelection
    Inherits System.Web.UI.UserControl

    Private _validationGroup As String = String.Empty

    Public Property AmountType() As Marketing.AmountTypes
        Get
            Return AmountDropDownList.SelectedIndex
        End Get
        Set(ByVal value As Marketing.AmountTypes)
            AmountDropDownList.SelectedIndex = value
        End Set
    End Property

    Public Property Amount() As Decimal
        Get
            Return Decimal.Parse(AmountTextBox.Text, System.Globalization.NumberStyles.Currency)
        End Get
        Set(ByVal value As Decimal)
            If Me.AmountType = Marketing.AmountTypes.MonetaryAmount Then
                AmountTextBox.Text = value.ToString("c")
            Else
                AmountTextBox.Text = value.ToString()
            End If

        End Set
    End Property

    Public Property ValidationGroup() As String
        Get
            Return _validationGroup
        End Get
        Set(ByVal value As String)
            _validationGroup = value
            PercentCustomValidator.ValidationGroup = _validationGroup
        End Set
    End Property

    Protected Sub PercentCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles PercentCustomValidator.ServerValidate
        If AmountDropDownList.SelectedIndex = Marketing.AmountTypes.Percent Then
            If TypeOf source Is CustomValidator Then
                DirectCast(source, CustomValidator).ErrorMessage = "Percent must be between 0.00 and 100.00 percent."
            End If
            Dim val As Decimal = 0
            If Decimal.TryParse(AmountTextBox.Text, System.Globalization.NumberStyles.Number, Threading.Thread.CurrentThread.CurrentUICulture, val) Then
                If val < 0 OrElse val > 100 Then
                    args.IsValid = False
                End If
            Else
                args.IsValid = False
            End If
        ElseIf AmountDropDownList.SelectedIndex = Marketing.AmountTypes.MonetaryAmount Then
            If TypeOf source Is CustomValidator Then
                DirectCast(source, CustomValidator).ErrorMessage = "Value must be a monetary amount."
            End If
            Dim val As Decimal = 0
            If Decimal.TryParse(AmountTextBox.Text, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, val) Then
                If val < 0 Then
                    args.IsValid = False
                End If
            Else
                args.IsValid = False
            End If
        End If
    End Sub
End Class

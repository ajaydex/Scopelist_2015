Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.Content

Partial Class BVModules_ProductChoices_DropDownList_ProductChoiceView
    Inherits ProductChoiceTemplate

    Protected choice As New Catalog.ProductChoice

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            InputRequiredFieldValidator.Validate()
            Return InputRequiredFieldValidator.IsValid
        End Get
    End Property

    Private Sub LoadSettings()
        choice = DirectCast(Me.Product.ChoicesAndInputs.FindBusinessObject(Me.BlockId), Catalog.ProductChoice)
    End Sub

    Protected Sub Display()
        If choice.DisplayName <> String.Empty Then
            InputLabel.Visible = True
            InputLabel.Text = choice.DisplayName
        Else
            InputLabel.Visible = False
        End If
        Me.ChoiceRadioButtonList.DataSource = choice.ChoiceOptions
        Me.ChoiceRadioButtonList.DataTextField = "DisplayText"
        Me.ChoiceRadioButtonList.DataValueField = "bvin"
        Me.ChoiceRadioButtonList.DataBind()

        For Each item As Catalog.ProductChoiceOption In choice.ChoiceOptions
            If item.IsDefault Then
                Me.ChoiceRadioButtonList.SelectedValue = item.Bvin
            End If
            If item.IsNull Then
                Me.InputRequiredFieldValidator.InitialValue = item.Bvin
            End If
        Next
    End Sub

    Public Overrides Sub InitializeDisplay()
        LoadSettings()
        Display()
    End Sub

    Public Overrides Function GetValue() As String
        Return ChoiceRadioButtonList.SelectedValue
    End Function

    Protected Sub ChoiceList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChoiceRadioButtonList.SelectedIndexChanged
        MyBase.RaiseSelectionChangedEvent()
    End Sub

    Public Overrides Sub SetValue(ByVal value As String)
        ChoiceRadioButtonList.SelectedValue = value
    End Sub
End Class

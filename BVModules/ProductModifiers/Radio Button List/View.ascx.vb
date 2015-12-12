Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.Content

Partial Class BVModules_ProductModifiers_DropDownList_ProductModifierView
    Inherits ProductModifierTemplate

    Protected modifier As New Catalog.ProductModifier

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            InputRequiredFieldValidator.Validate()
            Return InputRequiredFieldValidator.IsValid
        End Get
    End Property

    Private Sub LoadSettings()
        modifier = DirectCast(Me.Product.ChoicesAndInputs.FindBusinessObject(Me.BlockId), Catalog.ProductModifier)
        Me.displayName = modifier.DisplayName
    End Sub

    Protected Sub Display()
        If modifier.DisplayName <> String.Empty Then
            InputLabel.Visible = True
            InputLabel.Text = modifier.DisplayName
        Else
            InputLabel.Visible = False
        End If
        Me.ModifierRadioButtonList.DataSource = modifier.ModifierOptions
        Me.ModifierRadioButtonList.DataTextField = "DisplayText"
        Me.ModifierRadioButtonList.DataValueField = "bvin"
        Me.ModifierRadioButtonList.DataBind()

        Me.InputRequiredFieldValidator.Enabled = modifier.Required

        For Each item As ListItem In Me.ModifierRadioButtonList.Items            
            Dim modifierOption As Catalog.ProductModifierOption = Catalog.ProductModifierOption.FindByBvin(item.Value)
            If modifierOption.IsNull Then
                Me.InputRequiredFieldValidator.InitialValue = item.Value
            End If
            If modifierOption.IsDefault Then
                item.Selected = True
            Else
                item.Selected = False
            End If
        Next
    End Sub

    Public Overrides Sub InitializeDisplay()
        LoadSettings()
        Display()
    End Sub

    Public Overrides Function GetValue() As String
        Return ModifierRadioButtonList.SelectedValue
    End Function

    Protected Sub ModifierList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ModifierRadioButtonList.SelectedIndexChanged
        MyBase.RaiseSelectionChangedEvent()
    End Sub

    Public Overrides Sub SetValue(ByVal value As String)
        ModifierRadioButtonList.SelectedValue = value
    End Sub
End Class

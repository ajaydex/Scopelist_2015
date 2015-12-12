Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.Content

Partial Class BVModules_ProductModifiers_DropDownList_View
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

        Me.ModifierList.Items.Clear()

        Me.InputRequiredFieldValidator.Enabled = modifier.Required

        Dim firstNullBvin As String = String.Empty

        For Each item As Catalog.ProductModifierOption In modifier.ModifierOptions
            ' store first null item bvin so other nulls can use it.
            If item.IsNull AndAlso String.IsNullOrEmpty(firstNullBvin) Then
                Me.InputRequiredFieldValidator.InitialValue = item.Bvin
                firstNullBvin = item.Bvin
            End If

            ' add +/- adjustment to dropdown
            'Dim li As New ListItem(item.DisplayText, item.Bvin)
            Dim li As New System.Web.UI.WebControls.ListItem()
            li.Value = item.Bvin
            li.Text = item.DisplayText
            If item.PriceAdjustment <> 0 Then
                If item.PriceAdjustment > 0 Then
                    li.Text &= " +"
                Else
                    li.Text &= " -"
                End If
                li.Text &= Math.Abs(item.PriceAdjustment).ToString("c")
            End If

            If item.IsDefault Then
                li.Selected = True
            End If

            ' if this item is null always use the same null value
            If item.IsNull Then
                li.Value = firstNullBvin
            End If

            Me.ModifierList.Items.Add(li)
        Next
    End Sub

    Public Overrides Sub InitializeDisplay()
        LoadSettings()
        Display()
    End Sub

    Public Overrides Function GetValue() As String
        Return ModifierList.SelectedValue
    End Function

    Protected Sub ChoiceList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ModifierList.SelectedIndexChanged
        MyBase.RaiseSelectionChangedEvent()
    End Sub

    Public Overrides Sub SetValue(ByVal value As String)
        Me.ModifierList.SelectedValue = value
    End Sub

End Class
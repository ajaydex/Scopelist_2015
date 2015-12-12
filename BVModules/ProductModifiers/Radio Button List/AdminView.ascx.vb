Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.Content

Partial Class BVModules_ProductModifiers_Drop_Down_List_AdminView
    Inherits ProductModifierTemplate

    Protected modifier As New Catalog.ProductModifier

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            Return True
        End Get
    End Property

    Private Sub LoadSettings()
        modifier = DirectCast(Me.Product.ChoicesAndInputs.FindBusinessObject(Me.BlockId), Catalog.ProductModifier)
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
        'not used in admin mode
    End Sub
End Class

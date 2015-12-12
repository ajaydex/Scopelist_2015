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
        Me.ChoiceList.DataSource = choice.ChoiceOptions
        Me.ChoiceList.DataTextField = "DisplayText"
        Me.ChoiceList.DataValueField = "bvin"
        Me.ChoiceList.DataBind()

        For Each item As Catalog.ProductChoiceOption In choice.ChoiceOptions
            If item.IsDefault Then
                Me.ChoiceList.SelectedValue = item.Bvin                
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
        Return ChoiceList.SelectedValue
    End Function

    Protected Sub ChoiceList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChoiceList.SelectedIndexChanged
        MyBase.RaiseSelectionChangedEvent()
    End Sub

    Public Overrides Sub SetValue(ByVal value As String)
        Me.ChoiceList.SelectedValue = value
    End Sub
End Class

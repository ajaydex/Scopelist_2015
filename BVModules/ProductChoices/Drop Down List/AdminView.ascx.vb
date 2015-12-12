Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.Content

Partial Class BVModules_ProductChoices_Drop_Down_List_AdminView
    Inherits ProductChoiceTemplate

    Protected choice As New Catalog.ProductChoice

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            Return True
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
        'not used in adminview
    End Sub
End Class

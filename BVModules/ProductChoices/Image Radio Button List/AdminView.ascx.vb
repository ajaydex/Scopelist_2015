Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.Content

Partial Class BVModules_ProductChoices_Image_Radio_Button_List_AdminView
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

        Me.ChoiceList2.Items.Clear()

        Dim firstNullBvin As String = String.Empty

        For Each item As Catalog.ProductChoiceOption In choice.ChoiceOptions
            ' store first null item bvin so other nulls can use it.
            If item.IsNull AndAlso String.IsNullOrEmpty(firstNullBvin) Then
                Me.InputRequiredFieldValidator.InitialValue = item.Bvin
                firstNullBvin = item.Bvin
            End If

            Dim optionSettingsManager As New Datalayer.ComponentSettingsManager(item.Bvin)

            Dim li As New System.Web.UI.WebControls.ListItem()
            li.Value = item.Bvin
            li.Text = String.Format("<img src=""{0}"" alt=""{1}"" />", Page.ResolveUrl("~/" + optionSettingsManager.GetSetting("ImageUrl")), item.DisplayText)

            If item.IsDefault Then
                Me.ChoiceList2.SelectedValue = item.Bvin
            End If

            ' if this item is null always use the same null value
            If item.IsNull Then
                li.Value = firstNullBvin
            End If

            Me.ChoiceList2.Items.Add(li)
        Next
    End Sub

    Public Overrides Sub InitializeDisplay()
        LoadSettings()
        Display()
    End Sub

    Public Overrides Function GetValue() As String
        Return ChoiceList2.SelectedValue
    End Function

    Protected Sub ChoiceList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChoiceList2.SelectedIndexChanged
        MyBase.RaiseSelectionChangedEvent()
    End Sub

    Public Overrides Sub SetValue(ByVal value As String)
        Me.ChoiceList2.SelectedValue = value
    End Sub

End Class
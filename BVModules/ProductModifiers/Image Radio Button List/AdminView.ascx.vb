Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.Content

Partial Class BVModules_ProductModifiers_Image_Radio_Button_List_AdminView
    Inherits ProductModifierTemplate

    Protected modifier As New Catalog.ProductModifier

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            Return True
        End Get
    End Property

    Public Property NullValue() As String
        Get
            Dim obj As Object = ViewState("NullValue")
            If obj IsNot Nothing Then
                Return CStr(obj)
            Else
                Return String.Empty
            End If
        End Get
        Set(ByVal value As String)
            ViewState("NullValue") = value
        End Set
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

        Me.InputRequiredFieldValidator.Enabled = False

        Dim firstNullBvin As String = String.Empty

        For Each item As Catalog.ProductModifierOption In modifier.ModifierOptions
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

    Protected Sub ModifierList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ModifierList.SelectedIndexChanged
        MyBase.RaiseSelectionChangedEvent()
    End Sub

    Public Overrides Sub SetValue(ByVal value As String)
        Me.ModifierList.SelectedValue = value
    End Sub

End Class
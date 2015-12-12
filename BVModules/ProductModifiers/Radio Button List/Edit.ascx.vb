Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVModules_ProductModifiers_DropDownList_ProductModifierEdit
    Inherits ProductModifierTemplate

    Private _primaryKey As String
    Private _modifier As Catalog.ProductModifier

    Private Enum Views
        MultiEditView = 0
        SingleEditView = 1
    End Enum

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub newModifierOptionButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles newModifierOptionButton.Click
        'create our new modifier item
        Dim modifierOption As Catalog.ProductModifierOption = New Catalog.ProductModifierOption()
        _modifier.ModifierOptions.Add(modifierOption)
        ViewState("itemId") = modifierOption.Bvin
        ViewState("type") = "new"
        InitializeModifierOptionForm(modifierOption)
        ProductModifierMultiView.ActiveViewIndex = Views.SingleEditView
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.Mode = Modes.Edit
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        _modifier = Me.Product.ChoicesAndInputs.FindBusinessObject(Me.BlockId)
        If Not Page.IsPostBack Then
            InitializeFields()
            BindModifierOptions()
        End If
    End Sub

    Protected Sub InitializeFields()
        NameTextBox.Text = _modifier.Name
        DisplayNameTextBox.Text = _modifier.DisplayName
        RequiredCheckBox.Checked = _modifier.Required
    End Sub

    Protected Sub BindModifierOptions()
        ModifiersGridView.EditIndex = -1
        ModifiersGridView.DataSource = _modifier.ModifierOptions.GetNonDeletedItems()
        ModifiersGridView.DataKeyNames = New String() {"Bvin"}
        ModifiersGridView.DataBind()
    End Sub

    Protected Sub ModifierOptionSaveButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ModifierOptionContinueButton.Click
        If Page.IsValid Then
            If ModifierOptionDefaultItemCheckBox.Checked Then
                For Each item As Catalog.ProductModifierOption In _modifier.ModifierOptions
                    item.IsDefault = False
                Next
            End If

            Dim modifierOption As Catalog.ProductModifierOption = _modifier.ModifierOptions.FindBusinessObject(ViewState("itemId"))
            modifierOption.DisplayText = ModifierOptionDisplayNameTextBox.Text
            modifierOption.IsNull = NullItemCheckBox.Checked
            modifierOption.IsDefault = ModifierOptionDefaultItemCheckBox.Checked
            modifierOption.PriceAdjustment = Decimal.Parse(ModifierOptionPriceAdjustmentTextBox.Text, System.Globalization.NumberStyles.Currency)
            modifierOption.WeightAdjustment = Decimal.Parse(ModifierOptionWeightAdjustmentTextBox.Text, System.Globalization.NumberStyles.Currency)
            modifierOption.ShippingAdjustment = Decimal.Parse(ModifierOptionShippingAdjustmentTextBox.Text, System.Globalization.NumberStyles.Currency)
            ProductModifierMultiView.ActiveViewIndex = Views.MultiEditView
            BindModifierOptions()
        End If
    End Sub

    Protected Sub InitializeModifierOptionForm(ByVal modifierOption As Catalog.ProductModifierOption)
        ModifierOptionDisplayNameTextBox.Text = modifierOption.DisplayText
        NullItemCheckBox.Checked = modifierOption.IsNull
        ModifierOptionDefaultItemCheckBox.Checked = modifierOption.IsDefault
        ModifierOptionPriceAdjustmentTextBox.Text = modifierOption.PriceAdjustment.ToString("c")
        ModifierOptionWeightAdjustmentTextBox.Text = modifierOption.WeightAdjustment.ToString("N")
        ModifierOptionShippingAdjustmentTextBox.Text = modifierOption.ShippingAdjustment.ToString("c")
    End Sub

    Protected Sub ModifiersGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles ModifiersGridView.RowCommand
        If e.CommandName = "MoveItem" Then
            If TypeOf e.CommandSource Is ImageButton Then
                Dim row As GridViewRow = DirectCast(DirectCast(e.CommandSource, ImageButton).Parent.Parent, GridViewRow)
                _primaryKey = DirectCast(sender, GridView).DataKeys(row.RowIndex).Value
                'even though on the gridview it looks like down, we are actually moving it "up"
                'in the list because the first item in the grid is index 0. so moving it down is actually
                'moving it to index 1 in the list, so it is up in the list
                If e.CommandArgument = "Down" Then
                    _modifier.ModifierOptions.MoveUp(_primaryKey)
                ElseIf e.CommandArgument = "Up" Then
                    _modifier.ModifierOptions.MoveDown(_primaryKey)
                End If
                BindModifierOptions()
            End If
        End If
    End Sub

    Protected Sub ModifiersGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles ModifiersGridView.RowDeleting
        _primaryKey = DirectCast(sender, GridView).DataKeys(e.RowIndex).Value
        _modifier.ModifierOptions.MarkAsDeleted(_primaryKey)
        BindModifierOptions()
    End Sub

    Protected Sub ModifiersGridView_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles ModifiersGridView.RowEditing
        _primaryKey = DirectCast(sender, GridView).DataKeys(e.NewEditIndex).Value
        ViewState("itemId") = _primaryKey
        ViewState("type") = "edit"
        InitializeModifierOptionForm(_modifier.ModifierOptions.FindBusinessObject(_primaryKey))
        ProductModifierMultiView.ActiveViewIndex = Views.SingleEditView
    End Sub

    Protected Sub SaveChangesButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ContinueChangesButton.Click
        _modifier.Name = NameTextBox.Text
        _modifier.DisplayName = DisplayNameTextBox.Text
        _modifier.Required = RequiredCheckBox.Checked
        NotifyFinishedEditing()
    End Sub

    Protected Sub ModifierOptionCancelButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ModifierOptionCancelButton.Click
        If ViewState("type") = "new" Then
            _modifier.ModifierOptions.Remove(_modifier.ModifierOptions.FindBusinessObject(ViewState("itemId")))
        End If
        ProductModifierMultiView.ActiveViewIndex = Views.MultiEditView
        BindModifierOptions()
    End Sub

    Protected Sub CancelButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelButton.Click
        NotifyFinishedEditing("Canceled")
    End Sub

    Public Overrides Sub InitializeDisplay()
        'not used in edit mode
    End Sub

    Public Overrides Function GetValue() As String
        'not used in edit mode
        Return String.Empty
    End Function

    Public Overrides Sub SetValue(ByVal value As String)
        'not used in edit mode
    End Sub

    Protected Sub MonetaryValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)
        If Not Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, Nothing) Then
            args.IsValid = False
        Else
            args.IsValid = True
        End If
    End Sub
End Class

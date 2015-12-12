Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVModules_ProductChoices_DropDownList_ProductChoiceEdit
    Inherits ProductChoiceTemplate

    Private _primaryKey As String
    Private _choice As Catalog.ProductChoice

    Private Enum Views
        MultiEditView = 0
        SingleEditView = 1
    End Enum

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub newChoiceOptionButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles newChoiceOptionButton.Click
        'create our new choice item
        Dim choiceOption As Catalog.ProductChoiceOption = New Catalog.ProductChoiceOption()
        _choice.ChoiceOptions.Add(choiceOption)
        ViewState("itemId") = choiceOption.Bvin
        ViewState("type") = "new"
        InitializeChoiceOptionForm(choiceOption)
        ProductChoiceMultiView.ActiveViewIndex = Views.SingleEditView
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.Mode = Modes.Edit
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        _choice = Me.Product.ChoicesAndInputs.FindBusinessObject(Me.BlockId)
        If Not Page.IsPostBack Then
            InitializeFields()
            BindChoiceOptions()
        End If
    End Sub

    Protected Sub InitializeFields()
        NameTextBox.Text = _choice.Name
        DisplayNameTextBox.Text = _choice.DisplayName
    End Sub

    Protected Sub BindChoiceOptions()
        ChoicesGridView.EditIndex = -1
        ChoicesGridView.DataSource = _choice.ChoiceOptions.GetNonDeletedItems()
        ChoicesGridView.DataKeyNames = New String() {"Bvin"}
        ChoicesGridView.DataBind()
    End Sub

    Protected Sub ChoiceOptionSaveButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ChoiceOptionContinueButton.Click
        If ChoiceOptionDefaultItemCheckBox.Checked Then
            For Each item As Catalog.ProductChoiceOption In _choice.ChoiceOptions
                item.IsDefault = False
            Next
        End If

        Dim choiceOption As Catalog.ProductChoiceOption = _choice.ChoiceOptions.FindBusinessObject(ViewState("itemId"))
        choiceOption.DisplayText = ChoiceOptionDisplayNameTextBox.Text
        choiceOption.IsDefault = ChoiceOptionDefaultItemCheckBox.Checked
        choiceOption.IsNull = NullItemCheckBox.Checked
        ProductChoiceMultiView.ActiveViewIndex = Views.MultiEditView

        BindChoiceOptions()
    End Sub

    Protected Sub InitializeChoiceOptionForm(ByVal choiceOption As Catalog.ProductChoiceOption)
        ChoiceOptionDisplayNameTextBox.Text = choiceOption.DisplayText
        ChoiceOptionDefaultItemCheckBox.Checked = choiceOption.IsDefault
        NullItemCheckBox.Checked = choiceOption.IsNull
    End Sub

    Protected Sub ChoicesGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles ChoicesGridView.RowCommand
        If e.CommandName = "MoveItem" Then
            If TypeOf e.CommandSource Is ImageButton Then
                Dim row As GridViewRow = DirectCast(DirectCast(e.CommandSource, ImageButton).Parent.Parent, GridViewRow)
                _primaryKey = DirectCast(sender, GridView).DataKeys(row.RowIndex).Value
                'even though on the gridview it looks like down, we are actually moving it "up"
                'in the list because the first item in the grid is index 0. so moving it down is actually
                'moving it to index 1 in the list, so it is up in the list
                If e.CommandArgument = "Down" Then
                    _choice.ChoiceOptions.MoveUp(_primaryKey)
                ElseIf e.CommandArgument = "Up" Then
                    _choice.ChoiceOptions.MoveDown(_primaryKey)
                End If                
                BindChoiceOptions()
            End If
        End If
    End Sub

    Protected Sub ChoicesGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles ChoicesGridView.RowDeleting
        _primaryKey = DirectCast(sender, GridView).DataKeys(e.RowIndex).Value
        _choice.ChoiceOptions.MarkAsDeleted(_primaryKey)
        BindChoiceOptions()        
    End Sub

    Protected Sub ChoicesGridView_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles ChoicesGridView.RowEditing
        _primaryKey = DirectCast(sender, GridView).DataKeys(e.NewEditIndex).Value
        ViewState("itemId") = _primaryKey
        ViewState("type") = "edit"
        InitializeChoiceOptionForm(_choice.ChoiceOptions.FindBusinessObject(_primaryKey))
        ProductChoiceMultiView.ActiveViewIndex = Views.SingleEditView        
    End Sub

    Protected Sub SaveChangesButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ContinueChangesButton.Click
        _choice.Name = NameTextBox.Text
        _choice.DisplayName = DisplayNameTextBox.Text
        NotifyFinishedEditing()
    End Sub

    Protected Sub ChoiceOptionCancelButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ChoiceOptionCancelButton.Click
        If ViewState("type") = "new" Then
            _choice.ChoiceOptions.Remove(_choice.ChoiceOptions.FindBusinessObject(ViewState("itemId")))
        End If
        ProductChoiceMultiView.ActiveViewIndex = Views.MultiEditView
        BindChoiceOptions()
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
End Class

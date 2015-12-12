Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_ProductChoices
    Inherits BaseProductAdminPage

    Private _product As Catalog.Product

    Public Enum Views
        ProductChoiceListView = 0
        ProductChoiceCombinationsView = 1
    End Enum

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("id") Is Nothing Then
            Response.Redirect(DefaultCatalogPage)
        Else            
            If Not Page.IsPostBack Then
                If Request.QueryString("source") IsNot Nothing Then
                    If Request.QueryString("source") = "ProductChoiceEdit" Then
                        _product = CType(Session(Request.QueryString("id")), Catalog.Product)
                    ElseIf Request.QueryString("source") = "ProductModifierEdit" Then
                        _product = CType(Session(Request.QueryString("id")), Catalog.Product)
                    End If
                ElseIf _product Is Nothing Then
                    _product = Catalog.InternalProduct.FindByBvin(Request.QueryString("id"), True)
                    If Not String.IsNullOrEmpty(_product.ParentId) Then
                        Response.Redirect(String.Format("{0}?id={1}", HttpContext.Current.Request.Url.AbsolutePath, _product.ParentId))
                    End If
                    'ViewState("product") = _product
                    Session(Request.QueryString("id")) = _product
                End If
            Else
                _product = CType(Session(Request.QueryString("id")), Catalog.Product)
                If _product Is Nothing Then
                    _product = Catalog.InternalProduct.FindByBvin(Request.QueryString("id"))
                    If _product Is Nothing Then
                        Response.Redirect(DefaultCatalogPage)
                    End If
                End If
            End If
        End If
        InitializeErrorMessages()


        If _product.GlobalProduct IsNot Nothing Then
            If _product.GlobalProduct.HasTooManyChoices Then
                ChoicesMessageBox.ShowError("Product Currently Has Too Many Choices")
            End If
        End If        

        For Each row As GridViewRow In Me.ChoicesGridView.Rows
            LoadUserControlsViews(row)
        Next

        If Not Page.IsPostBack Then
            PopulateSharedChoices()
            PopulateChoiceOptions()
            PopulateChoicesGrid()
        End If
    End Sub

    Protected Sub InitializeErrorMessages()
        ChoicesMessageBox.ClearMessage()
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Choices"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub PopulateSharedChoices()
        Dim sharedChoicesAndInputs As New Collection(Of Catalog.ProductChoiceInputBase)()
        Dim choices As BusinessEntityList(Of Catalog.ProductChoice) = Catalog.ProductChoice.GetSharedProductChoices()
        Dim inputs As BusinessEntityList(Of Catalog.ProductInput) = Catalog.ProductInput.GetSharedProductInputs()
        Dim modifiers As BusinessEntityList(Of Catalog.ProductModifier) = Catalog.ProductModifier.GetSharedProductModifiers()

        ' Placeholder variants for headings to separate choices, inputs, and modifiers
        ' Validation ensures that the user does not select these
        Dim choiceHeading As New Catalog.ProductChoice()
        choiceHeading.Bvin = "[NULL1]"
        choiceHeading.Name = "--Product Choices--"
        Dim inputHeading As New Catalog.ProductInput()
        inputHeading.Bvin = "[NULL2]"
        inputHeading.Name = "--Product Inputs--"
        Dim modifierHeading As New Catalog.ProductModifier()
        modifierHeading.Bvin = "[NULL3]"
        modifierHeading.Name = "--Product Modifiers--"

        If choices.Count > 0 Then
            sharedChoicesAndInputs.Add(choiceHeading)

            For Each choice As Catalog.ProductChoice In choices
                sharedChoicesAndInputs.Add(choice)
            Next
        End If
        
        If inputs.Count > 0 Then
            sharedChoicesAndInputs.Add(inputHeading)

            For Each input As Catalog.ProductInput In inputs
                sharedChoicesAndInputs.Add(input)
            Next
        End If
        
        If modifiers.Count > 0 Then
            sharedChoicesAndInputs.Add(modifierHeading)

            For Each modifier As Catalog.ProductModifier In modifiers
                sharedChoicesAndInputs.Add(modifier)
            Next
        End If
        
        SharedChoicesDropDownList.DataSource = sharedChoicesAndInputs
        SharedChoicesDropDownList.DataTextField = "Name"
        SharedChoicesDropDownList.DataValueField = "Bvin"
        SharedChoicesDropDownList.DataBind()
    End Sub

    Protected Sub PopulateChoiceOptions()
        Dim choices As Collection(Of Catalog.ChoiceOrInput) = Catalog.InternalProduct.GetProductChoiceAndInputTypes()        
        ChoiceTypes.DataSource = choices
        ChoiceTypes.DataTextField = "Name"
        ChoiceTypes.DataValueField = "NameAndType"
        ChoiceTypes.DataBind()
    End Sub

    Protected Sub PopulateChoicesGrid()        
        ChoicesGridView.DataSource = _product.ChoicesAndInputs().GetNonDeletedItems()
        ChoicesGridView.DataKeyNames = New String() {"Bvin"}
        ChoicesGridView.DataBind()
    End Sub

    Protected Sub PopulateChoiceCombinationsGrid()
        ChoiceCombinationsGridView.DataSource = _product.ChoiceCombinations.GetNonDeletedItems()
        ChoiceCombinationsGridView.DataKeyNames = New String() {"Bvin"}
        ChoiceCombinationsGridView.DataBind()
    End Sub

    Protected Sub AddSharedChoiceButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddSharedChoiceButton.Click
        Dim item As Catalog.ProductChoiceInputBase = Catalog.ProductChoice.FindByBvin(SharedChoicesDropDownList.SelectedValue)
        If item Is Nothing Then
            item = Catalog.ProductInput.FindByBvin(SharedChoicesDropDownList.SelectedValue)
        End If
        If item Is Nothing Then
            item = Catalog.ProductModifier.FindByBvin(SharedChoicesDropDownList.SelectedValue)
        End If
        If item IsNot Nothing Then
            _product.ChoicesAndInputs.AddOrUpdate(item)
            'ViewState("product") = _product
            Session(Request.QueryString("id")) = _product
            PopulateChoicesGrid()
        End If
    End Sub

    Protected Sub SharedChoicesDropDownListRequiredvalidator_ServerValidate(ByVal sender As Object, ByVal e As ServerValidateEventArgs) Handles SharedChoicesDropDownListRequiredValidator.ServerValidate
        If Not SharedChoicesDropDownList.SelectedValue.Contains("[NULL") Then
            e.IsValid = True
        Else
            e.IsValid = False
        End If
    End Sub

    Protected Sub AddNewChoiceButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddNewChoiceButton.Click
        Session(_product.Bvin) = _product

        If ChoiceTypes.SelectedValue.EndsWith(Catalog.ChoiceInputTypeEnum.Choice) Then
            Response.Redirect("~/BVAdmin/Catalog/ProductChoiceEdit.aspx?pid=" & Request.QueryString("id") & "&choiceType=" & Server.UrlEncode(ChoiceTypes.SelectedItem.Text))
        ElseIf ChoiceTypes.SelectedValue.EndsWith(Catalog.ChoiceInputTypeEnum.Input) Then
            Response.Redirect("~/BVAdmin/Catalog/ProductInputEdit.aspx?pid=" & Request.QueryString("id") & "&inputType=" & Server.UrlEncode(ChoiceTypes.SelectedItem.Text))
        ElseIf ChoiceTypes.SelectedValue.EndsWith(Catalog.ChoiceInputTypeEnum.Modifier) Then
            Response.Redirect("~/BVAdmin/Catalog/ProductModifierEdit.aspx?pid=" & Request.QueryString("id") & "&modifierType=" & Server.UrlEncode(ChoiceTypes.SelectedItem.Text))
        End If
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click, btnSave2.Click
        If Page.IsValid Then
            Save()
        End If
    End Sub

    Protected Overrides Function Save() As Boolean
        Dim result As Boolean = True
        Dim _visibleChoices As BusinessEntityList(Of Catalog.ProductChoice) = _product.GlobalProduct.GetChoices().GetNonDeletedItems()
        Dim allChoicesHaveOptions As Boolean = True
        For Each choice As Catalog.ProductChoice In _visibleChoices
            If choice.ChoiceOptions.Count = 0 Then
                allChoicesHaveOptions = False
                Exit For
            End If
        Next

        If allChoicesHaveOptions Then
            If ProductChoiceMultiView.ActiveViewIndex = Views.ProductChoiceListView Then
                _product.GlobalProduct.CreateCombinations()
                If _product.GlobalProduct.GetChoices().GetNonDeletedItems.Count > 0 Then
                    If Not _product.GlobalProduct.HasTooManyChoices Then
                        ProductChoiceMultiView.ActiveViewIndex = Views.ProductChoiceCombinationsView

                        'this For statement and the one following are only here because of a bug in the gridview
                        'if you modify the rows (delete rows off the end) then the template column will no longer
                        'be accessible
                        For i As Integer = 1 To (ChoiceCombinationsGridView.Columns.Count - 1)
                            ChoiceCombinationsGridView.Columns(i).HeaderText = ""
                            ChoiceCombinationsGridView.Columns(i).Visible = False
                        Next

                        For i As Integer = 0 To (_visibleChoices.Count - 1)
                            If (ChoiceCombinationsGridView.Columns.Count - 1) < (i + 1) Then
                                Dim choiceField As New BoundField()
                                choiceField.SortExpression = _visibleChoices(i).Bvin
                                choiceField.HeaderText = _visibleChoices(i).Name
                                choiceField.Visible = True
                                ChoiceCombinationsGridView.Columns.Add(choiceField)
                            Else
                                ChoiceCombinationsGridView.Columns(i + 1).HeaderText = _visibleChoices(i).Name
                                ChoiceCombinationsGridView.Columns(i + 1).Visible = True
                            End If
                        Next

                        PopulateChoiceCombinationsGrid()
                        result = False
                    End If
                    'ViewState("product") = _product
                    Session(Request.QueryString("id")) = _product
                Else
                    If Not _product.GlobalProduct.Commit() Then
                        ChoicesMessageBox.ShowError("An error occurred while trying to save the product to the database.")
                        result = False
                    Else
                        'ViewState("product") = Catalog.InternalProduct.FindByBvin(_product.Bvin, True)
                        Session(Request.QueryString("id")) = Nothing
                        Response.Redirect("~/BVAdmin/Catalog/Products_Edit.aspx?id=" & Request.QueryString("id"))
                    End If
                End If
            Else
                SaveCheckedBoxesToChoiceCombinations()

                If Not _product.GlobalProduct.Commit() Then
                    ChoicesMessageBox.ShowError("An error occurred while trying to save the product to the database.")
                    result = False
                Else
                    Session(Request.QueryString("id")) = Nothing
                    'Session(Request.QueryString("id")) = Catalog.InternalProduct.FindByBvin(_product.Bvin, True)
                    'ViewState("product") = Catalog.InternalProduct.FindByBvin(_product.Bvin, True)                
                    Response.Redirect("~/BVAdmin/Catalog/Products_Edit.aspx?id=" & Request.QueryString("id"))
                End If
                ProductChoiceMultiView.ActiveViewIndex = Views.ProductChoiceListView
            End If
        Else
            ChoicesMessageBox.ShowError("All choices must have at least one option.")
        End If
        Return result
    End Function

    Protected Sub SaveCheckedBoxesToChoiceCombinations()
        For Each row As GridViewRow In ChoiceCombinationsGridView.Rows()
            Dim key As DataKey = ChoiceCombinationsGridView.DataKeys(row.RowIndex)
            Dim SelectedCheckBox As CheckBox = DirectCast(row.Cells(0).FindControl("SelectedCheckBox"), CheckBox)
            If SelectedCheckBox.Checked Then
                _product.ChoiceCombinations.FindBusinessObject(key.Value).Selected = True
            Else
                _product.ChoiceCombinations.FindBusinessObject(key.Value).Selected = False
            End If
        Next
    End Sub

    Protected Sub ChoiceCombinationsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles ChoiceCombinationsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem IsNot Nothing Then
                Dim choiceList As Catalog.ProductChoiceCombination = DirectCast(e.Row.DataItem, Catalog.ProductChoiceCombination)
                If choiceList.Selected Then
                    DirectCast(e.Row.Cells(0).FindControl("SelectedCheckBox"), CheckBox).Checked = True
                Else
                    DirectCast(e.Row.Cells(0).FindControl("SelectedCheckBox"), CheckBox).Checked = False
                End If
                For i As Integer = 0 To (choiceList.GetChoiceOptions.Count - 1)
                    Dim text As String = ChoiceCombinationsGridView.Columns(i + 1).HeaderText
                    For Each choiceOption As Catalog.ProductChoiceOption In choiceList.GetChoiceOptions
                        Dim choice As Catalog.ProductChoice = _product.ChoicesAndInputs.FindBusinessObject(choiceOption.ParentChoiceID)
                        If choice.Name = text Then
                            e.Row.Cells(i + 1).Text = choiceOption.DisplayText
                            Exit For
                        End If
                    Next
                Next
            End If
        End If
    End Sub

    Protected Sub ChoicesGridView_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles ChoicesGridView.RowEditing
        Dim _primaryKey As String = DirectCast(sender, GridView).DataKeys(e.NewEditIndex).Value
        Dim choice As Catalog.ProductChoiceInputBase = _product.ChoicesAndInputs.FindBusinessObject(_primaryKey)
        Session(_product.Bvin) = _product
        If TypeOf choice Is Catalog.ProductChoice Then
            Response.Redirect("~/BVAdmin/Catalog/ProductChoiceEdit.aspx?id=" & _primaryKey & "&pid=" & _product.Bvin)
        ElseIf TypeOf choice Is Catalog.ProductInput Then
            Response.Redirect("~/BVAdmin/Catalog/ProductInputEdit.aspx?id=" & _primaryKey & "&pid=" & _product.Bvin)
        ElseIf TypeOf choice Is Catalog.ProductModifier Then
            Response.Redirect("~/BVAdmin/Catalog/ProductModifierEdit.aspx?id=" & _primaryKey & "&pid=" & _product.Bvin)
        End If

    End Sub

    Protected Sub ChoicesGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles ChoicesGridView.RowDeleting
        Dim _primaryKey As String = DirectCast(sender, GridView).DataKeys(e.RowIndex).Value
        Dim choiceInput As Catalog.ProductChoiceInputBase = _product.ChoicesAndInputs.FindBusinessObject(_primaryKey)
        If choiceInput.IsShared Then
            If Not _product.ChoicesAndInputs.Remove(choiceInput) Then
                ChoicesMessageBox.ShowError("An error occurred while trying to remove the shared Choice")
            Else
                'ViewState("product") = _product
                Session(Request.QueryString("id")) = _product
                PopulateChoicesGrid()
            End If
        Else
            If Not _product.ChoicesAndInputs.MarkAsDeleted(_primaryKey) Then
                ChoicesMessageBox.ShowError("An error occurred while trying to delete the Choice")
            Else
                Session(Request.QueryString("id")) = _product
                'ViewState("product") = _product
                PopulateChoicesGrid()
            End If
        End If
    End Sub

    Protected Sub btnCancel2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancelChanges.Click, btnCancel2.Click
        Session(Request.QueryString("id")) = Nothing
        Response.Redirect(DefaultCatalogPage)
    End Sub

    Protected Sub ChoiceCombinationsGridView_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles ChoiceCombinationsGridView.Sorting
        SaveCheckedBoxesToChoiceCombinations()
        Dim comboSortDirection As SortDirection = CType(ViewState("sortDirection"), System.Web.UI.WebControls.SortDirection)
        Dim comboSortExpression As String = CType(ViewState("sortExpression"), String)
        If comboSortExpression Is Nothing Then
            comboSortDirection = e.SortDirection
            comboSortExpression = e.SortExpression
        Else
            If comboSortExpression = e.SortExpression Then
                If comboSortDirection = SortDirection.Ascending Then
                    comboSortDirection = SortDirection.Descending
                Else
                    comboSortDirection = SortDirection.Ascending
                End If
            Else
                comboSortDirection = SortDirection.Ascending
            End If
        End If
        ViewState("sortDirection") = comboSortDirection
        ViewState("sortExpression") = e.SortExpression


        Dim flipped As Boolean = True
        Dim choiceOptions1 As BusinessEntityList(Of Catalog.ProductChoiceOption) = Nothing
        Dim choiceOptions2 As BusinessEntityList(Of Catalog.ProductChoiceOption) = Nothing
        Dim option1 As Catalog.ProductChoiceOption = Nothing
        Dim option2 As Catalog.ProductChoiceOption = Nothing

        While flipped
            flipped = False
            For i As Integer = 0 To (_product.ChoiceCombinations.Count - 2)
                If Not _product.ChoiceCombinations(i).MarkedAsDeleted Then
                    choiceOptions1 = _product.ChoiceCombinations(i).GetChoiceOptions()
                    For j As Integer = 0 To (choiceOptions1.Count - 1)
                        If choiceOptions1(j).ParentChoiceID = e.SortExpression Then
                            option1 = choiceOptions1(j)
                            Exit For
                        End If
                    Next

                    choiceOptions2 = _product.ChoiceCombinations(i + 1).GetChoiceOptions()
                    For j As Integer = 0 To (choiceOptions2.Count - 1)
                        If choiceOptions2(j).ParentChoiceID = e.SortExpression Then
                            option2 = choiceOptions2(j)
                            Exit For
                        End If
                    Next

                    If comboSortDirection = SortDirection.Ascending Then
                        If option1.SortOrder > option2.SortOrder Then
                            flipped = True
                            _product.ChoiceCombinations.MoveUp(_product.ChoiceCombinations(i).Bvin)
                        End If
                    Else
                        If option1.SortOrder < option2.SortOrder Then
                            flipped = True
                            _product.ChoiceCombinations.MoveUp(_product.ChoiceCombinations(i).Bvin)
                        End If
                    End If

                    option1 = Nothing
                    option2 = Nothing
                End If
            Next
        End While
        choiceOptions1 = Nothing
        choiceOptions2 = Nothing
        PopulateChoiceCombinationsGrid()
    End Sub

    Protected Sub ChoicesGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles ChoicesGridView.RowCommand
        If e.CommandName = "MoveItem" Then
            Dim primaryKey As String
            Dim row As GridViewRow = DirectCast(DirectCast(e.CommandSource, ImageButton).Parent.Parent, GridViewRow)
            primaryKey = DirectCast(sender, GridView).DataKeys(row.RowIndex).Value
            If e.CommandArgument = "Up" Then
                _product.ChoicesAndInputs.MoveDown(primaryKey)
            ElseIf e.CommandArgument = "Down" Then
                _product.ChoicesAndInputs.MoveUp(primaryKey)
            End If
            PopulateChoicesGrid()
        End If
    End Sub

    Protected Sub ChoicesGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles ChoicesGridView.RowDataBound
        If e.Row.DataItem IsNot Nothing Then
            If DirectCast(e.Row.DataItem, Catalog.ProductChoiceInputBase).IsShared Then
                DirectCast(e.Row.Cells(3).FindControl("EditImageButton"), ImageButton).OnClientClick = "window.alert('You cannot edit a shared choice from a products choices page. \nShared choices can only be edited by going \nto the Catalog -> Shared Choices menu option.'); return false;"
                DirectCast(e.Row.Cells(2).FindControl("SharedImage"), Image).Visible = True
            Else
                DirectCast(e.Row.Cells(3).FindControl("EditImageButton"), ImageButton).OnClientClick = ""
                DirectCast(e.Row.Cells(2).FindControl("SharedImage"), Image).Visible = False
            End If
            LoadUserControlsViews(e.Row)            
        End If
    End Sub

    Private Sub LoadUserControlsViews(ByVal row As GridViewRow)
        Dim VariantsPanel As Panel = DirectCast(row.FindControl("VariantsPanel"), Panel)
        Dim dataItem As Object = Nothing
        If row.DataItem IsNot Nothing Then
            dataItem = row.DataItem
        Else
            Dim primaryKey As String = ChoicesGridView.DataKeys(row.RowIndex).Value
            dataItem = _product.ChoicesAndInputs.FindBusinessObject(primaryKey)
        End If
        If TypeOf dataItem Is Catalog.ProductChoice Then
            Dim choice As Catalog.ProductChoice = DirectCast(dataItem, Catalog.ProductChoice)
            Dim choiceTemplate As Content.ProductChoiceTemplate = Content.ModuleController.LoadProductChoiceAdminView(choice.Type, Me.Page)
            If choiceTemplate IsNot Nothing Then
                choiceTemplate.BlockId = choice.Bvin
                choiceTemplate.Product = _product
                choiceTemplate.InitializeDisplay()
                VariantsPanel.Controls.Add(choiceTemplate)
            End If
        ElseIf TypeOf dataItem Is Catalog.ProductInput Then
            Dim input As Catalog.ProductInput = DirectCast(dataItem, Catalog.ProductInput)
            Dim inputTemplate As Content.ProductInputTemplate = Content.ModuleController.LoadProductInputAdminView(input.Type, Me.Page)
            If inputTemplate IsNot Nothing Then
                inputTemplate.BlockId = input.Bvin
                inputTemplate.Product = _product
                inputTemplate.InitializeDisplay()
                VariantsPanel.Controls.Add(inputTemplate)
            End If
        ElseIf TypeOf dataItem Is Catalog.ProductModifier Then
            Dim modifier As Catalog.ProductModifier = DirectCast(dataItem, Catalog.ProductModifier)
            Dim modifierTemplate As Content.ProductModifierTemplate = Content.ModuleController.LoadProductModifierAdminView(modifier.Type, Me.Page)
            If modifierTemplate IsNot Nothing Then
                modifierTemplate.BlockId = modifier.Bvin
                modifierTemplate.Product = _product
                modifierTemplate.InitializeDisplay()
                VariantsPanel.Controls.Add(modifierTemplate)
            End If
        End If
    End Sub
End Class

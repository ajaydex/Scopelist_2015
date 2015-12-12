Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_ProductSharedChoices
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Shared Product Choices"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString("source") IsNot Nothing Then
                Dim id As String = String.Empty
                If CStr(Request.QueryString("source")) = "ChoiceEdit" Then
                    id = CStr(Request.QueryString("choiceId"))                    
                ElseIf CStr(Request.QueryString("source")) = "InputEdit" Then
                    id = CStr(Request.QueryString("inputId"))
                ElseIf CStr(Request.QueryString("source")) = "ModifierEdit" Then
                    id = CStr(Request.QueryString("modifierId"))
                End If
            End If
            PopulateChoiceOptions()
            BindSharedChoicesGrid()
        End If
    End Sub

    Protected Sub NewSharedChoiceImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles NewSharedChoiceImageButton.Click
        If SharedChoiceTypes.SelectedValue.EndsWith(Catalog.ChoiceInputTypeEnum.Choice) Then
            Response.Redirect("~/BVAdmin/Catalog/ProductChoiceEdit.aspx?pid=shared&choiceType=" & Server.UrlEncode(SharedChoiceTypes.SelectedItem.Text))
        ElseIf SharedChoiceTypes.SelectedValue.EndsWith(Catalog.ChoiceInputTypeEnum.Input) Then
            Response.Redirect("~/BVAdmin/Catalog/ProductInputEdit.aspx?pid=shared&inputType=" & Server.UrlEncode(SharedChoiceTypes.SelectedItem.Text))
        ElseIf SharedChoiceTypes.SelectedValue.EndsWith(Catalog.ChoiceInputTypeEnum.Modifier) Then
            Response.Redirect("~/BVAdmin/Catalog/ProductModifierEdit.aspx?pid=shared&modifierType=" & Server.UrlEncode(SharedChoiceTypes.SelectedItem.Text))
        End If
    End Sub

    Protected Sub PopulateChoiceOptions()
        SharedChoiceTypes.DataSource = Catalog.InternalProduct.GetProductChoiceAndInputTypes()
        SharedChoiceTypes.DataTextField = "Name"
        SharedChoiceTypes.DataValueField = "NameAndType"
        SharedChoiceTypes.DataBind()
    End Sub

    Protected Sub BindSharedChoicesGrid()
        Dim divider As Catalog.ProductChoiceInputBase = Nothing
        Dim inputsAndChoices As New BusinessEntityList(Of Catalog.ProductChoiceInputBase)
        Dim choices As BusinessEntityList(Of Catalog.ProductChoice) = Catalog.ProductChoice.GetSharedProductChoices()
        Dim inputs As BusinessEntityList(Of Catalog.ProductInput) = Catalog.ProductInput.GetSharedProductInputs()
        Dim modifiers As BusinessEntityList(Of Catalog.ProductModifier) = Catalog.ProductModifier.GetSharedProductModifiers()

        divider = New Catalog.ProductChoice()
        divider.Name = "Choices"
        choices.Insert(0, divider)
        For Each item As Catalog.ProductChoice In choices
            inputsAndChoices.Add(item)
        Next

        divider = New Catalog.ProductInput()
        divider.Name = "Inputs"
        inputs.Insert(0, divider)
        For Each item As Catalog.ProductInput In inputs
            inputsAndChoices.Add(item)
        Next

        divider = New Catalog.ProductModifier()
        divider.Name = "Modifiers"
        modifiers.Insert(0, divider)
        For Each item As Catalog.ProductModifier In modifiers
            inputsAndChoices.Add(item)
        Next

        SharedChoicesAndInputsGridView.DataSource = inputsAndChoices
        SharedChoicesAndInputsGridView.DataKeyNames = New String() {"bvin"}
        SharedChoicesAndInputsGridView.DataBind()
    End Sub

    Protected Sub SharedChoicesAndInputsGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles SharedChoicesAndInputsGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim choiceInput As Catalog.ProductChoiceInputBase = CType(e.Row.DataItem, Catalog.ProductChoiceInputBase)
            If choiceInput IsNot Nothing Then
                If String.IsNullOrEmpty(choiceInput.Type) Then
                    e.Row.Cells(0).Text = String.Format("<strong>{0}</strong>", e.Row.Cells(0).Text)

                    ' hide Edit and Delete buttons
                    e.Row.Cells(2).Controls.Clear()
                    e.Row.Cells(3).Controls.Clear()
                End If
            End If
        End If
    End Sub

    Protected Sub SharedChoicesAndInputsGridView_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles SharedChoicesAndInputsGridView.RowEditing
        Dim primaryKey As String = DirectCast(sender, GridView).DataKeys(e.NewEditIndex).Value
        Dim item As Catalog.ProductChoiceInputBase = Catalog.ProductInput.FindByBvin(primaryKey)
        If item Is Nothing Then
            item = Catalog.ProductChoice.FindByBvin(primaryKey)
        End If

        If item Is Nothing Then
            item = Catalog.ProductModifier.FindByBvin(primaryKey)
        End If
        If item IsNot Nothing Then
            If TypeOf item Is Catalog.ProductChoice Then
                Response.Redirect("~/BVAdmin/Catalog/ProductChoiceEdit.aspx?id=" & primaryKey & "&pid=shared")
            ElseIf TypeOf item Is Catalog.ProductInput Then
                Response.Redirect("~/BVAdmin/Catalog/ProductInputEdit.aspx?id=" & primaryKey & "&pid=shared")
            ElseIf TypeOf item Is Catalog.ProductModifier Then
                Response.Redirect("~/BVAdmin/Catalog/ProductModifierEdit.aspx?id=" & primaryKey & "&pid=shared")
            End If
        End If
    End Sub

    Protected Sub SharedChoicesAndInputsGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles SharedChoicesAndInputsGridView.RowDeleting
        Dim primaryKey As String = DirectCast(sender, GridView).DataKeys(e.RowIndex).Value
        Dim item As Catalog.ProductChoiceInputBase = Catalog.ProductInput.FindByBvin(primaryKey)
        If item Is Nothing Then
            item = Catalog.ProductChoice.FindByBvin(primaryKey)
        End If

        If item Is Nothing Then
            item = Catalog.ProductModifier.FindByBvin(primaryKey)
        End If

        If item IsNot Nothing Then
            'when this is marked as deleted some code fires off in the ProductChoice class (assuming it isn't a
            ' product input) that regenerates all of the choice combinations for affected products
            item.MarkAsDeleted()
            item.Commit()
        End If
        BindSharedChoicesGrid()
    End Sub
End Class

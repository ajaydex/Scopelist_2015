Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_VariantsGridDisplay
    Inherits System.Web.UI.UserControl

    Private _baseProduct As Catalog.Product

    Public Property BaseProduct() As Catalog.Product
        Get
            Return _baseProduct
        End Get
        Set(ByVal value As Catalog.Product)
            If value.ParentId <> String.Empty Then
                value = Catalog.InternalProduct.FindByBvin(value.ParentId)
            End If
            _baseProduct = value
            Me.Initialize(True)
        End Set
    End Property

    Public Sub Initialize(Optional ByVal Clear As Boolean = False)
        If Not Page.IsPostBack Then
            Dim controlsToDelete As New Collection(Of Control)
            For Each item As Control In VariantsPlaceHolder.Controls
                If (TypeOf item Is Content.ProductChoiceTemplate) OrElse (TypeOf item Is Content.ProductInputTemplate) OrElse (TypeOf item Is Content.ProductModifierTemplate) Then
                    controlsToDelete.Add(item)
                End If
            Next

            For Each item As Control In controlsToDelete
                VariantsPlaceHolder.Controls.Remove(item)
            Next

            If BaseProduct IsNot Nothing Then
                If BaseProduct.Bvin <> String.Empty Then
                    Dim CombinationDisplays As New Utilities.SortableCollection(Of Catalog.ProductCombinationDisplay)(Catalog.InternalProduct.GetProductCombinationDisplays(BaseProduct))
                    CombinationDisplays.Sort("ComboDisplayName", Utilities.SortDirection.Ascending)
                    VariantsGridDisplayRepeater.DataSource = CombinationDisplays
                    VariantsGridDisplayRepeater.DataBind()
                End If
            End If
        End If

        If BaseProduct IsNot Nothing Then
            If BaseProduct.Bvin <> String.Empty Then
                If BaseProduct.HasVariants Then
                    Dim count As Integer = 0
                    For Each item As Catalog.ProductChoiceInputBase In BaseProduct.ChoicesAndInputs
                        count += 1
                        If TypeOf item Is Catalog.ProductInput Then
                            Dim input As Catalog.ProductInput = DirectCast(item, Catalog.ProductInput)
                            Dim inputTemplate As Content.ProductInputTemplate = Content.ModuleController.LoadProductInput(input.Type, Me.Page)
                            If inputTemplate IsNot Nothing Then
                                inputTemplate.BlockId = input.Bvin
                                inputTemplate.ID = "inputTemplate" + count.ToString()
                                inputTemplate.Product = Me.BaseProduct
                                inputTemplate.InitializeDisplay()
                                VariantsPlaceHolder.Controls.Add(inputTemplate)
                            End If
                        End If
                    Next
                End If
            End If
        End If
    End Sub


    Public Function GetLineItems() As Collection(Of Orders.LineItem)
        Dim result As New Collection(Of Orders.LineItem)()
        For Each row As RepeaterItem In VariantsGridDisplayRepeater.Items
            Dim bvinHiddenField As HiddenField = CType(row.FindControl("BvinHiddenField"), HiddenField)
            Dim modifierOptionsHiddenField As HiddenField = CType(row.FindControl("ModifierOptionsHiddenField"), HiddenField)
            Dim field As TextBox = CType(row.FindControl("QuantityField"), TextBox)

            If bvinHiddenField IsNot Nothing AndAlso modifierOptionsHiddenField IsNot Nothing AndAlso field IsNot Nothing Then
                Dim val As Integer = 0
                If Integer.TryParse(field.Text, val) Then
                    If val > 0 Then
                        Dim lineItem As New Orders.LineItem()
                        lineItem.ProductId = bvinHiddenField.Value
                        lineItem.Quantity = val

                        Dim order As Integer = 0
                        Dim modOptionBvins As String() = modifierOptionsHiddenField.Value.Split(New Char() {","c}, System.StringSplitOptions.RemoveEmptyEntries)
                        For Each modOptionBvin As String In modOptionBvins
                            Dim modOption As Catalog.ProductModifierOption = Catalog.ProductModifierOption.FindByBvin(modOptionBvin)
                            Dim modifier As Catalog.ProductModifier = Catalog.ProductModifier.FindByBvin(modOption.ModifierID)

                            If modOption IsNot Nothing AndAlso modifier IsNot Nothing Then
                                Dim lineItemMod As New Orders.LineItemModifier()
                                lineItemMod.Order = order
                                lineItemMod.ModifierBvin = modifier.Bvin
                                lineItemMod.ModifierName = modifier.DisplayName
                                lineItemMod.ModifierValue = modOption.Bvin
                                lineItem.Modifiers.Add(lineItemMod)
                            End If
                            order += 1
                        Next

                        For Each item As Control In VariantsPlaceHolder.Controls
                            If TypeOf item Is Content.ProductInputTemplate Then
                                Dim input As Content.ProductInputTemplate = DirectCast(item, Content.ProductInputTemplate)
                                Dim lineItemInput As Orders.LineItemInput = Nothing
                                For Each item2 As Orders.LineItemInput In lineItem.Inputs
                                    If item2.InputBvin = input.BlockId Then
                                        lineItemInput = item2
                                        Exit For
                                    End If
                                Next

                                If lineItemInput IsNot Nothing Then
                                    lineItemInput.Order = order
                                    lineItemInput.InputValue = input.GetValue()
                                    lineItemInput.InputDisplayValue = input.GetDisplayValue()
                                    lineItemInput.InputAdminDisplayValue = input.GetAdminDisplayValue()
                                    lineItemInput.DisplayToCustomer = input.DisplayToCustomer
                                Else
                                    lineItemInput = New Orders.LineItemInput()
                                    lineItemInput.Order = order
                                    lineItemInput.LineItemBvin = lineItem.Bvin
                                    lineItemInput.InputBvin = input.BlockId
                                    lineItemInput.InputName = input.Name
                                    lineItemInput.InputValue = input.GetValue()
                                    lineItemInput.InputDisplayValue = input.GetDisplayValue()
                                    lineItemInput.InputAdminDisplayValue = input.GetAdminDisplayValue()
                                    lineItemInput.DisplayToCustomer = input.DisplayToCustomer
                                    lineItem.Inputs.Add(lineItemInput)
                                End If
                            End If
                            order += 1
                        Next

                        result.Add(lineItem)
                    End If
                End If
            End If


        Next

        Return result
    End Function

    Public Sub LoadFromLineItem(ByVal lineItem As Orders.LineItem)
        Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(lineItem.ProductId)
        If product.GlobalProduct.ParentId <> String.Empty Then
            product = Catalog.InternalProduct.FindByBvin(product.GlobalProduct.ParentId)
        End If

        If product IsNot Nothing Then
            'code that gets inputs and writes them to line item
            For Each input As Orders.LineItemInput In lineItem.Inputs
                For Each item As Control In VariantsPlaceHolder.Controls
                    If TypeOf item Is Content.ProductInputTemplate Then
                        Dim inputControl As Content.ProductInputTemplate = DirectCast(item, Content.ProductInputTemplate)
                        If inputControl.BlockId = input.InputBvin Then
                            inputControl.SetValue(input.InputValue)
                            Exit For
                        End If
                    End If
                Next
            Next

            For Each row As RepeaterItem In VariantsGridDisplayRepeater.Items
                Dim bvinHiddenField As HiddenField = CType(row.FindControl("BvinHiddenField"), HiddenField)
                Dim modifierOptionsHiddenField As HiddenField = CType(row.FindControl("ModifierOptionsHiddenField"), HiddenField)
                Dim field As TextBox = CType(row.FindControl("QuantityField"), TextBox)

                If bvinHiddenField IsNot Nothing AndAlso modifierOptionsHiddenField IsNot Nothing AndAlso field IsNot Nothing Then
                    If bvinHiddenField.Value = lineItem.ProductId Then
                        Dim modifiersMatch As Boolean = True
                        For Each lineItemMod As Orders.LineItemModifier In lineItem.Modifiers
                            Dim modifierOptions As String() = modifierOptionsHiddenField.Value.Split(New String() {","}, StringSplitOptions.RemoveEmptyEntries)
                            Dim found As Boolean = False
                            For Each modOption As String In modifierOptions
                                If String.Compare(lineItemMod.ModifierValue, modOption, True) = 0 Then
                                    found = True
                                End If
                            Next

                            If Not found Then
                                modifiersMatch = False
                                Continue For
                            End If
                        Next

                        If modifiersMatch Then
                            field.Text = lineItem.Quantity.ToString("0")
                            Exit For
                        End If
                    End If
                End If
            Next
        End If
    End Sub

    Protected Overrides Function SaveViewState() As Object
        Dim bvin As String = String.Empty
        If Me.BaseProduct IsNot Nothing Then
            bvin = Me.BaseProduct.Bvin
        End If
        Dim arr() As Object = New Object() {MyBase.SaveViewState(), bvin}
        Return arr
    End Function

    Protected Overrides Sub LoadViewState(ByVal savedState As Object)
        Dim arr() As Object = DirectCast(savedState, Object())
        MyBase.LoadViewState(arr(0))
        If arr(1) IsNot Nothing Then
            Me._baseProduct = Catalog.InternalProduct.FindByBvin(DirectCast(arr(1), String))
        End If
    End Sub

End Class

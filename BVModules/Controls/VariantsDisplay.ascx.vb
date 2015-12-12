Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_VariantsDisplay
    Inherits System.Web.UI.UserControl
    Implements IVariantDisplay

    Private _baseProduct As Catalog.Product

    Public Property BaseProduct() As Catalog.Product
        Get
            Return _baseProduct
        End Get
        Set(ByVal value As Catalog.Product)
            If (value IsNot Nothing) Then
                If value.ParentId <> String.Empty Then
                    value = Catalog.InternalProduct.FindByBvin(value.ParentId)
                End If
                _baseProduct = value
            End If
            Me.Initialize(True)
        End Set
    End Property

    Public Property IsValidCombination() As Boolean Implements IVariantDisplay.IsValidCombination
        Get
            Dim obj As Object = ViewState("Selected")
            If obj IsNot Nothing Then
                Return DirectCast(obj, Boolean)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            HttpContext.Current.Items("BVSelectedCombinationValid") = value
            ViewState("Selected") = value
        End Set
    End Property

    Public Sub Initialize(Optional ByVal Clear As Boolean = False) Implements IVariantDisplay.Initialize
        If Me.Page.IsPostBack Then
            Dim controlsToDelete As New Collection(Of Control)
            For Each item As Control In VariantsPlaceHolder.Controls
                If (TypeOf item Is Content.ProductChoiceTemplate) OrElse (TypeOf item Is Content.ProductInputTemplate) OrElse (TypeOf item Is Content.ProductModifierTemplate) Then
                    controlsToDelete.Add(item)
                End If
            Next

            For Each item As Control In controlsToDelete
                VariantsPlaceHolder.Controls.Remove(item)
            Next
        End If
        If BaseProduct IsNot Nothing Then
            If BaseProduct.Bvin <> String.Empty Then
                If BaseProduct.HasVariants Then
                    Dim count As Integer = 0
                    For Each item As Catalog.ProductChoiceInputBase In BaseProduct.ChoicesAndInputs
                        count += 1
                        If TypeOf item Is Catalog.ProductChoice Then
                            Dim choice As Catalog.ProductChoice = DirectCast(item, Catalog.ProductChoice)
                            Dim choiceTemplate As Content.ProductChoiceTemplate = Content.ModuleController.LoadProductChoice(choice.Type, Me.Page)
                            If choiceTemplate IsNot Nothing Then
                                AddHandler choiceTemplate.SelectionChanged, AddressOf Me.SelectionChanged
                                choiceTemplate.BlockId = choice.Bvin
                                choiceTemplate.ID = "choiceTemplate" + count.ToString()
                                choiceTemplate.Product = Me.BaseProduct
                                choiceTemplate.InitializeDisplay()
                                VariantsPlaceHolder.Controls.Add(choiceTemplate)
                            End If
                        ElseIf TypeOf item Is Catalog.ProductInput Then
                            Dim input As Catalog.ProductInput = DirectCast(item, Catalog.ProductInput)
                            Dim inputTemplate As Content.ProductInputTemplate = Content.ModuleController.LoadProductInput(input.Type, Me.Page)
                            If inputTemplate IsNot Nothing Then
                                inputTemplate.BlockId = input.Bvin
                                inputTemplate.ID = "inputTemplate" + count.ToString()
                                inputTemplate.Product = Me.BaseProduct
                                inputTemplate.InitializeDisplay()
                                VariantsPlaceHolder.Controls.Add(inputTemplate)
                            End If
                        ElseIf TypeOf item Is Catalog.ProductModifier Then
                            Dim modifier As Catalog.ProductModifier = DirectCast(item, Catalog.ProductModifier)
                            Dim modifierTemplate As Content.ProductModifierTemplate = Content.ModuleController.LoadProductModifier(modifier.Type, Me.Page)
                            If modifierTemplate IsNot Nothing Then
                                AddHandler modifierTemplate.SelectionChanged, AddressOf Me.SelectionChanged
                                modifierTemplate.BlockId = modifier.Bvin
                                modifierTemplate.ID = "modifierTemplate" + count.ToString()
                                modifierTemplate.Product = Me.BaseProduct
                                modifierTemplate.InitializeDisplay()
                                VariantsPlaceHolder.Controls.Add(modifierTemplate)
                            End If
                        End If
                    Next
                End If
            End If
        End If
    End Sub

    Protected Sub SelectionChanged()
        If TypeOf Me.Page Is BaseStoreProductPage Then
            DirectCast(Me.Page, BaseStoreProductPage).LocalProduct = Me.GetSelectedProduct(DirectCast(Me.Page, BaseStoreProductPage).LocalProduct)            
            DirectCast(Me.Page, BaseStoreProductPage).PopulateProductInfo(Me.IsValidCombination)
        End If
    End Sub

    Public Function IsValid() As Boolean Implements IVariantDisplay.IsValid
        For Each item As Control In VariantsPlaceHolder.Controls
            If TypeOf item Is Content.ProductInputTemplate Then
                If Not DirectCast(item, Content.ProductInputTemplate).IsValid Then
                    Return False
                End If
            ElseIf TypeOf item Is Content.ProductChoiceTemplate Then
                If Not DirectCast(item, Content.ProductChoiceTemplate).IsValid Then
                    Return False
                End If
            ElseIf TypeOf item Is Content.ProductModifierTemplate Then
                If Not DirectCast(item, Content.ProductModifierTemplate).IsValid Then
                    Return False
                End If
            End If
        Next
        If Me.IsValidCombination Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Function GetSelectedProduct(ByVal currentProduct As Catalog.Product) As Catalog.Product Implements IVariantDisplay.GetSelectedProduct

        'If currentProduct Is Nothing Then
        '    Return Nothing
        'End If

        If Me.BaseProduct.GlobalProduct.GetChoices().Count > 0 Then
            Dim keys As New Collection(Of String)
            'Dim productAdjustment As Decimal = 0D
            For Each item As Control In VariantsPlaceHolder.Controls
                If TypeOf item Is Content.ProductChoiceTemplate Then
                    Dim choice As Content.ProductChoiceTemplate = DirectCast(item, Content.ProductChoiceTemplate)
                    If choice IsNot Nothing Then
                        keys.Add(choice.GetValue())
                    End If
                End If
                'If TypeOf item Is Content.ProductModifierTemplate Then
                '    Dim modifier As Content.ProductModifierTemplate = DirectCast(item, Content.ProductModifierTemplate)
                '    If modifier IsNot Nothing Then
                '        Dim modifierOption As Catalog.ProductModifierOption = Catalog.ProductModifierOption.FindByBvin(modifier.GetValue())
                '        If modifierOption IsNot Nothing Then
                '            productAdjustment += modifierOption.PriceAdjustment
                '        End If
                '    End If
                'End If
            Next
            Dim productCombo As Catalog.ProductChoiceCombination = Me.BaseProduct.GlobalProduct.GetChoiceCombinationForChoices(keys)
            If productCombo IsNot Nothing Then
                If Not productCombo.Selected Then
                    Me.IsValidCombination = False
                Else
                    Me.IsValidCombination = True
                End If
                Return Catalog.InternalProduct.FindByBvin(productCombo.Bvin)
            Else
                'nothing is selected yet, so return the default product
                Me.IsValidCombination = True
                Return currentProduct
            End If
        Else
            Me.IsValidCombination = True
            Return Me.BaseProduct
        End If
    End Function

    Public Sub WriteValuesToLineItem(ByVal lineItem As Orders.LineItem) Implements IVariantDisplay.WriteValuesToLineItem
        Dim order As Integer = 0
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
            ElseIf TypeOf item Is Content.ProductModifierTemplate Then
                Dim modifier As Content.ProductModifierTemplate = DirectCast(item, Content.ProductModifierTemplate)
                Dim lineItemModifier As Orders.LineItemModifier = Nothing
                For Each item2 As Orders.LineItemModifier In lineItem.Modifiers
                    If item2.ModifierBvin = modifier.BlockId Then
                        lineItemModifier = item2
                        Exit For
                    End If
                Next

                If lineItemModifier IsNot Nothing Then
                    lineItemModifier.Order = order
                    lineItemModifier.ModifierValue = modifier.GetValue()
                    lineItemModifier.DisplayToCustomer = modifier.DisplayToCustomer
                Else
                    lineItemModifier = New Orders.LineItemModifier()
                    lineItemModifier.Order = order
                    lineItemModifier.LineItemBvin = lineItem.Bvin
                    lineItemModifier.ModifierBvin = modifier.BlockId
                    lineItemModifier.ModifierName = modifier.Name
                    lineItemModifier.ModifierValue = modifier.GetValue()
                    lineItemModifier.DisplayToCustomer = modifier.DisplayToCustomer
                    lineItem.Modifiers.Add(lineItemModifier)
                End If
            End If
            order += 1
        Next
    End Sub

    Public Sub LoadFromLineItem(ByVal lineItem As Orders.LineItem)
        Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(lineItem.ProductId)
        
        If product IsNot Nothing Then

            If product.GlobalProduct.ParentId <> String.Empty Then
                product = Catalog.InternalProduct.FindByBvin(product.GlobalProduct.ParentId)
            End If

            If product Is Nothing Then
                Return
            End If

            'code that loads product choices
            For Each item As Catalog.ProductChoiceCombination In product.ChoiceCombinations
                If item.Bvin = lineItem.ProductId Then
                    'we found the correct choice combination

                    Dim choiceOptions As New Collection(Of Catalog.ProductChoiceOption)
                    For Each choiceOptionId As String In item.ChoiceOptionIds
                        choiceOptions.Add(Catalog.ProductChoiceOption.FindByBvin(choiceOptionId))
                    Next

                    For Each panelControl As Control In VariantsPlaceHolder.Controls
                        If TypeOf panelControl Is Content.ProductChoiceTemplate Then
                            Dim choiceControl As Content.ProductChoiceTemplate = DirectCast(panelControl, Content.ProductChoiceTemplate)
                            For Each choiceOption As Catalog.ProductChoiceOption In choiceOptions
                                If choiceOption.ParentChoiceID = choiceControl.BlockId Then
                                    choiceControl.SetValue(choiceOption.Bvin)
                                    Exit For
                                End If
                            Next
                        End If
                    Next
                    Exit For
                End If
            Next

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

            'code that gets modifiers and writes them to line item
            For Each modifier As Orders.LineItemModifier In lineItem.Modifiers
                For Each item As Control In VariantsPlaceHolder.Controls
                    If TypeOf item Is Content.ProductModifierTemplate Then
                        Dim modifierControl As Content.ProductModifierTemplate = DirectCast(item, Content.ProductModifierTemplate)
                        If modifierControl.BlockId = modifier.ModifierBvin Then
                            modifierControl.SetValue(modifier.ModifierValue)
                            Exit For
                        End If
                    End If
                Next
            Next
        End If
    End Sub

    Public Function GetPriceAdjustment() As Decimal
        Dim result As Decimal = 0D
        For Each item As Control In VariantsPlaceHolder.Controls
            If TypeOf item Is Content.ProductModifierTemplate Then
                Dim modifierOption As Catalog.ProductModifierOption = Catalog.ProductModifierOption.FindByBvin(DirectCast(item, Content.ProductModifierTemplate).GetValue())
                If modifierOption IsNot Nothing Then
                    result += modifierOption.PriceAdjustment
                End If
            End If
        Next
        Return result
    End Function


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

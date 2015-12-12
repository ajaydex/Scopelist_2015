Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core

Public Interface IVariantDisplay

    Property IsValidCombination() As Boolean
    Function GetSelectedProduct(ByVal currentProduct As Catalog.Product) As Catalog.Product
    Function IsValid() As Boolean
    Sub WriteValuesToLineItem(ByVal lineItem As Orders.LineItem)
    Sub Initialize(Optional ByVal Clear As Boolean = False)

End Interface

Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core

Public Interface IKitDisplay
    Function GetSelections(ByVal currentProduct As Catalog.Product) As Catalog.KitSelections
    Function IsValid() As Boolean
    Sub WriteToLineItem(ByVal item As Orders.LineItem)
End Interface

Imports Microsoft.VisualBasic
Imports System.Web

Public Class AddToBabyRegistryClickedEventArgs
    Private _variantsDisplay As IVariantDisplay
    Private _messageBox As IVariantDisplay
    Private _page As BaseStoreProductPage
    Private _quantity As Integer
    Private _itemAddedToCartLabel As Anthem.Label
    Private _productOverridePrice As Decimal
    Private _isValid As Boolean = True

    Public Property VariantsDisplay() As IVariantDisplay
        Get
            Return _variantsDisplay
        End Get
        Set(ByVal value As IVariantDisplay)
            _variantsDisplay = value
        End Set
    End Property

    Public Property MessageBox() As IMessageBox
        Get
            Return _messageBox
        End Get
        Set(ByVal value As IMessageBox)
            _messageBox = value
        End Set
    End Property

    Public Property Page() As BaseStoreProductPage
        Get
            Return _page
        End Get
        Set(ByVal value As BaseStoreProductPage)
            _page = value
        End Set
    End Property

    Public Property Quantity() As Integer
        Get
            Return _quantity
        End Get
        Set(ByVal value As Integer)
            _quantity = value
        End Set
    End Property

    Public Property ItemAddedToCartLabel() As Anthem.Label
        Get
            Return _itemAddedToCartLabel
        End Get
        Set(ByVal value As Anthem.Label)
            _itemAddedToCartLabel = value
        End Set
    End Property

    Public Property ProductOverridePrice() As Decimal
        Get
            Return _productOverridePrice
        End Get
        Set(ByVal value As Decimal)
            _productOverridePrice = value
        End Set
    End Property

    Public Property IsValid() As Boolean
        Get
            Return _isValid
        End Get
        Set(ByVal value As Boolean)
            _isValid = value
        End Set
    End Property

End Class
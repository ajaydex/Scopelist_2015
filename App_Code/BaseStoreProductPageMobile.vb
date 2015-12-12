Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core

Public MustInherit Class BaseStoreProductPageMobile
    Inherits BaseStorePage

    Private _LocalProduct As New Catalog.Product
    Private _ModuleProductQuantity As Integer = 1
    Private _errorMessage As IMessageBox = Nothing

    Public Property LocalProduct() As Catalog.Product
        Get
            Return _LocalProduct
        End Get
        Set(ByVal value As Catalog.Product)
            _LocalProduct = value
        End Set
    End Property
    Public Property ModuleProductQuantity() As Integer
        Get
            Return _ModuleProductQuantity
        End Get
        Set(ByVal value As Integer)
            _ModuleProductQuantity = value
        End Set
    End Property

    Public Property MessageBox() As IMessageBox
        Get
            Return _errorMessage
        End Get
        Set(ByVal value As IMessageBox)
            _errorMessage = value
        End Set
    End Property

    Public Overrides ReadOnly Property DisplaysActiveCategoryTab() As Boolean
        Get
            Return True
        End Get
    End Property

    Public MustOverride Sub PopulateProductInfo(ByVal IsValidCombination As Boolean)

End Class

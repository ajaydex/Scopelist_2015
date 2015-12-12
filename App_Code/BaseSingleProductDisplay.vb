Imports BVSoftware.BVC5.Core

Public MustInherit Class BaseSingleProductDisplay
    Inherits BVSoftware.BVC5.Core.Controls.BVBaseUserControl

    Public Event AddToCartClicked(ByVal productId As String)

#Region " Properties "

    <ComponentModel.Browsable(True)> _
    Public Property DisplayMode() As Controls.SingleProductDisplayModes
        Get
            Dim obj As Object = ViewState("DisplayMode")
            If obj IsNot Nothing Then
                Return DirectCast(obj, Controls.SingleProductDisplayModes)
            Else
                Return BVSoftware.Bvc5.Core.Controls.SingleProductDisplayModes.Wide
            End If
        End Get
        Set(ByVal value As Controls.SingleProductDisplayModes)
            ViewState("DisplayMode") = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayName() As Boolean
        Get
            Dim obj As Object = ViewState("DisplayName")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return True
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplayName") = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayDescription() As Boolean
        Get
            Dim obj As Object = ViewState("DisplayDescription")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplayDescription") = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayPrice() As Boolean
        Get
            Dim obj As Object = ViewState("DisplayPrice")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return True
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplayPrice") = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayListPrice() As Boolean
        Get
            Dim obj As Object = ViewState("DisplayListPrice")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return True
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplayListPrice") = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayAddToCartButton() As Boolean
        Get
            Dim obj As Object = ViewState("DisplayAddToCartButton")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplayAddToCartButton") = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property CssClassPrefix() As String
        Get
            Dim obj As Object = ViewState("CssClassPrefix")
            If obj IsNot Nothing Then
                Return CStr(obj)
            Else
                Return String.Empty
            End If
        End Get
        Set(ByVal value As String)
            ViewState("CssClassPrefix") = value
        End Set
    End Property

    <ComponentModel.Browsable(False)> _
    Protected Property Destination() As String
        Get
            Dim obj As Object = ViewState("Destination")
            If obj IsNot Nothing Then
                Return CStr(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As String)
            ViewState("Destination") = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property RemainOnPageAfterAddToCart() As Boolean
        Get
            Dim obj As Object = ViewState("RemainOnPageAfterAddToCart")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("RemainOnPageAfterAddToCart") = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplaySelectedCheckBox() As Boolean
        Get
            Dim obj As Object = ViewState("DisplaySelectedCheckBox")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplaySelectedCheckBox") = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayQuantity() As Boolean
        Get
            Dim obj As Object = ViewState("DisplayQuantity")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplayQuantity") = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayImage() As Boolean
        Get
            Dim obj As Object = ViewState("DisplayImage")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplayImage") = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayNewBadge() As Boolean
        Get
            Dim obj As Object = ViewState("DisplayNewBadge")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplayNewBadge") = value
        End Set
    End Property

    Public MustOverride Property Selected() As Boolean

    Public ReadOnly Property ProductId() As String
        Get
            Dim obj As Object = ViewState("ProductID")
            If obj IsNot Nothing Then
                Return DirectCast(obj, String)
            Else
                Return ""
            End If
        End Get
    End Property

    Public MustOverride Property Quantity() As Integer

#End Region

    Public MustOverride Sub LoadWithProduct(ByVal p As Catalog.Product)

    Protected Overridable Sub OnAddToCartClicked(ByVal productId As String)
        RaiseEvent AddToCartClicked(productId)
    End Sub

End Class
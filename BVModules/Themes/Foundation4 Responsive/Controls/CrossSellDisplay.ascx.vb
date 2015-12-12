Imports System.Web
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.ComponentModel

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_CrossSellDisplay
    Inherits System.Web.UI.UserControl

    Public Event AddToCartClicked(ByVal productId As String)

    Private _maxItemsDisplayed As Integer = Integer.MaxValue
    Private _product As Catalog.Product = Nothing

    <ComponentModel.Browsable(True)> _
    Public Property MaxItemsDisplayed() As Integer
        Get
            Return _maxItemsDisplayed
        End Get
        Set(ByVal value As Integer)
            _maxItemsDisplayed = value
        End Set
    End Property

    <ComponentModel.Browsable(False)> _
    Public Property Product() As Catalog.Product
        Get
            Return _product
        End Get
        Set(ByVal value As Catalog.Product)
            _product = value
        End Set
    End Property

    'Properties of Single Product Display:
    Private _displayMode As Controls.SingleProductDisplayModes = BVSoftware.BVC5.Core.Controls.SingleProductDisplayModes.NoneUseCssClassPrefix
    Private _cssClassPrefix As String = String.Empty
    Private _displayName As Boolean = True
    Private _displayImage As Boolean = True
    Private _displayNewBadge As Boolean = WebAppSettings.NewProductBadgeAllowed
    Private _displayDescription As Boolean = False
    Private _displayPrice As Boolean = True
    Private _displayAddToCartButton As Boolean = False
    Private _displaySelectedCheckBox As Boolean = False
    Private _displayQuantity As Boolean = False
    Private _remainOnPageAfterAddToCart As Boolean = (Not WebAppSettings.RedirectToCartAfterAddProduct)
    Private _columns As Integer = 3

    <ComponentModel.Browsable(True)> _
    Public Property DisplayMode() As Controls.SingleProductDisplayModes
        Get
            Return _displayMode
        End Get
        Set(ByVal value As Controls.SingleProductDisplayModes)
            _displayMode = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property CssClassPrefix() As String
        Get
            Return _cssClassPrefix
        End Get
        Set(ByVal value As String)
            _cssClassPrefix = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayName() As Boolean
        Get
            Return _displayName
        End Get
        Set(ByVal value As Boolean)
            _displayName = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayImage() As Boolean
        Get
            Return _displayImage
        End Get
        Set(ByVal value As Boolean)
            _displayImage = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayNewBadge() As Boolean
        Get
            Return _displayNewBadge
        End Get
        Set(ByVal value As Boolean)
            _displayNewBadge = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayDescription() As Boolean
        Get
            Return _displayDescription
        End Get
        Set(ByVal value As Boolean)
            _displayDescription = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayPrice() As Boolean
        Get
            Return _displayPrice
        End Get
        Set(ByVal value As Boolean)
            _displayPrice = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayAddToCartButton() As Boolean
        Get
            Return _displayAddToCartButton
        End Get
        Set(ByVal value As Boolean)
            _displayAddToCartButton = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplaySelectedCheckBox() As Boolean
        Get
            Return _displaySelectedCheckBox
        End Get
        Set(ByVal value As Boolean)
            _displaySelectedCheckBox = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property DisplayQuantity() As Boolean
        Get
            Return _displayQuantity
        End Get
        Set(ByVal value As Boolean)
            _displayQuantity = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property RemainOnPageAfterAddToCart() As Boolean
        Get
            Return _remainOnPageAfterAddToCart
        End Get
        Set(ByVal value As Boolean)
            _remainOnPageAfterAddToCart = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property Columns() As Integer
        Get
            Return _columns
        End Get
        Set(ByVal value As Integer)
            _columns = value
        End Set
    End Property

    <ComponentModel.Browsable(True), DefaultValue("Recommended Products")> _
    Public Property Title() As String
        Get
            Return Me.TitleLabel.Text
        End Get
        Set(ByVal value As String)
            Me.TitleLabel.Text = value
        End Set
    End Property

    Protected Sub AddToCartClickedHandler(ByVal productId As String) Handles ProductGridDisplay.AddToCartClicked
        RaiseEvent AddToCartClicked(productId)
    End Sub

    Protected Overrides Function SaveViewState() As Object
        Dim state() As Object = New Object() {_maxItemsDisplayed, _product, _displayMode, _cssClassPrefix, _displayName, _displayImage, _displayNewBadge, _displayDescription, _displayPrice, _displayAddToCartButton, _displaySelectedCheckBox, _displayQuantity, _remainOnPageAfterAddToCart, _columns}
        Return New Pair(state, MyBase.SaveViewState)
    End Function

    Protected Overrides Sub LoadViewState(ByVal savedState As Object)
        If savedState IsNot Nothing Then
            Dim state As Pair = DirectCast(savedState, Pair)
            Dim objState() As Object = state.First
            _maxItemsDisplayed = DirectCast(objState(0), Integer)
            If objState(1) IsNot Nothing Then
                _product = DirectCast(objState(1), Catalog.Product)
            End If

            _displayMode = DirectCast(objState(2), Controls.SingleProductDisplayModes)
            _cssClassPrefix = DirectCast(objState(3), String)
            _displayName = DirectCast(objState(4), Boolean)
            _displayImage = DirectCast(objState(5), Boolean)
            _displayNewBadge = DirectCast(objState(6), Boolean)
            _displayDescription = DirectCast(objState(7), Boolean)
            _displayPrice = DirectCast(objState(8), Boolean)
            _displayAddToCartButton = DirectCast(objState(9), Boolean)
            _displaySelectedCheckBox = DirectCast(objState(10), Boolean)
            _displayQuantity = DirectCast(objState(11), Boolean)
            _remainOnPageAfterAddToCart = DirectCast(objState(12), Boolean)
            _columns = DirectCast(objState(13), Integer)

            MyBase.LoadViewState(state.Second)
        Else
            MyBase.LoadViewState(Nothing)
        End If
    End Sub

    Public Overrides Sub DataBind()
        If Me.Product IsNot Nothing Then
            Dim items As Collection(Of Catalog.Product) = Me.Product.GlobalProduct.GetCrossSells
            If items.Count > 0 Then
                While items.Count > _maxItemsDisplayed
                    items.RemoveAt(items.Count - 1)
                End While
                Me.Visible = True
                ProductGridDisplay.DataSource = items
                ProductGridDisplay.Columns = _columns
                ProductGridDisplay.DisplayMode = _displayMode
                ProductGridDisplay.CssClassPrefix = _cssClassPrefix
                ProductGridDisplay.DisplayImage = _displayImage
                ProductGridDisplay.DisplayNewBadge = _displayNewBadge
                ProductGridDisplay.DisplayName = _displayName
                ProductGridDisplay.DisplayDescription = _displayDescription
                ProductGridDisplay.DisplayPrice = _displayPrice
                ProductGridDisplay.DisplayAddToCartButton = _displayAddToCartButton
                ProductGridDisplay.DisplaySelectedCheckBox = _displaySelectedCheckBox
                ProductGridDisplay.DisplayQuantity = _displayQuantity
                ProductGridDisplay.RemainOnPageAfterAddToCart = _remainOnPageAfterAddToCart
                ProductGridDisplay.BindProducts()
            Else
                Me.Visible = False
            End If
        Else
            Me.Visible = False
        End If
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.TitleLabel.Text = If(String.IsNullOrEmpty(Me.Title), Content.SiteTerms.GetTerm("CrossSellTitle"), Me.Title)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


End Class

Imports System.Web
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.ComponentModel

Partial Class BVModules_Controls_CrossSellDisplay
    Inherits System.Web.UI.UserControl

    Public Event AddToCartClicked(ByVal productId As String)

    Private _displayDescriptions As Boolean = False
    Private _maxItemsDisplayed As Integer = Integer.MaxValue
    Private _product As Catalog.Product = Nothing
    Private _displayMode As Controls.SingleProductDisplayModes = BVSoftware.BVC5.Core.Controls.SingleProductDisplayModes.Wide
    Private _displayName As Boolean = True
    Private _displayImage As Boolean = True
    Private _displayNewBadge As Boolean = True
    Private _displayPrice As Boolean = True
    Private _productCssClassPrefix As String = String.Empty
    Private _displayAddToCartButton As Boolean = False
    Private _remainOnPageAfterAddToCart As Boolean = False
    Private _displaySelectedCheckBox As Boolean = False
    Private _displayQuantity As Boolean = False

    <ComponentModel.Browsable(True)> _
    Public Property MaxItemsDisplayed() As Integer
        Get
            Return _maxItemsDisplayed
        End Get
        Set(ByVal value As Integer)
            _maxItemsDisplayed = value
        End Set
    End Property

    <Category("Layout"), DefaultValue(3)> _
    Public Property RepeatColumns() As Integer
        Get
            Return CrossSellsDataList.RepeatColumns
        End Get
        Set(ByVal value As Integer)
            CrossSellsDataList.RepeatColumns = value
        End Set
    End Property

    <Category("Layout"), DefaultValue(RepeatDirection.Horizontal)> _
    Public Property RepeatDirection() As RepeatDirection
        Get
            Return CrossSellsDataList.RepeatDirection
        End Get
        Set(ByVal value As RepeatDirection)
            CrossSellsDataList.RepeatDirection = value
        End Set
    End Property

    <Category("Layout"), DefaultValue(RepeatLayout.Table)> _
    Public Property RepeatLayout() As RepeatLayout
        Get
            Return CrossSellsDataList.RepeatLayout
        End Get
        Set(ByVal value As RepeatLayout)
            CrossSellsDataList.RepeatLayout = value
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

    <ComponentModel.Browsable(True)> _
    Public Property DisplayDescriptions() As Boolean
        Get
            Return _displayDescriptions
        End Get
        Set(ByVal value As Boolean)
            _displayDescriptions = value
        End Set
    End Property

    <Browsable(True), Category("Layout"), TypeConverter(GetType(System.Web.UI.WebControls.UnitConverter))> _
    Public Property Height() As Unit
        Get
            Return Me.CrossSellsPanel.Height
        End Get
        Set(ByVal value As Unit)
            Me.CrossSellsPanel.Height = value
        End Set
    End Property

    <ComponentModel.Browsable(True), ComponentModel.Category("Layout")> _
    Public Property Width() As Unit
        Get
            Return Me.CrossSellsPanel.Width
        End Get
        Set(ByVal value As Unit)
            Me.CrossSellsPanel.Width = value
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
    Public Property DisplayPrice() As Boolean
        Get
            Return _displayPrice
        End Get
        Set(ByVal value As Boolean)
            _displayPrice = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property ProductCssClassPrefix() As String
        Get
            Return _productCssClassPrefix
        End Get
        Set(ByVal value As String)
            _productCssClassPrefix = value
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
    Public Property RemainOnPageAfterAddToCart() As Boolean
        Get
            Return _remainOnPageAfterAddToCart
        End Get
        Set(ByVal value As Boolean)
            _remainOnPageAfterAddToCart = value
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

    Protected Overrides Function SaveViewState() As Object
        Dim state() As Object = New Object() {_maxItemsDisplayed, _product, _displayDescriptions, _displayMode, _displayName, _displayImage, _displayNewBadge, _displayPrice, _productCssClassPrefix, _displayAddToCartButton, _remainOnPageAfterAddToCart, _displaySelectedCheckBox, _displayQuantity}
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
            _displayDescriptions = DirectCast(objState(2), Boolean)
            _displayMode = DirectCast(objState(3), Controls.SingleProductDisplayModes)
            _displayName = DirectCast(objState(4), Boolean)
            _displayImage = DirectCast(objState(5), Boolean)
            _displayNewBadge = DirectCast(objState(6), Boolean)
            _displayPrice = DirectCast(objState(7), Boolean)
            _productCssClassPrefix = DirectCast(objState(8), String)
            _displayAddToCartButton = DirectCast(objState(9), Boolean)
            _remainOnPageAfterAddToCart = DirectCast(objState(10), Boolean)
            _displaySelectedCheckBox = DirectCast(objState(11), Boolean)
            _displayQuantity = DirectCast(objState(12), Boolean)
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
                CrossSellsDataList.DataSource = items
                CrossSellsDataList.DataKeyField = "bvin"
                CrossSellsDataList.DataBind()
            Else
                Me.Visible = False
            End If
        Else
            Me.Visible = False
        End If
    End Sub

    Protected Sub CrossSellsDataList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles CrossSellsDataList.ItemDataBound
        If e.Item.DataItem IsNot Nothing Then
            Dim singleProductDisplay As BaseSingleProductDisplay = DirectCast(e.Item.FindControl("SingleProductDisplay"), BaseSingleProductDisplay)
            singleProductDisplay.DisplayDescription = _displayDescriptions
            singleProductDisplay.DisplayMode = _displayMode
            singleProductDisplay.DisplayName = _displayName
            singleProductDisplay.DisplayImage = _displayImage
            singleProductDisplay.DisplayNewBadge = _displayNewBadge
            singleProductDisplay.DisplayPrice = _displayPrice
            singleProductDisplay.CssClassPrefix = _productCssClassPrefix
            singleProductDisplay.DisplayAddToCartButton = _displayAddToCartButton
            singleProductDisplay.Quantity = 1
            singleProductDisplay.RemainOnPageAfterAddToCart = _remainOnPageAfterAddToCart
            singleProductDisplay.DisplaySelectedCheckBox = _displaySelectedCheckBox
            singleProductDisplay.DisplayQuantity = _displayQuantity
            AddHandler singleProductDisplay.AddToCartClicked, AddressOf AddToCartClickedHandler
            singleProductDisplay.LoadWithProduct(DirectCast(e.Item.DataItem, Catalog.Product))
        End If
    End Sub

    Protected Sub AddToCartClickedHandler(ByVal productId As String)
        RaiseEvent AddToCartClicked(productId)
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.TitleLabel.Text = If(String.IsNullOrEmpty(Me.Title), Content.SiteTerms.GetTerm("CrossSellTitle"), Me.Title)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.AddItemsToCartImageButton.ImageUrl = PersonalizationServices.GetThemedButton("AddSelectedItems")
        For Each row As DataListItem In Me.CrossSellsDataList.Items
            Dim singleProductDisplay As BaseSingleProductDisplay = DirectCast(row.FindControl("SingleProductDisplay"), BaseSingleProductDisplay)
            If singleProductDisplay IsNot Nothing Then
                AddHandler singleProductDisplay.AddToCartClicked, AddressOf AddToCartClickedHandler
            End If
        Next

        If _displaySelectedCheckBox Then
            Me.AddItemsToCartImageButton.Visible = True
            Me.AddItemsToCartImageButton.ImageUrl = PersonalizationServices.GetThemedButton("AddSelectedItems")
        Else
            Me.AddItemsToCartImageButton.Visible = False
        End If
    End Sub

    Public Function GetSelectedItems() As Collection(Of Orders.LineItem)
        Dim result As New Collection(Of Orders.LineItem)
        For Each item As DataListItem In CrossSellsDataList.Items
            For Each ctrl As Control In item.Controls
                If TypeOf ctrl Is BaseSingleProductDisplay Then
                    Dim singleProductDisplay As BaseSingleProductDisplay = DirectCast(ctrl, BaseSingleProductDisplay)
                    If singleProductDisplay.Selected Then
                        Dim lineItem As New Orders.LineItem()
                        lineItem.ProductId = singleProductDisplay.ProductId
                        lineItem.Quantity = singleProductDisplay.Quantity
                        result.Add(lineItem)
                    End If
                End If
            Next
        Next
        Return result
    End Function

    Protected Sub AddItemsToCartImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddItemsToCartImageButton.Click
        Dim items As Collection(Of Orders.LineItem) = Me.GetSelectedItems()
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        For Each item As Orders.LineItem In items
            Basket.AddItem(item)
        Next
        Response.Redirect("~/Cart.aspx")
    End Sub
End Class

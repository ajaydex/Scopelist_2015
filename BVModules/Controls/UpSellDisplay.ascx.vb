Imports System.Web
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.ComponentModel

Partial Class BVModules_Controls_UpSellDisplay
    Inherits System.Web.UI.UserControl

    Public Event AddToCartClicked(ByVal productId As String)

    Private _displayDescriptions As Boolean = False
    Private _maxItemsDisplayed As Integer = Integer.MaxValue
    Private _product As Catalog.Product = Nothing
    Private _displayMode As Controls.SingleProductDisplayModes = BVSoftware.Bvc5.Core.Controls.SingleProductDisplayModes.Wide
    Private _productCssClassPrefix As String = String.Empty
    Private _displayAddToCartButton As Boolean = False
    Private _quantity As Integer = 1

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
            Return UpSellsDataList.RepeatColumns
        End Get
        Set(ByVal value As Integer)
            UpSellsDataList.RepeatColumns = value
        End Set
    End Property

    <Category("Layout"), DefaultValue(RepeatDirection.Horizontal)> _
    Public Property RepeatDirection() As RepeatDirection
        Get
            Return UpSellsDataList.RepeatDirection
        End Get
        Set(ByVal value As RepeatDirection)
            UpSellsDataList.RepeatDirection = value
        End Set
    End Property

    <Category("Layout"), DefaultValue(RepeatLayout.Table)> _
    Public Property RepeatLayout() As RepeatLayout
        Get
            Return UpSellsDataList.RepeatLayout
        End Get
        Set(ByVal value As RepeatLayout)
            UpSellsDataList.RepeatLayout = value
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
            Return Me.UpSellsPanel.Height
        End Get
        Set(ByVal value As Unit)
            Me.UpSellsPanel.Height = value
        End Set
    End Property

    <ComponentModel.Browsable(True), ComponentModel.Category("Layout")> _
    Public Property Width() As Unit
        Get
            Return Me.UpSellsPanel.Width
        End Get
        Set(ByVal value As Unit)
            Me.UpSellsPanel.Width = value
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
    Public Property ProductCssClassPrefix() As String
        Get
            Return _productCssClassPrefix
        End Get
        Set(ByVal value As String)
            _productCssClassPrefix = value
        End Set
    End Property

    Public Property DisplayAddToCartButton() As Boolean
        Get
            Return _displayAddToCartButton
        End Get
        Set(ByVal value As Boolean)
            _displayAddToCartButton = value
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

    Protected Overrides Function SaveViewState() As Object
        Dim state() As Object = New Object() {_maxItemsDisplayed, _product, _displayDescriptions, _displayMode, _productCssClassPrefix, _displayAddToCartButton}
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
            _productCssClassPrefix = DirectCast(objState(4), String)
            _displayAddToCartButton = DirectCast(objState(5), Boolean)
            MyBase.LoadViewState(state.Second)
        Else
            MyBase.LoadViewState(Nothing)
        End If
    End Sub

    Public Overrides Sub DataBind()
        If Me.Product IsNot Nothing Then
            Dim items As Collection(Of Catalog.Product) = Me.Product.GlobalProduct.GetUpSells
            If items.Count > 0 Then
                While items.Count > _maxItemsDisplayed
                    items.RemoveAt(items.Count - 1)
                End While
                Me.Visible = True
                UpSellsDataList.DataSource = items
                UpSellsDataList.DataKeyField = "bvin"
                UpSellsDataList.DataBind()
            Else
                Me.Visible = False
            End If
        Else
            Me.Visible = False
        End If
    End Sub

    Protected Sub UpSellsDataList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles UpSellsDataList.ItemDataBound
        If e.Item.DataItem IsNot Nothing Then
            Dim singleProductDisplay As BaseSingleProductDisplay = DirectCast(e.Item.FindControl("SingleProductDisplay"), BaseSingleProductDisplay)
            singleProductDisplay.DisplayDescription = DisplayDescriptions
            singleProductDisplay.DisplayMode = DisplayMode
            singleProductDisplay.CssClassPrefix = ProductCssClassPrefix
            singleProductDisplay.DisplayAddToCartButton = DisplayAddToCartButton
            singleProductDisplay.Quantity = Me.Quantity
            AddHandler singleProductDisplay.AddToCartClicked, AddressOf AddToCartClickedHandler
            singleProductDisplay.LoadWithProduct(DirectCast(e.Item.DataItem, Catalog.Product))
        End If
    End Sub

    Protected Sub AddToCartClickedHandler(ByVal productId As String)
        RaiseEvent AddToCartClicked(productId)
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.TitleLabel.Text = Content.SiteTerms.GetTerm("UpSellTitle")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        For Each row As DataListItem In Me.UpSellsDataList.Items
            Dim singleProductDisplay As BaseSingleProductDisplay = DirectCast(row.FindControl("SingleProductDisplay"), BaseSingleProductDisplay)
            If singleProductDisplay IsNot Nothing Then
                AddHandler singleProductDisplay.AddToCartClicked, AddressOf AddToCartClickedHandler
            End If
        Next
    End Sub
End Class

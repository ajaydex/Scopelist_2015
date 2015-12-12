Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_ProductGridDisplay
    Inherits BVSoftware.BVC5.Core.Controls.BVBaseUserControl

    Private _DataSource As Object = Nothing
    Private _DataSourceType As Utilities.DataSourceType = Utilities.DataSourceType.None
    Private _Columns As Integer = 3
    Private _NumberOfItems As Integer = -1

    Private _displayMode As Controls.SingleProductDisplayModes = BVSoftware.BVC5.Core.Controls.SingleProductDisplayModes.NoneUseCssClassPrefix
    Private _cssClassPrefix As String = String.Empty
    Private _displayName As Boolean = True
    Private _displayDescription As Boolean = False
    Private _displayPrice As Boolean = True
    Private _displayListPrice As Boolean = True
    Private _displayAddToCartButton As Boolean = False
    Private _displaySelectedCheckBox As Boolean = False
    Private _displayQuantity As Boolean = False
    Private _remainOnPageAfterAddToCart As Boolean = (Not WebAppSettings.RedirectToCartAfterAddProduct)
    Private _displayImage As Boolean = True
    Private _displayNewBadge As Boolean = WebAppSettings.NewProductBadgeAllowed

    Public Event AddToCartClicked(ByVal productId As String)

#Region " Properties "

    Public Property DisplayMode As Controls.SingleProductDisplayModes
        Get
            Return _displayMode
        End Get
        Set(value As Controls.SingleProductDisplayModes)
            _displayMode = value
        End Set
    End Property

    Public Property CssClassPrefix As String
        Get
            Return _cssClassPrefix
        End Get
        Set(value As String)
            _cssClassPrefix = value
        End Set
    End Property

    Public Property DisplayName As Boolean
        Get
            Return _displayName
        End Get
        Set(value As Boolean)
            _displayName = value
        End Set
    End Property

    Public Property DisplayDescription As Boolean
        Get
            Return _displayDescription
        End Get
        Set(value As Boolean)
            _displayDescription = value
        End Set
    End Property

    Public Property DisplayPrice As Boolean
        Get
            Return _displayPrice
        End Get
        Set(value As Boolean)
            _displayPrice = value
        End Set
    End Property

    Public Property DisplayListPrice As Boolean
        Get
            Return _displayListPrice
        End Get
        Set(value As Boolean)
            _displayListPrice = value
        End Set
    End Property

    Public Property DisplayAddToCartButton As Boolean
        Get
            Return _displayAddToCartButton
        End Get
        Set(value As Boolean)
            _displayAddToCartButton = value
        End Set
    End Property

    Public Property DisplaySelectedCheckBox As Boolean
        Get
            Return _displaySelectedCheckBox
        End Get
        Set(value As Boolean)
            _displaySelectedCheckBox = value
        End Set
    End Property

    Public Property DisplayQuantity As Boolean
        Get
            Return _displayQuantity
        End Get
        Set(value As Boolean)
            _displayQuantity = value
        End Set
    End Property

    Public Property RemainOnPageAfterAddToCart As Boolean
        Get
            Return _remainOnPageAfterAddToCart
        End Get
        Set(value As Boolean)
            _remainOnPageAfterAddToCart = value
        End Set
    End Property

    Public Property DisplayImage As Boolean
        Get
            Return _displayImage
        End Get
        Set(value As Boolean)
            _displayImage = value
        End Set
    End Property

    Public Property DisplayNewBadge As Boolean
        Get
            Return _displayNewBadge
        End Get
        Set(value As Boolean)
            _displayNewBadge = value
        End Set
    End Property

    Public Overrides ReadOnly Property DefaultCssClass As String
        Get
            Return "singleProductDisplayGrid"
        End Get
    End Property

    Public Property DataSource() As Object
        Get
            Return Me._DataSource
        End Get
        Set(ByVal value As Object)
            Me._DataSource = value

            Dim type As System.Type = value.GetType()
            If type Is GetType(Collection(Of Catalog.Product)) Then
                Me._DataSourceType = Utilities.DataSourceType.Collection
            ElseIf type Is GetType(System.Data.DataSet) Then
                Me._DataSourceType = Utilities.DataSourceType.DataSet
            ElseIf type Is GetType(System.Data.DataTable) Then
                Me._DataSourceType = Utilities.DataSourceType.DataTable
            ElseIf type Is GetType(List(Of Catalog.Product)) Then
                Me._DataSourceType = Utilities.DataSourceType.List
            Else
                Throw New NotSupportedException("Unsupported DataSource type")
            End If
        End Set
    End Property

    Public ReadOnly Property DataSouceType() As Utilities.DataSourceType
        Get
            Return Me._DataSourceType
        End Get
    End Property

    Public ReadOnly Property NumberOfItems() As Integer
        Get
            If Me._NumberOfItems = -1 Then
                If Me.DataSource IsNot Nothing Then
                    Select Case Me.DataSouceType
                        Case Utilities.DataSourceType.Collection
                            Me._NumberOfItems = CType(Me.DataSource, Collection(Of Catalog.Product)).Count

                        Case Utilities.DataSourceType.DataSet
                            Dim ds As System.Data.DataSet = CType(Me.DataSource, System.Data.DataSet)
                            If ds.Tables.Count > 0 Then
                                Me._NumberOfItems = ds.Tables(0).Rows.Count
                            End If

                        Case Utilities.DataSourceType.DataTable
                            Me._NumberOfItems = CType(Me.DataSource, System.Data.DataTable).Rows.Count

                        Case Utilities.DataSourceType.List
                            Me._NumberOfItems = CType(Me.DataSource, List(Of Catalog.Product)).Count

                    End Select
                End If
            End If

            If Me._NumberOfItems = -1 Then
                Me._NumberOfItems = 0
            End If

            Return Me._NumberOfItems
        End Get
    End Property

    Public ReadOnly Property HasItemsWithoutChoices() As Boolean
        Get
            Dim result As Boolean = False
            For Each gridItem As RepeaterItem In rpProductGrid.Items
                Dim selectedCheckBox As CheckBox = CType(gridItem.FindControl("SingleProductDisplay").FindControl("SelectedCheckBox"), CheckBox)
                If selectedCheckBox IsNot Nothing Then
                    If selectedCheckBox.Visible Then
                        result = True
                        Exit For
                    End If
                End If
            Next
            Return result
        End Get
    End Property

    Public Property Columns() As Integer
        Get
            Return Me._Columns
        End Get
        Set(ByVal value As Integer)
            Me._Columns = value
        End Set
    End Property

#End Region

    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)

        Me.EnableViewState = False
    End Sub

    Protected Sub AddToCartClickedHandler(ByVal productId As String)
        RaiseEvent AddToCartClicked(productId)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Add to cart button
        Me.AddItemsToCartImageButton.ImageUrl = PersonalizationServices.GetThemedButton("AddSelectedItems")
        For Each row As RepeaterItem In Me.rpProductGrid.Items
            Dim singleProductDisplay As BaseSingleProductDisplay = DirectCast(row.FindControl("SingleProductDisplay"), BaseSingleProductDisplay)
            If singleProductDisplay IsNot Nothing Then
                AddHandler singleProductDisplay.AddToCartClicked, AddressOf AddToCartClickedHandler
            End If
        Next

        Me.AddItemsToCartImageButton.EnableCallBack = _remainOnPageAfterAddToCart
    End Sub

    Public Sub BindProducts()
        Me.rpProductGrid.DataSource = Me.DataSource
        Me.rpProductGrid.DataBind()

        ' Hide add selected to cart button if all products have choices
        If Me.HasItemsWithoutChoices Then
            Me.AddItemsToCartImageButton.Visible = _displaySelectedCheckBox
            Me.AddItemsToCartImageButton.ImageUrl = PersonalizationServices.GetThemedButton("AddSelectedItems")
        Else
            Me.AddItemsToCartImageButton.Visible = False
        End If
    End Sub

    Public Function GetSelectedItems() As Collection(Of Orders.LineItem)
        Dim result As New Collection(Of Orders.LineItem)
        For Each item As RepeaterItem In rpProductGrid.Items
            Dim ctrl As BaseSingleProductDisplay = item.FindControl("SingleProductDisplay")
            Dim singleProductDisplay As BaseSingleProductDisplay = DirectCast(ctrl, BaseSingleProductDisplay)
            If singleProductDisplay IsNot Nothing Then
                If singleProductDisplay.Selected Then
                    Dim lineItem As New Orders.LineItem()
                    lineItem.ProductId = singleProductDisplay.ProductId
                    lineItem.Quantity = singleProductDisplay.Quantity
                    result.Add(lineItem)
                End If
            End If
        Next
        Return result
    End Function

    Protected Sub AddItemsToCartImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddItemsToCartImageButton.Click
        Dim items As Collection(Of Orders.LineItem) = Me.GetSelectedItems()
        Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
        For Each item As Orders.LineItem In items
            Basket.AddItem(item)
        Next
        RaiseEvent AddToCartClicked(String.Empty)
        If AddItemsToCartImageButton.EnableCallBack = False Then
            Response.Redirect("~/Cart.aspx")
        End If
    End Sub

    Protected Sub rpProductGrid_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rpProductGrid.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim p As Catalog.Product = Nothing
            Select Case Me.DataSouceType
                Case Utilities.DataSourceType.Collection, Utilities.DataSourceType.List
                    p = CType(e.Item.DataItem, Catalog.Product)

                Case Utilities.DataSourceType.DataSet, Utilities.DataSourceType.DataTable
                    Dim dr As System.Data.DataRow = CType(e.Item.DataItem, System.Data.DataRow)
                    p = Catalog.InternalProduct.ConvertDataRow(dr)

            End Select

            Dim holder As Panel = e.Item.FindControl("holder")
            holder.CssClass = GetColumnClassName()

            Dim ucSingleProductDisplay As BaseSingleProductDisplay = e.Item.FindControl("SingleProductDisplay")
            If ucSingleProductDisplay IsNot Nothing Then
                ucSingleProductDisplay.DisplayMode = Me.DisplayMode
                ucSingleProductDisplay.CssClassPrefix = Me.CssClassPrefix
                ucSingleProductDisplay.DisplayName = Me.DisplayName
                ucSingleProductDisplay.DisplayImage = Me.DisplayImage
                ucSingleProductDisplay.DisplayNewBadge = Me.DisplayNewBadge
                ucSingleProductDisplay.DisplayDescription = Me.DisplayDescription
                ucSingleProductDisplay.DisplayPrice = Me.DisplayPrice
                ucSingleProductDisplay.DisplayListPrice = Me.DisplayListPrice
                ucSingleProductDisplay.DisplayAddToCartButton = Me.DisplayAddToCartButton
                ucSingleProductDisplay.DisplaySelectedCheckBox = Me.DisplaySelectedCheckBox
                ucSingleProductDisplay.DisplayQuantity = Me.DisplayQuantity
                ucSingleProductDisplay.RemainOnPageAfterAddToCart = Me.RemainOnPageAfterAddToCart
                ucSingleProductDisplay.LoadWithProduct(p)
            End If
        End If
    End Sub

    Private Function GetColumnClassName() As String
        Return String.Format("large-{0} columns", (12 / Columns).ToString())
    End Function

End Class
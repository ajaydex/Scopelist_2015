Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_ProductTableDisplay
    Inherits BVSoftware.Bvc5.Core.Controls.BVBaseUserControl

    Dim pricingWorkflow As BusinessRules.Workflow = Nothing

    Private _DisplayShortDescription As Boolean = True
    Private _DisplaySku As Boolean = True
    Private _DataSource As Object = Nothing
    Private _DataSourceType As Utilities.DataSourceType = Utilities.DataSourceType.None
    Private _NumberOfItems As Integer = -1

#Region " Properties "

    Public Overrides ReadOnly Property DefaultCssClass As String
        Get
            Return "singleProductDisplayTable"
        End Get
    End Property

    Public Property DisplayShortDescription As Boolean
        Get
            Return Me._DisplayShortDescription
        End Get
        Set(ByVal value As Boolean)
            Me._DisplayShortDescription = value
        End Set
    End Property

    Public Property DisplaySku As Boolean
        Get
            Return Me._DisplaySku
        End Get
        Set(ByVal value As Boolean)
            Me._DisplaySku = value
        End Set
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

#End Region

    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)

        Me.EnableViewState = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
    End Sub

    Public Overrides Sub RenderControl(ByVal htw As System.Web.UI.HtmlTextWriter)
        Me.BindProducts()
        MyBase.RenderControl(htw)
    End Sub

    Private Sub BindProducts()
        If Me.NumberOfItems > 0 Then
            pricingWorkflow = BusinessRules.Workflow.FindByName("Product Pricing")

            Me.rpProductTable.DataSource = Me.DataSource
            Me.rpProductTable.DataBind()
        End If
    End Sub

    Protected Sub rpProductList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rpProductTable.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim p As Catalog.Product = Nothing

            Select Case Me.DataSouceType
                Case Utilities.DataSourceType.Collection, Utilities.DataSourceType.List
                    p = CType(e.Item.DataItem, Catalog.Product)

                Case Utilities.DataSourceType.DataSet, Utilities.DataSourceType.DataTable
                    Dim dr As System.Data.DataRow = CType(e.Item.DataItem, System.Data.DataRow)
                    p = Catalog.InternalProduct.ConvertDataRow(dr)

            End Select


            Dim destinationUrl As String = Utilities.UrlRewriter.BuildUrlForProduct(p, Me.Page.Request)

            Dim lnkImage As HyperLink = CType(e.Item.FindControl("lnkImage"), HyperLink)
            If lnkImage IsNot Nothing Then
                lnkImage.ToolTip = p.ProductName
                lnkImage.ImageUrl = Me.Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(p.ImageFileSmall, True))
                lnkImage.NavigateUrl = destinationUrl
            End If

            Dim imgNewBadge As Image = CType(e.Item.FindControl("imgNewBadge"), Image)
            If imgNewBadge IsNot Nothing Then
                If WebAppSettings.NewProductBadgeAllowed AndAlso p.IsNew Then
                    imgNewBadge.ImageUrl = PersonalizationServices.GetThemedButton("Misc/NewProduct")
                    imgNewBadge.AlternateText = "New"
                Else
                    imgNewBadge.Visible = False
                End If
            End If

            Dim lblSku As Label = CType(e.Item.FindControl("lblSku"), Label)
            If lblSku IsNot Nothing Then
                If Me.DisplaySku Then
                    lblSku.Text = p.Sku
                Else
                    lblSku.Visible = False
                End If
            End If

            Dim lnkProductName As HyperLink = e.Item.FindControl("lnkProductName")
            If lnkProductName IsNot Nothing Then
                lnkProductName.Text = p.ProductName
                lnkProductName.ToolTip = p.MetaTitle
                lnkProductName.NavigateUrl = destinationUrl
            End If

            Dim litShortDescription As Literal = CType(e.Item.FindControl("litShortDescription"), Literal)
            If litShortDescription IsNot Nothing Then
                If Me.DisplayShortDescription Then
                    If Not String.IsNullOrEmpty(p.ShortDescription) Then
                        litShortDescription.Text = String.Format("<div>{0}</div>", p.ShortDescription)
                    End If
                Else
                    litShortDescription.Visible = False
                End If
            End If

            Dim lblSitePrice As Label = e.Item.FindControl("lblSitePrice")
            If lblSitePrice IsNot Nothing Then
                lblSitePrice.Text = p.GetSitePriceForDisplay(0D, pricingWorkflow)
            End If

            Dim ucAddToCartButtonRemote As BVModules_Controls_AddToCartButtonRemote = CType(e.Item.FindControl("ucAddToCartButtonRemote"), BVModules_Controls_AddToCartButtonRemote)
            If ucAddToCartButtonRemote IsNot Nothing Then
                ucAddToCartButtonRemote.LocalProduct = p
            End If
        End If
    End Sub

End Class
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_ProductListDisplay
    Inherits BVSoftware.Bvc5.Core.Controls.BVBaseUserControl

    Private _DataSource As Object
    Private _DataSourceType As Utilities.DataSourceType = Utilities.DataSourceType.None
    Private _NumberOfItems As Integer = -1

#Region " Properties "

    Public Overrides ReadOnly Property DefaultCssClass As String
        Get
            Return "singleProductDisplayList"
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
        Me.rpProductList.DataSource = Me.DataSource
        Me.rpProductList.DataBind()
    End Sub

    Protected Sub rpProductList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rpProductList.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim p As Catalog.Product = Nothing

            Select Case Me.DataSouceType
                Case Utilities.DataSourceType.Collection, Utilities.DataSourceType.List
                    p = CType(e.Item.DataItem, Catalog.Product)

                Case Utilities.DataSourceType.DataSet, Utilities.DataSourceType.DataTable
                    Dim dr As System.Data.DataRow = CType(e.Item.DataItem, System.Data.DataRow)
                    p = Catalog.InternalProduct.ConvertDataRow(dr)

            End Select

            Dim lnkProduct As HyperLink = e.Item.FindControl("lnkProduct")
            If lnkProduct IsNot Nothing Then
                lnkProduct.ToolTip = p.MetaTitle
                lnkProduct.NavigateUrl = Utilities.UrlRewriter.BuildUrlForProduct(p, Me.Page.Request)
            End If

            Dim lblProductName As Label = e.Item.FindControl("lblProductName")
            If lblProductName IsNot Nothing Then
                lblProductName.Text = p.ProductName
            End If

            Dim lblProductPrice As Label = e.Item.FindControl("lblProductPrice")
            If lblProductPrice IsNot Nothing Then
                lblProductPrice.Text = p.SitePrice.ToString("c")
            End If
        End If
    End Sub

End Class
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_ProductGridDisplay
    Inherits BVSoftware.Bvc5.Core.Controls.BVBaseUserControl

    Private _DataSource As Object = Nothing
    Private _DataSourceType As Utilities.DataSourceType = Utilities.DataSourceType.None
    Private _Columns As Integer = 3
    Private _NumberOfItems As Integer = -1

#Region " Properties "

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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Public Overrides Sub RenderControl(ByVal htw As System.Web.UI.HtmlTextWriter)
        Me.BindProducts()
        MyBase.RenderControl(htw)
    End Sub

    Private Sub BindProducts()
        Me.rpProductGrid.DataSource = Me.DataSource
        Me.rpProductGrid.DataBind()
    End Sub

    Protected Sub rpProductGrid_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rpProductGrid.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then

            ' add opening <tr>
            If e.Item.ItemIndex Mod Me.Columns = 0 Then
                e.Item.Controls.AddAt(0, New LiteralControl("<tr>"))
            End If

            Dim p As Catalog.Product = Nothing

            Select Case Me.DataSouceType
                Case Utilities.DataSourceType.Collection, Utilities.DataSourceType.List
                    p = CType(e.Item.DataItem, Catalog.Product)

                Case Utilities.DataSourceType.DataSet, Utilities.DataSourceType.DataTable
                    Dim dr As System.Data.DataRow = CType(e.Item.DataItem, System.Data.DataRow)
                    p = Catalog.InternalProduct.ConvertDataRow(dr)

            End Select

            Dim ucSingleProductDisplay As BaseSingleProductDisplay = e.Item.FindControl("ucSingleProductDisplay")
            If ucSingleProductDisplay IsNot Nothing Then
                ucSingleProductDisplay.DisplayMode = BVSoftware.Bvc5.Core.Controls.SingleProductDisplayModes.NoneUseCssClassPrefix
                ucSingleProductDisplay.CssClassPrefix = String.Empty
                ucSingleProductDisplay.LoadWithProduct(p)
            End If

            ' add closing </tr>
            If Me.NumberOfItems >= Me.Columns AndAlso e.Item.ItemIndex Mod Me.Columns = Me.Columns - 1 Then
                e.Item.Controls.Add(New LiteralControl("</tr>"))
            End If

            ' add missing <td></td> and closing </tr> elements to complete table
            If e.Item.ItemIndex = Me.NumberOfItems - 1 AndAlso e.Item.ItemIndex Mod Me.Columns <> Me.Columns - 1 Then
                Dim tdCount As Integer = 0

                If Me.NumberOfItems < Me.Columns Then
                    tdCount = Me.Columns - Me.NumberOfItems
                Else
                    tdCount = (e.Item.ItemIndex + 1) Mod Me.Columns
                End If

                For i As Integer = 0 To tdCount - 1
                    e.Item.Controls.Add(New LiteralControl("<td></td>"))
                Next

                If tdCount > 0 Then
                    e.Item.Controls.Add(New LiteralControl("</tr>"))
                End If
            End If
        End If
    End Sub

End Class
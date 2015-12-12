Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_ContentBlocks_Top_10_Products_adminview
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadProducts()
        End If
    End Sub

    Private Sub LoadProducts()
        Dim s As New Date(1900, 1, 1)
        Dim e As New Date(3000, 12, 31)
        Dim t As Data.DataTable = Catalog.InternalProduct.FindTotalProductsOrdered(s, e)

        Dim c As New Collection(Of Catalog.Product)

        Dim i As Integer = 0

        For Each mydatarow As Data.DataRow In t.Rows
            If i < 10 Then
                Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(mydatarow.Item(0).ToString)
                If p.ParentId = String.Empty Then
                    If Not p.Status = Catalog.ProductStatus.Disabled Then
                        If Not c.Contains(p) Then
                            c.Add(p)
                            i += 1
                        End If
                    End If
                Else
                    p = Catalog.InternalProduct.FindByBvin(p.ParentId)
                    If p.Status <> Catalog.ProductStatus.Disabled Then
                        If Not c.Contains(p) Then
                            c.Add(p)
                            i += 1
                        End If
                    End If
                End If
            End If
        Next

        Me.GridView1.DataSource = c
        Me.GridView1.DataBind()

    End Sub

End Class

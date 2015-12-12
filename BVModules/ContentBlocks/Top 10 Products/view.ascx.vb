Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_ContentBlocks_Top_10_Products_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadProducts()
    End Sub

    Private Sub LoadProducts()
        Dim s As New Date(1900, 1, 1)
        Dim e As New Date(3000, 12, 31)
        Dim products As Collection(Of Catalog.Product) = Catalog.InternalProduct.FindTopSellingProducts(s, e, False, 10)

        RenderList(products)
    End Sub

    Private Sub RenderList(ByVal products As Collection(Of Catalog.Product))
        If products IsNot Nothing Then
            Me.ProductList.Controls.Clear()
            Me.ProductList.Text = String.Empty

            Dim sb As New StringBuilder
            If products.Count > 0 Then
                sb.Append("<ol>")
                For i As Integer = 0 To products.Count - 1
                    sb.Append(RenderProduct(products(i)))
                Next
                sb.Append("</ol>")
                Me.ProductList.Text = sb.ToString()
            End If
        End If
    End Sub

    Private Function RenderProduct(ByVal p As Catalog.Product) As String
        Dim result As String = String.Empty

        If p IsNot Nothing Then
            result += "<li><a href="""
            result += p.ProductURL
            result += """ title="""
            result += p.ProductName
            result += """>"
            result += p.ProductName
            result += " - "
            result += p.SitePrice.ToString("c")
            result += "</a></li>"
        End If

        Return result
    End Function

End Class
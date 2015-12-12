Imports System.Collections.ObjectModel
Imports System.IO
Imports System.Linq
Imports BVSoftware.Bvc5.Core
Imports System.Net
Imports System.Data.SqlClient
Imports Newtonsoft.Json
Imports System.Collections.Generic

Partial Class GetProductInfo
    Inherits System.Web.UI.Page

    Protected _Products As Collection(Of Catalog.Product)

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Custom.master")
    End Sub

    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim url As String = Request.Url.ToString()
        If url.Contains("=") Then
            Dim SKU As String = url.Split("=")(1)
            If Not SKU.Contains("http://") Then
                GenerateProduct(SKU)
            Else
                GenerateProducts(SKU)
            End If
        End If
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        If Not String.IsNullOrEmpty(txtSKU.Text) Then
            GenerateProduct(txtSKU.Text)
        Else
            ltlJson.Text = "Invalid product"
        End If
    End Sub

    Protected Sub btnClearForm_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClearForm.Click
        Me.txtSKU.Text = String.Empty
        ltlJson.Text = String.Empty
    End Sub

    Protected Sub GenerateProduct(ByVal sku As String)
        Dim p As Catalog.Product = Catalog.InternalProduct.FindBySku(sku)

        If Not p Is Nothing Then
            Dim productInfo As ProductInfo = New ProductInfo()
            productInfo.Quantity = p.QuantityAvailable
            productInfo.SKU = p.Sku
            Dim jsonProduct As String = JsonConvert.SerializeObject(productInfo)

            Response.Clear()
            Response.ContentType = "application/json;"
            Response.Write(jsonProduct)
            Response.End()
        Else
            Dim productInfo As ProductInfo = New ProductInfo()
            productInfo.Quantity = "-10"
            productInfo.SKU = txtSKU.Text
            Dim jsonProduct As String = JsonConvert.SerializeObject(productInfo)
            Response.Clear()
            Response.ContentType = "application/json;"
            Response.Write(jsonProduct)
            Response.End()
        End If
    End Sub

    Protected Sub GenerateProducts(ByVal url As String)

        Dim client As WebClient = New WebClient()
        Dim productInfoList As List(Of ProductInfo) = New List(Of ProductInfo)()

        Dim skuList() As String
        skuList = client.DownloadString(url).Split(",")

        If Not skuList Is Nothing Then
            For Each sku In skuList
                Dim p As Catalog.Product = Catalog.InternalProduct.FindBySku(sku)
                If Not p Is Nothing Then
                    If p.QuantityAvailable <> 0 Then
                        productInfoList.Add(New ProductInfo(p.QuantityAvailable, p.Sku))
                    Else
                        productInfoList.Add(New ProductInfo(-10, p.Sku))
                    End If
                Else
                    productInfoList.Add(New ProductInfo(-10, sku))
                End If
            Next
        Else
            ltlJson.Text = "Invalid Url"
        End If

        Dim jsonProducts As String = JsonConvert.SerializeObject(productInfoList)
        jsonProducts = jsonProducts.Replace("""SKU""", String.Empty)
        jsonProducts = jsonProducts.Replace("},{:", ",")
        jsonProducts = jsonProducts.Replace("""Quantity""", String.Empty)
        jsonProducts = jsonProducts.Replace(",:", ":")
        jsonProducts = jsonProducts.Replace("[{:", "{")
        jsonProducts = jsonProducts.Replace("}]", "}")

        Response.Clear()
        Response.ContentType = "application/json;"
        Response.Write(jsonProducts)
        Response.End()

    End Sub

End Class


Public Class ProductInfo

    Public Sub New()

    End Sub

    Public Sub New(ByVal q As String, ByVal sku As String)
        Me.SKU = sku
        Me.Quantity = q
    End Sub

    Private _SKU As String
    Public Property SKU() As String
        Get
            Return _SKU
        End Get
        Set(ByVal value As String)
            _SKU = value
        End Set
    End Property

    Private _Quantity As String
    Public Property Quantity() As String
        Get
            Return _Quantity
        End Get
        Set(ByVal value As String)
            _Quantity = value
        End Set
    End Property

End Class

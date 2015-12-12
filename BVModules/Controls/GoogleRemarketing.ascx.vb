Imports System.Linq
Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Partial Class BVModules_Controls_GoogleRemarketing
    Inherits System.Web.UI.UserControl

    Private _ConversionId As String = String.Empty

    Private _ecomm_prodid As New StringCollection()
    Private _ecomm_pagetype As String = "other"
    Private _ecomm_totalvalue As Decimal = 0D

#Region " Properties "

    Public Property ConversionId() As String
        Get
            Return Me._ConversionId
        End Get
        Set(value As String)
            Me._ConversionId = value
        End Set
    End Property

    Public ReadOnly Property ecomm_prodid() As String
        Get
            Dim sb As New StringBuilder()

            For Each prodid As String In _ecomm_prodid
                If sb.Length > 0 Then
                    sb.Append(",")
                End If

                sb.AppendFormat("""{0}""", prodid)
            Next

            If sb.Length > 0 Then
                sb.Insert(0, "[")
                sb.Append("]")
            Else
                sb.Append("""""")
            End If

            Return sb.ToString()
        End Get
    End Property

    Public ReadOnly Property ecomm_pagetype() As String
        Get
            Return Me._ecomm_pagetype
        End Get
    End Property

    Public ReadOnly Property ecomm_totalvalue() As String
        Get
            Return _ecomm_totalvalue.ToString()
        End Get
    End Property

#End Region


    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)

        Me.EnableViewState = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not String.IsNullOrEmpty(Me.ConversionId) Then
            If Me.Page IsNot Nothing AndAlso Me.Request IsNot Nothing AndAlso Me.Request.RawUrl IsNot Nothing Then
                Dim pageUrl As String = Me.Request.RawUrl.Replace(Me.Request.ApplicationPath, "/").ToLower()

                If pageUrl.StartsWith("/default.aspx") Then
                    ' home
                    _ecomm_pagetype = "home"
                ElseIf pageUrl.StartsWith("/cart.aspx") Then
                    ' cart
                    _ecomm_pagetype = "cart"

                    If SessionManager.CurrentUserHasCart() Then
                        Me.ParseOrder(SessionManager.CurrentShoppingCart())
                    End If
                ElseIf pageUrl.StartsWith("/receipt.aspx") Then
                    ' purchase
                    _ecomm_pagetype = "purchase"

                    If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
                        Me.ParseOrder(Orders.Order.FindByBvin(Request.QueryString("id")))
                    End If
                ElseIf TypeOf Me.Page Is BaseStoreProductPage Then
                    ' product
                    _ecomm_pagetype = "product"

                    Dim p As Catalog.Product = CType(Me.Page, BaseStoreProductPage).LocalParentProduct
                    If p IsNot Nothing AndAlso Not String.IsNullOrEmpty(p.Bvin) Then
                        _ecomm_prodid.Add(p.Sku)
                        _ecomm_totalvalue = p.SitePrice
                    End If
                ElseIf TypeOf Me.Page Is BaseStoreCategoryPage Then
                    ' category
                    _ecomm_pagetype = "category"
                ElseIf TypeOf Me.Page Is BaseSearchPage Then
                    ' searchresults
                    _ecomm_pagetype = "searchresults"
                End If
            End If
        End If
    End Sub

    Protected Overrides Sub Render(writer As System.Web.UI.HtmlTextWriter)
        If Not String.IsNullOrEmpty(Me.ConversionId) Then
            Dim sb As New StringBuilder()

            sb.AppendLine("<!-- Google Code for Remarketing Tag -->")
            sb.AppendLine("<script type=""text/javascript"">")
            sb.AppendLine("var google_tag_params = {")
            sb.AppendFormat("ecomm_prodid:  {0},{1}", Me.ecomm_prodid, vbNewLine)
            sb.AppendFormat("ecomm_pagetype:  '{0}',{1}", Me.ecomm_pagetype, vbNewLine)
            sb.AppendFormat("ecomm_totalvalue:  {0}{1}", Me.ecomm_totalvalue, vbNewLine)
            sb.AppendLine("};")
            sb.AppendLine("</script>")
            sb.AppendLine("<script type=""text/javascript"">")
            sb.AppendLine("/* <![CDATA[ */")
            sb.AppendFormat("var google_conversion_id = {0};{1}", Me.ConversionId, vbNewLine)
            sb.AppendLine("var google_custom_params = window.google_tag_params;")
            sb.AppendLine("var google_remarketing_only = true;")
            sb.AppendLine("/* ]]> */")
            sb.AppendLine("</script>")
            sb.AppendLine("<script type=""text/javascript"" src=""//www.googleadservices.com/pagead/conversion.js"">")
            sb.AppendLine("</script>")
            sb.AppendLine("<noscript>")
            sb.AppendLine("<div style=""display:inline;"">")
            sb.AppendFormat("<img height=""1"" width=""1"" style=""border-style:none;"" alt="""" src=""//googleads.g.doubleclick.net/pagead/viewthroughconversion/{0}/?value={1}&amp;guid=ON&amp;script=0""/>{2}", Me.ConversionId, Me.ecomm_totalvalue.ToString(), vbNewLine)
            sb.AppendLine("</div>")
            sb.AppendLine("</noscript>")

            writer.Write(sb.ToString())

            sb = Nothing
        End If
    End Sub

    Private Sub ParseOrder(ByVal o As Orders.Order)
        _ecomm_prodid = New StringCollection()
        _ecomm_totalvalue = 0D

        If o IsNot Nothing AndAlso Not String.IsNullOrEmpty(o.Bvin) Then
            _ecomm_totalvalue = (o.SubTotal - o.OrderDiscounts)

            For Each li As Orders.LineItem In o.Items
                _ecomm_prodid.Add(li.ProductSku)
            Next
        End If
    End Sub

End Class
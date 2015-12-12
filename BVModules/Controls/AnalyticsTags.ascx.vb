Imports System.Linq
Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_AnalyticsTags
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If WebAppSettings.AnalyticsUseGoogleTracker Then
            RenderGoogleTracker(WebAppSettings.AnalyticsGoogleTrackingId)
        End If

        If WebAppSettings.GoogleTrustedStoresEnabled Then
            RenderGoogleTrustedStoresBadge(WebAppSettings.GoogleTrustedStoresAccountID, _
                                           WebAppSettings.GoogleShoppingAccountID, _
                                           WebAppSettings.GoogleShoppingCountry, _
                                           WebAppSettings.GoogleShoppingLanguage)
        End If

        If WebAppSettings.AnalyticsUseGoogleTagManager Then
            RenderGoogleTagManager(WebAppSettings.AnalyticsGoogleTagManagerContainerId)
        End If
    End Sub

    Public Sub RenderGoogleTracker(ByVal googleId As String)
        Dim sb As New StringBuilder()

        sb.AppendLine("<!-- Google Analytics -->")
        sb.AppendLine("<script async src='//www.google-analytics.com/analytics.js'></script>")
        sb.AppendLine("<script>")
        sb.AppendLine("window.ga=window.ga||function(){(ga.q=ga.q||[]).push(arguments)};ga.l=+new Date;")
        sb.AppendFormat("ga('create', '{0}', {{ 'userId': '{1}' }});{2}", googleId, SessionManager.GetCurrentUserId(), vbNewLine)
        If WebAppSettings.AnalyticsGoogleUseDisplayFeatures Then
            sb.AppendLine("ga('require', 'displayfeatures');")
        End If
        If WebAppSettings.AnalyticsGoogleUseEnhancedLinkAttribution Then
            sb.AppendLine("ga('require', 'linkid');")
        End If
        If WebAppSettings.AnalyticsUseGoogleEcommerce Then
            sb.AppendLine("ga('require', 'ec');")

            If Me.Page IsNot Nothing Then
                Dim pageUrl As String = Me.Request.RawUrl.Replace(Me.Request.ApplicationPath, "/").ToLower()

                If TypeOf Me.Page Is BaseStoreProductPage Then
                    ' Product Details View
                    Dim p As Catalog.Product = CType(Me.Page, BaseStoreProductPage).LocalParentProduct
                    If p IsNot Nothing AndAlso Not String.IsNullOrEmpty(p.Bvin) Then
                        sb.Append(GenerateGAaddProductObj(p))
                        sb.AppendLine("ga('ec:setAction', 'detail');")
                    End If
                ElseIf pageUrl.StartsWith("/receipt.aspx") Then
                    ' Transaction
                    If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
                        Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
                        If Not String.IsNullOrEmpty(o.Bvin) AndAlso o.IsPlaced Then
                            If Not o.CustomPropertyExists("Develisys", "ConversionTracked") Then
                                ' set flag indicating that this purchase has been tracked so we don't track it again and duplicate it
                                o.CustomPropertySet("Develisys", "ConversionTracked", Boolean.TrueString)
                                Orders.Order.Update(o)

                                For Each li As Orders.LineItem In o.Items
                                    sb.Append(GenerateGAaddProductObj(li))
                                Next

                                sb.AppendLine("ga('ec:setAction', 'purchase', {")
                                sb.AppendFormat("'id': '{0}',{1}", o.OrderNumber, vbNewLine)
                                sb.AppendFormat("'affiliation': '{0}',{1}", WebAppSettings.AnalyticsGoogleEcommerceStoreName, vbNewLine)
                                sb.AppendFormat("'revenue': '{0}',{1}", o.GrandTotal.ToString(), vbNewLine)
                                sb.AppendFormat("'tax': '{0}',{1}", o.TaxTotal.ToString(), vbNewLine)
                                sb.AppendFormat("'shipping': '{0}',{1}", (o.ShippingTotal - o.ShippingDiscounts).ToString(), vbNewLine)
                                If o.Coupons.Count > 0 Then
                                    sb.AppendFormat("'coupon': '{0}'{1}", GoogleSafeString(o.Coupons.First().CouponCode), vbNewLine)
                                End If
                                sb.AppendLine("});")
                            End If
                        End If
                    End If
                End If
            End If
        End If
        sb.AppendLine("ga('send', 'pageview');")
        sb.AppendLine("</script>")
        sb.AppendLine("<!-- End Google Analytics -->")

        If Me.Page IsNot Nothing AndAlso Me.Page.Header IsNot Nothing Then
            Try
                Me.Page.Header.Controls.Add(New LiteralControl(sb.ToString()))
            Catch ex As Exception
                ' do nothing
            End Try
        End If
    End Sub

    Private Function GenerateGAaddProductObj(ByVal p As Catalog.Product) As String
        Dim sb As New StringBuilder()

        sb.AppendLine("ga('ec:addProduct', {")
        sb.AppendFormat("'id': '{0}',{1}", GoogleSafeString(p.Sku), vbNewLine)
        sb.AppendFormat("'name': '{0}',{1}", GoogleSafeString(p.ProductName), vbNewLine)
        sb.AppendFormat("'category': '{0}',{1}", GoogleSafeString(GetProductCategory(p)), vbNewLine)
        sb.AppendFormat("'brand': '{0}',{1}", GoogleSafeString(Contacts.Manufacturer.FindByBvin(p.ManufacturerId).DisplayName), vbNewLine)
        sb.AppendLine("});")

        Return sb.ToString()
    End Function
    Private Function GenerateGAaddProductObj(ByVal li As Orders.LineItem) As String
        Dim sb As New StringBuilder()

        sb.AppendLine("ga('ec:addProduct', {")
        sb.AppendFormat("'id': '{0}',{1}", GoogleSafeString(li.ProductSku), vbNewLine)
        sb.AppendFormat("'name': '{0}',{1}", GoogleSafeString(li.ProductName), vbNewLine)
        If li.AssociatedProduct IsNot Nothing Then
            sb.AppendFormat("'category': '{0}',{1}", GoogleSafeString(GetProductCategory(li.AssociatedProduct)), vbNewLine)
            sb.AppendFormat("'brand': '{0}',{1}", GoogleSafeString(Contacts.Manufacturer.FindByBvin(li.AssociatedProduct.ManufacturerId).DisplayName), vbNewLine)
        End If
        sb.AppendFormat("'price': '{0}',{1}", li.AdjustedPrice.ToString(), vbNewLine)
        sb.AppendFormat("'quantity': '{0}',{1}", li.Quantity.ToString("0"), vbNewLine)
        sb.AppendLine("});")

        Return sb.ToString()
    End Function

    Private Function GetProductCategory(ByVal p As Catalog.Product) As String
        Dim result As String = ""

        Dim bvin As String = If(String.IsNullOrEmpty(p.ParentId), p.Bvin, p.ParentId)
        Dim categories As Collection(Of Catalog.Category) = Catalog.InternalProduct.GetCategories(bvin)
        If categories.Count > 0 Then
            ' favor non-hidden, static categories
            result = categories.OrderBy(Function(c) c.Hidden).ThenBy(Function(c) Convert.ToInt32(c.SourceType)).First().Name
        End If

        Return result
    End Function

    Public Sub RenderGoogleAdwordTracker(ByVal orderValue As Decimal, ByVal conversionId As String, ByVal conversionLabel As String, ByVal backgroundColor As String, ByVal https As Boolean)
        Dim sb As New StringBuilder

        Dim total As String = Math.Round(orderValue, 2).ToString()

        sb.Append("<!-- Google Code for purchase Conversion Page -->" & vbNewLine)
        sb.Append("<script language=""JavaScript"" type=""text/javascript"">" & vbNewLine)
        sb.Append("<!--" & vbNewLine)
        sb.Append("var google_conversion_id = " & conversionId & ";" & vbNewLine)
        sb.Append("var google_conversion_language = ""en_US"";" & vbNewLine)
        sb.Append("var google_conversion_format = ""1"";" & vbNewLine)
        sb.Append("var google_conversion_color = """ & backgroundColor & """;" & vbNewLine)
        sb.Append("if (" & total & ") {" & vbNewLine)
        sb.Append("  var google_conversion_value = " & total & ";" & vbNewLine)
        sb.Append("}" & vbNewLine)
        sb.Append("var google_conversion_label = """ & conversionLabel & """;" & vbNewLine)
        sb.Append("//-->" & vbNewLine)
        sb.Append("</script>" & vbNewLine)
        sb.Append("<script language=""JavaScript"" src=""https://www.googleadservices.com/pagead/conversion.js"">" & vbNewLine)
        sb.Append("</script>" & vbNewLine)
        sb.Append("<noscript>" & vbNewLine)
        sb.Append("<img height=""1"" width=""1"" border=""0"" src=""")
        If https Then
            sb.Append("https://")
        Else
            sb.Append("http://")
        End If
        sb.Append("www.googleadservices.com/pagead/conversion/" & conversionId & "/imp.gif?value=" & total & "&label=" & conversionLabel & "&script=0"">" & vbNewLine)
        sb.Append("</noscript>" & vbNewLine)

        Me.litGoogleAdwords.Text = sb.ToString
    End Sub
    
    Public Sub RenderGoogleTagManager(ByVal containerId As String)
        ' build data layer
        Dim dataLayer As New Generic.Dictionary(Of String, Object)

        ' receipt page conversion data
        If Request.RawUrl.Replace(Request.ApplicationPath, "/").StartsWith("/Receipt.aspx", StringComparison.InvariantCultureIgnoreCase) Then
            If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
                Dim o As Orders.Order = Orders.Order.FindByBvin(Request.QueryString("id"))
                If Not String.IsNullOrEmpty(o.Bvin) AndAlso o.IsPlaced Then
                    dataLayer.Add("transactionAffiliation", WebAppSettings.AnalyticsGoogleEcommerceStoreName)
                    dataLayer.Add("transactionId", o.OrderNumber)
                    dataLayer.Add("transactionSubTotal", (o.SubTotal - o.OrderDiscounts))
                    dataLayer.Add("transactionShipping", (o.ShippingTotal - o.ShippingDiscounts))
                    dataLayer.Add("transactionHandling", o.HandlingTotal)
                    dataLayer.Add("transactionTax", o.TaxTotal)
                    dataLayer.Add("transactionTotal", o.GrandTotal)
                    dataLayer.Add("transactionEmail", o.UserEmail)

                    ' products
                    Dim transactionProducts As New Collection(Of Generic.Dictionary(Of String, Object))

                    For Each li As Orders.LineItem In o.Items
                        Dim transactionProduct As New Generic.Dictionary(Of String, Object)

                        transactionProduct.Add("sku", li.ProductSku)
                        transactionProduct.Add("name", li.ProductName)
                        If li.AssociatedProduct IsNot Nothing AndAlso Not String.IsNullOrEmpty(li.AssociatedProduct.Bvin) Then
                            transactionProduct.Add("category", GetProductCategory(li.AssociatedProduct))
                        End If
                        transactionProduct.Add("price", li.AdjustedPrice)
                        transactionProduct.Add("quantity", li.Quantity)

                        transactionProducts.Add(transactionProduct)
                    Next
                    dataLayer.Add("transactionProducts", transactionProducts)
                End If
            End If
        End If


        Dim sb As New StringBuilder()
        sb.AppendLine("<!-- Google Tag Manager -->")

        ' render data layer
        sb.AppendLine("<script>")
        sb.AppendLine("dataLayer = [{")

        Dim sbDataLayer As New StringBuilder()
        Dim sbDataLayerQs As New StringBuilder()
        GenerateDataLayer(dataLayer, sbDataLayer, sbDataLayerQs)
        sb.Append(sbDataLayer.ToString())

        sb.AppendLine("}];")
        sb.AppendLine("</script>")


        ' render container script
        sb.AppendFormat("<noscript><iframe src=""//www.googletagmanager.com/ns.html?id={0}{1}"" height=""0"" width=""0"" style=""display:none;visibility:hidden""></iframe></noscript>{2}", containerId, sbDataLayerQs.ToString(), vbNewLine)
        sb.AppendLine("<script>")
        sb.AppendLine("(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':new Date().getTime(),event:'gtm.js'});")
        sb.AppendLine("var f=d.getElementsByTagName(s)[0],j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src='//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);")
        sb.AppendLine("})")
        sb.AppendFormat("(window,document,'script','dataLayer','{0}');{1}", containerId, vbNewLine)
        sb.AppendLine("</script>")
        sb.AppendLine("<!-- End Google Tag Manager -->")

        Me.litGoogleTagManager.Text = sb.ToString()
    End Sub

    Private Sub GenerateDataLayer(ByVal dataLayer As Generic.Dictionary(Of String, Object), ByRef sbDataLayer As StringBuilder, ByRef sbDataLayerQs As StringBuilder)
        For Each dataItem As Generic.KeyValuePair(Of String, Object) In dataLayer
            If sbDataLayer.Length > 0 Then
                sbDataLayer.Append("," + vbNewLine)
            End If

            If TypeOf dataItem.Value Is Generic.Dictionary(Of String, Object) Then
                Dim sb As New StringBuilder()
                Dim dl As Generic.Dictionary(Of String, Object) = CType(dataItem.Value, Generic.Dictionary(Of String, Object))
                GenerateDataLayer(dl, sb, New StringBuilder())

                sbDataLayer.AppendFormat("'{0}': {{{1}}}", dataItem.Key, sb.ToString())
            ElseIf TypeOf dataItem.Value Is Collection(Of Generic.Dictionary(Of String, Object)) Then
                Dim sb As New StringBuilder()
                Dim dls As Collection(Of Generic.Dictionary(Of String, Object)) = CType(dataItem.Value, Collection(Of Generic.Dictionary(Of String, Object)))
                For Each dl As Generic.Dictionary(Of String, Object) In dls
                    sb.Append("{")
                    GenerateDataLayer(dl, sb, New StringBuilder())
                    sb.Append("}," + vbNewLine)
                Next

                sbDataLayer.AppendFormat("'{0}': [{2}{1}{2}]", dataItem.Key, sb.ToString().Replace("{,", "{").TrimEnd(("," + vbNewLine).ToCharArray()), vbNewLine)
            Else
                sbDataLayer.AppendFormat("'{0}': {2}{1}{2}", dataItem.Key, GoogleSafeString(dataItem.Value.ToString()), If(IsNumeric(dataItem.Value), "", "'"))
                sbDataLayerQs.AppendFormat("&{0}={1}", HttpUtility.UrlEncode(dataItem.Key), HttpUtility.UrlEncode(dataItem.Value.ToString()))
            End If
        Next
    End Sub

    Public Sub RenderGoogleTrustedStoresBadge(ByVal accountId As String, ByVal shoppingAccountId As String, ByVal shoppingCountry As String, ByVal shoppingLanguage As String)
        Dim sb As New StringBuilder()

        sb.AppendLine("<!-- BEGIN: Google Trusted Store -->")
        sb.AppendLine("<script type=""text/javascript"">")
        sb.AppendLine("var gts = gts || [];")

        sb.AppendFormat("gts.push([""id"", ""{0}""]);{1}", accountId, vbNewLine)
        sb.AppendFormat("gts.push([""badge_position"", ""{0}""]);{1}", WebAppSettings.GoogleTrustedStoresBadgeLocation, vbNewLine)
        If WebAppSettings.GoogleTrustedStoresBadgeLocation = "USER_DEFINED" Then
            sb.AppendLine("gts.push([""badge_container"", ""GTS_CONTAINER""]);")
        End If
        If Not String.IsNullOrEmpty(shoppingCountry) AndAlso Not String.IsNullOrEmpty(shoppingLanguage) Then
            sb.AppendFormat("gts.push([""locale"", ""{0}_{1}""]);{2}", shoppingLanguage, shoppingCountry, vbNewLine)
        End If
        If TypeOf Me.Page Is BaseStoreProductPage Then
            sb.AppendFormat("gts.push([""google_base_offer_id"", ""{0}""]);{1}", DirectCast(Me.Page, BaseStoreProductPage).LocalProduct.Sku, vbNewLine)
        End If

        If Not String.IsNullOrEmpty(shoppingAccountId) Then
            sb.AppendFormat("gts.push([""google_base_subaccount_id"", ""{0}""]);{1}", shoppingAccountId, vbNewLine)

            If Not String.IsNullOrEmpty(shoppingCountry) Then
                sb.AppendFormat("gts.push([""google_base_country"", ""{0}""]);{1}", shoppingCountry, vbNewLine)
            End If

            If Not String.IsNullOrEmpty(shoppingLanguage) Then
                sb.AppendFormat("gts.push([""google_base_language"", ""{0}""]);{1}", shoppingLanguage, vbNewLine)
            End If
        End If

        sb.AppendLine("(function() {")
        sb.AppendLine("var scheme = ((""https:"" == document.location.protocol) ? ""https://"" : ""http://"");")
        sb.AppendLine("var gts = document.createElement(""script"");")
        sb.AppendLine("gts.type = ""text/javascript"";")
        sb.AppendLine("gts.async = true;")
        sb.AppendLine("gts.src = scheme + ""www.googlecommerce.com/trustedstores/gtmp_compiled.js"";")
        sb.AppendLine("var s = document.getElementsByTagName(""script"")[0];")
        sb.AppendLine("s.parentNode.insertBefore(gts, s);")
        sb.AppendLine("})();")
        sb.AppendLine("</script>")
        sb.AppendLine("<!-- END: Google Trusted Store -->")

        Me.litGoogleTrustedStores.Text = sb.ToString()
    End Sub

    Public Sub RenderGoogleTrustedStoresOrderConfirmation(ByVal o As BVSoftware.BVC5.Core.Orders.Order, ByVal shoppingAccountId As String, ByVal shoppingCountry As String, ByVal shoppingLanguage As String)
        Dim sb As New StringBuilder()

        Try
            Dim country As Content.Country = Content.Country.FindByBvin(o.ShippingAddress.CountryBvin)
            Dim hasBackorderedItems As Boolean = o.Items.Any(Function(li) li.AssociatedProduct.IsTrackingInventory AndAlso li.AssociatedProduct.QuantityAvailableForSale <= 0)
            Dim shipDate As DateTime = Nothing
            If DateTime.Today.DayOfWeek = DayOfWeek.Friday AndAlso DateTime.Now.TimeOfDay > WebAppSettings.GoogleTrustedStoresShippingTime AndAlso Not WebAppSettings.GoogleTrustedStoresSaturdayShipping Then
                shipDate = DateTime.Today.AddDays(WebAppSettings.GoogleTrustedStoresShippingDays + 2)
            ElseIf DateTime.Today.DayOfWeek = DayOfWeek.Saturday Then
                shipDate = DateTime.Today.AddDays(WebAppSettings.GoogleTrustedStoresShippingDays + 1)
            ElseIf DateTime.Now.TimeOfDay < WebAppSettings.GoogleTrustedStoresShippingTime Then
                shipDate = DateTime.Today.AddDays(WebAppSettings.GoogleTrustedStoresShippingDays - 1)
            Else
                shipDate = DateTime.Today.AddDays(WebAppSettings.GoogleTrustedStoresShippingDays)
            End If
            shipDate = shipDate.AddDays(If(hasBackorderedItems, WebAppSettings.GoogleTrustedStoresMaxBackorderDays, 0))
            Dim deliveryDate As DateTime = shipDate.AddDays(WebAppSettings.GoogleTrustedStoresMaxTransitDays)
            
            sb.AppendLine("<!-- START Trusted Stores Order -->")
            sb.AppendLine("<div id=""gts-order"" style=""display:none;"">")
            sb.AppendLine("<!-- start order and merchant information -->")
            sb.AppendFormat("<span id=""gts-o-id"">{0}</span>{1}", o.OrderNumber, vbNewLine)
            sb.AppendFormat("<span id=""gts-o-domain"">{0}</span>{1}", WebAppSettings.SiteStandardRoot.Replace("http://", "").Replace("https://", "").TrimEnd("/"c), vbNewLine)
            sb.AppendFormat("<span id=""gts-o-email"">{0}</span>{1}", o.UserEmail, vbNewLine)
            sb.AppendFormat("<span id=""gts-o-country"">{0}</span>{1}", country.IsoCode, vbNewLine)
            sb.AppendFormat("<span id=""gts-o-currency"">{0}</span>{1}", New System.Globalization.RegionInfo(country.CultureCode).ISOCurrencySymbol, vbNewLine)
            sb.AppendFormat("<span id=""gts-o-total"">{0}</span>{1}", Utilities.Money.ConvertDecimalToString(o.GrandTotal), vbNewLine)
            sb.AppendFormat("<span id=""gts-o-discounts"">{0}</span>{1}", (-1 * Utilities.Money.ConvertDecimalToString(o.OrderDiscounts + o.ShippingDiscounts)), vbNewLine)
            sb.AppendFormat("<span id=""gts-o-shipping-total"">{0}</span>{1}", Utilities.Money.ConvertDecimalToString(o.ShippingTotal), vbNewLine)
            sb.AppendFormat("<span id=""gts-o-tax-total"">{0}</span>{1}", Utilities.Money.ConvertDecimalToString(o.TaxTotal + o.TaxTotal2), vbNewLine)
            sb.AppendFormat("<span id=""gts-o-est-ship-date"">{0}</span>{1}", shipDate.ToString("yyyy-MM-dd"), vbNewLine)
            sb.AppendFormat("<span id=""gts-o-est-delivery-date"">{0}</span>{1}", deliveryDate.ToString("yyyy-MM-dd"), vbNewLine)
            sb.AppendFormat("<span id=""gts-o-has-preorder"">{0}</span>{1}", If(hasBackorderedItems, "Y", "N"), vbNewLine)
            sb.AppendFormat("<span id=""gts-o-has-digital"">{0}</span>{1}", If(o.Items.Any(Function(li) Catalog.ProductFile.FindByProductId(If(String.IsNullOrEmpty(li.AssociatedProduct.ParentId), li.AssociatedProduct.Bvin, li.AssociatedProduct.ParentId)).Count > 0), "Y", "N"), vbNewLine)
            sb.AppendLine("<!-- end order and merchant information -->")

            sb.AppendLine("<!-- start repeated item specific information -->")
            For Each li As BVSoftware.BVC5.Core.Orders.LineItem In o.Items
                sb.AppendLine("<span class=""gts-item"">")
                sb.AppendFormat("<span class=""gts-i-name"">{0}</span>{1}", li.ProductName, vbNewLine)
                sb.AppendFormat("<span class=""gts-i-price"">{0}</span>{1}", Utilities.Money.ConvertDecimalToString(li.AdjustedPrice), vbNewLine)
                sb.AppendFormat("<span class=""gts-i-quantity"">{0}</span>{1}", li.Quantity.ToString("0"), vbNewLine)
                If Not String.IsNullOrEmpty(shoppingAccountId) Then
                    sb.AppendFormat("<span class=""gts-i-prodsearch-id"">{0}</span>{1}", li.ProductSku, vbNewLine)
                    sb.AppendFormat("<span class=""gts-i-prodsearch-store-id"">{0}</span>{1}", shoppingAccountId, vbNewLine)
                    If Not String.IsNullOrEmpty(shoppingCountry) Then
                        sb.AppendFormat("<span class=""gts-i-prodsearch-country"">{0}</span>{1}", shoppingCountry, vbNewLine)
                    End If
                    If Not String.IsNullOrEmpty(shoppingLanguage) Then
                        sb.AppendFormat("<span class=""gts-i-prodsearch-language"">{0}</span>{1}", shoppingLanguage, vbNewLine)
                    End If
                End If
                sb.AppendFormat("</span>")
            Next
            sb.AppendLine("<!-- end repeated item specific information -->")
            sb.AppendLine("</div>")
            sb.AppendLine("<!-- END Trusted Stores -->")

            Me.litGoogleTrustedStoresOrder.Text = sb.ToString()
        Catch ex As Exception
            AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.System, BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Failure, "Analytics", String.Format("Google Trusted Stores order confirmation: {0} | {1}", ex.Message, ex.StackTrace))
        End Try
    End Sub

    Private Function GoogleSafeString(ByVal input As String) As String
        Return input.Replace("|", "").Replace("""", "\""")
    End Function

    Public Sub RenderYahooTracker(ByVal o As BVSoftware.BVC5.Core.Orders.Order, ByVal accountId As String)

        Dim sb As New StringBuilder()

        sb.Append("<script type=""text/javascript"">" & vbNewLine)
        sb.Append("<!-- Yahoo! Inc." & vbNewLine)
        sb.Append("window.ysm_customData = new Object();" & vbNewLine)
        sb.Append("window.ysm_customData.conversion = ""transId=" & o.OrderNumber & ",currency=USD,amount=" & o.GrandTotal & """;" & vbNewLine)
        sb.Append("var ysm_accountid  = """ & accountId & """;" & vbNewLine)
        sb.Append("document.write(""<scr"" + ""ipt type='text/javascript' """ & vbNewLine)
        sb.Append(" + ""src=//"" + ""srv1.wa.marketingsolutions.yahoo.com"" + " & vbNewLine)
        sb.Append("""/script/ScriptServlet"" + ""?aid="" + ysm_accountid " & vbNewLine)
        sb.Append(" + ""></scr"" + ""ipt>"");" & vbNewLine)
        sb.Append("// -->" & vbNewLine)
        sb.Append("</script>")

        Me.litYahooConversion.Text = sb.ToString()
    End Sub

    Public Sub RenderMicrosoftAdCenterTracker(ByVal o As BVSoftware.BVC5.Core.Orders.Order)
        Me.litMicrosoftAdCenterConversion.Text = WebAppSettings.AnalyticsMicrosoftAdCenterTrackingCode.Replace("revenue=&", String.Format("revenue={0}&", o.GrandTotal.ToString()))
    End Sub

End Class
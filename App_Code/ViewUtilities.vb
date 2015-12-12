Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Public Class ViewUtilities
    Public Enum Sizes
        Small = 0
        Medium = 1
    End Enum

    Public Shared Sub ForceImageSize(ByVal image As Control, ByVal imageFile As String, ByVal size As Sizes, ByVal currentPage As Page)
        ' Force Image Size Code
        If WebAppSettings.ForceImageSizes Then
            Dim resizeInfo As New Utilities.ImageInfo
            If imageFile.ToLower.StartsWith("http://") Then
                If size = Sizes.Small Then
                    resizeInfo.Width = WebAppSettings.ImagesSmallWidth
                    resizeInfo.Height = WebAppSettings.ImagesSmallHeight
                ElseIf size = Sizes.Medium Then
                    resizeInfo.Width = WebAppSettings.ImagesMediumWidth
                    resizeInfo.Height = WebAppSettings.ImagesMediumHeight
                End If
            Else
                Dim iInfo As Utilities.ImageInfo = Utilities.ImageHelper.GetImageInformation(currentPage.ResolveUrl(Utilities.ImageHelper.GetValidImage(imageFile, True)))
                If iInfo.Width = 0 AndAlso iInfo.Height = 0 Then
                    If size = Sizes.Small Then
                        iInfo.Width = WebAppSettings.ImagesSmallWidth
                        iInfo.Height = WebAppSettings.ImagesSmallHeight
                    ElseIf size = Sizes.Medium Then
                        iInfo.Width = WebAppSettings.ImagesMediumWidth
                        iInfo.Height = WebAppSettings.ImagesMediumHeight
                    End If
                End If
                If size = Sizes.Small Then
                    resizeInfo = Utilities.ImageHelper.GetProportionalImageDimensionsForImage(iInfo, WebAppSettings.ImagesSmallWidth, WebAppSettings.ImagesSmallHeight)
                ElseIf size = Sizes.Medium Then
                    resizeInfo = Utilities.ImageHelper.GetProportionalImageDimensionsForImage(iInfo, WebAppSettings.ImagesMediumWidth, WebAppSettings.ImagesMediumHeight)
                End If

            End If

            If TypeOf image Is UI.HtmlControls.HtmlImage Then
                Dim img As HtmlImage = DirectCast(image, HtmlImage)
                img.Width = resizeInfo.Width
                img.Height = resizeInfo.Height
            ElseIf TypeOf image Is UI.WebControls.Image Then
                Dim img As Image = DirectCast(image, Image)
                img.Width = System.Web.UI.WebControls.Unit.Pixel(resizeInfo.Width)
                img.Height = System.Web.UI.WebControls.Unit.Pixel(resizeInfo.Height)
            ElseIf TypeOf image Is UI.WebControls.ImageButton Then
                Dim img As ImageButton = DirectCast(image, ImageButton)
                img.Width = System.Web.UI.WebControls.Unit.Pixel(resizeInfo.Width)
                img.Height = System.Web.UI.WebControls.Unit.Pixel(resizeInfo.Height)
            ElseIf TypeOf image Is Anthem.Image Then
                Dim img As Anthem.Image = DirectCast(image, Anthem.Image)
                img.Width = System.Web.UI.WebControls.Unit.Pixel(resizeInfo.Width)
                img.Height = System.Web.UI.WebControls.Unit.Pixel(resizeInfo.Height)
            ElseIf TypeOf image Is UI.WebControls.HyperLink Then
                Dim link As HyperLink = DirectCast(image, HyperLink)
                link.Width = resizeInfo.Width
                link.Height = resizeInfo.Height
            Else
                Throw New ArgumentException("Force Image Size Does Not Support A Control Of Type " & GetType(Image).Name)
            End If
        End If
    End Sub

    Private Enum Location
        Store = 0
        Admin = 1
    End Enum

    Public Shared Sub GetInputsAndModifiersForAdminLineItemDescription(ByVal p As Page, ByVal gv As GridView)
        GetInputsAndModifiersForLineItemDescription(p, gv, Location.Admin)
    End Sub

    Public Shared Sub GetInputsAndModifiersForLineItemDescription(ByVal p As Page, ByVal gv As GridView)
        GetInputsAndModifiersForLineItemDescription(p, gv, Location.Store)
    End Sub

    Public Shared Sub DisplayKitInLineItem(ByVal p As Page, ByVal gv As GridView, Optional ByVal displayCollapsible As Boolean = False)
        For Each row As GridViewRow In gv.Rows
            Dim lineItem As Orders.LineItem = Nothing
            If row.DataItem IsNot Nothing Then
                If TypeOf lineItem Is Orders.LineItem Then
                    lineItem = DirectCast(row.DataItem, Orders.LineItem)
                End If
            Else
                lineItem = Orders.LineItem.FindByBvin(gv.DataKeys(row.RowIndex).Value)
                If String.IsNullOrEmpty(lineItem.Bvin) Then
                    lineItem = Nothing
                End If
            End If

            Dim kitDisplayPlaceHolder As PlaceHolder = DirectCast(row.FindControl("KitDisplayPlaceHolder"), PlaceHolder)

            If (kitDisplayPlaceHolder IsNot Nothing) AndAlso (lineItem IsNot Nothing) Then
                If (lineItem.KitSelections IsNot Nothing) AndAlso (Not lineItem.KitSelections.IsEmpty) Then
                    Dim parts As Collection(Of Catalog.KitPart) = Services.KitService.GetKitPartsForKitSelections(lineItem.KitSelections)
                    If parts.Count > 0 Then
                        Dim literal As New LiteralControl()
                        Dim kitDetails As String = Content.SiteTerms.GetTerm("KitDetails")

                        If displayCollapsible Then
                            If WebAppSettings.KitDisplayCollapsed Then
                                literal.Text += "<h4 class=""kit-detail-header"">" & kitDetails & " <img class=""collapsed"" src=""Images/plus.png"" /></h4>"
                            Else
                                literal.Text += "<h4 class=""kit-detail-header"">" & kitDetails & " <img class=""expanded"" src=""Images/minus.png"" /></h4>"
                            End If

                        Else
                            literal.Text += "<h4 class=""kit-detail-header"">" & kitDetails & "</h4>"
                        End If

                        If displayCollapsible Then
                            If WebAppSettings.KitDisplayCollapsed Then
                                literal.Text += "<ul class=""kit-detail-display"" style=""display: none;"">"
                            Else
                                literal.Text += "<ul class=""kit-detail-display"">"
                            End If

                        Else
                            literal.Text += "<ul class=""kit-detail-display"">"
                        End If

                        For Each part As Catalog.KitPart In parts
                            literal.Text += "<li>" & part.Description & "</li>"
                        Next
                        literal.Text += "</ul>"
                        kitDisplayPlaceHolder.Controls.Add(literal)
                    End If
                End If
            End If
        Next
    End Sub

    Private Shared Sub GetInputsAndModifiersForLineItemDescription(ByVal p As Page, ByVal gv As GridView, ByVal where As Location)
        For Each row As GridViewRow In gv.Rows
            Dim lineItem As Orders.LineItem = Nothing
            If row.DataItem IsNot Nothing Then
                If TypeOf lineItem Is Orders.LineItem Then
                    lineItem = DirectCast(row.DataItem, Orders.LineItem)
                End If
            Else
                lineItem = Orders.LineItem.FindByBvin(gv.DataKeys(row.RowIndex).Value)
                If String.IsNullOrEmpty(lineItem.Bvin) Then
                    lineItem = Nothing
                End If
            End If

            Dim inputModifiersPlaceHolder As PlaceHolder = DirectCast(row.FindControl("CartInputModifiersPlaceHolder"), PlaceHolder)

            If (inputModifiersPlaceHolder IsNot Nothing) AndAlso (lineItem IsNot Nothing) Then
                Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(lineItem.ProductId)
                If product IsNot Nothing Then
                    If product.GlobalProduct.ParentId <> String.Empty Then
                        product = Catalog.InternalProduct.FindByBvin(product.GlobalProduct.ParentId)
                    End If
                End If
                

                Dim count As Integer = 0
                For Each item As Object In lineItem.GetCustomerVisibleInputsAndModifiers()
                    If TypeOf item Is Orders.LineItemInput Then
                        Dim input As Catalog.ProductInput = Catalog.ProductInput.FindByBvin(item.InputBvin)
                        If input IsNot Nothing Then
                            Dim inputTemplate As Content.ProductInputTemplate = Nothing
                            If where = Location.Admin Then
                                inputTemplate = Content.ModuleController.LoadProductInputAdminLineItemView(input.Type, p)
                            ElseIf where = Location.Store Then
                                inputTemplate = Content.ModuleController.LoadProductInputLineItemView(input.Type, p)
                            End If
                            If inputTemplate Is Nothing Then
                                Dim url As String = String.Empty
                                If where = Location.Store Then
                                    If product IsNot Nothing Then
                                        url = Utilities.UrlRewriter.BuildUrlForProduct(product, p, "LineItemId=" & HttpUtility.UrlEncode(lineItem.Bvin))
                                    End If
                                End If                                

                                If Not String.IsNullOrEmpty(item.InputDisplayValue) Then
                                    Dim inputDiv As New HtmlGenericControl("div")
                                    inputModifiersPlaceHolder.Controls.Add(inputDiv)
                                    inputDiv.Attributes.Add("class", "inputvalue")
                                    If where = Location.Admin Then
                                        inputDiv.InnerHtml = GetInputModifierDisplay(item.InputName, item.InputDisplayValue, 0D)
                                    ElseIf where = Location.Store Then
                                        Dim inputOutput As New HtmlAnchor()
                                        inputDiv.Controls.Add(inputOutput)
                                        inputOutput.HRef = url
                                        inputOutput.InnerHtml = GetInputModifierDisplay(item.InputName, item.InputDisplayValue, 0D)
                                    End If
                                End If
                            Else
                                inputModifiersPlaceHolder.Controls.Add(inputTemplate)
                                inputTemplate.BlockId = input.Bvin
                                inputTemplate.ID = "inputTemplate" & count.ToString()
                                inputTemplate.SetValue(lineItem, item)
                                inputTemplate.InitializeDisplay()
                            End If
                        Else
                            Dim url As String = String.Empty
                            If where = Location.Store Then
                                If product IsNot Nothing Then
                                    url = Utilities.UrlRewriter.BuildUrlForProduct(product, p, "LineItemId=" & HttpUtility.UrlEncode(lineItem.Bvin))
                                End If
                            End If

                            If Not String.IsNullOrEmpty(item.InputDisplayValue) Then
                                Dim inputDiv As New HtmlGenericControl("div")
                                inputModifiersPlaceHolder.Controls.Add(inputDiv)
                                inputDiv.Attributes.Add("class", "inputvalue")
                                If where = Location.Admin Then
                                    inputDiv.InnerHtml = GetInputModifierDisplay(item.InputName, item.InputDisplayValue, 0D)
                                ElseIf where = Location.Store Then
                                    Dim inputOutput As New HtmlAnchor()
                                    inputDiv.Controls.Add(inputOutput)
                                    inputOutput.HRef = url
                                    inputOutput.InnerHtml = GetInputModifierDisplay(item.InputName, item.InputDisplayValue, 0D)
                                End If
                            End If
                        End If
                    ElseIf TypeOf item Is Orders.LineItemModifier Then
                        Dim modifier As Catalog.ProductModifier = Catalog.ProductModifier.FindByBvin(item.ModifierBvin)
                        If modifier IsNot Nothing Then
                            Dim modifierTemplate As Content.ProductModifierTemplate = Nothing
                            If where = Location.Store Then
                                modifierTemplate = Content.ModuleController.LoadProductModifierLineItemView(modifier.Type, p)
                            ElseIf where = Location.Admin Then
                                modifierTemplate = Content.ModuleController.LoadProductModifierAdminLineItemView(modifier.Type, p)
                            End If

                            If modifierTemplate Is Nothing Then
                                Dim modifierOption As Catalog.ProductModifierOption = Catalog.ProductModifierOption.FindByBvin(item.ModifierValue)
                                If (modifierOption IsNot Nothing) AndAlso (Not modifierOption.IsNull) Then
                                    Dim url As String = String.Empty
                                    If product IsNot Nothing Then
                                        url = Utilities.UrlRewriter.BuildUrlForProduct(product, p, "LineItemId=" & HttpUtility.UrlEncode(lineItem.Bvin))
                                    End If

                                    Dim modifierDiv As New HtmlGenericControl("div")
                                    inputModifiersPlaceHolder.Controls.Add(modifierDiv)
                                    modifierDiv.Attributes.Add("class", "modifiervalue")
                                    If where = Location.Admin Then
                                        modifierDiv.InnerHtml = GetInputModifierDisplay(item.ModifierName, modifierOption.DisplayText, modifierOption.PriceAdjustment)
                                    ElseIf where = Location.Store Then
                                        Dim modifierOutput As New HtmlAnchor()
                                        modifierDiv.Controls.Add(modifierOutput)
                                        modifierOutput.HRef = url
                                        modifierOutput.InnerHtml = GetInputModifierDisplay(item.ModifierName, modifierOption.DisplayText, modifierOption.PriceAdjustment)
                                    End If                                    
                                End If
                            Else
                                modifierTemplate.BlockId = modifier.Bvin
                                inputModifiersPlaceHolder.Controls.Add(modifierTemplate)
                                modifierTemplate.ID = "modifierTemplate" & count.ToString()
                                modifierTemplate.Product = lineItem.AssociatedProduct
                                modifierTemplate.SetValue(lineItem, item)
                                modifierTemplate.InitializeDisplay()
                            End If
                        Else
                            Dim modifierOption As Catalog.ProductModifierOption = Catalog.ProductModifierOption.FindByBvin(item.ModifierValue)
                            If (modifierOption IsNot Nothing) AndAlso (Not modifierOption.IsNull) Then
                                Dim url As String = String.Empty
                                If product IsNot Nothing Then
                                    url = Utilities.UrlRewriter.BuildUrlForProduct(product, p, "LineItemId=" & HttpUtility.UrlEncode(lineItem.Bvin))
                                End If

                                Dim modifierDiv As New HtmlGenericControl("div")
                                inputModifiersPlaceHolder.Controls.Add(modifierDiv)
                                modifierDiv.Attributes.Add("class", "modifiervalue")
                                If where = Location.Admin Then
                                    modifierDiv.InnerHtml = GetInputModifierDisplay(item.ModifierName, modifierOption.DisplayText, modifierOption.PriceAdjustment)
                                ElseIf where = Location.Store Then
                                    Dim modifierOutput As New HtmlAnchor()
                                    modifierDiv.Controls.Add(modifierOutput)
                                    modifierOutput.HRef = url
                                    modifierOutput.InnerHtml = GetInputModifierDisplay(item.ModifierName, modifierOption.DisplayText, modifierOption.PriceAdjustment)
                                End If
                            End If
                        End If
                    End If
                    count += 1
                Next
            End If
        Next
    End Sub

    Public Shared Function GetInputModifierDisplay(ByVal name As String, ByVal displayValue As String, ByVal discount As Decimal) As String
        Dim sb As New StringBuilder()

        sb.AppendFormat("<span class=""inputmodifiername"">{0}</span> ", HttpUtility.HtmlEncode(name))
        sb.AppendFormat("<span class=""inputmodifiervalue"">{0}</span> ", HttpUtility.HtmlEncode(displayValue))

        If discount <> 0 Then
            sb.AppendFormat("<span class=""inputmodifierdiscount"">{0}{1}</span> ", If(discount > 0, "+", "-"), HttpUtility.HtmlEncode(discount.ToString("c")))
        End If

        Return sb.ToString()
    End Function

    Public Shared Function GetAdditionalImagesPopupJavascript(ByVal productId As String, ByVal currentPage As Page) As String
        Dim w As Integer = 700
        Dim h As Integer = 600
        Return "JavaScript:window.open('" & currentPage.ResolveClientUrl("~/ZoomImage.aspx") & "?productID=" & productId & "','Images','width=" & w & ", height=" & h & ", menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no')"
    End Function

    Public Shared Function DownloadFile(ByVal file As Catalog.ProductFile) As Boolean
        Dim extension As String = IO.Path.GetExtension(file.FileName)
        Dim name As String = IO.Path.GetFileName(file.FileName)
        Dim fileSize As Double = 0

        Dim sitePath As String = HttpContext.Current.Request.PhysicalApplicationPath
        Dim filePath As String = sitePath & "\files\" & file.Bvin & "_" & file.FileName & ".config"

        Dim type As String = ""
        type = Utilities.MimeTypes.FindTypeForExtension(extension)

        If System.IO.File.Exists(filePath) Then

            Dim f As New System.IO.FileInfo(filePath)
            If Not f Is Nothing Then
                fileSize = f.Length()
            End If

            HttpContext.Current.Response.Clear()
            HttpContext.Current.Response.ClearContent()
            HttpContext.Current.Response.ClearHeaders()

            If type <> "" Then
                HttpContext.Current.Response.ContentType = type
            End If

            'If type = "application/octet-stream" Then
            HttpContext.Current.Response.AppendHeader("content-disposition", String.Format("attachment; filename=""{0}""", name))
            'End If

            If fileSize > 0 Then
                HttpContext.Current.Response.AddHeader("Content-Length", fileSize.ToString())
            End If

            HttpContext.Current.Response.WriteFile(filePath)
            HttpContext.Current.Response.Flush()
            HttpContext.Current.Response.End()

            Return True
        Else
            Return False
        End If
    End Function
End Class

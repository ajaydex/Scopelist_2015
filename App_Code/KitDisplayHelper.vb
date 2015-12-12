Imports Microsoft.VisualBasic
Imports BVSoftware.BVC5.Core
Imports System.IO
Imports System.Collections.ObjectModel
Imports System.Collections.Generic
Imports System.Linq

Public Class KitDisplayHelper

    Public Shared Function DoRenderComponent(ByVal component As Catalog.KitComponent) As Boolean
        Return component.ComponentType <> Catalog.KitComponentType.IncludedHidden
    End Function

    Public Shared Function RenderName(ByVal component As Catalog.KitComponent) As String
        Return component.DisplayName
    End Function

    Public Shared Function RenderNameWithWrapper(ByVal component As Catalog.KitComponent) As String
        Return "<span class=""kitcomponentname"">" & component.DisplayName & "</span>"
    End Function

    Public Shared Function RenderComponentSmallImage(ByVal component As Catalog.KitComponent, ByVal page As System.Web.UI.Page) As String
        Dim result As String = String.Empty

        If component.SmallImage.Trim.Length > 0 Then
            Dim url As String = Utilities.ImageHelper.GetValidImage(component.SmallImage, True)
            result = "<span class=""kitcomponentimage"">"
            If component.LargeImage.Trim.Length > 0 Then
                Dim url2 As String = Utilities.ImageHelper.GetValidImage(component.LargeImage, True)
                result += "<a href="""
                result += page.ResolveUrl(url2)
                result += """ target=""_blank"">"
            End If
            result += "<img src=""" & page.ResolveUrl(url) & """ border=""0""/>"
            If component.LargeImage.Trim.Length > 0 Then
                result += "</a>"
            End If
            result += "</span>"
        End If

        Return result
    End Function


    Public Shared Function RenderComponentInput(ByVal KitSelections As Catalog.KitSelections, ByVal component As Catalog.KitComponent) As HtmlGenericControl
        Dim values As Collection(Of String) = Nothing

        Dim kvp As KeyValuePair(Of Catalog.KitComponent, Collection(Of String))?
        kvp = KitSelections.SelectedValues.FirstOrDefault(Function(x) x.Key.Bvin = component.Bvin)
        If kvp IsNot Nothing AndAlso kvp.Value.Value IsNot Nothing Then
            values = kvp.Value.Value
        Else
            values = New Collection(Of String)()
        End If

        'Dim result As String = String.Empty
        Dim result As New HtmlGenericControl
        If component.ComponentType = Catalog.KitComponentType.IncludedHidden Then
            'render nothing
        ElseIf component.ComponentType = Catalog.KitComponentType.IncludedShown Then
            result = ProcessIncludedShown(component, values)
        ElseIf component.ComponentType = Catalog.KitComponentType.RadioSelection Then
            result = ProcessRadioButton(component, values)
        ElseIf component.ComponentType = Catalog.KitComponentType.DropDownListSelection Then
            result = ProcessDropDownList(component, values)
        ElseIf component.ComponentType = Catalog.KitComponentType.CheckBoxSelection Then
            result = ProcessCheckBox(component, values)
        End If
        Return result
    End Function

    Protected Shared Function ProcessCheckBox(ByVal component As Catalog.KitComponent, ByVal values As Collection(Of String)) As HtmlGenericControl

        Dim result As New HtmlGenericControl("ul")
        result.Attributes("class") = "kitcomponent"

        Dim i As Integer = 0
        For Each part As Catalog.KitPart In component.InStockParts
            Dim li As New HtmlGenericControl("li")
            result.Controls.Add(li)

            Dim acb As New Anthem.CheckBox()
            acb.ID = component.Bvin & "_" & i.ToString()
            acb.AutoUpdateAfterCallBack = True

            If values.Contains(part.Bvin) Then
                acb.Text = part.Description & Content.SiteTerms.GetTerm("KitPartIncludedInPrice")
            Else
                acb.Text = part.Description & FormatPrice(part.TotalPrice)
            End If

            acb.InputAttributes("value") = part.Bvin
            acb.AutoCallBack = True

            If values.Contains(part.Bvin) Then
                acb.Checked = True
            End If

            li.Controls.Add(acb)

            i += 1
        Next

        Return result
    End Function

    Protected Shared Function ProcessDropDownList(ByVal component As Catalog.KitComponent, ByVal values As Collection(Of String)) As HtmlGenericControl

        Dim result As New HtmlGenericControl("div")
        Dim addl As New Anthem.DropDownList()
        addl.ID = component.Bvin
        addl.AutoUpdateAfterCallBack = True

        Dim selected As String = String.Empty
        Dim selectedPrice As Decimal = 0

        For Each part As Catalog.KitPart In component.InStockParts
            If values.Contains(part.Bvin) Then
                selected = part.Bvin
                selectedPrice = part.TotalPrice
            End If
        Next

        For Each part As Catalog.KitPart In component.InStockParts
            Dim li As New ListItem(part.Description, part.Bvin)
            If li.Value <> selected Then
                li.Text &= FormatPrice(part.GetPriceRelativeToSpecifiedPrice(selectedPrice))
            Else
                li.Text &= Content.SiteTerms.GetTerm("KitPartIncludedInPrice")
            End If
            addl.Items.Add(li)
        Next
        addl.AutoCallBack = True

        If values.Count > 0 Then
            addl.SelectedValue = values(0)
        End If

        result.Controls.Add(addl)

        Return result
    End Function

    Protected Shared Function ProcessRadioButton(ByVal component As Catalog.KitComponent, ByVal values As Collection(Of String)) As HtmlGenericControl

        Dim ul As New HtmlGenericControl("ul")
        ul.Attributes("class") = "kitcomponent"

        Dim selected As String = String.Empty
        Dim selectedPrice As Decimal = 0

        For Each part As Catalog.KitPart In component.InStockParts
            If values.Contains(part.Bvin) Then
                selected = part.Bvin
                selectedPrice = part.TotalPrice
            End If
        Next

        Dim i As Integer = 0

        For Each part As Catalog.KitPart In component.InStockParts

            Dim li As New HtmlGenericControl("li")

            Dim arb As New Anthem.RadioButton()
            arb.ID = component.Bvin & "_" & i.ToString()
            arb.Text = part.Description
            If part.Bvin <> selected Then
                arb.Text &= FormatPrice(part.GetPriceRelativeToSpecifiedPrice(selectedPrice))
            Else
                arb.Text &= Content.SiteTerms.GetTerm("KitPartIncludedInPrice")
            End If

            Dim pr As Catalog.Product = Catalog.InternalProduct.FindByBvin(part.ProductBvin)
            If pr IsNot Nothing AndAlso pr.ShortDescription <> "" Then
                arb.Text &= "<br /><div class=""kitpart-description"">" + pr.ShortDescription + "</div>"
            End If

            arb.Attributes("value") = part.Bvin
            arb.GroupName = component.Bvin
            arb.AutoCallBack = True
            arb.AutoUpdateAfterCallBack = True

            If values.Contains(part.Bvin) Then
                arb.Checked = True
            End If

            li.Controls.Add(arb)
            ul.Controls.Add(li)
            i += 1
        Next

        Return ul
    End Function

    Protected Shared Function ProcessIncludedShown(ByVal component As Catalog.KitComponent, ByVal values As Collection(Of String)) As HtmlGenericControl
        Dim result As New HtmlGenericControl("ul")
        result.Attributes("class") = "kitcomponent"

        If component.Parts.Count > 0 Then
            For Each part As Catalog.KitPart In component.InStockParts
                Dim li As New HtmlGenericControl("li")
                li.InnerHtml = part.Description
                result.Controls.Add(li)
            Next
        End If
        Return result
    End Function

    Protected Shared Function FormatPrice(ByVal amount As Decimal) As String
        Dim result As String = String.Empty
        Dim negative As Boolean = False
        If amount < 0 Then
            negative = True
        End If

        amount = Math.Abs(amount)

        If negative Then
            result = Content.SiteTerms.GetTerm("KitPartLessBefore") + amount.ToString("c") + Content.SiteTerms.GetTerm("KitPartLessAfter")
        Else
            result = Content.SiteTerms.GetTerm("KitPartMoreBefore") + amount.ToString("c") + Content.SiteTerms.GetTerm("KitPartMoreAfter")
        End If

        Return result
    End Function
End Class

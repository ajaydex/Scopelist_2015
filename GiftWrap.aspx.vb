Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Xml

Partial Class search
    Inherits BaseStorePage

    Dim lineitembvin As String = String.Empty
    Dim lineitem As Orders.LineItem = Nothing
    Dim product As Catalog.Product = Nothing

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.btnContinue.ImageUrl = PersonalizationServices.GetThemedButton("ContinueToCart")
            SetupPage()
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Cart.master")
        Me.PageTitle = "Gift Wrap"
    End Sub

    Protected Sub SetupPage()
        If Request.QueryString("id") IsNot Nothing Then
            lineitembvin = Request.QueryString("id")
        End If
        lineitem = Orders.LineItem.FindByBvin(lineitembvin)
        If lineitem IsNot Nothing Then
            product = Catalog.InternalProduct.FindByBvin(lineitem.ProductId)

            If product IsNot Nothing Then

                If (lineitem.AssociatedProduct IsNot Nothing) Then
                    Me.imgProduct.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(lineitem.AssociatedProduct.ImageFileSmall, True))
                Else
                    Me.imgProduct.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage("", True))
                End If

                Me.lblitemdescription.Text = product.ProductName

                ' Display price per item
                If product.GiftWrapAllowed Then
                    Me.lblgiftwrapprice.Text = String.Format("{0:c}", product.GiftWrapPrice)
                Else
                    If WebAppSettings.GiftWrapAll Then
                        Me.lblgiftwrapprice.Text = String.Format("{0:c}", WebAppSettings.GiftWrapCharge)
                    Else
                        Me.lblgiftwrapprice.Text = "Unable to determine price. Contact administrator. Error GW1002"
                    End If
                End If


                Dim giftwrapdetails As Collection(Of Orders.GiftWrapDetails) = lineitem.GiftWrapDetails
                Me.repeatercontrol.DataSource = giftwrapdetails
                Me.repeatercontrol.DataBind()

            Else
                Me.lblitemdescription.Text = "Unable to load product. Contact administrator. Error GW1003"
            End If
        Else
            Me.lblitemdescription.Text = "Unable to load line item. Contact administrator. Error GW1001"
        End If
    End Sub

    Protected Function SavePage() As Boolean
        Dim giftwrapdetails As New Collection(Of Orders.GiftWrapDetails)

        For Each item As RepeaterItem In Me.repeatercontrol.Items
            Dim _chkGiftWrap As CheckBox = CType(item.FindControl("chkGiftWrap"), CheckBox)
            Dim _txtToField As TextBox = CType(item.FindControl("txtToField"), TextBox)
            Dim _txtFromField As TextBox = CType(item.FindControl("txtFromField"), TextBox)
            Dim _txtMessageField As TextBox = CType(item.FindControl("txtMessageField"), TextBox)

            Dim giftwrapitem As New Orders.GiftWrapDetails

            If _chkGiftWrap IsNot Nothing Then
                giftwrapitem.GiftWrapEnabled = _chkGiftWrap.Checked
            End If

            If _txtToField IsNot Nothing Then
                giftwrapitem.ToField = _txtToField.Text.Trim
            End If

            If _txtFromField IsNot Nothing Then
                giftwrapitem.FromField = _txtFromField.Text.Trim
            End If

            If _txtMessageField IsNot Nothing Then
                giftwrapitem.MessageField = _txtMessageField.Text.Trim
            End If

            giftwrapdetails.Add(giftwrapitem)
        Next

        lineitembvin = Request.QueryString("id")
        lineitem = Orders.LineItem.FindByBvin(lineitembvin)
        lineitem.GiftWrapDetails = giftwrapdetails

        'lineitem.AddGiftWrapDetailsCollection(giftwrapdetails)

        'Dim prod As Catalog.Product = Catalog.InternalProduct.FindByBvin(lineitem.ProductId)
        'lineitem.GiftWrapTotal = 0D
        'For Each item As Orders.GiftWrapDetails In lineitem.GiftWrapDetails
        '    If item.GiftWrapEnabled = True Then
        '        lineitem.GiftWrapTotal += prod.GiftWrapPrice
        '    End If
        'Next

        Dim whathappened As Boolean = Orders.LineItem.Update(lineitem)
        Return whathappened
    End Function

    Protected Sub repeatercontrol_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles repeatercontrol.ItemDataBound
        If (e.Item.ItemType = ListItemType.Item) OrElse (e.Item.ItemType = ListItemType.AlternatingItem) Then
            If CType(e.Item.DataItem, Orders.GiftWrapDetails).GiftWrapEnabled = True Then
                CType(e.Item.FindControl("chkGiftWrap"), CheckBox).Checked = True
            End If

            CType(e.Item.FindControl("txtToField"), TextBox).Text = CType(e.Item.DataItem, Orders.GiftWrapDetails).ToField
            CType(e.Item.FindControl("txtFromField"), TextBox).Text = CType(e.Item.DataItem, Orders.GiftWrapDetails).FromField
            CType(e.Item.FindControl("txtMessageField"), TextBox).Text = CType(e.Item.DataItem, Orders.GiftWrapDetails).MessageField
        End If
    End Sub

    Protected Sub btnContinue_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnContinue.Click
        If SavePage() Then
            Response.Redirect("Cart.aspx")
        End If
    End Sub
End Class

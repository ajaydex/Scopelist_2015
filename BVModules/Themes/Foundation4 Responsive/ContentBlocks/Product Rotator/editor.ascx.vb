Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core
Imports System.IO

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Product_Rotator_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
            LoadItems()
        End If
    End Sub

    Private Sub LoadData()
        Me.chkShowInOrder.Checked = SettingsManager.GetBooleanSetting("ShowInOrder")

        'Product display data
        If SettingsManager.SettingExists("DisplayName") Then
            Me.txtCssClassPrefix.Text = SettingsManager.GetSetting("CssClassPrefix")
            Me.chkDisplayName.Checked = SettingsManager.GetBooleanSetting("DisplayName")
            Me.chkDisplayImage.Checked = SettingsManager.GetBooleanSetting("DisplayImage")
            Me.chkDisplayNewBadge.Checked = SettingsManager.GetBooleanSetting("DisplayNewBadge")
            Me.chkDisplayDescription.Checked = SettingsManager.GetBooleanSetting("DisplayDescription")
            Me.chkDisplayPrice.Checked = SettingsManager.GetBooleanSetting("DisplayPrice")
            Me.chkDisplayQuantity.Checked = SettingsManager.GetBooleanSetting("DisplayQuantity")
            Me.chkDisplayAddToCartButton.Checked = SettingsManager.GetBooleanSetting("DisplayAddToCartButton")
            Me.chkRemainOnPageAfterAddToCart.Checked = SettingsManager.GetBooleanSetting("RemainOnPageAfterAddToCart")

            Me.ucPreContentHtml.Text = SettingsManager.GetSetting("PreContentHtml_HtmlData")
            Dim pretransformText As String = SettingsManager.GetSetting("PreContentHtml_PreTransformHtmlData")
            If Me.ucPreContentHtml.SupportsTransform = True Then
                If pretransformText.Length > 0 Then
                    Me.ucPreContentHtml.Text = pretransformText
                End If
            End If

            Me.ucPostContentHtml.Text = SettingsManager.GetSetting("PostContentHtml_HtmlData")
            pretransformText = SettingsManager.GetSetting("PostContentHtml_PreTransformHtmlData")
            If Me.ucPostContentHtml.SupportsTransform = True Then
                If pretransformText.Length > 0 Then
                    Me.ucPostContentHtml.Text = pretransformText
                End If
            End If
        Else
            Me.chkDisplayName.Checked = True
            Me.chkDisplayImage.Checked = True
            Me.chkDisplayNewBadge.Checked = WebAppSettings.NewProductBadgeAllowed
            Me.chkDisplayDescription.Checked = False
            Me.chkDisplayPrice.Checked = True
            Me.chkDisplayQuantity.Checked = False
            Me.chkDisplayAddToCartButton.Checked = False
            Me.chkRemainOnPageAfterAddToCart.Checked = (Not WebAppSettings.RedirectToCartAfterAddProduct)
        End If
    End Sub

    Private Sub LoadItems()
        Me.GridView1.DataSource = SettingsManager.GetSettingList("Products")
        Me.GridView1.DataBind()
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("PreContentHtml_HtmlData", Me.ucPreContentHtml.Text.Trim(), "Develisys", "Content Block", "Product Rotator")
        SettingsManager.SaveSetting("PreContentHtml_PreTransformHtmlData", Me.ucPreContentHtml.PreTransformText.Trim(), "Develisys", "Content Block", "Product Rotator")
        SettingsManager.SaveSetting("PostContentHtml_HtmlData", Me.ucPostContentHtml.Text.Trim(), "Develisys", "Content Block", "Product Rotator")
        SettingsManager.SaveSetting("PostContentHtml_PreTransformHtmlData", Me.ucPostContentHtml.PreTransformText.Trim(), "Develisys", "Content Block", "Product Rotator")
        SettingsManager.SaveBooleanSetting("ShowInOrder", Me.chkShowInOrder.Checked, "bvsoftware", "Content Block", "Product Rotator")

        ' Product display data
        SettingsManager.SaveSetting("CssClassPrefix", Me.txtCssClassPrefix.Text, "Develisys", "Content Block", "Product Rotator")
        SettingsManager.SaveBooleanSetting("DisplayName", Me.chkDisplayName.Checked, "Develisys", "Content Block", "Product Rotator")
        SettingsManager.SaveBooleanSetting("DisplayImage", Me.chkDisplayImage.Checked, "Develisys", "Content Block", "Product Rotator")
        SettingsManager.SaveBooleanSetting("DisplayNewBadge", Me.chkDisplayNewBadge.Checked, "Develisys", "Content Block", "Product Rotator")
        SettingsManager.SaveBooleanSetting("DisplayDescription", Me.chkDisplayDescription.Checked, "Develisys", "Content Block", "Product Rotator")
        SettingsManager.SaveBooleanSetting("DisplayPrice", Me.chkDisplayPrice.Checked, "Develisys", "Content Block", "Product Rotator")
        SettingsManager.SaveBooleanSetting("DisplayAddToCartButton", Me.chkDisplayAddToCartButton.Checked, "Develisys", "Content Block", "Product Rotator")
        SettingsManager.SaveBooleanSetting("DisplayQuantity", Me.chkDisplayQuantity.Checked, "Develisys", "Content Block", "Product Rotator")
        SettingsManager.SaveBooleanSetting("RemainOnPageAfterAddToCart", Me.chkRemainOnPageAfterAddToCart.Checked, "Develisys", "Content Block", "Product Rotator")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        Page.Validate()
        If Page.IsPostBack Then
            SaveData()
            Me.NotifyFinishedEditing()
        End If

    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click

        'Inserting
        SettingsManager.GetSettingList("Products")
        For Each product As String In ProductPicker1.SelectedProducts
            Dim c As New Content.ComponentSettingListItem
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(product)
            c.Setting1 = product
            c.Setting2 = p.Sku
            c.Setting3 = p.ProductName
            c.Setting4 = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(p.ImageFileSmall, True))
            c.Setting5 = p.ProductURL
            c.Setting6 = p.ImageFileSmallAlternateText
            SettingsManager.InsertSettingListItem("Products", c, "bvsoftware", "Content Block", "Product Rotator")
        Next
        LoadItems()
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        SettingsManager.MoveSettingListItemDown(bvin, "Products")
        LoadItems()
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim bvin As String = CType(Me.GridView1.DataKeys(e.RowIndex).Value, String)
        SettingsManager.DeleteSettingListItem(bvin)
        LoadItems()
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        SettingsManager.MoveSettingListItemUp(bvin, "Products")
        LoadItems()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub


End Class

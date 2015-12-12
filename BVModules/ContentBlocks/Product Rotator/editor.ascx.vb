Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core
Imports System.IO

Partial Class BVModules_ContentBlocks_Product_Rotator_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadItems()
            Me.chkShowInOrder.Checked = SettingsManager.GetBooleanSetting("ShowInOrder")
            Me.PreHtmlField.Text = SettingsManager.GetSetting("PreHtml")
            Me.PostHtmlField.Text = SettingsManager.GetSetting("PostHtml")
        End If
    End Sub

    Private Sub LoadItems()
        Me.GridView1.DataSource = SettingsManager.GetSettingList("Products")
        Me.GridView1.DataBind()
    End Sub

    Protected Sub btnOkay_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOkay.Click
        SettingsManager.SaveSetting("PreHtml", Me.PreHtmlField.Text.Trim, "bvsoftware", "Content Block", "Product Rotator")
        SettingsManager.SaveSetting("PostHtml", Me.PostHtmlField.Text.Trim, "bvsoftware", "Content Block", "Product Rotator")
        SettingsManager.SaveBooleanSetting("ShowInOrder", Me.chkShowInOrder.Checked, "bvsoftware", "Content Block", "Product Rotator")
        Me.NotifyFinishedEditing()
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
        Response.Redirect("~/BVAdmin/Content/Columns.aspx")
    End Sub


End Class

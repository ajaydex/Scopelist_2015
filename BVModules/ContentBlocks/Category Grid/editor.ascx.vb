Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.Linq
Imports BVSoftware.BVC5.Core

Partial Class BVModules_ContentBlocks_Category_Grid_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Private Sub BindCategoryGridView()
        Dim settings As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Categories")
        Dim categories As New Collection(Of Catalog.Category)
        For Each item As Content.ComponentSettingListItem In settings
            Dim category As Catalog.Category = Catalog.Category.FindByBvin(item.Setting1)
            If Not String.IsNullOrEmpty(category.Bvin) Then
                categories.Add(category)
            End If
        Next
        CategoriesGridView.DataSource = categories
        CategoriesGridView.DataBind()

        ' update treeview
        Me.ucCategoryTreeView.LoadSelectedCategories(categories)
        Me.ucCategoryTreeView.LoadTreeView()
    End Sub

    Private Sub LoadData()
        Me.PreHtmlField.Text = SettingsManager.GetSetting("PreHtml")
        Me.PostHtmlField.Text = SettingsManager.GetSetting("PostHtml")
        Me.txtTitle.Text = SettingsManager.GetSetting("Title")
        Me.txtColumns.Text = SettingsManager.GetSetting("Columns")
        Me.ddlHeadingTag.SelectedValue = SettingsManager.GetSetting("HeadingTag")

        BindCategoryGridView()
    End Sub

    Protected Sub AddImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddImageButton.Click
        Dim settings As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Categories")

        For Each item As KeyValuePair(Of String, String) In Me.ucCategoryTreeView.SelectedCategories
            If Not settings.Any(Function(csli) csli.Setting1 = item.Key) Then
                Dim csli As New Content.ComponentSettingListItem()
                csli.Setting1 = item.Key
                SettingsManager.InsertSettingListItem("Categories", csli, "Develisys", "Content Block", "Category Grid")
            End If
        Next

        BindCategoryGridView()
    End Sub

    Protected Sub btnOK_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOk.Click
        SettingsManager.SaveSetting("Title", Me.txtTitle.Text, "Develisys", "Content Block", "Category Grid")
        SettingsManager.SaveSetting("HeadingTag", Me.ddlHeadingTag.SelectedValue, "Develisys", "Content Block", "Category Grid")
        SettingsManager.SaveSetting("Columns", Me.txtColumns.Text, "Develisys", "Content Block", "Category Grid")
        SettingsManager.SaveSetting("PreHtml", Me.PreHtmlField.Text.Trim, "Develisys", "Content Block", "Category Grid")
        SettingsManager.SaveSetting("PostHtml", Me.PostHtmlField.Text.Trim, "Develisys", "Content Block", "Category Grid")
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub CategoriesGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles CategoriesGridView.RowDeleting
        Dim settings As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Categories")
        For Each item As Content.ComponentSettingListItem In settings
            If item.Setting1 = CStr(CategoriesGridView.DataKeys(e.RowIndex).Value) Then
                SettingsManager.DeleteSettingListItem(item.Bvin)
            End If
        Next

        BindCategoryGridView()
    End Sub

    Protected Sub CategoriesGridView_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles CategoriesGridView.RowUpdating
        Dim settings As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Categories")

        Dim bvin As String = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString()
        For Each csli As Content.ComponentSettingListItem In settings
            If csli.Setting1 = bvin Then
                SettingsManager.MoveSettingListItemUp(csli.Bvin, "Categories")
                Exit For
            End If
        Next

        BindCategoryGridView()
    End Sub

    Protected Sub CategoriesGridView_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles CategoriesGridView.RowCancelingEdit
        Dim settings As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Categories")

        Dim bvin As String = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString()
        For Each csli As Content.ComponentSettingListItem In settings
            If csli.Setting1 = bvin Then
                SettingsManager.MoveSettingListItemDown(csli.Bvin, "Categories")
            End If
        Next

        BindCategoryGridView()
    End Sub

End Class
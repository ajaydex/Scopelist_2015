Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.Linq
Imports BVSoftware.BVC5.Core

Partial Class BVModules_ContentBlocks_Category_Rotator_editor
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
            If category IsNot Nothing AndAlso category.Bvin <> String.Empty Then
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
        Me.chkShowInOrder.Checked = SettingsManager.GetBooleanSetting("ShowInOrder")        

        BindCategoryGridView()
    End Sub

    Protected Sub AddImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddImageButton.Click
        Dim settings As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Categories")

        For Each item As KeyValuePair(Of String, String) In Me.ucCategoryTreeView.SelectedCategories
            If Not settings.Any(Function(csli) csli.Setting1 = item.Key) Then
                Dim csli As New Content.ComponentSettingListItem()
                csli.Setting1 = item.Key
                SettingsManager.InsertSettingListItem("Categories", csli, "Develisys", "Content Block", "Category Rotator")
            End If
        Next

        BindCategoryGridView()
    End Sub

    Protected Sub btnOK_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOK.Click        
        SettingsManager.SaveSetting("PreHtml", Me.PreHtmlField.Text.Trim, "bvsoftware", "Content Block", "Category Rotator")
        SettingsManager.SaveSetting("PostHtml", Me.PostHtmlField.Text.Trim, "bvsoftware", "Content Block", "Category Rotator")
        SettingsManager.SaveBooleanSetting("ShowInOrder", Me.chkShowInOrder.Checked, "bvsoftware", "Content Block", "Category Rotator")
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

        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        For Each item As Content.ComponentSettingListItem In settings
            If item.Setting1 = bvin Then
                SettingsManager.MoveSettingListItemUp(item.Bvin, "Categories")
                Exit For
            End If
        Next

        BindCategoryGridView()
    End Sub

    Protected Sub CategoriesGridView_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles CategoriesGridView.RowCancelingEdit
        Dim settings As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Categories")

        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        For Each item As Content.ComponentSettingListItem In settings
            If item.Setting1 = bvin Then
                SettingsManager.MoveSettingListItemDown(item.Bvin, "Categories")
            End If
        Next

        BindCategoryGridView()
    End Sub
End Class

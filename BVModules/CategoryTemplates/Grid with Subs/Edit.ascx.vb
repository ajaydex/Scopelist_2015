Imports BVSoftware.BVC5.Core

Partial Class BVModules_CategoryTemplates_Grid_with_Subs_Edit
    Inherits Content.CategoryEditorTemplate

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.BlockId = "D2D63F6A-2480-42a1-A593-FCFA83A2C8B8"
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        NotifyFinishedEditing()
    End Sub

    Public Overrides Sub LoadFormData()
        ItemsPerPageTextBox.Text = Me.SettingsManager.GetIntegerSetting("ItemsPerPage")
        PagersDropDownList.SelectedValue = Me.SettingsManager.GetIntegerSetting("PagerMode")
    End Sub

    Public Overrides Sub SaveFormData()
        Me.SettingsManager.SaveIntegerSetting("ItemsPerPage", CInt(ItemsPerPageTextBox.Text), "bvsoftware", "Category Template", "Grid")
        Me.SettingsManager.SaveIntegerSetting("PagerMode", CInt(PagersDropDownList.SelectedValue), "bvsoftware", "Category Template", "Grid")
        NotifyFinishedEditing()
    End Sub

    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveImageButton.Click
        If Page.IsValid Then
            SaveFormData()
        End If
    End Sub

End Class

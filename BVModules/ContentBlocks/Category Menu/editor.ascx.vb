Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_Category_Menu_editor
    Inherits Content.BVModule

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Private Sub LoadData()

        Me.TitleField.Text = SettingsManager.GetSetting("Title")

        Dim mode As String = "0"
        mode = SettingsManager.GetSetting("CategoryMenuMode")
        If ModeField.Items.FindByValue(mode) IsNot Nothing Then
            ModeField.Items.FindByValue(mode).Selected = True
        End If
        Me.ProductCountCheckBox.Checked = SettingsManager.GetBooleanSetting("ShowProductCount")
        Me.SubCategoryCountCheckBox.Checked = SettingsManager.GetBooleanSetting("ShowCategoryCount")
        Me.HomeLinkField.Checked = SettingsManager.GetBooleanSetting("HomeLink")

        Me.MaximumDepth.Text = SettingsManager.GetIntegerSetting("MaximumDepth")

    End Sub

    Private Sub SaveData()

        SettingsManager.SaveSetting("Title", Me.TitleField.Text.Trim, "bvsoftware", "Content Block", "Category Menu")

        Dim mode As String = "0"
        If ModeField.SelectedValue IsNot Nothing Then
            mode = ModeField.SelectedValue
        End If
        SettingsManager.SaveSetting("CategoryMenuMode", mode, "bvsoftware", "Content Block", "Category Menu")
        SettingsManager.SaveBooleanSetting("ShowProductCount", Me.ProductCountCheckBox.Checked, "bvsoftware", "Content Block", "Category Menu")
        SettingsManager.SaveBooleanSetting("ShowCategoryCount", Me.SubCategoryCountCheckBox.Checked, "bvsoftware", "Content Block", "Category Menu")
        Me.SubCategoryCountCheckBox.Checked = SettingsManager.GetBooleanSetting("ShowCategoryCount")
        SettingsManager.SaveBooleanSetting("HomeLink", Me.HomeLinkField.Checked, "bvsoftware", "Content Block", "Category Menu")

        Dim maxDepth As Integer = 0
        Integer.TryParse(Me.MaximumDepth.Text.Trim, maxDepth)
        SettingsManager.SaveIntegerSetting("MaximumDepth", maxDepth, "bvsoftware", "Content Block", "Category Menu")
    End Sub

End Class

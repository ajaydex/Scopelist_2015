Imports BVSoftware.BVC5.Core

Partial Class BVModules_ContentBlocks_Category_Menu_Plus_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.chkDisplayTopLevelAsHeadings.AutoPostBack = True
            Me.chkShowMoreLink.AutoPostBack = True

            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        Me.txtDepthLevels.Text = SettingsManager.GetSetting("DepthLevels", 9999)
        Me.txtStartDepth.Text = SettingsManager.GetSetting("StartDepth", 1)
        Me.txtDefaultExpandedDepth.Text = SettingsManager.GetSetting("DefaultExpandedDepth", 1)
        Me.chkDisplayOnlyActiveBranch.Checked = SettingsManager.GetBooleanSetting("DisplayOnlyActiveBranch")
        Me.chkDisplayOnlyChildrenOfCurrentCategory.Checked = SettingsManager.GetBooleanSetting("DisplayOnlyChildrenOfCurrentCategory")
        Me.chkShowProductCount.Checked = SettingsManager.GetBooleanSetting("ShowProductCount")
        Me.chkShowSubCategoryCount.Checked = SettingsManager.GetBooleanSetting("ShowSubCategoryCount")
        Me.chkUseShowInTopMenuSettings.Checked = SettingsManager.GetBooleanSetting("UseShowInTopMenuSettings")
        Me.chkShowMoreLink.Checked = SettingsManager.GetBooleanSetting("ShowMoreLink")
        Me.txtMoreLinkText.Text = SettingsManager.GetSetting("MoreLinkText", "more")
        Me.txtHtmlID.Text = SettingsManager.GetSetting("HtmlID")
        Me.txtCssClass.Text = SettingsManager.GetSetting("CssClass")
        Me.chkAssignUniqueCssClassNames.Checked = SettingsManager.GetBooleanSetting("AssignUniqueCssClassNames")
        Me.chkDisplayTopLevelAsHeadings.Checked = SettingsManager.GetBooleanSetting("DisplayTopLevelAsHeadings")
        Me.txtHeadingTag.Text = SettingsManager.GetSetting("HeadingTag", "span")
        Me.txtCurrentCategoryID.Text = SettingsManager.GetSetting("CurrentCategoryID")

        chkDisplayTopLevelAsHeadings_CheckedChanged(Nothing, Nothing)
        chkShowMoreLink_CheckedChanged(Nothing, Nothing)
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("DepthLevels", Me.txtDepthLevels.Text, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveSetting("StartDepth", Me.txtStartDepth.Text, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveSetting("DefaultExpandedDepth", Me.txtDefaultExpandedDepth.Text, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveBooleanSetting("DisplayOnlyActiveBranch", Me.chkDisplayOnlyActiveBranch.Checked, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveBooleanSetting("DisplayOnlyChildrenOfCurrentCategory", Me.chkDisplayOnlyChildrenOfCurrentCategory.Checked, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveBooleanSetting("ShowProductCount", chkShowProductCount.Checked, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveBooleanSetting("ShowSubCategoryCount", chkShowSubCategoryCount.Checked, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveBooleanSetting("UseShowInTopMenuSettings", chkUseShowInTopMenuSettings.Checked, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveBooleanSetting("ShowMoreLink", Me.chkShowMoreLink.Checked, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveSetting("MoreLinkText", Me.txtMoreLinkText.Text, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveSetting("HtmlID", Me.txtHtmlID.Text, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveSetting("CssClass", Me.txtCssClass.Text, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveBooleanSetting("AssignUniqueCssClassNames", Me.chkAssignUniqueCssClassNames.Checked, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveBooleanSetting("DisplayTopLevelAsHeadings", Me.chkDisplayTopLevelAsHeadings.Checked, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveSetting("HeadingTag", Me.txtHeadingTag.Text, "bvsoftware", "Content Block", "Category Menu Plus")
        SettingsManager.SaveSetting("CurrentCategoryID", Me.txtCurrentCategoryID.Text, "bvsoftware", "Content Block", "Category Menu Plus")
    End Sub

    Protected Sub chkDisplayTopLevelAsHeadings_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles chkDisplayTopLevelAsHeadings.CheckedChanged
        Me.txtHeadingTag.Visible = Me.chkDisplayTopLevelAsHeadings.Checked
    End Sub

    Protected Sub chkShowMoreLink_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles chkShowMoreLink.CheckedChanged
        Me.txtMoreLinkText.Visible = Me.chkShowMoreLink.Checked
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        Page.Validate()
        If Page.IsValid Then
            SaveData()
            Me.NotifyFinishedEditing()
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub

End Class
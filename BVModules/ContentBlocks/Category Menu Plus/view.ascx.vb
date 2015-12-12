Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_Category_Menu_Plus_view
    Inherits Content.BVModule

    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)

        Me.EnableViewState = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ucCategoryMenuPlus.CurrentCategoryId = SettingsManager.GetSetting("CurrentCategoryId")
        ucCategoryMenuPlus.DepthLevels = SettingsManager.GetIntegerSetting("DepthLevels")
        ucCategoryMenuPlus.StartDepth = SettingsManager.GetIntegerSetting("StartDepth")
        ucCategoryMenuPlus.DefaultExpandedDepth = SettingsManager.GetIntegerSetting("DefaultExpandedDepth")
        ucCategoryMenuPlus.DisplayOnlyActiveBranch = SettingsManager.GetBooleanSetting("DisplayOnlyActiveBranch")
        ucCategoryMenuPlus.DisplayOnlyChildrenOfCurrentCategory = SettingsManager.GetBooleanSetting("DisplayOnlyChildrenOfCurrentCategory")
        ucCategoryMenuPlus.ShowProductCount = SettingsManager.GetBooleanSetting("ShowProductCount")
        ucCategoryMenuPlus.ShowSubCategoryCount = SettingsManager.GetBooleanSetting("ShowSubCategoryCount")
        ucCategoryMenuPlus.UseShowInTopMenuSettings = SettingsManager.GetBooleanSetting("UseShowInTopMenuSettings")
        ucCategoryMenuPlus.HtmlID = SettingsManager.GetSetting("HtmlID")
        ucCategoryMenuPlus.CssClass = SettingsManager.GetSetting("CssClass")
        ucCategoryMenuPlus.AssignUniqueCssClassNames = SettingsManager.GetBooleanSetting("AssignUniqueCssClassNames")
        ucCategoryMenuPlus.DisplayTopLevelAsHeadings = SettingsManager.GetBooleanSetting("DisplayTopLevelAsHeadings")
        ucCategoryMenuPlus.HeadingTag = SettingsManager.GetSetting("HeadingTag")
        ucCategoryMenuPlus.ShowMoreLink = SettingsManager.GetBooleanSetting("ShowMoreLink")
        ucCategoryMenuPlus.MoreLinkText = SettingsManager.GetSetting("MoreLinkText")
    End Sub

End Class
Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core
Imports System.IO

Partial Class BVModules_ContentBlocks_Last_Products_Viewed_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.PreHtmlField.Text = SettingsManager.GetSetting("PreHtml")
            Me.PostHtmlField.Text = SettingsManager.GetSetting("PostHtml")
            Me.LPVGridColumnsField.Text = SettingsManager.GetIntegerSetting("LPVGridColumnsField")
            Me.LPVDisplayTypeRad.SelectedValue = SettingsManager.GetIntegerSetting("LPVDisplayTypeRad")
            Me.LVPTitle.Text = Content.SiteTerms.GetTerm("RecentlyViewedItems")
        End If
    End Sub

    Protected Sub btnOkay_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOkay.Click
        SettingsManager.SaveSetting("PreHtml", Me.PreHtmlField.Text.Trim, "bvsoftware", "Content Block", "Last Product Viewed")
        SettingsManager.SaveSetting("PostHtml", Me.PostHtmlField.Text.Trim, "bvsoftware", "Content Block", "Last Product Viewed")
        SettingsManager.SaveIntegerSetting("LPVGridColumnsField", Me.LPVGridColumnsField.Text.Trim, "bvsoftware", "Content Block", "Last Product Viewed")
        SettingsManager.SaveIntegerSetting("LPVDisplayTypeRad", Me.LPVDisplayTypeRad.SelectedValue, "bvsoftware", "Content Block", "Last Product Viewed")
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("~/BVAdmin/Content/Columns.aspx")
    End Sub

End Class

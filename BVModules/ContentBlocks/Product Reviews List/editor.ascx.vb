Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Partial Class BVModules_ContentBlocks_Product_Reviews_List_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.chkTruncateReview.AutoPostBack = True

            Me.ddlCategory.Items.Add(New ListItem("- Any -", String.Empty))
            Dim cats As Collection(Of ListItem) = Catalog.Category.ListFullTreeWithIndents(True)
            For Each li As ListItem In cats
                Me.ddlCategory.Items.Add(li)
            Next

            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        Me.txtTitle.Text = SettingsManager.GetSetting("Title")
        Me.txtMinimumRating.Text = SettingsManager.GetSetting("MinimumRating", 1)
        Me.chkIgnoreBadKarma.Checked = SettingsManager.GetBooleanSetting("IgnoreBadKarma")
        Me.chkIgnoreAnonymousReviews.Checked = SettingsManager.GetBooleanSetting("IgnoreAnonymousReviews")
        Me.ddlCategory.SelectedValue = SettingsManager.GetSetting("CategoryId")
        Me.txtNumberOfItems.Text = SettingsManager.GetSetting("NumberOfItems", 10)
        Me.chkTruncateReview.Checked = SettingsManager.GetBooleanSetting("TruncateReview")
        Me.txtTruncateReviewLength.Text = SettingsManager.GetSetting("TruncateReviewLength", 250)
        Me.txtDateFormat.Text = SettingsManager.GetSetting("DateFormat", "M/d/yyyy")

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

        chkTruncateReview_CheckedChanged(Nothing, Nothing)
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Title", Me.txtTitle.Text, "Develisys", "Content Block", "Develisys Product Reviews List")
        SettingsManager.SaveSetting("MinimumRating", Me.txtMinimumRating.Text, "Develisys", "Content Block", "Develisys Product Reviews List")
        SettingsManager.SaveBooleanSetting("IgnoreBadKarma", Me.chkIgnoreBadKarma.Checked, "Develisys", "Content Block", "Develisys Product Reviews List")
        SettingsManager.SaveBooleanSetting("IgnoreAnonymousReviews", Me.chkIgnoreAnonymousReviews.Checked, "Develisys", "Content Block", "Develisys Product Reviews List")
        SettingsManager.SaveSetting("CategoryId", Me.ddlCategory.SelectedValue, "Develisys", "Content Block", "Develisys Product Reviews List")
        SettingsManager.SaveSetting("NumberOfItems", Me.txtNumberOfItems.Text, "Develisys", "Content Block", "Develisys Product Reviews List")
        SettingsManager.SaveBooleanSetting("TruncateReview", Me.chkTruncateReview.Checked, "Develisys", "Content Block", "Develisys Product Reviews List")
        SettingsManager.SaveSetting("TruncateReviewLength", Me.txtTruncateReviewLength.Text, "Develisys", "Content Block", "Develisys Product Reviews List")
        SettingsManager.SaveSetting("DateFormat", Me.txtDateFormat.Text, "Develisys", "Content Block", "Develisys Product Reviews List")
        SettingsManager.SaveSetting("PreContentHtml_HtmlData", Me.ucPreContentHtml.Text.Trim(), "Develisys", "Content Block", "Develisys Product Reviews List")
        SettingsManager.SaveSetting("PreContentHtml_PreTransformHtmlData", Me.ucPreContentHtml.PreTransformText.Trim(), "Develisys", "Content Block", "Develisys Product Reviews List")
        SettingsManager.SaveSetting("PostContentHtml_HtmlData", Me.ucPostContentHtml.Text.Trim(), "Develisys", "Content Block", "Develisys Product Reviews List")
        SettingsManager.SaveSetting("PostContentHtml_PreTransformHtmlData", Me.ucPostContentHtml.PreTransformText.Trim(), "Develisys", "Content Block", "Develisys Product Reviews List")
    End Sub

    Protected Sub chkTruncateReview_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles chkTruncateReview.CheckedChanged
        Me.phTruncateReviewLength.Visible = Me.chkTruncateReview.Checked
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        Page.Validate()
        If Page.IsPostBack Then
            SaveData()
            Me.NotifyFinishedEditing()
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub

End Class
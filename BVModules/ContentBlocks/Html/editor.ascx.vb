Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_Html_editor
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
            PopulateTags()
            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        Me.HtmlEditor1.Text = Me.SettingsManager.GetSetting("HtmlData")
        Dim pretransformText As String = Me.SettingsManager.GetSetting("PreTransformHtmlData")
        If Me.HtmlEditor1.SupportsTransform = True Then
            If pretransformText.Length > 0 Then
                Me.HtmlEditor1.Text = pretransformText
            End If
        End If

        Me.HtmlEditor2.Text = Me.SettingsManager.GetSetting("ScheduledHtmlData")
        pretransformText = Me.SettingsManager.GetSetting("PreTransformScheduledHtmlData")
        If Me.HtmlEditor2.SupportsTransform = True Then
            If pretransformText.Length > 0 Then
                Me.HtmlEditor2.Text = pretransformText
            End If
        End If

        Me.EnableScheduledContent.Checked = SettingsManager.GetBooleanSetting("EnableScheduledContent")

        Dim tempDateTime As String = Me.SettingsManager.GetSetting("StartDateTime")
        If Not String.IsNullOrEmpty(tempDateTime) Then
            Try
                Me.StartDatePicker.SelectedDate = New DateTime(Long.Parse(tempDateTime))
            Catch ex As Exception
                ' use default MinValue
            End Try
        End If

        tempDateTime = Me.SettingsManager.GetSetting("EndDateTime")
        If Not String.IsNullOrEmpty(tempDateTime) Then
            Try
                Me.EndDatePicker.SelectedDate = New DateTime(Long.Parse(tempDateTime))
            Catch ex As Exception
                ' use default MaxValue
            End Try
        End If

        Me.EnableReplacementTags.Checked = Me.SettingsManager.GetBooleanSetting("EnableReplacementTags")
        Me.ShowHideByQueryString.Checked = Me.SettingsManager.GetBooleanSetting("ShowHideByQueryString")
        Me.QueryStringName.Text = Me.SettingsManager.GetSetting("QueryStringName")
        Me.QueryStringValue.Text = Me.SettingsManager.GetSetting("QueryStringValue")
        Me.RemoveWrappingDiv.Checked = Me.SettingsManager.GetBooleanSetting("RemoveWrappingDiv")
    End Sub

    Private Sub SaveData()
        Me.SettingsManager.SaveSetting("HtmlData", Me.HtmlEditor1.Text.Trim, "bvsoftware", "Content Block", "HTML")
        Me.SettingsManager.SaveSetting("PreTransformHtmlData", Me.HtmlEditor1.PreTransformText.Trim, "bvsoftware", "Content Block", "HTML")
        Me.SettingsManager.SaveSetting("ScheduledHtmlData", Me.HtmlEditor2.Text.Trim, "bvsoftware", "Content Block", "HTML")
        Me.SettingsManager.SaveSetting("PreTransformScheduledHtmlData", Me.HtmlEditor2.PreTransformText.Trim, "bvsoftware", "Content Block", "HTML")
        Me.SettingsManager.SaveBooleanSetting("EnableScheduledContent", Me.EnableScheduledContent.Checked, "bvsoftware", "Content Block", "HTML")
        Me.SettingsManager.SaveSetting("StartDateTime", Me.StartDatePicker.SelectedDate.Ticks.ToString(), "bvsoftware", "Content Block", "HTML")
        Me.SettingsManager.SaveSetting("EndDateTime", Me.EndDatePicker.SelectedDate.Ticks.ToString(), "bvsoftware", "Content Block", "HTML")
        Me.SettingsManager.SaveBooleanSetting("EnableReplacementTags", Me.EnableReplacementTags.Checked, "bvsoftware", "Content Block", "HTML")
        Me.SettingsManager.SaveBooleanSetting("ShowHideByQueryString", Me.ShowHideByQueryString.Checked, "bvsoftware", "Content Block", "HTML")
        Me.SettingsManager.SaveSetting("QueryStringName", Me.QueryStringName.Text, "bvsoftware", "Content Block", "HTML")
        Me.SettingsManager.SaveSetting("QueryStringValue", Me.QueryStringValue.Text, "bvsoftware", "Content Block", "HTML")
        Me.SettingsManager.SaveBooleanSetting("RemoveWrappingDiv", Me.RemoveWrappingDiv.Checked, "bvsoftware", "Content Block", "HTML")
    End Sub

    Private Sub PopulateTags()
        Dim t As New Collection(Of Content.EmailTemplateTag)

        Dim e As New Content.EmailTemplate
        For Each tt As Content.EmailTemplateTag In e.ReplacementTags()
            t.Add(tt)
        Next

        Dim u As New Membership.UserAccount
        For Each tt As Content.EmailTemplateTag In u.ReplacementTags
            t.Add(tt)
        Next

        Me.Tags.DataSource = t
        Me.Tags.DataValueField = "Tag"
        Me.Tags.DataTextField = "Tag"
        Me.Tags.DataBind()
    End Sub

End Class
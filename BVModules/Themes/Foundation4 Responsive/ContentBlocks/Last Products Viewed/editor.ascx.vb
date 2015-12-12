Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core
Imports System.IO

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Last_Products_Viewed_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        Me.txtTitle.Text = SettingsManager.GetSetting("Title")
        Me.ddlHeadingTag.SelectedValue = SettingsManager.GetSetting("HeadingTag")
        Me.ddlColumns.SelectedValue = SettingsManager.GetSetting("Columns")
        If SettingsManager.SettingExists("DisplayName") Then
            Me.txtCssClassPrefix.Text = SettingsManager.GetSetting("CssClassPrefix")
            Me.chkDisplayName.Checked = SettingsManager.GetBooleanSetting("DisplayName")
            Me.chkDisplayImage.Checked = SettingsManager.GetBooleanSetting("DisplayImage")
            Me.chkDisplayNewBadge.Checked = SettingsManager.GetBooleanSetting("DisplayNewBadge")
            Me.chkDisplayDescription.Checked = SettingsManager.GetBooleanSetting("DisplayDescription")
            Me.chkDisplayPrice.Checked = SettingsManager.GetBooleanSetting("DisplayPrice")
            Me.chkDisplayQuantity.Checked = SettingsManager.GetBooleanSetting("DisplayQuantity")
            Me.chkDisplayAddToCartButton.Checked = SettingsManager.GetBooleanSetting("DisplayAddToCartButton")
            Me.chkDisplaySelectedCheckbox.Checked = SettingsManager.GetBooleanSetting("DisplaySelectedCheckbox")
            Me.chkRemainOnPageAfterAddToCart.Checked = SettingsManager.GetBooleanSetting("RemainOnPageAfterAddToCart")

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
        Else
            Me.chkDisplayName.Checked = True
            Me.chkDisplayImage.Checked = True
            Me.chkDisplayNewBadge.Checked = WebAppSettings.NewProductBadgeAllowed
            Me.chkDisplayDescription.Checked = False
            Me.chkDisplayPrice.Checked = True
            Me.chkDisplayQuantity.Checked = False
            Me.chkDisplayAddToCartButton.Checked = False
            Me.chkDisplaySelectedCheckbox.Checked = False
            Me.chkRemainOnPageAfterAddToCart.Checked = (Not WebAppSettings.RedirectToCartAfterAddProduct)
            Me.ddlColumns.SelectedValue = "3"
        End If
    End Sub

    Protected Sub SaveData()
        SettingsManager.SaveSetting("Title", Me.txtTitle.Text, "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveSetting("HeadingTag", Me.ddlHeadingTag.SelectedValue, "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveSetting("Columns", Me.ddlColumns.SelectedValue.Trim, "bvsoftware", "Content Block", "Last Product Viewed")
        SettingsManager.SaveSetting("PreContentHtml_HtmlData", Me.ucPreContentHtml.Text.Trim(), "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveSetting("PreContentHtml_PreTransformHtmlData", Me.ucPreContentHtml.PreTransformText.Trim(), "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveSetting("PostContentHtml_HtmlData", Me.ucPostContentHtml.Text.Trim(), "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveSetting("PostContentHtml_PreTransformHtmlData", Me.ucPostContentHtml.PreTransformText.Trim(), "Develisys", "Content Block", "Last Product Viewed")

        ' Product display data
        SettingsManager.SaveSetting("CssClassPrefix", Me.txtCssClassPrefix.Text, "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveBooleanSetting("DisplayName", Me.chkDisplayName.Checked, "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveBooleanSetting("DisplayImage", Me.chkDisplayImage.Checked, "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveBooleanSetting("DisplayNewBadge", Me.chkDisplayNewBadge.Checked, "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveBooleanSetting("DisplayDescription", Me.chkDisplayDescription.Checked, "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveBooleanSetting("DisplayPrice", Me.chkDisplayPrice.Checked, "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveBooleanSetting("DisplayAddToCartButton", Me.chkDisplayAddToCartButton.Checked, "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveBooleanSetting("DisplaySelectedCheckBox", Me.chkDisplaySelectedCheckbox.Checked, "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveBooleanSetting("DisplayQuantity", Me.chkDisplayQuantity.Checked, "Develisys", "Content Block", "Last Product Viewed")
        SettingsManager.SaveBooleanSetting("RemainOnPageAfterAddToCart", Me.chkRemainOnPageAfterAddToCart.Checked, "Develisys", "Content Block", "Last Product Viewed")
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

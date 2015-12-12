Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Top_Selling_Products_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

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
        Me.txtNumberOfItems.Text = SettingsManager.GetSetting("NumberOfItems", 10)
        Me.ddlCategory.SelectedValue = SettingsManager.GetSetting("CategoryId")
        Me.ddlColumns.SelectedValue = SettingsManager.GetSetting("Columns")
        Me.ddlHeadingTag.SelectedValue = SettingsManager.GetSetting("HeadingTag")

        Dim dateRange As BVSoftware.BVC5.Core.Utilities.DateRange = New BVSoftware.BVC5.Core.Utilities.DateRange()
        dateRange.RangeType = CType(SettingsManager.GetIntegerSetting("DateRangeType"), BVSoftware.BVC5.Core.Utilities.DateRangeType)

        Select Case dateRange.RangeType
            Case BVSoftware.BVC5.Core.Utilities.DateRangeType.Custom
                Dim tempDateTime As String = SettingsManager.GetSetting("StartDate")
                If Not String.IsNullOrEmpty(tempDateTime) Then
                    dateRange.StartDate = Convert.ToDateTime(tempDateTime)
                End If

                tempDateTime = SettingsManager.GetSetting("EndDate")
                If Not String.IsNullOrEmpty(tempDateTime) Then
                    dateRange.EndDate = Convert.ToDateTime(tempDateTime)
                End If

                Me.ucDateRange.StartDate = dateRange.StartDate
                Me.ucDateRange.EndDate = dateRange.EndDate

                Me.ViewState("StartDate") = dateRange.StartDate
                Me.ViewState("EndDate") = dateRange.EndDate

            Case BVSoftware.BVC5.Core.Utilities.DateRangeType.None
                ' do nothing

            Case Else
                Me.ucDateRange.RangeType = dateRange.RangeType

        End Select

        ' Product display data
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

    Private Sub SaveData()
        SettingsManager.SaveSetting("Title", Me.txtTitle.Text, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveSetting("NumberOfItems", Me.txtNumberOfItems.Text, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveSetting("CategoryId", Me.ddlCategory.SelectedValue, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveSetting("Columns", Me.ddlColumns.SelectedValue, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveSetting("HeadingTag", Me.ddlHeadingTag.SelectedValue, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveIntegerSetting("DateRangeType", Convert.ToInt32(Me.ucDateRange.RangeType), "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveSetting("StartDate", Me.ucDateRange.StartDate.ToString(), "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveSetting("EndDate", Me.ucDateRange.EndDate.ToString(), "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveSetting("PreContentHtml_HtmlData", Me.ucPreContentHtml.Text.Trim(), "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveSetting("PreContentHtml_PreTransformHtmlData", Me.ucPreContentHtml.PreTransformText.Trim(), "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveSetting("PostContentHtml_HtmlData", Me.ucPostContentHtml.Text.Trim(), "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveSetting("PostContentHtml_PreTransformHtmlData", Me.ucPostContentHtml.PreTransformText.Trim(), "Develisys", "Content Block", "Develisys Top Sellers")

        ' Product display data
        SettingsManager.SaveSetting("CssClassPrefix", Me.txtCssClassPrefix.Text, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveBooleanSetting("DisplayName", Me.chkDisplayName.Checked, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveBooleanSetting("DisplayImage", Me.chkDisplayImage.Checked, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveBooleanSetting("DisplayNewBadge", Me.chkDisplayNewBadge.Checked, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveBooleanSetting("DisplayDescription", Me.chkDisplayDescription.Checked, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveBooleanSetting("DisplayPrice", Me.chkDisplayPrice.Checked, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveBooleanSetting("DisplayAddToCartButton", Me.chkDisplayAddToCartButton.Checked, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveBooleanSetting("DisplaySelectedCheckBox", Me.chkDisplaySelectedCheckbox.Checked, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveBooleanSetting("DisplayQuantity", Me.chkDisplayQuantity.Checked, "Develisys", "Content Block", "Develisys Top Sellers")
        SettingsManager.SaveBooleanSetting("RemainOnPageAfterAddToCart", Me.chkRemainOnPageAfterAddToCart.Checked, "Develisys", "Content Block", "Develisys Top Sellers")
    End Sub

    Protected Sub ucDateRange_RangeTypeChanged(ByVal e As EventArgs) Handles ucDateRange.RangeTypeChanged
        If ucDateRange.RangeType = BVSoftware.BVC5.Core.Utilities.DateRangeType.Custom Then
            If Me.ViewState("StartDate") IsNot Nothing Then
                ucDateRange.StartDate = CType(Me.ViewState("StartDate"), DateTime)
            End If

            If Me.ViewState("EndDate") IsNot Nothing Then
                ucDateRange.EndDate = CType(Me.ViewState("EndDate"), DateTime)
            End If
        End If
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
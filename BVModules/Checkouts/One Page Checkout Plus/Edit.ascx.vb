Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Checkouts_One_Page_Checkout_Plus_Edit
    Inherits Content.CheckoutEditorTemplate

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.BlockId = "8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0"
    End Sub

    Public Overrides Sub LoadFormData()
        If Not Page.IsPostBack Then
            Dim pretransformText As String = String.Empty

            Me.chkEnableAccountCreation.Checked = SettingsManager.GetBooleanSetting("EnableAccountCreation")
            Me.chkRequireAccountCreation.Checked = SettingsManager.GetBooleanSetting("RequireAccountCreation")
            Me.chkRequireAccountCreation.Enabled = Me.chkEnableAccountCreation.Checked
            Me.chkPromptForLogin.Checked = SettingsManager.GetBooleanSetting("PromptForLogin")
            Me.chkEnablePromotionalCodeEntry.Checked = SettingsManager.GetBooleanSetting("EnablePromotionalCodeEntry")
            Me.chkEnableMailingListSignup.Checked = SettingsManager.GetBooleanSetting("EnableMailingListSignup")

            Me.ddlMaillingList.DataSource = Contacts.MailingList.FindAll()
            Me.ddlMaillingList.DataValueField = "Bvin"
            Me.ddlMaillingList.DataTextField = "Name"
            Me.ddlMaillingList.DataBind()
            Me.ddlMaillingList.SelectedValue = SettingsManager.GetSetting("MailingList")

            Me.ucShippingInstructions.Text = SettingsManager.GetSetting("ShippingInstructions_HtmlData")
            pretransformText = SettingsManager.GetSetting("ShippingInstructions_PreTransformHtmlData")
            If Me.ucShippingInstructions.SupportsTransform = True Then
                If pretransformText.Length > 0 Then
                    Me.ucShippingInstructions.Text = pretransformText
                End If
            End If

            Me.ucBillingInstructions.Text = SettingsManager.GetSetting("BillingInstructions_HtmlData")
            pretransformText = SettingsManager.GetSetting("BillingInstructions_PreTransformHtmlData")
            If Me.ucBillingInstructions.SupportsTransform = True Then
                If pretransformText.Length > 0 Then
                    Me.ucBillingInstructions.Text = pretransformText
                End If
            End If

            Me.ucPaymentInstructions.Text = SettingsManager.GetSetting("PaymentInstructions_HtmlData")
            pretransformText = SettingsManager.GetSetting("PaymentInstructions_PreTransformHtmlData")
            If Me.ucPaymentInstructions.SupportsTransform = True Then
                If pretransformText.Length > 0 Then
                    Me.ucPaymentInstructions.Text = pretransformText
                End If
            End If

            Me.ucGiftCertificateInstructions.Text = SettingsManager.GetSetting("GiftCertificateInstructions_HtmlData")
            pretransformText = SettingsManager.GetSetting("GiftCertificateInstructions_PreTransformHtmlData")
            If Me.ucGiftCertificateInstructions.SupportsTransform = True Then
                If pretransformText.Length > 0 Then
                    Me.ucGiftCertificateInstructions.Text = pretransformText
                End If
            End If

            Me.ucPromotionalCodeInstructions.Text = SettingsManager.GetSetting("PromotionalCodeInstructions_HtmlData")
            pretransformText = SettingsManager.GetSetting("PromotionalCodeInstructions_PreTransformHtmlData")
            If Me.ucPromotionalCodeInstructions.SupportsTransform = True Then
                If pretransformText.Length > 0 Then
                    Me.ucPromotionalCodeInstructions.Text = pretransformText
                End If
            End If

            Me.ucAccountInstructions.Text = SettingsManager.GetSetting("AccountInstructions_HtmlData")
            pretransformText = SettingsManager.GetSetting("AccountInstructions_PreTransformHtmlData")
            If Me.ucAccountInstructions.SupportsTransform = True Then
                If pretransformText.Length > 0 Then
                    Me.ucAccountInstructions.Text = pretransformText
                End If
            End If

            Me.ucReviewInstructions.Text = SettingsManager.GetSetting("ReviewInstructions_HtmlData")
            pretransformText = SettingsManager.GetSetting("ReviewInstructions_PreTransformHtmlData")
            If Me.ucReviewInstructions.SupportsTransform = True Then
                If pretransformText.Length > 0 Then
                    Me.ucReviewInstructions.Text = pretransformText
                End If
            End If
        End If
    End Sub

    Public Overrides Sub SaveFormData()
        SettingsManager.SaveBooleanSetting("EnableAccountCreation", chkEnableAccountCreation.Checked, "Develisys", "Checkout", "One Page Checkout Plus")
        SettingsManager.SaveBooleanSetting("RequireAccountCreation", chkRequireAccountCreation.Checked, "Develisys", "Checkout", "One Page Checkout Plus")
        SettingsManager.SaveBooleanSetting("PromptForLogin", chkPromptForLogin.Checked, "Develisys", "Checkout", "One Page Checkout Plus")
        SettingsManager.SaveBooleanSetting("EnablePromotionalCodeEntry", chkEnablePromotionalCodeEntry.Checked, "Develisys", "Checkout", "One Page Checkout Plus")
        SettingsManager.SaveBooleanSetting("EnableMailingListSignup", chkEnableMailingListSignup.Checked, "Develisys", "Checkout", "One Page Checkout Plus")
        SettingsManager.SaveSetting("MailingList", ddlMaillingList.SelectedValue, "Develisys", "Checkout", "One Page Checkout Plus")

        ' Shipping Instructions
        SettingsManager.SaveSetting("ShippingInstructions_HtmlData", Me.ucShippingInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")
        SettingsManager.SaveSetting("ShippingInstructions_PreTransformHtmlData", Me.ucShippingInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")

        ' Billing Instructions
        SettingsManager.SaveSetting("BillingInstructions_HtmlData", Me.ucBillingInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")
        SettingsManager.SaveSetting("BillingInstructions_PreTransformHtmlData", Me.ucBillingInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")

        ' Payment Instructions
        SettingsManager.SaveSetting("PaymentInstructions_HtmlData", Me.ucPaymentInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")
        SettingsManager.SaveSetting("PaymentInstructions_PreTransformHtmlData", Me.ucPaymentInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")

        ' Gift Certificate Instructions
        SettingsManager.SaveSetting("GiftCertificateInstructions_HtmlData", Me.ucGiftCertificateInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")
        SettingsManager.SaveSetting("GiftCertificateInstructions_PreTransformHtmlData", Me.ucGiftCertificateInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")

        ' Promotional Code Instructions
        SettingsManager.SaveSetting("PromotionalCodeInstructions_HtmlData", Me.ucPromotionalCodeInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")
        SettingsManager.SaveSetting("PromotionalCodeInstructions_PreTransformHtmlData", Me.ucPromotionalCodeInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")

        ' Account Instructions
        SettingsManager.SaveSetting("AccountInstructions_HtmlData", Me.ucAccountInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")
        SettingsManager.SaveSetting("AccountInstructions_PreTransformHtmlData", Me.ucAccountInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")

        ' Review Instructions
        SettingsManager.SaveSetting("ReviewInstructions_HtmlData", Me.ucReviewInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")
        SettingsManager.SaveSetting("ReviewInstructions_PreTransformHtmlData", Me.ucReviewInstructions.Text.Trim(), "Develisys", "Checkout", "One Page Checkout Plus")

        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        Page.Validate()
        If Page.IsValid Then
            SaveFormData()
        End If
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub

End Class
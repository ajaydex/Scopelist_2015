Imports BVSoftware.Bvc5.Core.PersonalizationServices
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.Data

Partial Class BVModules_Themes_Foundation4_Responsive_Pages_Contact
    Inherits BaseStorePage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Service.master")
    End Sub

    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.TitleLabel.Text = Content.SiteTerms.GetTerm("ContactUs")
        PageTitle = Content.SiteTerms.GetTerm("ContactUs")

        If Not Page.IsPostBack Then
            Dim policy As Content.Policy = Content.Policy.FindByBvin(WebAppSettings.ContactUsPolicy)
            For Each block As Content.PolicyBlock In policy.Blocks
                contactUsInfo.InnerHtml += block.Description
            Next
        End If

        If WebAppSettings.ContactForm = True Then
            Me.rpForm.DataSource = Contacts.ContactUsQuestion.FindAll()
            Me.rpForm.DataBind()
            Me.pnlContactForm.Visible = True
        Else
            Me.pnlContactForm.Visible = False
        End If
    End Sub

    Protected Sub rpForm_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles rpForm.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim question As Contacts.ContactUsQuestion = CType(e.Item.DataItem, Contacts.ContactUsQuestion)

            Dim ctrlId As String = "ctrl_" + question.Bvin.Replace("-", "_")
            Dim pnlField As Panel = CType(e.Item.FindControl("pnlField"), Panel)

            Dim lblField As Label = CType(e.Item.FindControl("lblField"), Label)
            lblField.AssociatedControlID = ctrlId
            lblField.Text = question.Name

            Dim rfvField As Controls.BVRequiredFieldValidator = CType(e.Item.FindControl("rfvField"), Controls.BVRequiredFieldValidator)
            rfvField.ControlToValidate = ctrlId

            Select Case question.Type
                Case Contacts.ContactUsQuestionType.FreeAnswer, Contacts.ContactUsQuestionType.TextArea
                    Dim txt As New TextBox()
                    txt.ID = ctrlId
                    If question.Type = Contacts.ContactUsQuestionType.TextArea Then
                        txt.TextMode = TextBoxMode.MultiLine
                        pnlField.CssClass = "large-12 columns"
                    Else
                        pnlField.CssClass = "large-6 small-12 columns"
                    End If

                    pnlField.Controls.Add(txt)


                Case Contacts.ContactUsQuestionType.MultipleChoice
                    Dim ddl As New DropDownList()
                    ddl.ID = ctrlId

                    For Each questionOption As Contacts.ContactUsQuestionOption In question.Values
                        If Not String.IsNullOrEmpty(questionOption.Bvin) Then
                            ddl.Items.Add(questionOption.Value)
                        End If
                    Next

                    pnlField.Controls.Add(ddl)
                    pnlField.CssClass = "large-6 small-12 columns"

            End Select
        End If
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSubmit.Click
        Dim t As Content.EmailTemplate = Content.EmailTemplate.FindByBvin(WebAppSettings.EmailTemplateID_ContactUs)

        If t IsNot Nothing Then
            Dim m As System.Net.Mail.MailMessage = t.ConvertToMailMessage(t.From, WebAppSettings.ContactUsEmailRecipient)

            Dim sb As New StringBuilder(m.Body)
            sb.Append("<br />")

            For Each ri As RepeaterItem In Me.rpForm.Items
                If ri.ItemType = ListItemType.Item OrElse ri.ItemType = ListItemType.AlternatingItem Then
                    Dim lblField As Label = CType(ri.FindControl("lblField"), Label)
                    If lblField IsNot Nothing Then
                        Dim ctrl As Control = ri.FindControl(lblField.AssociatedControlID)
                        If ctrl IsNot Nothing Then
                            Dim value As String = ""

                            If TypeOf ctrl Is TextBox Then
                                value = CType(ctrl, TextBox).Text.Trim()
                            ElseIf TypeOf ctrl Is DropDownList Then
                                value = CType(ctrl, DropDownList).SelectedValue
                            End If

                            sb.AppendFormat("{0}:&nbsp;&nbsp;{1}{2}<br /><br />", lblField.Text, value, Environment.NewLine)
                        End If
                    End If
                End If
            Next

            m.Body = sb.ToString()

            If Utilities.MailServices.SendMail(m) = False Then
                msg.ShowError("Error while sending mail!")
            Else
                pnlContactForm.Visible = False
                msg.ShowOk("<strong>Thank you. Your message has been sent.</strong>")
            End If
        End If
    End Sub

End Class
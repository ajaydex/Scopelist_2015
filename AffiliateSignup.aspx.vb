Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class AffiliateSignup
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Private Enum Modes
        Intro = 0
        Form = 1
        Thanks = 2
    End Enum

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        TitleLabel.Text = Content.SiteTerms.GetTerm("AffiliateSignup")

        Me.ManualBreadCrumbTrail1.ClearTrail()
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("CustomerService"), "~/ContactUs.aspx")
        Me.ManualBreadCrumbTrail1.AddNonLink(Content.SiteTerms.GetTerm("AffiliateSignup"))

        If Not Page.IsPostBack Then
            Me.btnCancel.ImageUrl = PersonalizationServices.GetThemedButton("Cancel")
            Me.btnSave.ImageUrl = PersonalizationServices.GetThemedButton("Submit")

            StoreAddressEditor1.ShowMiddleInitial = True
            StoreAddressEditor1.ShowCompanyName = True
            StoreAddressEditor1.ShowPhoneNumber = True
            StoreAddressEditor1.ShowFaxNumber = True
            StoreAddressEditor1.ShowWebSiteURL = False

            Dim policy As Content.Policy = Content.Policy.FindByBvin(WebAppSettings.AffiliateIntroId)
            For Each block As Content.PolicyBlock In policy.Blocks
                affiliateIntro.InnerHtml += block.Description
            Next
            'Me.valEmail.Text = ImageHelper.GetErrorIconTag
            'Me.valWebSite.Text = ImageHelper.GetErrorIconTag
        End If
        AddDynamicQuestions()
    End Sub

    Protected Sub AddDynamicQuestions()
        Dim questions As Collection(Of Contacts.AffiliateQuestion) = Contacts.AffiliateQuestion.FindAll()
        Dim count As Integer = 0
        For Each question As Contacts.AffiliateQuestion In questions
            count += 1
            Dim row As New HtmlTableRow()
            row.ID = "DynamicRow" & count
            If question.Type = Contacts.AffiliateQuestionType.FreeAnswer Then
                Dim questionLabel As New Label()
                questionLabel.ID = "questionLabel" & count.ToString()
                questionLabel.Text = question.Values(0).Value
                Dim questionTextBox As New TextBox()
                questionTextBox.ID = "questionTextBox" & count.ToString()
                questionTextBox.Text = ""
                questionTextBox.TabIndex = 140 + count
                Dim cell As New HtmlTableCell()
                cell.Attributes.Add("class", "formlabel")
                cell.Controls.Add(questionLabel)
                row.Cells.Add(cell)
                cell = New HtmlTableCell()
                cell.Attributes.Add("class", "formfield")
                cell.Controls.Add(questionTextBox)
                row.Cells.Add(cell)

                Dim validator As New Controls.BVRequiredFieldValidator()
                validator.Text = "*"
                validator.ErrorMessage = "Field is required."
                validator.ControlToValidate = "questionTextBox" & count.ToString()
                cell.Controls.Add(validator)
            ElseIf question.Type = Contacts.AffiliateQuestionType.MultipleChoice Then
                Dim questionLabel As New Label()
                questionLabel.ID = "questionLabel" & count.ToString()
                questionLabel.Text = question.Values(question.Values.Count - 1).Value
                question.Values.RemoveAt(question.Values.Count - 1)
                Dim questionDropDownList As New DropDownList()
                questionDropDownList.ID = "questionDropDownList" & count.ToString()
                questionDropDownList.TabIndex = 140 + count
                For Each questionOption As Contacts.AffiliateQuestionOption In question.Values
                    questionDropDownList.Items.Add(questionOption.Value)
                Next
                Dim cell As New HtmlTableCell()
                cell.Attributes.Add("class", "formlabel")
                cell.Controls.Add(questionLabel)
                row.Cells.Add(cell)
                cell = New HtmlTableCell()
                cell.Attributes.Add("class", "formfield")
                cell.Controls.Add(questionDropDownList)
                row.Cells.Add(cell)

                Dim validator As New Controls.BVRequiredFieldValidator()
                validator.Text = "*"
                validator.ErrorMessage = "Field is required."
                validator.ControlToValidate = "questionDropDownList" & count.ToString()
                cell.Controls.Add(validator)
            End If
            QuestionTable.Rows.Add(row)
        Next
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("~/Default.aspx")
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        MessageBox1.ClearMessage()
        If chkAgree.Checked Then
            If StoreAddressEditor1.Validate = True Then
                If CreateAffiliate() Then
                    AffiliateMultiView.ActiveViewIndex = Modes.Thanks
                    Dim policy As Content.Policy = Content.Policy.FindByBvin(WebAppSettings.AffiliateThanksId)
                    For Each block As Content.PolicyBlock In policy.Blocks
                        affiliateThanks.InnerHtml += block.Description
                    Next
                End If
            End If
        Else
            MessageBox1.ShowWarning("You must agree to the Terms and Conditions to join the affiliate program.")
        End If
    End Sub

    Private Function CreateAffiliate() As Boolean
        Dim result As Boolean = False

        Dim aff As New Contacts.Affiliate
        Try
            If Not aff Is Nothing Then
                aff.ReferralId = System.Guid.NewGuid().ToString()
                aff.DisplayName = HttpUtility.HtmlEncode(DisplayNameField.Text)
                aff.CommissionAmount = WebAppSettings.AffiliateCommissionAmount
                aff.ReferralDays = WebAppSettings.AffiliateReferralDays
                aff.CommissionType = WebAppSettings.AffiliateCommissionType
                aff.TaxId = HttpUtility.HtmlEncode(Me.TaxIDField.Text.Trim)
                aff.DriversLicenseNumber = HttpUtility.HtmlEncode(Me.DriversLicenseNumberField.Text.Trim)
                aff.WebSiteUrl = HttpUtility.HtmlEncode(Me.WebSiteURLField.Text.Trim)
                aff.Address = StoreAddressEditor1.GetAsAddress

                Dim count As Integer = 0
                For Each row As HtmlTableRow In AffiliateFormTable.Rows
                    If row.ID IsNot Nothing Then
                        If row.ID.StartsWith("DynamicRow") Then
                            count += 1
                            Dim label As Label = CType(row.FindControl("questionLabel" & count.ToString()), Label)
                            Dim obj As Object = row.FindControl("questionTextBox" & count.ToString())
                            If obj IsNot Nothing Then
                                aff.Notes += " " & label.Text & ":" & DirectCast(obj, TextBox).Text & Environment.NewLine
                            Else
                                obj = row.FindControl("questionDropDownList" & count.ToString())
                                If obj IsNot Nothing Then
                                    aff.Notes += " " & label.Text & ":" & DirectCast(obj, DropDownList).SelectedItem.Text & Environment.NewLine
                                End If
                            End If
                        End If
                    End If
                Next

                If Contacts.Affiliate.Insert(aff) Then
                    result = True
                    Me.lblAffiliateLink.Text = "Your Affiliate ID is: " & aff.ReferralId & "<br>"
                    Me.lblAffiliateLink.Text += "Your affiliate Link Is: " & Server.HtmlEncode(Contacts.Affiliate.GetDefaultLink(aff.ReferralId))
                Else
                    MessageBox1.ShowError("Couldn't Create New Affiliate Account. Save Failed.")
                End If
            End If
        Catch Ex As Exception
            MessageBox1.ShowException(Ex)
            result = False
        End Try
        aff = Nothing

        Return result
    End Function

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Service.master")
        Me.PageTitle = Content.SiteTerms.GetTerm("AffiliateSignup")
    End Sub

    Protected Sub SignUpLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SignUpLinkButton.Click
        AffiliateMultiView.ActiveViewIndex = Modes.Form
    End Sub
End Class

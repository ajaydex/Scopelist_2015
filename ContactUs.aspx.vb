Imports BVSoftware.Bvc5.Core.PersonalizationServices
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.Data
Imports System.Net.Mail
Imports System.Net
Imports System.Net.Configuration
Imports System.Web.Configuration
Imports System.IO


Partial Class Contact
    Inherits BaseStorePage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Service.master")
    End Sub

    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim header As UserControl = DirectCast(Me.Master.FindControl("Header1"), UserControl)
        Dim lnkMyAccount As HyperLink = DirectCast(header.FindControl("lnkContactUs"), HyperLink)
        lnkMyAccount.ForeColor = Drawing.Color.White

        Me.TitleLabel.Text = Content.SiteTerms.GetTerm("ContactUs")
        PageTitle = Content.SiteTerms.GetTerm("ContactUs")
        If Not Page.IsPostBack Then
            Me.ImageButton1.ImageUrl = PersonalizationServices.GetThemedButton("Submit")

            'Dim policy As Content.Policy = Content.Policy.FindByBvin(WebAppSettings.ContactUsPolicy)
            'For Each block As Content.PolicyBlock In policy.Blocks
            '    contactUsInfo.InnerHtml += block.Description
            'Next

            Dim policy As Content.Policy = Content.Policy.FindByBvin(WebAppSettings.ContactUsPolicy)
            Dim i As Integer = 0
            For Each block As Content.PolicyBlock In policy.Blocks
                If i = 0 Then
                    contactUsInfo.InnerHtml += block.Description
                End If

                If i = 1 Then
                    contactUsBottom.InnerHtml += block.Description
                End If

                i = i + 1
            Next
        End If

        If WebAppSettings.ContactForm = True Then
            AddDynamicQuestions()
            Me.pnlContactForm.Visible = True
        Else
            Me.pnlContactForm.Visible = False
        End If

    End Sub

    Protected Sub AddDynamicQuestions()
        Dim questions As Collection(Of Contacts.ContactUsQuestion) = Contacts.ContactUsQuestion.FindAll()
        Dim count As Integer = 0
        For Each question As Contacts.ContactUsQuestion In questions
            count += 1
            Dim row As New HtmlTableRow()
            row.ID = "DynamicRow" & count
            If question.Type = Contacts.ContactUsQuestionType.FreeAnswer Then
                Dim questionLabel As New Label()
                questionLabel.ID = "questionLabel" & count.ToString()
                questionLabel.Text = question.Values(0).Value
                Dim questionTextBox As New TextBox()
                questionTextBox.ID = "questionTextBox" & count.ToString()
                questionTextBox.Text = ""
                questionTextBox.TabIndex = 140 + count
                questionLabel.AssociatedControlID = questionTextBox.ID
                questionTextBox.CssClass = "forminput"
                Dim cell As New HtmlTableCell()
                cell.Controls.Add(questionLabel)
                cell.Attributes.Add("class", "formlabel")
                row.Cells.Add(cell)
                cell = New HtmlTableCell()
                cell.Controls.Add(questionTextBox)
                cell.Attributes.Add("class", "formfield")
                row.Cells.Add(cell)

                Dim validator As New Controls.BVRequiredFieldValidator()
                validator.Text = "*"
                validator.ErrorMessage = "Field is required."
                validator.ControlToValidate = "questionTextBox" & count.ToString()
                cell.Controls.Add(validator)
            ElseIf question.Type = Contacts.ContactUsQuestionType.MultipleChoice Then
                Dim questionLabel As New Label()
                questionLabel.ID = "questionLabel" & count.ToString()
                questionLabel.Text = question.Values(question.Values.Count - 1).Value
                question.Values.RemoveAt(question.Values.Count - 1)
                Dim questionDropDownList As New DropDownList()
                questionDropDownList.ID = "questionDropDownList" & count.ToString()
                questionDropDownList.TabIndex = 140 + count
                For Each questionOption As Contacts.ContactUsQuestionOption In question.Values
                    questionDropDownList.Items.Add(questionOption.Value)
                Next
                questionLabel.AssociatedControlID = questionDropDownList.ID
                Dim cell As New HtmlTableCell()
                cell.Controls.Add(questionLabel)
                cell.Attributes.Add("class", "formlabel")
                row.Cells.Add(cell)
                cell = New HtmlTableCell()
                cell.Controls.Add(questionDropDownList)
                cell.Attributes.Add("class", "formfield")
                row.Cells.Add(cell)

                Dim validator As New Controls.BVRequiredFieldValidator()
                validator.Text = "*"
                validator.ErrorMessage = "Field is required."
                validator.ControlToValidate = "questionDropDownList" & count.ToString()
                cell.Controls.Add(validator)
            ElseIf question.Type = Contacts.ContactUsQuestionType.TextArea Then
                Dim questionLabel As New Label()
                questionLabel.ID = "questionLabel" & count.ToString()
                questionLabel.Text = question.Values(0).Value
                Dim questionTextBox As New TextBox()
                questionTextBox.ID = "questionTextBox" & count.ToString()
                questionTextBox.Text = ""
                questionTextBox.TextMode = TextBoxMode.MultiLine
                questionTextBox.TabIndex = 140 + count
                questionLabel.AssociatedControlID = questionTextBox.ID
                questionTextBox.CssClass = "formtextarea"
                Dim cell As New HtmlTableCell()
                cell.Controls.Add(questionLabel)
                cell.Attributes.Add("class", "formlabel aligntop")
                row.Cells.Add(cell)
                cell = New HtmlTableCell()
                cell.Controls.Add(questionTextBox)
                cell.Attributes.Add("class", "formfield")
                row.Cells.Add(cell)

                Dim validator As New Controls.BVRequiredFieldValidator()
                validator.Text = "*"
                validator.ErrorMessage = "Field is required."
                validator.ControlToValidate = "questionTextBox" & count.ToString()
                cell.Controls.Add(validator)
                cell.VAlign = "top"
            End If
            ContactUsFormTable.Rows.Add(row)
        Next
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click

        Dim t As Content.EmailTemplate
        t = Content.EmailTemplate.FindByBvin(WebAppSettings.EmailTemplateID_ContactUs)
        Dim toEmail As String = WebAppSettings.ContactUsEmailRecipient

        If t IsNot Nothing Then
            Dim m As System.Net.Mail.MailMessage
            m = t.ConvertToMailMessage(t.From, toEmail)

            Dim sBody As String = m.Body
            sBody += "<br />"
            Dim count As Integer = 0
            For Each row As HtmlTableRow In Me.ContactUsFormTable.Rows
                If row.ID IsNot Nothing Then
                    If row.ID.StartsWith("DynamicRow") Then
                        count += 1
                        Dim label As Label = CType(row.FindControl("questionLabel" & count.ToString()), Label)
                        Dim obj As Object = row.FindControl("questionTextBox" & count.ToString())
                        If obj IsNot Nothing Then
                            sBody += " " & label.Text & ":&nbsp;&nbsp;" & DirectCast(obj, TextBox).Text & Environment.NewLine & "<br /> <br />"
                        Else
                            obj = row.FindControl("questionDropDownList" & count.ToString())
                            If obj IsNot Nothing Then
                                sBody += " " & label.Text & ":&nbsp;&nbsp;" & DirectCast(obj, DropDownList).SelectedItem.Text & Environment.NewLine & "<br /> <br />"
                            End If
                        End If
                    End If
                End If
            Next

            m.Body = sBody

            If Utilities.MailServices.SendMail(m) = False Then
                msg.ShowError("Error while sending mail!")
            Else
                pnlContactForm.Visible = False
                msg.ShowOk("<strong>Thank you.  Your message has been sent.</strong>")
            End If
        End If

    End Sub

    Protected Sub btnContact_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnContactUs.ServerClick

        'code to get affid from site
        Dim cook As HttpCookie = Request.Cookies("affiliateReference")
        Dim affid As String = String.Empty
        If Not cook Is Nothing Then
            affid = cook.Value
        End If

        Dim remoteUrl As String = "https://www.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8"
        Dim firstName As String = Me.txtFirstName.Text
        Dim lastName As String = Me.txtLastName.Text
        Dim email As String = Me.txtEmail.Text
        Dim phone As String = Me.txtTelephone.Text
        Dim purpose As String = Me.ddlPurpose.SelectedItem.Value
        Dim query As String = Me.txtMessage.Text
        Dim oid As String = "00Do0000000JvrX"
        Dim retURL As String = "http://"
        Dim ipaddress As String = Request.UserHostAddress.ToString()
        Dim lead_source As String = "Contact Us"

        Dim encoding As ASCIIEncoding = New ASCIIEncoding

        Dim data As String = String.Format("first_name={0}&last_name={1}&email={2}&phone={3}&00No0000005nvyK={4}&00No0000005nvyP={5}&oid={6}&retURL={7}&lead_source={8}&00No0000003opMp={9}&00No0000003opNs={10}", firstName, lastName, email, phone, purpose, query, oid, retURL, lead_source, ipaddress, affid)

        Dim bytes() As Byte = encoding.GetBytes(data)
        Dim httpRequest As HttpWebRequest = CType(WebRequest.Create(remoteUrl), HttpWebRequest)
        httpRequest.Method = "POST"
        httpRequest.ContentType = "application/x-www-form-urlencoded"
        httpRequest.ContentLength = bytes.Length()
        Dim stream As Stream = httpRequest.GetRequestStream
        stream.Write(bytes, 0, bytes.Length)
        stream.Close()

        'Build our email message
        Dim strFromName As String = Me.txtFirstName.Text
        Dim strFromAddress As String = Me.txtEmail.Text
        Dim strToAddress As String = ConfigurationManager.AppSettings("Email.AskUs")
        Dim strSubject As String = "Contact Us From the Scopelist.com Website"
        Dim sbBody As StringBuilder = New StringBuilder
        sbBody.Append("<p><b>First Name: </b>" & strFromName & "</p>")
        sbBody.Append("<p><b>Last Name: </b>" & lastName & "</p>")
        sbBody.Append("<p><b>Phone: </b>" & Me.txtTelephone.Text & "</p>")
        sbBody.Append("<p><b>Email: </b>" & strFromAddress & "</p>")
        sbBody.Append("<p><b>Product: </b>" & Me.ddlPurpose.SelectedItem.Value & "</p>")
        sbBody.Append("<p><b>Query: </b>" & Me.txtMessage.Text & "</p>")
        sbBody.Append("<p><b>Ip Address: </b>" & ipaddress)

        If Not affid Is Nothing Then
            sbBody.Append("<p><b>Affiliate Id: </b>" & affid & "</p>")
        End If

        Dim strOutput As String = sbBody.ToString()

        ' Send our email
        Me.SendEmail(strToAddress, strFromAddress, strFromName, strSubject, strOutput, True)

    End Sub

    ''' <summary>
    ''' Sends an email in either HTML or Text format 
    ''' </summary>
    ''' <param name="sToAddr">String: The email recipient</param>
    ''' <param name="sFromAddr">String: The senders email address</param>
    ''' <param name="sFromName">String: The senders name</param>
    ''' <param name="sSubject">String: The email subject</param>
    ''' <param name="sBody">String: The message body</param>
    ''' <param name="bHtmlFormat">Boolean: True = HTML, False = Text</param>
    Public Sub SendEmail(ByVal sToAddr As String, ByVal sFromAddr As String, _
                         ByVal sFromName As String, ByVal sSubject As String, _
                         ByVal sBody As String, ByVal bHtmlFormat As Boolean)

        Dim strMail As New MailMessage()
        strMail.From = New MailAddress(sFromAddr, sFromName)
        strMail.To.Add(sToAddr)
        strMail.Subject = sSubject
        strMail.IsBodyHtml = bHtmlFormat
        strMail.Body = sBody

        Dim objSmptClient As New SmtpClient()
        Try
            Dim configurationFile As System.Configuration.Configuration = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath)
            Dim mailSettings As MailSettingsSectionGroup = TryCast(configurationFile.GetSectionGroup("system.net/mailSettings"), MailSettingsSectionGroup)
            Dim smtpSection As SmtpSection = mailSettings.Smtp

            Dim networkCredentials As New NetworkCredential(smtpSection.Network.UserName, smtpSection.Network.Password)
            objSmptClient.Credentials = networkCredentials

            'objSmptClient.EnableSsl = False
            objSmptClient.EnableSsl = True

            objSmptClient.Send(strMail)
            msg.ShowOk("Thank you.Your message has been sent successfully")
        Catch exception1 As Exception
            msg.ShowError(exception1.ToString() & "Sending mail failed..please check your mail id and try again")
        End Try
    End Sub
End Class

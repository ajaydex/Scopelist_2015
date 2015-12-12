Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.PersonalizationServices
Imports System.Collections.ObjectModel
Imports System.Net
Imports System.IO
Imports System.Net.Mail
Imports System.Net.Configuration
Imports System.Web.Configuration


Partial Class BVModules_Controls_NewUserControl
    Inherits System.Web.UI.UserControl

    Public Event LoginCompleted(ByVal sender As Object, ByVal args As Controls.LoginCompleteEventArgs)

    Public Property LoginAfterCreate() As Boolean
        Get
            Dim val As Object = Nothing
            val = ViewState("LoginAfterCreate")
            If val Is Nothing Then
                Return False
            Else
                Return val
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("LoginAfterCreate") = value
        End Set
    End Property

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        UsernameLabel.Text = Content.SiteTerms.GetTerm("Username")
        PasswordHintLabel.Text = Content.SiteTerms.GetTerm("PasswordHint") & ":"
        PasswordAnswerLabel.Text = Content.SiteTerms.GetTerm("PasswordAnswer") & ":"
        If Not Page.IsPostBack Then
            'Me.btnSaveChanges.ImageUrl = PersonalizationServices.GetThemedButton("CreateNew")
        End If
        PasswordReminder.InnerText = "Password must be at least " & WebAppSettings.PasswordMinimumLength & " characters long."
        AddDynamicQuestions()
    End Sub

    Protected Sub AddDynamicQuestions()
        Dim questions As Collection(Of Membership.UserQuestion) = Membership.UserQuestion.FindAll()
        Dim count As Integer = 0
        For Each question As Membership.UserQuestion In questions
            count += 1
            Dim row As New HtmlTableRow()
            row.ID = "DynamicRow" & count
            If question.Type = Membership.UserQuestionType.FreeAnswer Then
                Dim questionLabel As New Label()
                questionLabel.ID = "questionLabel" & count.ToString()
                questionLabel.AssociatedControlID = "questionTextBox" & count.ToString()
                questionLabel.Text = question.Values(0).Value
                Dim questionTextBox As New TextBox()
                questionTextBox.ID = "questionTextBox" & count.ToString()
                questionTextBox.Text = ""
                questionTextBox.TabIndex = 2009 + count
                questionTextBox.Columns = 30
                questionTextBox.CssClass = "forminput"

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
                validator.ValidationGroup = "NewUser"
                validator.CssClass = "errormessage"
                validator.ForeColor = Nothing
                cell.Controls.Add(validator)
            ElseIf question.Type = Membership.UserQuestionType.MultipleChoice Then
                Dim questionLabel As New Label()
                questionLabel.ID = "questionLabel" & count.ToString()
                questionLabel.Text = question.Values(question.Values.Count - 1).Value
                questionLabel.AssociatedControlID = "questionDropDownList" & count.ToString()
                question.Values.RemoveAt(question.Values.Count - 1)
                Dim questionDropDownList As New DropDownList()
                questionDropDownList.ID = "questionDropDownList" & count.ToString()
                questionDropDownList.TabIndex = 2009 + count
                questionDropDownList.CssClass = "forminput"
                For Each questionOption As Membership.UserQuestionOption In question.Values
                    questionDropDownList.Items.Add(questionOption.Value)
                Next
                Dim cell As New HtmlTableCell()
                cell.Controls.Add(questionLabel)
                cell.Attributes.Add("class", "formlabel")
                row.Cells.Add(cell)
                cell = New HtmlTableCell()
                cell.Attributes.Add("class", "formfield")
                cell.Controls.Add(questionDropDownList)
                row.Cells.Add(cell)

                Dim validator As New Controls.BVRequiredFieldValidator()
                validator.Text = "*"
                validator.ErrorMessage = "Field is required."
                validator.ControlToValidate = "questionDropDownList" & count.ToString()
                validator.ValidationGroup = "NewUser"
                validator.CssClass = "errormessage"
                validator.ForeColor = Nothing
                cell.Controls.Add(validator)
            End If
            NewUserTable.Controls.Add(row)
        Next
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Page.IsValid Then
            Dim result As Boolean = False

            ' Check password length
            If Me.PasswordField.Text.Trim.Length < WebAppSettings.PasswordMinimumLength Then
                'Me.lblError.Visible = True
                'Me.lblError.Text = "Password must be at least " & WebAppSettings.PasswordMinimumLength & " characters long."
                Me.MessageBox1.ShowError("Password must be at least " & WebAppSettings.PasswordMinimumLength & " characters long.")
            Else

                ' PCI Validation
                If (Membership.UserAccount.IsPasswordStrong(Me.PasswordField.Text) = False) Then
                    'commented by developer on Sept 7th
                    'Me.lblError.Visible = True
                    'Me.lblError.Text = "Password must contain at least one letter and one number"
                    Me.MessageBox1.ShowError("Password must contain at least one letter and one number")
                    Return
                End If

                Dim u As Membership.UserAccount
                u = Membership.UserAccount.FindByBvin(Me.BvinField.Value)

                If u IsNot Nothing Then

                    u.Email = Me.EmailField.Text.Trim
                    u.FirstName = Me.FirstNameField.Text.Trim
                    u.LastName = Me.LastNameField.Text.Trim
                    u.PasswordAnswer = Me.PasswordAnswerField.Text.Trim
                    u.PasswordHint = Me.PasswordHintField.Text.Trim
                    u.UserName = Me.UsernameField.Text.Trim

                    Dim count As Integer = 0
                    For Each row As Control In NewUserTable.Controls
                        If row.ID IsNot Nothing Then
                            If row.ID.StartsWith("DynamicRow") Then
                                count += 1
                                Dim label As Label = CType(row.FindControl("questionLabel" & count.ToString()), Label)
                                Dim obj As Object = row.FindControl("questionTextBox" & count.ToString())
                                If obj IsNot Nothing Then
                                    u.CustomQuestionAnswers += " " & label.Text & ":" & DirectCast(obj, TextBox).Text & Environment.NewLine
                                Else
                                    obj = row.FindControl("questionDropDownList" & count.ToString())
                                    If obj IsNot Nothing Then
                                        u.CustomQuestionAnswers += " " & label.Text & ":" & DirectCast(obj, DropDownList).SelectedItem.Text & Environment.NewLine
                                    End If
                                End If
                            End If
                        End If
                    Next

                    Dim oldPasswordFormat As Membership.UserPasswordFormat = u.PasswordFormat
                    'u.PasswordFormat = CType(Me.PasswordFormatField.SelectedValue, Membership.UserPasswordFormat)
                    u.PasswordFormat = WebAppSettings.PasswordDefaultEncryption

                    Dim s As Membership.CreateUserStatus = Membership.CreateUserStatus.None

                    If Me.BvinField.Value = String.Empty Then
                        ' Insert automatically encrypts password when generating salt
                        u.Password = Me.PasswordField.Text.Trim
                        ' Create new user
                        result = Membership.UserAccount.Insert(u, s)

                        'code to send salesforce request and email
                        SendSalesForceRequest()
                    Else
                        ' Encrypt password if updating user
                        If oldPasswordFormat <> u.PasswordFormat Then
                            ' Password format has changed so alway encrypt
                            u.Password = u.EncryptPassword(Me.PasswordField.Text.Trim)
                        Else
                            If u.PasswordFormat = Membership.UserPasswordFormat.Hashed Then
                                ' Only updated hashed password if the admin changed the password, otherwise leave it alone
                                If u.Password <> Me.PasswordField.Text.Trim Then
                                    u.Password = u.EncryptPassword(Me.PasswordField.Text.Trim)
                                End If
                            Else
                                ' Clear text and encrypted passwords are alway decrypted so we can view and encrypt them again.
                                u.Password = u.EncryptPassword(Me.PasswordField.Text.Trim)
                            End If
                        End If

                        ' Update User
                        result = Membership.UserAccount.Update(u, s)
                    End If

                    If result = False Then
                        Select Case s
                            Case Membership.CreateUserStatus.DuplicateUsername
                                'commented by developer on Sept 7th
                                'Me.lblError.Visible = True
                                'Me.lblError.Text = "That username already exists. Select another username."
                                Me.MessageBox1.ShowError("That username already exists. Select another username.")
                            Case Else
                                'commented by developer on Sept 7th
                                'Me.lblError.Visible = True
                                'Me.lblError.Text = "Unable to save user. Unknown error."
                                Me.MessageBox1.ShowError("Unable to save user. Unknown error.")
                        End Select
                    Else
                        ' Update bvin field so that next save will call updated instead of create
                        Me.BvinField.Value = u.Bvin
                        If LoginAfterCreate Then
                            SessionManager.SetCurrentUserId(u.Bvin, True)
                        End If
                        Dim args As New Controls.LoginCompleteEventArgs()
                        args.UserId = u.Bvin
                        RaiseEvent LoginCompleted(Me, args)
                    End If

                End If
            End If
        End If
    End Sub

    Protected Sub SendSalesForceRequest()
        Dim remoteUrl As String = "https://www.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8"
        Dim oid As String = "00Do0000000JvrX"
        Dim retURL As String = "http://"
        Dim ipaddress As String = Request.UserHostAddress.ToString()
        Dim lead_source As String = "Scopelist.com Signin"

        Dim encoding As ASCIIEncoding = New ASCIIEncoding

        Dim data As String = String.Format("first_name={0}&last_name={1}&email={2}&oid={3}&retURL={4}&lead_source={5}&00No0000003opMp={6}", Me.FirstNameField.Text, Me.LastNameField.Text, Me.EmailField.Text, oid, retURL, lead_source, ipaddress)

        Dim bytes() As Byte = encoding.GetBytes(data)
        Dim httpRequest As HttpWebRequest = CType(WebRequest.Create(remoteUrl), HttpWebRequest)
        httpRequest.Method = "POST"
        httpRequest.ContentType = "application/x-www-form-urlencoded"
        httpRequest.ContentLength = bytes.Length()
        Dim stream As Stream = httpRequest.GetRequestStream
        stream.Write(bytes, 0, bytes.Length)
        stream.Close()

        'Build our email message
        Dim strFromName As String = Me.FirstNameField.Text
        Dim strFromAddress As String = Me.EmailField.Text
        Dim strToAddress As String = ConfigurationManager.AppSettings("Email.AskUs")
        Dim strSubject As String = "SignUp From the Scopelist.com Website"
        Dim sbBody As StringBuilder = New StringBuilder
        sbBody.Append("<p><b>First Name: </b>" & strFromName & "</p>")
        sbBody.Append("<p><b>Last Name: </b>" & Me.LastNameField.Text & "</p>")
        sbBody.Append("<p><b>Email: </b>" & strFromAddress & "</p>")
        sbBody.Append("<p><b>Ip Address: </b>" & ipaddress)
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
            'msg.ShowOk("Thank you.Your message has been sent successfully")
        Catch exception1 As Exception
            'msg.ShowError(exception1.ToString() & "Sending mail failed..please check your mail id and try again")
        End Try
    End Sub

End Class

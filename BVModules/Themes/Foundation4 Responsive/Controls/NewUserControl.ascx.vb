Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.PersonalizationServices
Imports System.Collections.ObjectModel
Imports System.Collections.Generic

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_NewUserControl
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
        UsernameLabel.Text = Content.SiteTerms.GetTerm("Username") & ""
        PasswordHintLabel.Text = Content.SiteTerms.GetTerm("PasswordHint") & ""
        PasswordAnswerLabel.Text = Content.SiteTerms.GetTerm("PasswordAnswer") & ""
        If Not Page.IsPostBack Then
            Me.btnSaveChanges.ImageUrl = PersonalizationServices.GetThemedButton("CreateNew")
        End If
        PasswordReminder.InnerText = "" & WebAppSettings.PasswordMinimumLength & "+ characters"
        AddDynamicQuestions()
    End Sub

    Protected Sub AddDynamicQuestions()
        Dim questions As Collection(Of Membership.UserQuestion) = Membership.UserQuestion.FindAll()
        Dim count As Integer = 0
        Dim row As New Panel()
        row.CssClass = "row"
        For Each question As Membership.UserQuestion In questions
            count += 1
            Dim column As New Panel()
            column.ID = "DynamicRow" & count
            column.CssClass = "large-6 columns"
            If question.Type = Membership.UserQuestionType.FreeAnswer Then
                Dim questionLabel As New Label()
                questionLabel.ID = "questionLabel" & count.ToString()
                questionLabel.AssociatedControlID = "questionTextBox" & count.ToString()
                questionLabel.Text = question.Values(0).Value

                Dim questionTextBox As New TextBox()
                questionTextBox.ID = "questionTextBox" & count.ToString()
                questionTextBox.Text = ""
                'questionTextBox.TabIndex = 2009 + count
                questionTextBox.Columns = 30
                questionTextBox.CssClass = "forminput"

                Dim validator As New Controls.BVRequiredFieldValidator()
                'validator.Text = "*"
                validator.ErrorMessage = String.Format("<i class='fa fa-exclamation-triangle'></i> {0} is required", questionLabel.Text)
                validator.ControlToValidate = "questionTextBox" & count.ToString()
                validator.ValidationGroup = "NewUser"
                validator.Display = ValidatorDisplay.Dynamic
                'validator.CssClass = "errormessage"
                
                column.Controls.Add(questionLabel)
                column.Controls.Add(validator)
                column.Controls.Add(questionTextBox)
            ElseIf question.Type = Membership.UserQuestionType.MultipleChoice Then
                Dim questionLabel As New Label()
                questionLabel.ID = "questionLabel" & count.ToString()
                questionLabel.Text = question.Values(question.Values.Count - 1).Value
                questionLabel.AssociatedControlID = "questionDropDownList" & count.ToString()
                question.Values.RemoveAt(question.Values.Count - 1)

                Dim questionDropDownList As New DropDownList()
                questionDropDownList.ID = "questionDropDownList" & count.ToString()
                'questionDropDownList.TabIndex = 2009 + count
                questionDropDownList.CssClass = "forminput"
                For Each questionOption As Membership.UserQuestionOption In question.Values
                    questionDropDownList.Items.Add(questionOption.Value)
                Next

                Dim validator As New Controls.BVRequiredFieldValidator()
                'validator.Text = "*"
                validator.ErrorMessage = String.Format("<i class='fa fa-exclamation-triangle'></i> {0} is required", questionLabel.Text)
                validator.ControlToValidate = "questionDropDownList" & count.ToString()
                validator.ValidationGroup = "NewUser"
                validator.Display = ValidatorDisplay.Dynamic
                'validator.CssClass = "errormessage"
                
                column.Controls.Add(questionLabel)
                column.Controls.Add(validator)
                column.Controls.Add(questionDropDownList)
            End If
            row.Controls.Add(column)

            If count Mod 2 = 0 OrElse count = questions.Count Then
                Me.phDynamicFields.Controls.Add(row)
                row = New Panel()
                row.CssClass = "row"
            End If
        Next
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Page.IsValid Then
            Dim result As Boolean = False

            ' Check password length
            If Me.PasswordField.Text.Trim.Length < WebAppSettings.PasswordMinimumLength Then
                Me.ucMessageBox.ShowError(String.Format("Password must be at least {0} characters long.", WebAppSettings.PasswordMinimumLength))
            Else

                ' PCI Validation
                If (Membership.UserAccount.IsPasswordStrong(Me.PasswordField.Text) = False) Then
                    Me.ucMessageBox.ShowError("Password must contain at least one letter and one number")
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

                    ' find Panel controls to interate through
                    Dim panels As New List(Of Panel)
                    BVSoftware.BVC5.Core.Controls.BVBaseControl.FindControlsByType(phDynamicFields.Controls, panels)

                    Dim count As Integer = 0
                    For Each pnl As Panel In panels
                        If Not String.IsNullOrEmpty(pnl.ID) Then
                            If pnl.ID.StartsWith("DynamicRow") Then
                                count += 1
                                Dim label As Label = CType(pnl.FindControl("questionLabel" & count.ToString()), Label)
                                Dim obj As Object = pnl.FindControl("questionTextBox" & count.ToString())
                                If obj IsNot Nothing Then
                                    u.CustomQuestionAnswers += " " & label.Text & ":" & DirectCast(obj, TextBox).Text & Environment.NewLine
                                Else
                                    obj = pnl.FindControl("questionDropDownList" & count.ToString())
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
                                Me.ucMessageBox.ShowError("That username already exists. Select another username.")
                            Case Else
                                Me.ucMessageBox.ShowError("Unable to save user. Unknown error.")
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

End Class
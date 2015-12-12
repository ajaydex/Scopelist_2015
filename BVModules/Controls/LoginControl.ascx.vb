Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.PersonalizationServices
Imports System.Net.Mail
Imports System.Web.Configuration
Imports System.Net.Configuration
Imports System.IO
Imports System.Net

Partial Class BVModules_Controls_LoginControl
    Inherits System.Web.UI.UserControl

    Public Property HideIfLoggedIn() As Boolean
        Get
            Dim obj As Object = ViewState("HideIfLoggedIn")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("HideIfLoggedIn") = value
        End Set
    End Property

    Public Property HeaderText() As String
        Get
            Dim obj As Object = ViewState("HeaderText")
            If obj IsNot Nothing Then
                Return CStr(obj)
            Else
                Return ""
            End If
        End Get
        Set(ByVal value As String)
            ViewState("HeaderText") = value
        End Set
    End Property

    Public Event LoginCompleted(ByVal sender As Object, ByVal args As Controls.LoginCompleteEventArgs)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UsernameLabel.Text = Content.SiteTerms.GetTerm("Username")
        If HideIfLoggedIn Then
            If SessionManager.IsUserAuthenticated Then
                Me.Visible = False
            Else
                Me.Visible = True
            End If
        End If

        If WebAppSettings.RememberUsers Then
            trRememberMe.Visible = True
            RememberMeCheckBox.Text = Content.SiteTerms.GetTerm("RememberUser")
        Else
            trRememberMe.Visible = False
        End If


        If Me.HeaderText.Trim = String.Empty Then
            Me.HeaderTextH2.Visible = False
        Else
            Me.HeaderTextH2.Visible = True
            'HeaderTextH2.InnerText = Me.HeaderText
            lnkSign.HRef = Page.ResolveUrl("~/login.aspx")
        End If

        If Request.RawUrl = "/checkout/checkout.aspx" Then
            Me.signupId.Visible = True
        Else
            Me.signupId.Visible = False
        End If

        If Not Page.IsPostBack Then
            'Me.btnLogin.ImageUrl = PersonalizationServices.GetThemedButton("Login")

            If Request.QueryString("ReturnURL") <> Nothing Then
                Me.RedirectToField.Value = Request.QueryString("ReturnURL")
            End If

            If Not Request.QueryString("username") Is Nothing Then
                UsernameField.Text = Request.QueryString("username")
            End If

            Me.UsernameField.Focus()

            If WebAppSettings.RememberUsers = True Then
                Dim uid As String = SessionManager.GetCookieString(WebAppSettings.UserIdCookieName)
                If uid <> String.Empty Then
                    Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(uid)
                    If u IsNot Nothing Then
                        Me.UsernameField.Text = u.UserName
                        Me.PasswordField.Focus()
                    End If
                End If
            End If

        End If
    End Sub

    Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnLogin.Click
        If Page.IsValid Then
            Dim validateResult As BVOperationResult = Membership.UserAccount.ValidateUser(Me.UsernameField.Text.Trim, Me.PasswordField.Text.Trim)
            If validateResult.Success = True Then
                Dim u As Membership.UserAccount = Membership.UserAccount.FindByUserName(Me.UsernameField.Text.Trim)
                If u IsNot Nothing Then
                    SessionManager.SetCurrentUserId(u.Bvin, RememberMeCheckBox.Checked)
                    Dim args As New Controls.LoginCompleteEventArgs()
                    args.UserId = u.Bvin

                    SendSalesForceRequest(u.FirstName, u.LastName, u.Email)
                    RaiseEvent LoginCompleted(Me, args)
                End If
            Else
                Me.MessageBox1.ShowError(validateResult.Message)
                Me.PasswordField.Focus()
            End If
        End If
    End Sub

    Protected Sub SendSalesForceRequest(ByVal firstName As String, ByVal lastName As String, ByVal email As String)
        Dim remoteUrl As String = "https://www.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8"
        Dim oid As String = "00Do0000000JvrX"
        Dim retURL As String = "http://"
        Dim ipaddress As String = Request.UserHostAddress.ToString()
        Dim lead_source As String = "Scopelist.com Login"

        Dim encoding As ASCIIEncoding = New ASCIIEncoding

        Dim data As String = String.Format("first_name={0}&last_name={1}&email={2}&oid={3}&retURL={4}&lead_source={5}&00No0000003opMp={6}", firstName, lastName, email, oid, retURL, lead_source, ipaddress)

        Dim bytes() As Byte = encoding.GetBytes(data)
        Dim httpRequest As HttpWebRequest = CType(WebRequest.Create(remoteUrl), HttpWebRequest)
        httpRequest.Method = "POST"
        httpRequest.ContentType = "application/x-www-form-urlencoded"
        httpRequest.ContentLength = bytes.Length()
        Dim stream As Stream = httpRequest.GetRequestStream
        stream.Write(bytes, 0, bytes.Length)
        stream.Close()



        'Build our email message
        Dim strFromName As String = firstName
        Dim strFromAddress As String = email
        Dim strToAddress As String = ConfigurationManager.AppSettings("Email.AskUs")
        Dim strSubject As String = "Login From the Scopelist.com Website"
        Dim sbBody As StringBuilder = New StringBuilder
        sbBody.Append("<p><b>First Name: </b>" & strFromName & "</p>")
        sbBody.Append("<p><b>Last Name: </b>" & lastName & "</p>")
        sbBody.Append("<p><b>Email: </b>" & strFromAddress & "</p>")
        sbBody.Append("<p><b>Ip Address: </b>" & ipaddress)
        Dim strOutput As String = sbBody.ToString()

    End Sub
End Class

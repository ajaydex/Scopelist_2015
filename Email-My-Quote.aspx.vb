Imports BVSoftware.Bvc5.Core
Imports System.Net.Mail
Imports System.Net
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.Security
Imports System.Net.Configuration
Imports System.Web.Configuration
Imports System.Linq

Partial Class Email_My_Quote
    Inherits BaseStorePage

    Private _LocalProduct As New Catalog.Product()

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Product.master")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Request.QueryString("id") Is Nothing Then
            If Request.QueryString("id").Length > 36 Then
                Throw New ApplicationException("Invalid product id length.")
            End If
            _LocalProduct = Catalog.InternalProduct.FindByBvin(Request.QueryString("id"))
        End If

        If Not Page.IsPostBack Then
            Me.PageTitle = "Email My Quote"
        End If

        If Not _LocalProduct Is Nothing Then
            txtCurrentPrice.Value = "$" & Math.Round(_LocalProduct.SitePrice, 2)
            txtProductName.Value = _LocalProduct.ProductName
            txtSKU.Value = _LocalProduct.Sku
            txtYourPrice.Attributes.Add("placeholder", "Your Price " & "$" & Math.Round(_LocalProduct.SitePrice, 2))

        End If

    End Sub

    Protected Sub btnContact_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnContact.Click
        'Build our email message
        Dim strFromName As String = Me.txtContactFirstName.Value & " " & Me.txtContactLastName.Value
        Dim strFromAddress As String = Me.txtContactEmail.Value
        Dim strToAddress As String = ConfigurationManager.AppSettings("Email.AskUs")
        Dim strSubject As String = "Freedom Sale Question"
        Dim sbBody As StringBuilder = New StringBuilder
        sbBody.Append("<p><b>From: </b>" & strFromName & "</p>")
        sbBody.Append("<p><b>Phone: </b>" & Me.txtTelephone.Value & "</p>")
        sbBody.Append("<p><b>Email: </b>" & strFromAddress & "</p>")
        sbBody.Append("<p><b>Address: </b>" & Me.txtAddress.Value & "</p>")
        If Not _LocalProduct Is Nothing Then
            If Not _LocalProduct.ProductName Is Nothing And _LocalProduct.ProductName <> String.Empty Then
                sbBody.Append("<p><b>Product Name: </b>" & _LocalProduct.ProductName & "</p>")
                sbBody.Append("<p><b>Product Url: </b>" & WebAppSettings.SiteStandardRoot.TrimEnd("/"c) & _LocalProduct.ProductURL & "</p>")
                sbBody.Append("<p><b>SKU: </b>" & _LocalProduct.Sku & "</p>")
                sbBody.Append("<p><b>Current Price: </b>" & "$" & Math.Round(_LocalProduct.SitePrice, 2) & "</p>")
                sbBody.Append("<p><b>Available Quantity: </b>" & Math.Round(_LocalProduct.QuantityAvailable, 0) & "</p>")
            End If
        End If
        sbBody.Append("<p><b>Your Price: </b>" & Me.txtYourPrice.Value & "</p>")
        sbBody.Append("<p><b>Ip Address: </b>" & Request.UserHostAddress.ToString() & "</p>")

        Dim strOutput As String = sbBody.ToString()



        'If Not strFromAddress <> String.Empty Then
        '    ' Send our email
        '    Me.SendEmail(strToAddress, strFromAddress, strFromName, strSubject, strOutput, True)
        'Else
        '    messagebox1.ShowError("Sending mail failed..please check your mail id and try again")
        'End If

        Me.SendEmail(strToAddress, strFromAddress, strFromName, strSubject, strOutput, True)



        ' Set our new view client side to the thank you message
        'commented by developer
        ' Me.mv1.ActiveViewIndex = 1
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
        strMail.ReplyToList.Add(sFromAddr)

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
            messagebox1.ShowOk("Your request has sent successfully..will respond your mail within 24hours")
        Catch exception1 As Exception
            messagebox1.ShowError(exception1.ToString() & "Sending mail failed..please check your mail id and try again")
        End Try
    End Sub

End Class

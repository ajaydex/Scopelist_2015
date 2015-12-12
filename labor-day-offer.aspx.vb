Imports BVSoftware.Bvc5.Core
Imports System.Net.Mail
Imports System.Net
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.Security
Imports System.Net.Configuration
Imports System.Web.Configuration
Imports System.Linq
Imports System.IO

Partial Class labor_day_offer
    Inherits BaseStorePage

    Private _LocalProduct As New Catalog.Product()

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Product.master")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim cookDict As HttpCookie = Request.Cookies("userdetails")
            If Not cookDict Is Nothing Then
                Me.first_name.Value = cookDict.Values("fname")
                Me.last_name.Value = cookDict.Values("lname")
                Me.txtTelephone.Value = cookDict.Values("phonenumber")
                Me.email.Value = cookDict.Values("email")
                Me.txtAddress.InnerText = cookDict.Values("Address")
            End If

            If Not Request.QueryString("id") Is Nothing Then
                If Request.QueryString("id").Length > 36 Then
                    Throw New ApplicationException("Invalid product id length.")
                End If
                _LocalProduct = Catalog.InternalProduct.FindByBvin(Request.QueryString("id"))

                ' Page Title
                If _LocalProduct.MetaTitle.Trim.Length > 0 Then
                    Me.PageTitle = "Email My Quote" & " - " & _LocalProduct.MetaTitle
                Else
                    Me.PageTitle = "Email My Quote" & " - " & _LocalProduct.ProductName
                End If

                ' Meta Keywords
                If _LocalProduct.MetaKeywords.Trim.Length > 0 Then
                    CType(Page, BaseStorePage).MetaKeywords = _LocalProduct.MetaKeywords
                Else
                    CType(Page, BaseStorePage).MetaKeywords = _LocalProduct.ProductName & " , " & _LocalProduct.Sku
                End If

                ' Meta Description
                If _LocalProduct.MetaDescription.Trim.Length > 0 Then
                    CType(Page, BaseStorePage).MetaDescription = _LocalProduct.MetaDescription
                End If
            End If

            'If Not Page.IsPostBack Then
            '    Me.PageTitle = "Make An Offer And Save Big"
            'End If

            If Not _LocalProduct Is Nothing Then
                txtCurrentPrice.Value = "$" & Math.Round(_LocalProduct.SitePrice, 2)
                txtProductName.Value = _LocalProduct.ProductName
                txtSKU.Value = _LocalProduct.Sku
                txtYourPrice.Attributes.Add("placeholder", "Your Price " & "$" & Math.Round(_LocalProduct.SitePrice, 2))
            End If
        End If
    End Sub

    Protected Sub btnContact_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnContact.Click

        'code to get affid from site
        Dim cook As HttpCookie = Request.Cookies("affiliateReference")
        Dim affid As String = String.Empty
        If Not cook Is Nothing Then
            affid = cook.Value
        End If

        'code to submit form values to salesforce site
        Dim remoteUrl As String = "https://www.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8"
        Dim firstName As String = Me.first_name.Value
        Dim lastName As String = Me.last_name.Value
        Dim email As String = Me.email.Value
        Dim affiliateid As String = affid
        Dim ipaddress As String = Request.UserHostAddress.ToString()
        Dim oid As String = "00Do0000000JvrX"
        Dim retURL As String = "http://www.scopelist.com/thank-you-for-your-offer.aspx"
        Dim debug As String = "0"
        Dim debugEmail As String = "sales@scopelist.net"
        'Dim debugEmail As String = "ajaycse505@gmail.com"
        Dim address As String = Me.txtAddress.Value
        Dim campaignId As String = "701o0000000EAiW"
        Dim memberstatus As String = "Received"
        Dim lead_source As String = "Web"
        Dim sku As String = ""
        Dim phonenumber As String = Me.txtTelephone.Value
        Dim productname As String = String.Empty
        Dim quotequantity As String = "0"
        Dim quoteshipping As String = Me.ddlExpeditedShipping.SelectedValue
        Dim producturl As String = String.Empty
        Dim salePrice As String = String.Empty
        Dim yourprice As String = Me.txtYourPrice.Value
        Dim cashbackchoose As String = Me.ddlCashBackChoose.SelectedValue

        Dim encoding As ASCIIEncoding = New ASCIIEncoding

        If Not Request.QueryString("id") Is Nothing Then
            If Request.QueryString("id").Length > 36 Then
                Throw New ApplicationException("Invalid product id length.")
            End If
            _LocalProduct = Catalog.InternalProduct.FindByBvin(Request.QueryString("id"))
        End If

        If Not _LocalProduct Is Nothing Then
            If Not _LocalProduct.ProductName Is Nothing And _LocalProduct.ProductName <> String.Empty Then
                salePrice = Math.Round(_LocalProduct.SitePrice, 2).ToString()
                sku = _LocalProduct.Sku
                productname = Me.txtProductName.Value
                producturl = WebAppSettings.SiteStandardRoot.TrimEnd("/"c) & _LocalProduct.ProductURL
                quotequantity = Math.Round(_LocalProduct.QuantityAvailable, 0)
            End If
        End If

        Dim data As String = String.Format("first_name={0}&last_name={1}&email={2}&00No0000003opNs={3}&00No0000003opMp={4}&00No00000039vpH={5}&oid={6}&retURL={7}&debug={8}&debugEmail={9}&Campaign_ID={10}&member_status={11}&lead_source={12}&00No0000003AtN4={13}&00No0000003AtZt={14}&00No00000039vpM={15}&phone={16}&00No0000003AtbV={17}&00No0000003pJ9C={18}&00No0000003pJ9f={19}&00No0000003pJ9k={20}&00No0000005DpEJ={21}", firstName, lastName, email, affid, ipaddress, address, oid, retURL, debug, debugEmail, campaignId, memberstatus, lead_source, salePrice, yourprice, sku, phonenumber, quotequantity, quoteshipping, producturl, productname, cashbackchoose)

        Dim bytes() As Byte = encoding.GetBytes(data)
        Dim httpRequest As HttpWebRequest = CType(WebRequest.Create(remoteUrl), HttpWebRequest)
        httpRequest.Method = "POST"
        httpRequest.ContentType = "application/x-www-form-urlencoded"
        httpRequest.ContentLength = bytes.Length()
        Dim stream As Stream = httpRequest.GetRequestStream
        stream.Write(bytes, 0, bytes.Length)
        stream.Close()

        'Build our email message
        Dim strFromName As String = Me.first_name.Value & " " & Me.last_name.Value
        Dim strFromAddress As String = Me.email.Value
        Dim strToAddress As String = ConfigurationManager.AppSettings("Email.AskUs")
        Dim strSubject As String = "Make An Offer and Save Big"

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
        sbBody.Append("<p><b>Expedited Shipping: </b>" & Me.ddlExpeditedShipping.Text & "</p>")
        sbBody.Append("<p><b>Ip Address: </b>" & Request.UserHostAddress.ToString() & "</p>")
        sbBody.Append("<p><b>Cash Back Choose: </b>" & cashbackchoose & "</p>")

        If Not affid Is Nothing Then
            sbBody.Append("<p><b>Affiliate Id: </b>" & affid & "</p>")
        End If

        Dim strOutput As String = sbBody.ToString()

        Dim cookDict As HttpCookie = Request.Cookies("userdetails")
        If cookDict Is Nothing Then
            cookDict = New HttpCookie("userdetails")
        End If
        cookDict.Values("fname") = Me.first_name.Value
        cookDict.Values("lname") = Me.last_name.Value
        cookDict.Values("phonenumber") = Me.txtTelephone.Value
        cookDict.Values("email") = Me.email.Value
        cookDict.Values("Address") = Me.txtAddress.InnerText
        cookDict.Expires.AddYears(1)
        cookDict.Path = Request.ApplicationPath
        Response.Cookies.Add(cookDict)

        Me.SendEmail(strToAddress, strFromAddress, strFromName, strSubject, strOutput, True)
        Response.Redirect("~/thank-you-for-your-offer.aspx")


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

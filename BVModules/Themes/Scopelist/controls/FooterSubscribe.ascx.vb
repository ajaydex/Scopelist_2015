Imports BVSoftware.Bvc5.Core
Imports System.Net.Mail
Imports System.Net
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.Security
Imports System.Net.Configuration
Imports System.Web.Configuration
Imports System.Linq
Imports System.IO

Partial Class BVModules_Themes_Scopelist_controls_FooterSubscribe
    Inherits System.Web.UI.UserControl


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lnkHome.Text = Content.SiteTerms.GetTerm("Home")
        lnkHome.ToolTip = Content.SiteTerms.GetTerm("Home")

        'lnkSearch.Text = Content.SiteTerms.GetTerm("Search")
        'lnkSearch.ToolTip = Content.SiteTerms.GetTerm("Search")

        'lnkSiteMap.Text = Content.SiteTerms.GetTerm("SiteMap")
        'lnkSiteMap.ToolTip = Content.SiteTerms.GetTerm("SiteMap")

        'Me.lblCopyYear.Text = DateTime.Now.Year.ToString()

        'If TypeOf Me.Page Is BaseStorePage Then
        '    If DirectCast(Me.Page, BaseStorePage).UseTabIndexes Then
        '        lnkHome.TabIndex = 10000
        '        lnkSearch.TabIndex = 10001
        '        lnkSiteMap.TabIndex = 10002
        '    End If
        'End If

        'facebookImage.Src = Page.ResolveUrl("~/BVModules/Themes/OpticAuthority/Images/social1.png")
        'twitterImage.Src = Page.ResolveUrl("~/BVModules/Themes/OpticAuthority/Images/social2.png")

        'Dim url As String = Request.Url.ToString()
        'If url.Contains("=") And url.Contains("affid") And url.Contains("ppc") Then
        '    lnkFirearms.Visible = False
        '    lnkRiflescopes.InnerText = "Riflescopes"
        'End If

    End Sub

    'Protected Sub btnJoinNow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnJoinNow.Click

    '    Try
    '        'code to get affid from site
    '        Dim cook As HttpCookie = Request.Cookies("affiliateReference")
    '        Dim affid As String = String.Empty
    '        If Not cook Is Nothing Then
    '            affid = cook.Value
    '        End If

    '        Dim remoteUrl As String = "https://www.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8"

    '        Dim email As String = Me.txtEmail.Text
    '        Dim lead_source As String = "Newsletter"
    '        Dim ipaddress As String = Request.UserHostAddress.ToString()
    '        Dim oid As String = "00Do0000000JvrX"
    '        Dim retURL As String = "http://www.scopelist.com"
    '        Dim debug As String = "1"
    '        Dim debugEmail As String = "sales@scopelist.net"
    '        Dim firstName As String = Me.txtFirstName.Text
    '        Dim lastName As String = Me.txtLastName.Text


    '        Dim encoding As ASCIIEncoding = New ASCIIEncoding

    '        Dim data As String = String.Format("first_name={0}&last_name={1}&email={2}&lead_source={3}&00No0000003opMp={4}&oid={5}&retURL={6}&debug={7}&debugEmail={8}&00No0000003opNs={9}", firstName, lastName, email, lead_source, ipaddress, oid, retURL, debug, debugEmail, affid)

    '        Dim bytes() As Byte = encoding.GetBytes(data)
    '        Dim httpRequest As HttpWebRequest = CType(WebRequest.Create(remoteUrl), HttpWebRequest)
    '        httpRequest.Method = "POST"
    '        httpRequest.ContentType = "application/x-www-form-urlencoded"
    '        httpRequest.ContentLength = bytes.Length()
    '        Dim stream As Stream = httpRequest.GetRequestStream
    '        stream.Write(bytes, 0, bytes.Length)
    '        stream.Close()

    '        msg.ShowOk("<strong>Thank you.</strong>")
    '        txtFirstName.Focus()
    '    Catch ex As Exception
    '        msg.ShowError("Error in subscription!")
    '        txtFirstName.Focus()
    '    End Try

    'End Sub

End Class

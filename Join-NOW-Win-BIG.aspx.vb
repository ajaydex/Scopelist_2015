Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.IO
Imports System.Linq
Imports BVSoftware.Bvc5.Core
Imports System.Net

Partial Class Join_NOW_Win_BIG
    Inherits BaseStorePage

    Private _AllCats As Collection(Of Catalog.Category) = Nothing
    Dim pricingWorkflow As BusinessRules.Workflow = Nothing

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Custom.master")
    End Sub

    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        Try
            'code to get affid from site
            Dim cook As HttpCookie = Request.Cookies("affiliateReference")
            Dim affid As String = String.Empty
            If Not cook Is Nothing Then
                affid = cook.Value
            End If

            Dim remoteUrl As String = "https://www.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8"

            Dim email As String = Me.txtEmailId.Text
            Dim lead_source As String = "Newsletter"
            Dim ipaddress As String = Request.UserHostAddress.ToString()
            Dim oid As String = "00Do0000000JvrX"
            Dim retURL As String = "http://www.scopelist.com"
            Dim debug As String = "1"
            Dim debugEmail As String = "sales@scopelist.net"
            Dim firstName As String = Me.txtFirstName.Text
            Dim lastName As String = Me.txtLastName.Text
            Dim campaignId As String = "701o0000000dHF0"


            Dim encoding As ASCIIEncoding = New ASCIIEncoding

            Dim data As String = String.Format("first_name={0}&last_name={1}&email={2}&lead_source={3}&00No0000003opMp={4}&oid={5}&retURL={6}&debug={7}&debugEmail={8}&00No0000003opNs={9}&Campaign_ID={10}", firstName, lastName, email, lead_source, ipaddress, oid, retURL, debug, debugEmail, affid, campaignId)

            Dim bytes() As Byte = encoding.GetBytes(data)
            Dim httpRequest As HttpWebRequest = CType(WebRequest.Create(remoteUrl), HttpWebRequest)
            httpRequest.Method = "POST"
            httpRequest.ContentType = "application/x-www-form-urlencoded"
            httpRequest.ContentLength = bytes.Length()
            Dim stream As Stream = httpRequest.GetRequestStream
            stream.Write(bytes, 0, bytes.Length)
            stream.Close()

            'msg.ShowOk("<strong>Thank you.</strong>")
            'MsgBox("Thank you.", MsgBoxStyle.OkCancel, "Joined successfully")

            'dvBanner.Attributes["class"] = "banner thanku_banner"

            dvBanner.Attributes.Add("class", "joinbanner thanku_banner")



            txtFirstName.Focus()
        Catch ex As Exception
            'msg.ShowError("Error in Joining! Please try again")
            'MsgBox("Error in Joining! Please try again", MsgBoxStyle.OkCancel, "Joining failed")
            txtFirstName.Focus()
        End Try

    End Sub
End Class

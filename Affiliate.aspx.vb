Imports BVSoftware.Bvc5.Core


Partial Class Affiliate
    Inherits BaseStorePage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Legacy Code to handle old affiliate links.
        If Request.Params(WebAppSettings.AffiliateQueryStringName) <> Nothing Then
            Try
                Dim affid As Integer
                affid = Convert.ToInt32(Request.Params(WebAppSettings.AffiliateQueryStringName))
                Dim url As String
                url = Request.Params("url")

                Dim referral As New Contacts.AffiliateReferral
                referral.AffiliateId = affid
                referral.ReferrerUrl = url
                Contacts.AffiliateReferral.Insert(referral)
            Catch ex As Exception

            End Try
        End If
        Response.Redirect("~/Default.aspx")
    End Sub
End Class

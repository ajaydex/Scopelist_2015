Imports System.Net.Mail
Imports BVSoftware.BVC5.Core

Partial Class BVAdmin_Configuration_Shipping_DHLSignup
    Inherits System.Web.UI.Page

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSubmit.Click
        If Me.IsValid Then
            Dim msg As New MailMessage()
            msg.IsBodyHtml = True
            msg.To.Add(New MailAddress("xmlrequests@dhl.com"))
            msg.From = New MailAddress(businessContactField.Text)
            msg.Subject = String.Format("XML-PI registration: {0}", companyNameField.Text)

            Dim sb As New StringBuilder()
            sb.Append("<table cellspacing=""0"" cellpadding=""4"" border=""1""")
            sb.AppendFormat("<tr><td><strong>Region</strong></td><td>{0}</td></tr>", regionField.SelectedValue)
            sb.AppendFormat("<tr><td><strong>Country Name</strong></td><td>{0}</td></tr>", Content.Country.FindByBvin(WebAppSettings.SiteCountryBvin).DisplayName)
            sb.Append("<tr><td><strong>Requested By (DHL Contact)</strong></td><td>John Riff</td></tr>")
            sb.Append("<tr><td colspan=""2""><strong>Customer Details</strong></td></tr>")
            sb.AppendFormat("<tr><td>Company Name</td><td>{0}</td></tr>", companyNameField.Text)
            sb.AppendFormat("<tr><td>Account Number(s)</td><td>{0}</td></tr>", accountNumberField.Text)
            sb.AppendFormat("<tr><td>IT Contact</td><td>{0}</td></tr>", itContactField.Text)
            sb.AppendFormat("<tr><td>Contact e-mail for future product support</td><td>{0}</td></tr>", futureContactEmailField.Text)
            sb.AppendFormat("<tr><td>Business Contact</td><td>{0}</td></tr>", businessContactField.Text)
            sb.Append("<tr><td>Services Requested</td><td>Rates</td></tr>")
            sb.Append("<tr><td>Describe the application and business process where XML PI will be used</td><td>e-commerce shopping cart platform - BV Commerce</td></tr>")
            sb.AppendFormat("<tr><td>Planned go live date</td><td>{0}</td></tr>", goLiveDatePicker.SelectedDate.ToString("MMM-yy"))
            sb.AppendFormat("<tr><td>Expected Transaction Volume (Daily, Weekly, Monthly etc.)</td><td>{0}</td></tr>", expectedTransactionVolumeField.Text)
            sb.Append("</table>")
            msg.Body = sb.ToString()

            Try
                If Utilities.MailServices.SendMail(msg) Then
                    mvSignupForm.SetActiveView(successView)
                Else
                    msgBox.ShowError("The signup process could not be completed at this time. Please try again later.")
                End If
            Catch ex As Exception
                msgBox.ShowError("The signup process could not be completed at this time. Please try again later.")
            End Try
        End If
    End Sub

    Protected Sub btnContinue_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnContinue.Click
        Response.Redirect("Shipping.aspx", True)
    End Sub

End Class

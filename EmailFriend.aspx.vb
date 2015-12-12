Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class EmailFriend
    Inherits BaseStorePage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Popup.master")
    End Sub


    Sub PageLoad(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then

            btnSend.ImageUrl = PersonalizationServices.GetThemedButton("Submit")

            inMessage.Text = "<a href=""" & Request.Params("page") & """>" & Request.Params("page") & "</a>"

            If SessionManager.IsUserAuthenticated = True Then

                Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)

                Me.FromEmailField.Text = u.Email
            End If

            Me.pnlMain.Visible = True
            Me.pnlRegister.Visible = False

            'Me.valEmail.Text = ImageHelper.GetErrorIconTag
            'Me.valEmail2.Text = ImageHelper.GetErrorIconTag
            'Me.Requiredfieldvalidator1.Text = ImageHelper.GetErrorIconTag
            'Me.Regularexpressionvalidator1.Text = ImageHelper.GetErrorIconTag
        End If
    End Sub

    Sub btnSend_OnClick(ByVal Sender As Object, ByVal E As ImageClickEventArgs) Handles btnSend.Click
        lblErrorMessage.Visible = False
        lblErrorMessage.Text = ""
        lblResults.Text = ""
        Dim f As String = String.Empty

        Dim p As Catalog.Product
        p = Catalog.InternalProduct.FindByBvin(Request.QueryString("productID"))

        Dim t As Content.EmailTemplate

        t = Content.EmailTemplate.FindByBvin(WebAppSettings.EmailTemplateID_EmailFriend)

        If t IsNot Nothing Then

            Dim m As System.Net.Mail.MailMessage
            m = t.ConvertToMailMessage(Me.FromEmailField.Text.Trim, Me.toEmailField.Text.Trim, p)

            If Utilities.MailServices.SendMail(m) = False Then
                lblErrorMessage.Text = "Error while sending mail!"
                lblErrorMessage.Visible = True
            Else
                lblResults.Text = "Thank you.  Your message has been sent."
            End If

        End If

    End Sub

End Class

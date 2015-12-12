Imports BVSoftware.Bvc5.Core.PersonalizationServices
Imports BVSoftware.Bvc5.Core
Imports System.Web.Security

Partial Class login2
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Checkout.master")
    End Sub

    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        AddHandler LoginControl1.LoginCompleted, AddressOf LoginCompleted
        AddHandler NewUserControl1.LoginCompleted, AddressOf LoginCompleted

        'Me.ManualBreadCrumbTrail1.ClearTrail()
        'Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        'Me.ManualBreadCrumbTrail1.AddNonLink(Content.SiteTerms.GetTerm("Login"))

        If Not Page.IsPostBack Then

            If WebAppSettings.IsPrivateStore Then
                'Me.pnlNewUser.Visible = False
                Me.ContactUsHyperLink.Text = Content.SiteTerms.GetTerm("PrivateStoreNewUser")
                Me.ContactUsHyperLink.Visible = True
            Else
                'Me.pnlNewUser.Visible = True
                Me.ContactUsHyperLink.Visible = False
            End If

            'TitleLabel.Text = Content.SiteTerms.GetTerm("Login")
            Page.Title = Content.SiteTerms.GetTerm("Login")

            If Request.Params("ReturnTo") <> Nothing Then
                'then we set the ReturnURL after they login
                ViewState("ReturnTo") = "Checkout"
            ElseIf Request.Params("ReturnURL") <> Nothing Then
                ViewState("ReturnURL") = Request.Params("ReturnURL")
            End If

        End If
    End Sub

    Private Sub RedirectOnComplete(ByVal userId As String)
        If (ViewState("ReturnTo") IsNot Nothing) AndAlso (userId <> String.Empty) Then
            If ViewState("ReturnTo").ToLower() = "checkout" Then
                Response.Redirect(PersonalizationServices.GetCheckoutUrl(userId))
            End If
        ElseIf (ViewState("ReturnURL") IsNot Nothing) AndAlso (userId <> String.Empty) Then
            Response.Redirect(ViewState("ReturnURL"))
        Else
            If WebAppSettings.RedirectToHomePageOnLogin = True Then
                Response.Redirect("~")
            Else
                Response.Redirect("MyAccount_Orders.aspx")
            End If
        End If
    End Sub

    Public Sub LoginCompleted(ByVal sender As Object, ByVal args As Controls.LoginCompleteEventArgs)
        RedirectOnComplete(args.UserId)
    End Sub
End Class

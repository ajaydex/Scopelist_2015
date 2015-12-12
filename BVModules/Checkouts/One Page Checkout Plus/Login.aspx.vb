Imports BVSoftware.Bvc5.Core.PersonalizationServices
Imports BVSoftware.Bvc5.Core
Imports System.Web.Security

Partial Class BVModules_Checkouts_One_Page_Checkout_Plus_Login
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Checkout.master")
        Me.Title = "Login to Checkout"
    End Sub

    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        AddHandler ucLoginControl.LoginCompleted, AddressOf LoginCompleted

        If Not Page.IsPostBack Then
            Me.btnContinue.ImageUrl = PersonalizationServices.GetThemedButton("ContinueToCheckout")

            If SessionManager.IsUserAuthenticated Then
                RedirectOnComplete(SessionManager.GetCurrentUserId)
            End If
        End If
    End Sub

    Private Sub RedirectOnComplete(ByVal userId As String)
        Response.Redirect(PersonalizationServices.GetCheckoutUrl(userId))
    End Sub

    Public Sub LoginCompleted(ByVal sender As Object, ByVal args As Controls.LoginCompleteEventArgs)
        RedirectOnComplete(args.UserId)
    End Sub

    Protected Sub ibtnContinue_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnContinue.Click
        Response.Redirect(PersonalizationServices.GetCheckoutUrl(SessionManager.GetCurrentUserId) & "?s=new")
    End Sub

End Class

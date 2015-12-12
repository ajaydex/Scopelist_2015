Imports BVSoftware.Bvc5.Core

Partial Class check_winner
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Custom.master")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Content.SiteTerms.GetTerm("Win-BIG-Winner") Is Nothing And Content.SiteTerms.GetTerm("Win-BIG-Winner") <> String.Empty Then
            '/Join-NOW-Win-BIG-Winner.aspx/?affid=bing&Win-Big-Winner=todi@dex.in
            If Not Request.Url Is Nothing And Request.Url.ToString().ToLower().Contains("win-big-winner") Then
                Dim WinnerEmail As String = Content.SiteTerms.GetTerm("Win-BIG-Winner")
                If WinnerEmail.ToLower() = Request.QueryString("win-big-winner").ToLower() Then
                    Response.Redirect("~/Win-Big-Congratulations.aspx")
                Else
                    Response.Redirect("~/Win-Big-Sorry-Try-Next-Time.aspx")
                End If
            Else
                Me.lblMessage.Text = "Something has went wrong with the URL"
                Me.lblMessage.Attributes.Add("style", "color:red;")
            End If
        End If

    End Sub

End Class

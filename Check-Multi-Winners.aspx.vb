Imports BVSoftware.Bvc5.Core

Partial Class Check_Multi_Winners
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Custom.master")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Content.SiteTerms.GetTerm("WIN-MANY-WINNERS") Is Nothing And Content.SiteTerms.GetTerm("WIN-MANY-WINNERS") <> String.Empty Then
            '/Join-NOW-Win-BIG-Winner.aspx/?affid=bing&Win-Big-Winner=todi@dex.in
            If Not Request.Url Is Nothing And Request.Url.ToString().ToLower().Contains("win-many-winners") Then

                'Dim WinnerEmails As String() = Content.SiteTerms.GetTerm("WIN-MANY-WINNERS").Split(",")
                Dim WinnerEmails As String = Content.SiteTerms.GetTerm("WIN-MANY-WINNERS")

                Dim EmailsInUrl As String() = Request.QueryString("WIN-MANY-WINNERS").Split(",")

                Dim res As Boolean

                For Each email In EmailsInUrl
                    If WinnerEmails.Contains(email) And Not email Is Nothing And Not email Is String.Empty Then
                        res = True
                        Exit For
                    End If
                Next

                If res Then
                    Response.Redirect("~/Win-Big-Congratulations.aspx")
                Else
                    Response.Redirect("~/Win-Big-Sorry-Try-Next-Time.aspx")
                End If
            Else
                Me.lblMessage.Text = "Something has went wrong with the URL"
                Me.lblMessage.Attributes.Add("style", "color:red;")
            End If
        Else
            Me.lblMessage.Text = "Something has went wrong with the URL"
            Me.lblMessage.Attributes.Add("style", "color:red;")
        End If

    End Sub

End Class

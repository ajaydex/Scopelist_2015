Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_Search
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            SetDefaultControlValues()

            If Not String.IsNullOrEmpty(Me.KeywordField.Text) Then
                Me.KeywordField.Attributes.Add("onfocus", "if(this.value == '" & Me.KeywordField.Text & "') this.value = '';")
                Me.KeywordField.Attributes.Add("onblur", "if(this.value == '') this.value = '" & Me.KeywordField.Text & "';")
            End If
        End If
    End Sub

    Private Sub SetDefaultControlValues()
        'lblTitle.Text = Content.SiteTerms.GetTerm("Search")
        'btnSearch.ImageUrl = PersonalizationServices.GetThemedButton("GoSearch")
        'btnSearch.AlternateText = "Submit Form"
    End Sub

    'Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click
    '    Response.Redirect("~/search.aspx?keyword=" & Server.UrlEncode(Me.KeywordField.Text.Trim))
    'End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSearch.Click
        Response.Redirect("~/search.aspx?keyword=" & Server.UrlEncode(Me.KeywordField.Text.Trim))
    End Sub

End Class

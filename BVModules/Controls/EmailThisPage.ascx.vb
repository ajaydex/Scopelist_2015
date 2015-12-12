Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_EmailThisPage
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If Not Page.IsPostBack Then
        '    Me.imgEmail.ImageUrl = PersonalizationServices.GetThemedButton("EmailThisPage")
        'End If

        Dim w As Integer = 400
        Dim h As Integer = 200

        Dim id As String = Request.QueryString("ProductID")
        Me.EmailLink.Style.Add("CURSOR", "pointer")
        Me.EmailLink.Attributes.Add("onclick", "JavaScript:window.open('" & Page.ResolveClientUrl("~/EmailFriend.aspx") & "?productID=" & id & "','Images','width=" & w & ", height=" & h & ", menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no')")

    End Sub
End Class


Partial Class contact
    Inherits System.Web.UI.Page

    Private Use301 As Boolean = True

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim destination As String = "ContactUs.aspx"

        If Use301 Then
            Response.Status = "301 Moved Permanently"
            Response.AddHeader("Location", destination)
        Else
            Response.Redirect(destination)
        End If

    End Sub

End Class

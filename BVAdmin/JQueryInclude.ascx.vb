Partial Class BVAdmin_JQueryInclude
    Inherits System.Web.UI.UserControl


    Protected Sub BVAdmin_JQueryInclude_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        BuildJQueryIncludes()
    End Sub

    Private Sub BuildJQueryIncludes()
        Dim sb As New StringBuilder()

        sb.Append("<script src=""//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"" type=""text/javascript""></script>")
        sb.Append(System.Environment.NewLine)
        sb.Append("<script src=""//ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"" type=""text/javascript""></script>")
        sb.Append(System.Environment.NewLine)
        sb.AppendFormat("<script src=""{0}"" type=""text/javascript""></script>", Page.ResolveClientUrl("~/Bvc.js"))
        sb.Append(System.Environment.NewLine)
        sb.AppendFormat("<script src=""{0}"" type=""text/javascript""></script>", Page.ResolveClientUrl("~/BVAdmin/BVAdmin.js"))
        sb.Append(System.Environment.NewLine)
        sb.AppendFormat("<script src=""{0}"" type=""text/javascript""></script>", Page.ResolveClientUrl("~/BVAdmin/scripts/colorbox/jquery.colorbox.js"))
        sb.AppendFormat(System.Environment.NewLine)

        Me.litJQuery.Text = sb.ToString()
    End Sub

End Class
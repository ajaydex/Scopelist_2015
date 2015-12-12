Imports BVSoftware.BVC5.Core

Partial Class BVModules_Controls_GovermentRestrictionsDisplay
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("productid") IsNot Nothing Then
            Dim info As ProductInfo = ProductInfo.FindByProduct(Request.QueryString("productid"))
            If info IsNot Nothing Then

                If info.ItarRestriction = True Then
                    Dim req As String = WebAppSettings.GetStringSetting("ITARRestriction")
                    If req <> String.Empty Then
                        Dim sb As New StringBuilder
                        sb.AppendLine("<table cellspacing=""0"" cellpadding=""0"" border=""0"" class=""r_display"">")
                        sb.AppendLine("<tr>")
                        sb.AppendLine("<td class=""r_image"">")
                        sb.AppendLine("<img src=""" & ResolveUrl("~/Images/icon_ITAR.png") & """ alt="""" />")
                        sb.AppendLine("</td>")
                        sb.AppendLine("<td class=""r_text"">")
                        sb.AppendLine(req)
                        sb.AppendLine("</td>")
                        sb.AppendLine("</tr>")
                        sb.AppendLine("</table>")
                        lItar.Text = sb.ToString
                    End If
                End If

                If info.FflRestriction = True Then
                    Dim req As String = WebAppSettings.GetStringSetting("FFLRestriction")
                    If req <> String.Empty Then
                        Dim sb As New StringBuilder
                        sb.AppendLine("<table cellspacing=""0"" cellpadding=""0"" border=""0"" class=""r_display"">")
                        sb.AppendLine("<tr>")
                        sb.AppendLine("<td class=""r_image"">")
                        sb.AppendLine("<img src=""" & ResolveUrl("~/Images/icon_FFL.png") & """ alt="""" />")
                        sb.AppendLine("</td>")
                        sb.AppendLine("<td class=""r_text"">")
                        sb.AppendLine(req)
                        sb.AppendLine("</td>")
                        sb.AppendLine("</tr>")
                        sb.AppendLine("</table>")
                        lFFl.Text = sb.ToString
                    End If
                End If

                If info.ExportRestriction = True Then
                    Dim req As String = WebAppSettings.GetStringSetting("ExportRestriction")
                    If req <> String.Empty Then
                        Dim sb As New StringBuilder
                        sb.AppendLine("<table cellspacing=""0"" cellpadding=""0"" border=""0"" class=""r_display"">")
                        sb.AppendLine("<tr>")
                        sb.AppendLine("<td class=""r_image"">")
                        sb.AppendLine("<img src=""" & ResolveUrl("~/Images/icon_export.png") & """ alt="""" />")
                        sb.AppendLine("</td>")
                        sb.AppendLine("<td class=""r_text"">")
                        sb.AppendLine(req)
                        sb.AppendLine("</td>")
                        sb.AppendLine("</tr>")
                        sb.AppendLine("</table>")
                        lExport.Text = sb.ToString
                    End If
                End If

            End If
        End If
    End Sub

End Class

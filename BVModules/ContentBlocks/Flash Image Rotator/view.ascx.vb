Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Text

Partial Class BVModules_ContentBlocks_Flash_Image_Rotator_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        DumpFlashTag()
    End Sub

    Private Sub DumpFlashTag()

        Me.PreHtml.Text = SettingsManager.GetSetting("PreHtml")
        Me.PostHtml.Text = SettingsManager.GetSetting("PostHtml")

        Dim sb As New StringBuilder

        Dim width As Integer = SettingsManager.GetIntegerSetting("Width")
        Dim height As Integer = SettingsManager.GetIntegerSetting("Height")

        Dim swfName As String = Page.ResolveClientUrl("~/BVModules/ContentBlocks/Flash Image Rotator/ImageRotator.swf")
        swfName = swfName.Replace("%20", " ")
        Dim bgcolor As String = SettingsManager.GetSetting("bgcolor")
        Dim objectName As String = "flashBlock" & Me.BlockId
        Dim containerName As String = "flashcontent" & Me.BlockId

        sb.Append(ControlChars.NewLine)
        sb.Append("<div id=""" & containerName & """ style=""width:")
        sb.Append(width.ToString)
        sb.Append("px;height:")
        sb.Append(height.ToString)
        sb.Append("px;display:block;"">")
        sb.Append(ControlChars.NewLine)

        Dim script As String = _
            "<script type=""text/javascript"">" & _
            "   //<![CDATA[" & Environment.NewLine & _
            "   var so = new SWFObject(""" & swfName & """, """ & objectName & """, ""100%"", ""100%"", ""7"", """ & bgcolor & """);" & _
            "   so.addParam(""quality"", ""high"");" & _
            "   so.addParam(""movie"", """");" & _
            "   so.addParam(""FlashVars"", """");" & _
            "   so.addParam(""loop"", ""false"");" & _
            "   so.addParam(""menu"", ""false"");" & _
            "   so.addParam(""scale"", ""exactfit"");" & _
            "   so.addParam(""salign"", ""t"");" & _
            "   so.addParam(""wmode"", ""Opaque"");" & _
            "   so.addParam(""FlashVars"", """ & GetImageParams() & """);" & _
            "   so.write(""" & containerName & """);" & _
            "   //]]" & Environment.NewLine & _
            "</script>"

        Dim jscript As String = Me.Page.ResolveUrl("~/BVModules/ContentBlocks/Flash Image Rotator/swfobject.js")
        Me.Page.ClientScript.RegisterClientScriptInclude("SWTObjectInclude", jscript)

        sb.Append("</div>")
        Me.FlashLiteral.Text = sb.ToString
        Me.FlashLiteral.Text &= script
       
    End Sub

    Private Function GetImageParams() As String

        Dim imageList As Collection(Of Content.ComponentSettingListItem) = Content.ComponentSettingListItem.FindByListName("Images", Me.BlockId)

        Dim sb As New StringBuilder
        Dim sbLinks As New StringBuilder

        If imageList IsNot Nothing Then
            ' Images
            For i As Integer = 0 To imageList.Count - 1
                Dim imageIndex As Integer = i + 1
                sb.Append("image")
                sb.Append(imageIndex.ToString)
                sb.Append("=")
                'sb.Append(Page.ResolveUrl(imageList(i).Setting1))
                sb.Append(Page.ResolveClientUrl(imageList(i).Setting1))
                sb.Append("&")
            Next

            ' Links
            For i As Integer = 0 To imageList.Count - 1
                Dim imageIndex As Integer = i + 1
                If imageList(i).Setting2.Trim.Length > 1 Then
                    sbLinks.Append("link")
                    sbLinks.Append(imageIndex.ToString)
                    sbLinks.Append("=")
                    If imageList(i).Setting2.StartsWith("~") Then
                        sbLinks.Append(Page.ResolveClientUrl(imageList(i).Setting2))
                    Else
                        sbLinks.Append(imageList(i).Setting2)
                    End If
                    sbLinks.Append("&")
                End If
            Next

            sb.Append("Totalimages=")
            sb.Append(imageList.Count)
            sb.Append("&")

            sb.Append(sbLinks.ToString)


            sb.Append("PauseInterval=")
            Dim pause As Integer = 0
            pause = Me.SettingsManager.GetIntegerSetting("Pause")
            If pause < 0 Then
                pause = 0
            End If
            sb.Append(pause)

            If Me.SettingsManager.GetBooleanSetting("OpenInNewWindow") = True Then
                sb.Append("&OpenLinksInNewWindow=true")
            Else
                sb.Append("&OpenLinksInNewWindow=false")
            End If

        End If

        Return sb.ToString
    End Function
End Class

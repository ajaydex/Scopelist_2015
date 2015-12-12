Imports BVSoftware.BVC5.Core
Imports System.Collections.ObjectModel
Imports System.Collections.Generic
Imports System.Linq

Partial Class BVModules_ContentBlocks_Image_Rotator_jQuery_adminview
    Inherits Content.BVModule

    Dim cleanId As String = String.Empty

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        cleanId = BVSoftware.Web.Text.ForceAlphaNumericOnly(Me.BlockId)

        RenderList()
    End Sub

    Private Sub RenderList()

        Dim myImages As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Images")
        If myImages IsNot Nothing Then
            If myImages.Count > 0 Then

                Dim ImageList As New List(Of Content.ComponentSettingListItem)()
                For Each c As Content.ComponentSettingListItem In myImages
                    ImageList.Add(c)
                Next

                ' Randomize order if not showing in order
                If SettingsManager.GetBooleanSetting("ShowInOrder") = False Then
                    RandomizeList(ImageList)
                End If

                RegisterScript()
                RenderHtml(ImageList)
            End If
        End If

        Me.PreHtml.Text = SettingsManager.GetSetting("PreHtml")
        Me.PostHtml.Text = SettingsManager.GetSetting("PostHtml")

        ' Make sure we have the z-index CSS rendered
        PreHtml.Text += RenderCSS()
    End Sub

    Private Sub RandomizeList(ByRef items As List(Of Content.ComponentSettingListItem))

        Dim rand As New System.Random()

        For i As Integer = items.Count - 1 To 0 Step -1
            Dim n As Integer = rand.Next(i + 1)

            ' Swap
            Dim temp As Content.ComponentSettingListItem = items.Item(i)
            items.Item(i) = items.Item(n)
            items.Item(n) = temp
        Next

    End Sub

    Private Function RenderCSS() As String
        Dim sb As New StringBuilder()

        sb.Append("<style type=""text/css"">")

        sb.Append("#rotator" + cleanId + " {")

        Dim h As Integer = SettingsManager.GetIntegerSetting("Height")
        Dim w As Integer = SettingsManager.GetIntegerSetting("Width")

        If (h > 0) Then
            sb.Append(" height:" + h.ToString() + "px;")
        End If
        If (w > 0) Then
            sb.Append(" width:" + w.ToString() + "px;")
        End If

        sb.Append(" position:relative;")
        sb.Append(" margin:0;padding:0;")
        sb.Append("}")

        sb.Append("#rotator" + cleanId + " li {")
        sb.Append("list-style:none;")
        sb.Append("float:left;")
        sb.Append("position:absolute;")
        sb.Append("margin:0;padding:0;")
        sb.Append("} ")

        sb.Append("#rotator" + cleanId + " li.show {")
        sb.Append("z-index:500;")
        sb.Append("} ")

        sb.Append("</style>")

        Return sb.ToString()
    End Function

    Private Sub RenderHtml(ByVal images As List(Of Content.ComponentSettingListItem))
        If (images.Count > 0) Then
            Dim sb As New StringBuilder
            sb.Append("<div class=""" + SettingsManager.GetSetting("cssclass") + """><ul id=""rotator" + cleanId + """>")

            Dim first As Boolean = True
            For Each c As Content.ComponentSettingListItem In images
                RenderHtmlImage(sb, c, first)
                first = False
            Next

            sb.Append("</ul></div>")

            Me.litMain.Text = sb.ToString()
        End If
    End Sub

    Private Sub RenderHtmlImage(ByRef sb As StringBuilder, ByVal data As Content.ComponentSettingListItem, ByVal isFirst As Boolean)

        Dim imageUrl As String = Page.ResolveUrl(data.Setting1)
        Dim link As String = data.Setting2

        If (isFirst) Then
            sb.Append("<li class=""show"">")
        Else
            sb.Append("<li>")
        End If

        ' Open Link
        If (link.Trim().Length > 0) Then
            sb.Append("<a href=""" + link + """ ")
            If (data.Setting3 = "1") Then
                sb.Append(" target=""_blank""")
            End If
            sb.Append(">")
        End If

        sb.Append("<img src=""" + imageUrl + """ alt=""" + data.Setting4 + """ />")

        If (link.Trim().Length > 0) Then
            sb.Append("</a>")
        End If
        sb.Append("</li>")

    End Sub

    Private Sub RegisterScript()
        Dim sb As New StringBuilder

        sb.Append("function rotate" + cleanId + "() {")
        sb.Append("var current = ($('#rotator" + cleanId + " li.show')?  $('#rotator" + cleanId + " li.show') : $('#rotator" + cleanId + " li:first'));")
        sb.Append("var next = ((current.next().length) ? ((current.next().hasClass('show')) ? $('#rotator" + cleanId + " li:first') :current.next()) : $('#rotator" + cleanId + " li:first'));")

        sb.Append("next.css({opacity: 0.0})")
        sb.Append(".addClass('show')")
        sb.Append(".animate({opacity: 1.0}, 1000);")

        sb.Append("current.animate({opacity: 0.0}, 1000)")
        sb.Append(".removeClass('show');")
        sb.Append("}")


        sb.Append("function theRotator" + cleanId + "() {")
        sb.Append("$('#rotator" + cleanId + " li').css({opacity: 0.0});")
        sb.Append("$('#rotator" + cleanId + " li:first').css({opacity: 1.0});")

        Dim p As Integer = SettingsManager.GetIntegerSetting("Pause")
        If (p < 0) Then
            p = 3
        End If

        sb.Append("setInterval(function() {rotate" + cleanId + "();}," + p.ToString() + "000);")
        sb.Append("}")


        sb.Append("$(document).ready(function() {")
        sb.Append("theRotator" + cleanId + "();")
        sb.Append("});")


        Page.ClientScript.RegisterClientScriptInclude("jQuery", "//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js")
        Page.ClientScript.RegisterStartupScript(Me.GetType, "Rotator" + cleanId, sb.ToString(), True)
        'Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "Rotator" + cleanId, sb.ToString, True)
    End Sub

End Class


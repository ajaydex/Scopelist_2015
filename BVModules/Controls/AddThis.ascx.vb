Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_AddThis
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not String.IsNullOrEmpty(WebAppSettings.AddThisCode) Then
            Me.litAddThisCode.Text = WebAppSettings.AddThisCode

            If WebAppSettings.AddThisTrackUrls AndAlso Not String.IsNullOrEmpty(WebAppSettings.AddThisProfileID) Then
                If Not Me.Page.ClientScript.IsClientScriptBlockRegistered("AddThisSettings") Then
                    Me.Page.ClientScript.RegisterClientScriptBlock(GetType(Page), "AddThisSettings", "var addthis_config = {""data_track_addressbar"":true};", True)
                End If
            End If

            If Not Me.Page.ClientScript.IsClientScriptIncludeRegistered("AddThis") Then
                Dim jsUrl As String = "//s7.addthis.com/js/300/addthis_widget.js"
                If Not String.IsNullOrEmpty(WebAppSettings.AddThisProfileID) Then
                    jsUrl += "#pubid=" + WebAppSettings.AddThisProfileID
                End If
                Me.Page.ClientScript.RegisterClientScriptInclude("AddThis", jsUrl)
            End If
        End If
    End Sub

End Class
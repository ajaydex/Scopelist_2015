Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_Sticky_Note_adminview
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.lblContent.Text = SettingsManager.GetSetting("Content")
        End If
    End Sub
End Class

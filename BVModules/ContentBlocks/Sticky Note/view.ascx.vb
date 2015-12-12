Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_Sticky_Note_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim c As String = SettingsManager.GetSetting("Color")
        If c.Trim.Length < 1 Then
            c = "Yellow"
        End If
        Dim s As String = "background-image:url('"
        s += Page.ResolveClientUrl("~/BVModules/ContentBlocks/Sticky Note/Images/" & c & ".png")
        s += "');background-position:bottom right;"
        s += "height: " & Me.SettingsManager.GetSetting("Height") & ";"
        Me.StickyNoteContainer.Attributes.Add("style", s)

        If Not Page.IsPostBack Then
            Me.lblContent.Text = SettingsManager.GetSetting("Content")
        End If

    End Sub

End Class

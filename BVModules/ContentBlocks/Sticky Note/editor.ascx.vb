Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_Sticky_Note_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            LoadData()
        End If

        Dim c As String = Me.lstColor.SelectedValue
        If c.Trim.Length < 1 Then
            c = "Yellow"
        End If

        Dim s As String = "background-image:url('"
        s += Page.ResolveClientUrl("~/BVModules/ContentBlocks/Sticky Note/Images/" & c & ".png")
        s += "');background-position:bottom right;"
        Me.StickyNoteContainer.Attributes.Add("style", s)

    End Sub

    Private Sub LoadData()
        Me.ContentField.Text = Me.SettingsManager.GetSetting("Content")
        Me.HeightField.Text = Me.SettingsManager.GetSetting("Height")
        If Me.HeightField.Text.Trim.Length < 1 Then
            Me.HeightField.Text = "150px"
        End If
        Dim c As String = Me.SettingsManager.GetSetting("Color")
        If c.Trim.Length < 1 Then
            c = "Yellow"
        End If
        If Me.lstColor.Items.FindByValue(c) IsNot Nothing Then
            Me.lstColor.ClearSelection()
            Me.lstColor.Items.FindByValue(c).Selected = True
        End If
    End Sub

    Private Sub SaveData()
        Me.SettingsManager.SaveSetting("Content", Me.ContentField.Text.Trim, "bvsoftware", "Content Block", "Sticky Note")
        Me.SettingsManager.SaveSetting("Color", Me.lstColor.SelectedValue, "bvsoftware", "Content Block", "Sticky Note")
        Me.SettingsManager.SaveSetting("Height", Me.HeightField.Text.Trim, "bvsoftware", "Content Block", "Sticky Note")
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        SaveData()
        Me.NotifyFinishedEditing()
    End Sub
End Class

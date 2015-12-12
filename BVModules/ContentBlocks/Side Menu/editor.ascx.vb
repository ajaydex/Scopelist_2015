Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_ContentBlocks_Side_Menu_editor
    Inherits Content.BVModule

    Private SettingListName As String = "Links"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadItems()
            Me.TitleField.Text = SettingsManager.GetSetting("Title")
        End If
    End Sub

    Private Sub LoadItems()
        Me.GridView1.DataSource = SettingsManager.GetSettingList(SettingListName)
        Me.GridView1.DataBind()
    End Sub

    Protected Sub btnOkay_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOkay.Click
        SettingsManager.SaveSetting("Title", Me.TitleField.Text.Trim, "bvsoftware", "Content Block", "Side Menu")
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Dim c As New Content.ComponentSettingListItem

        If Me.EditBvinField.Value <> String.Empty Then
            'Updating
            c = SettingsManager.FindSettingListItem(EditBvinField.Value)
            c.Setting1 = Me.LinkTextField.Text.Trim
            c.Setting2 = Me.LinkField.Text.Trim
            If Me.OpenInNewWindowField.Checked = True Then
                c.Setting3 = "1"
            Else
                c.Setting3 = "0"
            End If
            c.Setting4 = Me.AltTextField.Text.Trim
            SettingsManager.UpdateSettingListItem(c, "bvsoftware", "Content Block", "Side Menu")
            ClearEditor()
        Else
            'Inserting
            c.Setting1 = Me.LinkTextField.Text.Trim
            c.Setting2 = Me.LinkField.Text.Trim
            If Me.OpenInNewWindowField.Checked = True Then
                c.Setting3 = "1"
            Else
                c.Setting3 = "0"
            End If
            c.Setting4 = Me.AltTextField.Text.Trim
            SettingsManager.InsertSettingListItem(SettingListName, c, "bvsoftware", "Content Block", "Side Menu")
        End If
        LoadItems()
    End Sub

    Sub ClearEditor()
        Me.EditBvinField.Value = String.Empty
        Me.LinkTextField.Text = String.Empty
        Me.LinkField.Text = String.Empty
        Me.OpenInNewWindowField.Checked = False
        Me.AltTextField.Text = String.Empty
        Me.btnNew.ImageUrl = "~/BVAdmin/Images/Buttons/New.png"
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        SettingsManager.MoveSettingListItemDown(bvin, SettingListName)
        LoadItems()
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim bvin As String = CType(Me.GridView1.DataKeys(e.RowIndex).Value, String)
        SettingsManager.DeleteSettingListItem(bvin)
        LoadItems()
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Dim c As Content.ComponentSettingListItem
        c = MyBase.SettingsManager.FindSettingListItem(bvin)
        If c.Bvin <> String.Empty Then
            Me.EditBvinField.Value = c.Bvin
            Me.LinkField.Text = c.Setting2
            Me.LinkTextField.Text = c.Setting1
            If c.Setting3 = "1" Then
                Me.OpenInNewWindowField.Checked = True
            Else
                Me.OpenInNewWindowField.Checked = False
            End If
            Me.AltTextField.Text = c.Setting4
            Me.btnNew.ImageUrl = "~/BVAdmin/Images/Buttons/SaveChanges.png"
        End If
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        SettingsManager.MoveSettingListItemUp(bvin, SettingListName)
        LoadItems()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        ClearEditor()
    End Sub

End Class

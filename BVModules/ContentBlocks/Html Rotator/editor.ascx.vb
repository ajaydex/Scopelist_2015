Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_Html_Rotator_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadItems()
            Me.chkShowInOrder.Checked = SettingsManager.GetBooleanSetting("ShowInOrder")
        End If
    End Sub

    Private Sub LoadItems()
        Me.GridView1.DataSource = SettingsManager.GetSettingList("Html")
        Me.GridView1.DataBind()
    End Sub

    Protected Sub btnOkay_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOkay.Click
        SettingsManager.SaveBooleanSetting("ShowInOrder", Me.chkShowInOrder.Checked, "bvsoftware", "Content Block", "HTML Rotator")
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Dim c As New Content.ComponentSettingListItem

        If Me.EditBvinField.Value <> String.Empty Then
            'Updating
            c = SettingsManager.FindSettingListItem(EditBvinField.Value)
            c.Setting1 = Me.HtmlField.Text.Trim
            SettingsManager.UpdateSettingListItem(c, "bvsoftware", "Content Block", "HTML Rotator")
            ClearEditor()
        Else
            'Inserting
            c.Setting1 = Me.HtmlField.Text.Trim
            SettingsManager.InsertSettingListItem("Html", c, "bvsoftware", "Content Block", "HTML Rotator")
        End If
        LoadItems()
    End Sub

    Sub ClearEditor()
        Me.HtmlField.Text = String.Empty
        Me.EditBvinField.Value = String.Empty
        Me.btnNew.ImageUrl = "~/BVAdmin/Images/Buttons/New.png"
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        SettingsManager.MoveSettingListItemDown(bvin, "Html")
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
            Me.HtmlField.Text = c.Setting1
            Me.btnNew.ImageUrl = "~/BVAdmin/Images/Buttons/SaveChanges.png"
        End If
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        SettingsManager.MoveSettingListItemUp(bvin, "Html")
        LoadItems()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        ClearEditor()
    End Sub

End Class

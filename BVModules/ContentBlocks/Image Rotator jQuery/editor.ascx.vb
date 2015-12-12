Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core
Imports System.IO

Partial Class BVModules_ContentBlocks_Image_Rotator_jQuery_editor
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.RegisterWindowScripts()

        If Not Page.IsPostBack Then
            LoadItems()
            Me.chkShowInOrder.Checked = SettingsManager.GetBooleanSetting("ShowInOrder")
            Me.PreHtmlField.Text = SettingsManager.GetSetting("PreHtml")
            Me.PostHtmlField.Text = SettingsManager.GetSetting("PostHtml")
            Me.cssclass.Text = SettingsManager.GetSetting("cssclass")


            Me.WidthField.Text = SettingsManager.GetIntegerSetting("Width")
            If (Me.WidthField.Text.Trim = String.Empty) OrElse (Me.WidthField.Text = "0") Then
                Me.WidthField.Text = WebAppSettings.ImagesSmallWidth.ToString
            End If

            Me.HeighField.Text = SettingsManager.GetIntegerSetting("Height")
            If (Me.HeighField.Text.Trim = String.Empty) OrElse (Me.HeighField.Text = "0") Then
                Me.HeighField.Text = WebAppSettings.ImagesSmallHeight.ToString
            End If

            Dim seconds As Integer = Me.SettingsManager.GetIntegerSetting("Pause")
            If seconds < 0 Then
                seconds = 3
            End If
            Me.PauseField.Text = seconds.ToString


        End If
    End Sub

    Private Sub LoadItems()
        Me.GridView1.DataSource = SettingsManager.GetSettingList("Images")
        Me.GridView1.DataBind()
    End Sub

    Protected Sub btnOkay_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOkay.Click
        SettingsManager.SaveSetting("PreHtml", Me.PreHtmlField.Text.Trim, "bvsoftware", "Content Block", "Image Rotator jQuery")
        SettingsManager.SaveSetting("PostHtml", Me.PostHtmlField.Text.Trim, "bvsoftware", "Content Block", "Image Rotator jQuery")
        SettingsManager.SaveBooleanSetting("ShowInOrder", Me.chkShowInOrder.Checked, "bvsoftware", "Content Block", "Image Rotator jQuery")
        SettingsManager.SaveSetting("cssclass", Me.cssclass.Text.Trim(), "bvsoftware", "Content Block", "Image Rotator jQuery")

        Dim width As Integer = 0
        Integer.TryParse(Me.WidthField.Text.Trim, width)
        SettingsManager.SaveIntegerSetting("Width", width, "bvsoftware", "Content Block", "Image Rotator jQuery")
        Dim height As Integer = 0
        Integer.TryParse(Me.HeighField.Text.Trim, height)
        SettingsManager.SaveIntegerSetting("Height", height, "bvsoftware", "Content Block", "Image Rotator jQuery")
        Dim pause As Integer = 0
        Integer.TryParse(Me.PauseField.Text, pause)
        SettingsManager.SaveIntegerSetting("Pause", pause, "bvsoftware", "Content Block", "Image Rotator jQuery")

        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Dim c As New Content.ComponentSettingListItem

        If Me.EditBvinField.Value <> String.Empty Then
            'Updating
            c = SettingsManager.FindSettingListItem(EditBvinField.Value)
            c.Setting1 = Me.ImageUrlField.Text.Trim
            c.Setting2 = Me.ImageLinkField.Text.Trim
            If Me.chkOpenInNewWindow.Checked = True Then
                c.Setting3 = "1"
            Else
                c.Setting3 = "0"
            End If
            c.Setting4 = Me.AltTextField.Text.Trim
            SettingsManager.UpdateSettingListItem(c, "bvsoftware", "Content Block", "Image Rotator jQuery")
            ClearEditor()
        Else
            'Inserting
            c.Setting1 = Me.ImageUrlField.Text.Trim
            c.Setting2 = Me.ImageLinkField.Text.Trim
            If Me.chkOpenInNewWindow.Checked = True Then
                c.Setting3 = "1"
            Else
                c.Setting3 = "0"
            End If
            c.Setting4 = Me.AltTextField.Text.Trim
            SettingsManager.InsertSettingListItem("Images", c, "bvsoftware", "Content Block", "Image Rotator jQuery")
        End If
        LoadItems()
    End Sub

    Sub ClearEditor()
        Me.EditBvinField.Value = String.Empty
        Me.ImageUrlField.Text = String.Empty
        Me.ImageLinkField.Text = String.Empty
        Me.chkOpenInNewWindow.Checked = False
        Me.AltTextField.Text = String.Empty
        Me.btnNew.ImageUrl = "~/BVAdmin/Images/Buttons/New.png"
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        SettingsManager.MoveSettingListItemDown(bvin, "Images")
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
            Me.ImageLinkField.Text = c.Setting2
            Me.ImageUrlField.Text = c.Setting1
            If c.Setting3 = "1" Then
                Me.chkOpenInNewWindow.Checked = True
            Else
                Me.chkOpenInNewWindow.Checked = False
            End If
            Me.AltTextField.Text = c.Setting4
            Me.btnNew.ImageUrl = "~/BVAdmin/Images/Buttons/SaveChanges.png"
        End If
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        SettingsManager.MoveSettingListItemUp(bvin, "Images")
        LoadItems()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        ClearEditor()
    End Sub

    Private Sub RegisterWindowScripts()

        Dim sb As New StringBuilder

        sb.Append("var w;")
        sb.Append("function popUpWindow(parameters) {")
        sb.Append("w = window.open('../ImageBrowser.aspx' + parameters, null, 'height=505, width=950');")
        sb.Append("}")

        sb.Append("function closePopup() {")
        sb.Append("w.close();")
        sb.Append("}")

        sb.Append("function SetImage(fileName) {")
        sb.Append("document.getElementById('")
        sb.Append(Me.ImageUrlField.ClientID)
        sb.Append("').value = '~/' + fileName;")
        sb.Append("w.close();")
        sb.Append("}")

        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "WindowScripts", sb.ToString, True)

    End Sub


End Class

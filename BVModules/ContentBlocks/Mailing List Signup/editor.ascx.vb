Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_Mailing_List_Signup_editor
    Inherits Content.BVModule


    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Private Sub LoadData()        
        Me.TitleField.Text = SettingsManager.GetSetting("Title")
        If Me.TitleField.Text = String.Empty Then
            Me.TitleField.Text = "Mailing List"
        End If
        Me.InstructionsField.Text = SettingsManager.GetSetting("Instructions")
        If Me.InstructionsField.Text = String.Empty Then
            Me.InstructionsField.Text = "Please enter your email address"
        End If
        Me.ErrorMessageField.Text = SettingsManager.GetSetting("ErrorMessage")
        If Me.ErrorMessageField.Text = String.Empty Then
            Me.ErrorMessageField.Text = "Please enter a valid email address"
        End If
        Me.SuccessMessageField.Text = SettingsManager.GetSetting("SuccessMessage")
        If Me.SuccessMessageField.Text = String.Empty Then
            Me.SuccessMessageField.Text = "Thank You!"
        End If
        Me.lstMailingLists.DataSource = Contacts.MailingList.FindAllPublic
        Me.lstMailingLists.DataTextField = "Name"
        Me.lstMailingLists.DataValueField = "Bvin"
        Me.lstMailingLists.DataBind()

        Dim listSetting As String = SettingsManager.GetSetting("MailingListId")
        If listSetting.Trim <> String.Empty Then
            If lstMailingLists.Items.FindByValue(listSetting) IsNot Nothing Then
                Me.lstMailingLists.Items.FindByValue(listSetting).Selected = True
            End If
        End If
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Title", Me.TitleField.Text.Trim, "bvsoftware", "Content Block", "Mailing List Signup")
        SettingsManager.SaveSetting("Instructions", Me.InstructionsField.Text.Trim, "bvsoftware", "Content Block", "Mailing List Signup")
        SettingsManager.SaveSetting("ErrorMessage", Me.ErrorMessageField.Text.Trim, "bvsoftware", "Content Block", "Mailing List Signup")
        SettingsManager.SaveSetting("SuccessMessage", Me.SuccessMessageField.Text.Trim, "bvsoftware", "Content Block", "Mailing List Signup")
        If Me.lstMailingLists.SelectedValue IsNot Nothing Then
            SettingsManager.SaveSetting("MailingListId", Me.lstMailingLists.SelectedValue, "bvsoftware", "Content Block", "Mailing List Signup")
        End If
    End Sub

End Class

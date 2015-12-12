Imports BVSoftware.Bvc5.Core

Partial Class BVModules_OrderTasks_Email_Shipping_Info_edit
    Inherits Content.BVModule

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        MyBase.NotifyFinishedEditing()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            PopulateLists()
            LoadData()
        End If
    End Sub

    Private Sub PopulateLists()
        Me.EmailTemplateField.DataSource = Content.EmailTemplate.FindAll
        Me.EmailTemplateField.DataTextField = "DisplayName"
        Me.EmailTemplateField.DataValueField = "bvin"
        Me.EmailTemplateField.DataBind()
    End Sub

    Private Sub LoadData()
        Me.StepNameField.Text = Me.SettingsManager.GetSetting("StepName")
        Dim template As String = Me.SettingsManager.GetSetting("EmailTemplate")
        Me.CustomToField.Text = Me.SettingsManager.GetSetting("CustomEmail")
        Dim toemail As String = Me.SettingsManager.GetSetting("ToEmail")

        If EmailTemplateField.Items.FindByValue(template) IsNot Nothing Then
            Me.EmailTemplateField.ClearSelection()
            Me.EmailTemplateField.Items.FindByValue(template).Selected = True
        Else
            If Me.EmailTemplateField.Items.FindByValue("0e1331d9-c323-464a-937e-41f749aa9fab") IsNot Nothing Then
                Me.EmailTemplateField.ClearSelection()
                Me.EmailTemplateField.Items.FindByValue("0e1331d9-c323-464a-937e-41f749aa9fab").Selected = True
            End If            
        End If

        If EmailToField.Items.FindByValue(toemail) IsNot Nothing Then
            Me.EmailToField.ClearSelection()
            Me.EmailToField.Items.FindByValue(toemail).Selected = True
        End If

    End Sub

    Private Sub SaveData()
        Me.SettingsManager.SaveSetting("StepName", Me.StepNameField.Text.Trim, "bvsoftware", "Order Tasks", "Email Shipping Info")
        Me.SettingsManager.SaveSetting("EmailTemplate", Me.EmailTemplateField.SelectedValue, "bvsoftware", "Order Tasks", "Email Shipping Info")
        Me.SettingsManager.SaveSetting("CustomEmail", Me.CustomToField.Text.Trim, "bvsoftware", "Order Tasks", "Email Shipping Info")
        Me.SettingsManager.SaveSetting("ToEmail", Me.EmailToField.SelectedValue, "bvsoftware", "Order Tasks", "Email Shipping Info")
    End Sub

    Protected Sub EmailToField_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles EmailToField.SelectedIndexChanged
        If Me.EmailToField.SelectedValue IsNot Nothing Then
            If Me.EmailToField.SelectedValue = "Custom" Then
                Me.CustomToField.Visible = True
            Else
                Me.CustomToField.Visible = False
            End If
        End If
    End Sub

End Class

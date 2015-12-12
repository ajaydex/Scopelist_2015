Imports BVSoftware.Bvc5.Core

Partial Class BVModules_OrderTasks_Apply_Minimum_Order_Amount_edit
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
            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        Me.StepNameField.Text = Me.SettingsManager.GetSetting("StepName")        

        MinimumOrderAmountTextBox.Text = Me.SettingsManager.GetDecimalSetting("MinimumOrderAmount").ToString("c")

        Dim errorMessage As String = Me.SettingsManager.GetSetting("CustomerErrorMessage")
        If errorMessage = String.Empty Then
            errorMessage = "Minimum Order Amount Was Not Exceeded."
        End If
        Me.ErrorMessageTextBox.Text = errorMessage        
    End Sub

    Private Sub SaveData()
        Me.SettingsManager.SaveSetting("StepName", Me.StepNameField.Text.Trim, "bvsoftware", "Order Tasks", "Apply Minimum Order Amount")
        Me.SettingsManager.SaveDecimalSetting("MinimumOrderAmount", Decimal.Parse(Me.MinimumOrderAmountTextBox.Text, System.Globalization.NumberStyles.Currency), "bvsoftware", "Order Tasks", "Apply Minimum Order Amount")
        Me.SettingsManager.SaveSetting("CustomerErrorMessage", Me.ErrorMessageTextBox.Text.Trim, "bvsoftware", "Order Tasks", "Apply Minimum Order Amount")
    End Sub

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        If Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, Threading.Thread.CurrentThread.CurrentUICulture, Nothing) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub
End Class

Imports BVSoftware.Bvc5.Core

Partial Class BVModules_PaymentMethods_COD_edit
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
        Me.NameField.Text = WebAppSettings.PaymentCODName
        Me.DescriptionField.Text = WebAppSettings.PaymentCODDescription
    End Sub

    Private Sub SaveData()
        WebAppSettings.PaymentCODName = Me.NameField.Text.Trim
        WebAppSettings.PaymentCODDescription = Me.DescriptionField.Text.Trim
    End Sub


End Class

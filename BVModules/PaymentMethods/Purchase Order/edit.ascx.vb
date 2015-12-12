Imports BVSoftware.Bvc5.Core

Partial Class BVModules_PaymentMethods_Purchase_Order_edit
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
        Me.NameField.Text = WebAppSettings.PaymentPurchaseOrderName
        Me.DescriptionField.Text = WebAppSettings.PaymentPurchaseOrderDescription
    End Sub

    Private Sub SaveData()
        WebAppSettings.PaymentPurchaseOrderName = Me.NameField.Text.Trim
        WebAppSettings.PaymentPurchaseOrderDescription = Me.DescriptionField.Text.Trim
    End Sub

End Class

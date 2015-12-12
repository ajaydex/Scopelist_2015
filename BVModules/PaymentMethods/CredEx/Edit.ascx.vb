Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports BVSoftware.CredEx

Partial Class BVModules_PaymentMethods_CredEx_Edit
    Inherits Content.BVModule

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Page.IsValid Then
            SaveData()
            Me.NotifyFinishedEditing()
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        Me.MerchantIdField.Text = WebAppSettings.CredExMerchantId
        Me.MerchantKeyField.Text = WebAppSettings.CredExMerchantKey
        Me.ProductIdField.Text = WebAppSettings.CredExProductId
        Me.DiagnosticsModeField.Checked = WebAppSettings.CredExDiagnosticsMode
        Me.TestModeField.Checked = WebAppSettings.CredExTestMode       
    End Sub

    Private Sub SaveData()
        WebAppSettings.CredExMerchantId = Me.MerchantIdField.Text.Trim()
        WebAppSettings.CredExMerchantKey = Me.MerchantKeyField.Text.Trim()
        WebAppSettings.CredExProductId = Me.ProductIdField.Text.Trim()
        WebAppSettings.CredExDiagnosticsMode = Me.DiagnosticsModeField.Checked
        WebAppSettings.CredExTestMode = Me.TestModeField.Checked
    End Sub

   
    Protected Sub btnSendTest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendTest.Click
        Me.lblMessage.Text = String.Empty

        Dim criteria As New Orders.OrderSearchCriteria()
        criteria.IsPlaced = True
        criteria.OrderNumber = Me.OrderNumberField.Text.Trim()

        Dim possible As Collection(Of Orders.Order) = Orders.Order.FindByCriteria(criteria)
        If (possible.Count < 1) Then
            Me.lblMessage.Text = "Could not locate that order number. Try again."
            Return
        Else
            Dim o As Orders.Order = possible(0)

            Dim samplePost As New CreditPostBackData()
            samplePost.MerchantRefernceNumber = o.Bvin

            If (Me.lstResponse.SelectedItem.Value = "Y") Then
                samplePost.PopulateSampleSuccess()
            Else
                samplePost.PopulateSampleDecline()
            End If

            Dim destination As String = WebAppSettings.SiteStandardRoot & "CredExPostBack.aspx?id=" & System.Web.HttpUtility.UrlEncode(o.Bvin)

            Dim res As String = Utilities.WebForms.SendRequestByPost(destination, samplePost.ToXml)

            Me.lblMessage.Text = "Sent Post Back Data. <a href=""" + Page.ResolveUrl("~/bvadmin/Orders/ReceivePayments.aspx?id=" + System.Web.HttpUtility.UrlEncode(o.Bvin)) & """>Check Order</a> for Details"

        End If
    End Sub

End Class

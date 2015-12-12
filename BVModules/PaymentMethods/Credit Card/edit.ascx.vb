Imports BVSoftware.Bvc5.Core

Partial Class BVModules_PaymentMethods_Credit_Card_edit
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
            PopulateGatewaylist()
            LoadData()
        End If
    End Sub

    Private Sub PopulateGatewaylist()
        Me.lstGateway.DataSource = Payment.AvailableGateways.Gateways
        Me.lstGateway.DataValueField = "GatewayId"
        Me.lstGateway.DataTextField = "GatewayFriendlyName"
        Me.lstGateway.DataBind()
    End Sub

    Private Sub LoadData()
        Me.lstCaptureMode.ClearSelection()
        If WebAppSettings.PaymentCreditCardAuthorizeOnly = True Then
            Me.lstCaptureMode.SelectedValue = "1"
        Else
            Me.lstCaptureMode.SelectedValue = "0"
        End If

        Me.chkRequireCreditCardSecurityCode.Checked = WebAppSettings.PaymentCreditCardRequireCVV
        Me.DisplayFullCreditCardCheckBox.Checked = WebAppSettings.DisplayFullCreditCardNumber

        Me.lstGateway.ClearSelection()
        Me.lstGateway.SelectedValue = WebAppSettings.PaymentCreditCardGateway

        Me.CreditCardGrid.DataSource = Payment.CreditCardType.FindAll
        Me.CreditCardGrid.DataBind()
    End Sub

    Private Sub SaveData()
        If Me.lstCaptureMode.SelectedValue = "1" Then
            WebAppSettings.PaymentCreditCardAuthorizeOnly = True
        Else
            WebAppSettings.PaymentCreditCardAuthorizeOnly = False
        End If
        WebAppSettings.PaymentCreditCardRequireCVV = Me.chkRequireCreditCardSecurityCode.Checked
        WebAppSettings.PaymentCreditCardGateway = Me.lstGateway.SelectedValue

        WebAppSettings.DisplayFullCreditCardNumber = Me.DisplayFullCreditCardCheckBox.Checked

        For Each r As GridViewRow In CreditCardGrid.Rows
            If r.RowType = DataControlRowType.DataRow Then
                Dim bvin As String = CStr(CreditCardGrid.DataKeys(r.RowIndex).Value)
                Dim ct As Payment.CreditCardType = Payment.CreditCardType.FindByCode(bvin)
                If ct IsNot Nothing Then
                    Dim chkActive As CheckBox = r.FindControl("chkActive")
                    ct.Active = chkActive.Checked
                    Payment.CreditCardType.Update(ct)
                End If
            End If
        Next
    End Sub

    Protected Sub btnOptions_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOptions.Click
        SaveData()
        Response.Redirect("Payment_Edit_Gateway.aspx?id=" & Me.lstGateway.SelectedValue & "&payid=" & Me.BlockId)
    End Sub

    Protected Sub CreditCardGrid_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles CreditCardGrid.RowDataBound
        Dim ct As Payment.CreditCardType = CType(e.Row.DataItem, Payment.CreditCardType)
        If ct IsNot Nothing Then
            Dim chkActive As CheckBox = e.Row.FindControl("chkActive")
            chkActive.Checked = ct.Active
        End If
    End Sub
End Class

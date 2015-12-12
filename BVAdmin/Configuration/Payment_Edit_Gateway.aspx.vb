Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Payment_Edit_Gateway
    Inherits BaseAdminPage

    Private g As Payment.CreditCardGateway
    Private WithEvents editor As Content.BVModule

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Payment Gateway Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Request.QueryString("id") IsNot Nothing Then
            Me.GatewayIdField.Value = Request.QueryString("id")
        End If
        If Request.QueryString("payid") IsNot Nothing Then
            Me.MethodIdField.Value = Request.QueryString("payid")
        End If
        If Payment.AvailableGateways.CurrentGateway.GatewayId = Me.GatewayIdField.Value Then
            g = Payment.AvailableGateways.CurrentGateway
        Else
            For i As Integer = 0 To Payment.AvailableGateways.Gateways.Count - 1
                If String.Compare(Payment.AvailableGateways.Gateways(i).GatewayId, Me.GatewayIdField.Value, True) = 0 Then
                    g = Payment.AvailableGateways.Gateways(i)
                End If
            Next
        End If
        
        LoadEditor()
    End Sub

    Private Sub LoadEditor()
        Dim tempControl As System.Web.UI.Control = Content.ModuleController.LoadCreditCardGatewayEditor(g.GatewayName, Me)

        If TypeOf tempControl Is Content.BVModule Then
            editor = CType(tempControl, Content.BVModule)
            If Not editor Is Nothing Then
                editor.BlockId = g.GatewayId
                Me.phEditor.Controls.Add(editor)
            End If
        Else
            Me.phEditor.Controls.Add(New LiteralControl("Error, editor is not based on Content.BVModule class"))
        End If
    End Sub

    Protected Sub editor_EditingComplete(ByVal sender As Object, ByVal e As BVSoftware.BVC5.Core.Content.BVModuleEventArgs) Handles editor.EditingComplete
        AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Payment, _
                           BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Information, _
                            "Gateway Settings Viewed/Edited", "Credit Card Gateway Settings for " & g.GatewayFriendlyName & " were viewed or edited.")
        Response.Redirect("Payment_Edit.aspx?id=" & Me.MethodIdField.Value)
    End Sub


End Class

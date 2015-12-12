Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Payment_Edit
    Inherits BaseAdminPage

    Private m As Payment.PaymentMethod
    Private WithEvents editor As Content.BVModule

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit        
        Me.PageTitle = "Payment Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Request.QueryString("id") IsNot Nothing Then
            Me.MethodIdField.Value = Request.QueryString("id")
        End If
        For i As Integer = 0 To Payment.AvailablePayments.Methods.Count - 1
            If String.Compare(Payment.AvailablePayments.Methods(i).MethodId, Me.MethodIdField.Value, True) = 0 Then
                m = Payment.AvailablePayments.Methods(i)
            End If
        Next
        LoadEditor()
    End Sub

    Private Sub LoadEditor()
        Dim tempControl As System.Web.UI.Control = Content.ModuleController.LoadPaymentMethodEditor(m.MethodName, Me)

        If TypeOf tempControl Is Content.BVModule Then
            editor = CType(tempControl, Content.BVModule)
            If Not editor Is Nothing Then
                editor.BlockId = m.MethodId
                Me.phEditor.Controls.Add(editor)
            End If
        Else
            Me.phEditor.Controls.Add(New LiteralControl("Error, editor is not based on Content.BVModule class"))
        End If
    End Sub

    Protected Sub editor_EditingComplete(ByVal sender As Object, ByVal e As BVSoftware.BVC5.Core.Content.BVModuleEventArgs) Handles editor.EditingComplete
        AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Payment, _
                           BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Information, _
                            "Payment Settings Viewed or Edited", "Payment settings for " & m.MethodName & " were viewed or edited.")
        Response.Redirect("Payment.aspx")
    End Sub

End Class

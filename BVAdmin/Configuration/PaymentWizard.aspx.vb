Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVAdmin_Configuration_PaymentWizard    
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Payment Setup Wizard"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub lnkWithPayPal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkWithPayPal.Click
        Me.multiview1.SetActiveView(Me.step2)
    End Sub

    Protected Sub lnkNoPayPal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNoPayPal.Click
        Me.multiview1.SetActiveView(Me.step2b)
    End Sub

    Protected Sub lnkBackFrom2a_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBackFrom2a.Click
        Me.multiview1.SetActiveView(Me.step1)
    End Sub

    Protected Sub lnkBackFrom2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBackFrom2.Click
        Me.multiview1.SetActiveView(Me.step1)        
    End Sub

    Protected Sub lnkBackFrom3b_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBackFrom3b.Click
        Me.multiview1.SetActiveView(Me.step2b)
    End Sub

    Protected Sub lnkBackFrom3a_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBackFrom3a.Click
        Me.multiview1.SetActiveView(Me.step2)
    End Sub

    Protected Sub btnPayPalStandard_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPayPalStandard.Click
        Me.multiview1.SetActiveView(Me.step3a)
    End Sub

    Protected Sub btnPayPayPro_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPayPayPro.Click
        Me.multiview1.SetActiveView(Me.step3a)
    End Sub

    Protected Sub btnSaveGateway_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveGateway.Click
        Me.multiview1.SetActiveView(Me.step3b)
    End Sub

    Protected Sub btnPayPalConfig_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPayPalConfig.Click
        Me.multiview1.SetActiveView(step4)
    End Sub

    Protected Sub btnCCConfig_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCCConfig.Click
        Me.multiview1.SetActiveView(step4)
    End Sub
End Class

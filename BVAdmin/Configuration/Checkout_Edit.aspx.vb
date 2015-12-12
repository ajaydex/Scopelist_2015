Imports BVSoftware.Bvc5.Core
'Imports System.Collections.ObjectModel

Partial Class BVAdmin_Configuration_Checkout_Edit
    Inherits BaseAdminPage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Checkout Edit"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim checkout As String = Request.QueryString("checkout")
            If String.IsNullOrEmpty(checkout) Then
                Response.Redirect("Orders.aspx")
            Else
                Me.CheckoutIdField.Value = checkout
            End If
        End If

        LoadCheckoutEditor()
    End Sub

    Private Sub LoadCheckoutEditor()
        Dim checkoutEditor As Content.CheckoutEditorTemplate = Content.ModuleController.LoadCheckoutEditor(Me.CheckoutIdField.Value, Me)
        AddHandler checkoutEditor.EditingComplete, AddressOf FinishedEditing

        phEditor.Controls.Add(checkoutEditor)
    End Sub

    Protected Sub FinishedEditing(ByVal sender As Object, ByVal e As Content.BVModuleEventArgs)
        Response.Redirect("Orders.aspx")
    End Sub

End Class
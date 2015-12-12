Imports BVSoftware.Bvc5.Core
Imports System.IO

Partial Class BVAdmin_Orders_UPSOnlineTools_RecoverLabel
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Ups Online Tools - Recover Labels"
        Me.CurrentTab = AdminTabType.Orders
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersView)
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click        
        Me.lnkView.Visible = False

        Dim UPSLabelDirectory As String = Path.Combine(Request.PhysicalApplicationPath, "images\UPS")

        If File.Exists(Path.Combine(UPSLabelDirectory, Me.TextBox1.Text & ".htm")) = True Then
            Me.MessageBox.ShowOK("Label Found. Click button to View and Print")
            Me.lnkView.NavigateUrl = Page.ResolveClientUrl("~/Images/UPS/" & Me.TextBox1.Text & ".htm")
            Me.lnkView.Visible = True
        Else
            Me.MessageBox.ShowWarning("That label wasn't found. Please check your tracking number and try again.")
        End If
    End Sub
End Class

Imports BVSoftware.Bvc5.Core
Imports BvLicensing

Partial Class BVAdmin_Header
    Inherits System.Web.UI.UserControl

    Public Property SelectedTab() As AdminTabType
        Get
            If Session("ActiveAdminTab") Is Nothing Then
                Return AdminTabType.Dashboard
            Else
                Return CType(Session("ActiveAdminTab"), AdminTabType)
            End If
        End Get
        Set(ByVal value As AdminTabType)
            Session("ActiveAdminTab") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.lnkGoToStore.NavigateUrl = WebAppSettings.SiteStandardRoot

        Select Case SelectedTab
            Case AdminTabType.Catalog
                Me.lnkCatalog.Attributes("class") = "maintabselected"
                Me.MultiView1.SetActiveView(Me.viewCatalog)
            Case AdminTabType.Configuration
                Me.lnkOptions.Attributes("class") = "maintabselected"
                Me.MultiView1.SetActiveView(Me.viewConfiguration)
            Case AdminTabType.Content
                Me.lnkContent.Attributes("class") = "maintabselected"
                Me.MultiView1.SetActiveView(Me.viewContent)
            Case AdminTabType.Dashboard
                Me.lnkDashboard.Attributes("class") = "maintabselected"
                Me.MultiView1.SetActiveView(Me.viewDashboard)
            Case AdminTabType.Marketing
                Me.lnkMarketing.Attributes("class") = "maintabselected"
                Me.MultiView1.SetActiveView(Me.viewMarketing)
            Case AdminTabType.Orders
                Me.lnkOrders.Attributes("class") = "maintabselected"
                Me.MultiView1.SetActiveView(Me.viewOrders)
            Case AdminTabType.People
                Me.lnkPeople.Attributes("class") = "maintabselected"
                Me.MultiView1.SetActiveView(Me.viewPeople)
                Dim lnkRoles As HyperLink = Me.viewPeople.FindControl("lnkRoles")
                If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.RolesView) = False Then
                    lnkRoles.Visible = False
                End If
            Case AdminTabType.Reports
                Me.lnkReports.Attributes("class") = "maintabselected"
                Me.MultiView1.SetActiveView(Me.viewReports)
            Case AdminTabType.Plugins
                Me.lnkPlugins.Attributes("class") = "maintabselected"
                Me.MultiView1.SetActiveView(Me.viewPlugins)
        End Select

        ' reports
        Dim reports As StringCollection = Content.ModuleController.FindReports()
        For Each item As String In reports
            Dim link As New HyperLink()
            link.EnableViewState = False
            link.NavigateUrl = "~/BVModules/Reports/" & item & "/view.aspx"
            link.Text = item

            Dim li As New HtmlControls.HtmlGenericControl("li")
            li.Controls.Add(link)
            Me.ulReports.Controls.Add(li)
        Next

        ' plugins
        Me.viewPlugins.Controls.Clear()
        Dim defaultLink As New HyperLink()
        defaultLink.EnableViewState = False
        defaultLink.NavigateUrl = "~/BVAdmin/Plugins/default.aspx?noredirect=1"
        defaultLink.Text = "Change Default"
        Me.viewPlugins.Controls.Add(defaultLink)

        Dim plugins As StringCollection = BVSoftware.BVC5.Core.Content.ModuleController.FindAdminPlugins()
        For Each item As String In plugins
            Dim link As New HyperLink()
            link.EnableViewState = False
            link.NavigateUrl = "~/BVAdmin/Plugins/" & item & "/default.aspx"
            link.Text = item
            Me.viewPlugins.Controls.Add(link)

            Dim linkCopy As New HyperLink()
            linkCopy.EnableViewState = False
            linkCopy.NavigateUrl = "~/BVAdmin/Plugins/" & item & "/default.aspx"
            linkCopy.Text = item
            Dim li As New HtmlControls.HtmlGenericControl("li")
            li.Controls.Add(linkCopy)
            Me.ulPlugins.Controls.Add(li)
        Next
        Me.ulPlugins.Visible = (plugins.Count > 0)

        HideTabsWithoutPermission()
        If Not Page.IsPostBack Then
            SetUserNames()
        End If
        CheckLicense()

    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If WebAppSettings.AdminHeaderMessage.Trim().Length > 0 Then
            Me.pnlHeaderMessage.Controls.Add(New LiteralControl(WebAppSettings.AdminHeaderMessage))
        Else
            Me.pnlHeaderMessage.Visible = False
        End If
    End Sub

    Private Sub HideTabsWithoutPermission()

        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.CatalogView) = False Then
            Me.lnkCatalog.Visible = False
        End If
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentView) = False Then
            Me.lnkContent.Visible = False
        End If
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.MarketingView) = False Then
            Me.lnkMarketing.Visible = False
        End If
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.OrdersView) = False Then
            Me.lnkOrders.Visible = False
        End If
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleView) = False Then
            Me.lnkPeople.Visible = False
        End If
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ReportsView) = False Then
            Me.lnkReports.Visible = False
        End If
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsView) = False Then
            Me.lnkOptions.Visible = False
        End If
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PluginView) = False Then
            Me.lnkPlugins.Visible = False
        End If

    End Sub

    Private Sub SetUserNames()
        Dim u As Membership.UserAccount = SessionManager.GetCurrentUser()
        If u IsNot Nothing Then
            Me.lnkLogout.Text = String.Format("Log Out ({0})", u.FullName)
        Else
            Me.lnkLogout.Text = "Log Out"
        End If
    End Sub

    Private Sub CheckLicense()
        'Dim l As New BvLicensing.LicenseKey()
        'l.LoadFromString(WebAppSettings.LicenseData)
        'If l.IsValid = False Then
        '    Me.lnkInvalidLicense.Visible = True
        '    Me.lnkCatalog.Visible = False
        '    Me.lnkContent.Visible = False
        '    Me.lnkMarketing.Visible = False
        '    Me.lnkOrders.Visible = False
        '    Me.lnkPeople.Visible = False
        '    Me.lnkReports.Visible = False
        '    Me.lnkOptions.Visible = False
        '    Me.lnkPlugins.Visible = False
        '    Me.lnkDashboard.Visible = False
        '    Me.lnkOptions.Visible = False
        'Else
        'Me.lnkInvalidLicense.ValidationGroup = False
        'End If
    End Sub

    'Protected Sub lnkInvalidLicense_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkInvalidLicense.Click
    '    Response.Redirect("~/BVAdmin/Configuration/License.aspx")
    'End Sub

End Class
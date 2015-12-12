Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_People_Roles_Edit
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            SetSecurityModel()

            Me.RoleNameField.Focus()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadRole()
            Else
                Me.BvinField.Value = String.Empty
                LoadPermissions()
            End If
        End If
    End Sub

    Private Sub SetSecurityModel()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.RolesEdit) = False Then
            Me.btnSaveChanges.Enabled = False
            Me.btnSaveChanges.Visible = False
            Me.btnAddPermission.Enabled = False
            Me.btnAddPermission.Visible = False
            Me.btnRemovePermission.Enabled = False
            Me.btnRemovePermission.Visible = False
            Me.AddButton.Enabled = False
            Me.AddButton.Visible = False
            Me.RemoveButton.Enabled = False
            Me.RemoveButton.Visible = False
            Me.RoleNameField.ReadOnly = True
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Group"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.RolesView)
    End Sub

    Private Sub LoadRole()
        Dim r As Membership.Role
        r = Membership.Role.FindByBvin(Me.BvinField.Value)

        If Not r Is Nothing Then
            If r.Bvin <> String.Empty Then
                Me.RoleNameField.Text = r.RoleName

                If r.Bvin = WebAppSettings.AdministratorsRoleID Then
                    Me.btnSaveChanges.Visible = False
                    Me.RoleNameField.ReadOnly = True
                End If

            End If
        End If
        LoadGroups()
        LoadPermissionsFromList(r.Permissions)
    End Sub

    Private Sub LoadPermissionsFromList(ByVal p As Collection(Of Membership.RolePermission))
        Me.PermissionList.DataSource = p
        Me.PermissionList.DataTextField = "Name"
        Me.PermissionList.DataValueField = "bvin"
        Me.PermissionList.DataBind()

        If Me.BvinField.Value = WebAppSettings.AdministratorsRoleId Then
            Me.AvailablePermissionsList.DataSource = Nothing
            Me.AvailablePermissionsList.DataBind()
        Else
            Dim availablePermissions As New Collection(Of Membership.RolePermission)
            If Me.BvinField.Value = String.Empty Then
                availablePermissions = Membership.RolePermission.FindAll()
            Else
                availablePermissions = Membership.RolePermission.FindNotInRoleId(Me.BvinField.Value)
            End If

            Me.AvailablePermissionsList.DataSource = availablePermissions
            Me.AvailablePermissionsList.DataTextField = "Name"
            Me.AvailablePermissionsList.DataValueField = "bvin"
            Me.AvailablePermissionsList.DataBind()
        End If

    End Sub

    Private Sub LoadPermissions()
        Dim perms As Collection(Of Membership.RolePermission) = Membership.RolePermission.FindByRoleId(Me.BvinField.Value)
        LoadPermissionsFromList(perms)
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Me.Save = True Then
            Response.Redirect("roles.aspx")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("Roles.aspx")
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim r As Membership.Role
        r = Membership.Role.FindByBvin(Me.BvinField.Value)

        If r IsNot Nothing Then
            r.RoleName = Me.RoleNameField.Text.Trim

            If Me.BvinField.Value = String.Empty Then
                result = Membership.Role.Insert(r)
            Else
                result = Membership.Role.Update(r)
            End If

            If result = True Then
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = r.Bvin
            End If
        End If

        Return result
    End Function

    Protected Sub btnAddPermission_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddPermission.Click
        If Me.Save = True Then
            For i As Integer = 0 To Me.AvailablePermissionsList.Items.Count - 1
                If Me.AvailablePermissionsList.Items(i).Selected = True Then
                    Membership.Role.AddPermissionToRole(Me.BvinField.Value, Me.AvailablePermissionsList.Items(i).Value)
                End If
            Next
            LoadPermissions()
        End If
    End Sub

    Protected Sub btnRemovePermission_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnRemovePermission.Click
        If Me.Save = True Then
            For i As Integer = 0 To Me.PermissionList.Items.Count - 1
                If Me.PermissionList.Items(i).Selected = True Then
                    Membership.Role.RemovePermissionFromRole(Me.BvinField.Value, Me.PermissionList.Items(i).Value)
                End If
            Next
            LoadPermissions()
        End If
    End Sub

    Protected Sub AddButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddButton.Click
        Dim li As ListItem
        For Each li In NonMemberList.Items
            If li.Selected = True Then
                Membership.Role.AddUser(li.Value, Me.BvinField.Value)
            End If
        Next
        LoadGroups()
    End Sub

    Protected Sub RemoveButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemoveButton.Click
        Dim li As ListItem
        For Each li In MemberList.Items
            If li.Selected = True Then
                Membership.Role.RemoveUser(li.Value, Me.BvinField.Value)
            End If
        Next
        LoadGroups()
    End Sub

    Private Sub LoadGroups()
        MemberList.DataSource = Membership.Role.FindUsersInRole(Me.BvinField.Value)
        MemberList.DataValueField = "bvin"
        MemberList.DataTextField = "Username"
        MemberList.DataBind()

        NonMemberList.DataSource = Membership.Role.FindUsersNotInRole(Me.BvinField.Value)
        NonMemberList.DataValueField = "bvin"
        NonMemberList.DataTextField = "Username"
        NonMemberList.DataBind()
    End Sub
End Class

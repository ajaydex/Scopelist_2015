Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVAdmin_People_Vendors_Edit
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        SetEditorMode()

        If Not Page.IsPostBack Then
            Me.DisplayNameField.Focus()
            Me.SetSecurityModel()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                InitializeForm()
                LoadVendor()                
            Else
                Me.BvinField.Value = String.Empty
                InitializeForm()
                LoadGroups()
            End If
        End If
        Me.UserPicker1.MessageBox = Me.MessageBox1
        AddHandler Me.UserPicker1.UserSelected, AddressOf Me.UserSelected
    End Sub

    Private Sub SetSecurityModel()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = False Then
            Me.btnSaveChanges.Enabled = False
            Me.btnSaveChanges.Visible = False
            Me.RemoveButton.Enabled = False
        End If
    End Sub

    Private Sub SetEditorMode()
        AddressEditor1.RequireAddress = False
        AddressEditor1.RequireCity = False
        AddressEditor1.RequireCompany = False
        AddressEditor1.RequireFax = False
        AddressEditor1.RequireFirstName = False
        AddressEditor1.RequireLastName = False
        AddressEditor1.RequirePhone = False
        AddressEditor1.RequirePostalCode = False
        AddressEditor1.RequireRegion = False
        AddressEditor1.RequireWebSiteURL = False
        AddressEditor1.ShowCompanyName = True
        AddressEditor1.ShowFaxNumber = True
        AddressEditor1.ShowMiddleInitial = True
        AddressEditor1.ShowPhoneNumber = True
        AddressEditor1.ShowWebSiteURL = True
        AddressEditor1.ShowCounty = True
    End Sub

    Private Sub LoadVendor()
        Dim v As Contacts.Vendor
        v = Contacts.Vendor.FindByBvin(Me.BvinField.Value)
        If Not v Is Nothing Then
            If v.Bvin <> String.Empty Then
                Me.DisplayNameField.Text = v.DisplayName
                Me.EmailField.Text = v.EmailAddress
                Me.AddressEditor1.LoadFromAddress(v.Address)
                Me.DropShipNotificationDropDownList.SelectedValue = v.DropShipEmailTemplateId
            End If
        End If
        LoadGroups()
    End Sub

    Private Sub InitializeForm()
        DropShipNotificationDropDownList.DataSource = Content.EmailTemplate.FindAll()
        DropShipNotificationDropDownList.DataTextField = "DisplayName"
        DropShipNotificationDropDownList.DataValueField = "bvin"
        DropShipNotificationDropDownList.DataBind()
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Vendor"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("Vendors.aspx")
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        Me.lblError.Text = String.Empty

        If Save() = True Then
            Response.Redirect("Vendors.aspx")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim v As Contacts.Vendor
        v = Contacts.Vendor.FindByBvin(Me.BvinField.Value)

        If v IsNot Nothing Then
            v.DisplayName = Me.DisplayNameField.Text.Trim
            v.EmailAddress = Me.EmailField.Text.Trim
            v.Address = Me.AddressEditor1.GetAsAddress
            v.DropShipEmailTemplateId = Me.DropShipNotificationDropDownList.SelectedValue
            If Me.BvinField.Value = String.Empty Then
                result = Contacts.Vendor.Insert(v)
            Else               
                result = Contacts.Vendor.Update(v)
            End If

            If result = False Then
                Me.lblError.Text = "Unable to save vendor. Uknown error."
            Else
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = v.Bvin
            End If

        End If

        Return result
    End Function

    Protected Sub RemoveButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemoveButton.Click
        Dim li As ListItem
        For Each li In MemberList.Items
            If li.Selected = True Then
                Contacts.Vendor.RemoveUser(li.Value, Me.BvinField.Value)
            End If
        Next
        LoadGroups()
    End Sub

    Private Sub LoadGroups()
        MemberList.DataSource = Contacts.Vendor.FindAssociatedUsers(Me.BvinField.Value)
        MemberList.DataValueField = "bvin"
        MemberList.DataTextField = "Username"
        MemberList.DataBind()
    End Sub

    Protected Sub UserSelected(ByVal args As Controls.UserSelectedEventArgs)
        If Me.BvinField.Value = String.Empty Then
            Save()
        End If
        Contacts.Vendor.AddUser(args.UserAccount.Bvin, Me.BvinField.Value)
        LoadGroups()
    End Sub

End Class

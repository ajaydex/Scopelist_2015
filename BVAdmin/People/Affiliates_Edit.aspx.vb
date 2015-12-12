Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVAdmin_People_Affiliates_Edit
    Inherits BaseAdminPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        lstStyleSheet.DataSource = Content.ModuleController.FindThemes()
        lstStyleSheet.DataBind()
        Dim item As New ListItem("No Custom Theme", "")
        lstStyleSheet.Items.Insert(0, item)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        SetEditorMode()

        If Not Page.IsPostBack Then
            SetDefaults()
            Me.SetSecurityModel()
            Me.DisplayNameField.Focus()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadAffiliate()
                LoadGroups()
            Else
                Me.BvinField.Value = String.Empty
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

    Private Sub SetDefaults()
        Me.lstCommissionType.ClearSelection()
        Select Case WebAppSettings.AffiliateCommissionType
            Case Contacts.AffiliateCommissionType.PercentageCommission, Contacts.AffiliateCommissionType.None
                Me.lstCommissionType.Items.FindByValue("1").Selected = True
            Case Contacts.AffiliateCommissionType.FlatRateCommission
                Me.lstCommissionType.Items.FindByValue("2").Selected = True
            Case Else
                Me.lstCommissionType.Items.FindByValue("1").Selected = True
        End Select
        Me.CommissionAmountField.Text = WebAppSettings.AffiliateCommissionAmount.ToString("N")
        Me.ReferralDaysField.Text = WebAppSettings.AffiliateReferralDays.ToString
    End Sub

    Private Sub LoadAffiliate()
        Dim a As Contacts.Affiliate
        a = Contacts.Affiliate.FindByBvin(Me.BvinField.Value)
        If Not a Is Nothing Then
            If a.Bvin <> String.Empty Then
                Me.DisplayNameField.Text = a.DisplayName
                Me.ReferralIdField.Text = a.ReferralID
                Me.lstCommissionType.ClearSelection()
                Select Case a.CommissionType
                    Case Contacts.AffiliateCommissionType.PercentageCommission
                        Me.lstCommissionType.Items.FindByValue("1").Selected = True
                    Case Contacts.AffiliateCommissionType.FlatRateCommission, Contacts.AffiliateCommissionType.None
                        Me.lstCommissionType.Items.FindByValue("2").Selected = True
                    Case Else
                        Me.lstCommissionType.Items.FindByValue("1").Selected = True
                End Select
                Me.CommissionAmountField.Text = a.CommissionAmount.ToString("N")
                Me.ReferralDaysField.Text = a.ReferralDays.ToString
                Me.TaxIdField.Text = a.TaxID
                Me.DriversLicenseField.Text = a.DriversLicenseNumber
                Me.WebsiteUrlField.Text = a.WebSiteUrl
                Me.NotesTextBox.Text = a.Notes
                Me.lstStyleSheet.SelectedValue = a.CustomThemeName
                If a.ReferralId <> String.Empty Then
                    Me.SampleUrlLabel.Text = WebAppSettings.SiteStandardRoot + "default.aspx?" + WebAppSettings.AffiliateQueryStringName + "=" + a.ReferralId
                Else
                    Me.SampleUrlLabel.Text = String.Empty
                End If

                'Load Theme Info Here                
                Me.AddressEditor1.LoadFromAddress(a.Address)
            End If
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Affiliate"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("Affiliates.aspx")
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        Me.lblError.Text = String.Empty

        If Save() = True Then
            Response.Redirect("Affiliates.aspx")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim a As Contacts.Affiliate
        a = Contacts.Affiliate.FindByBvin(Me.BvinField.Value)

        If a IsNot Nothing Then
            a.DisplayName = Me.DisplayNameField.Text.Trim
            a.ReferralID = Me.ReferralIdField.Text.Trim
            Dim typeSelection As Integer = CType(Me.lstCommissionType.SelectedValue, Integer)
            a.CommissionType = CType(typeSelection, Contacts.AffiliateCommissionType)
            a.CommissionAmount = Decimal.Parse(Me.CommissionAmountField.Text, System.Globalization.NumberStyles.Currency)
            a.ReferralDays = Integer.Parse(Me.ReferralDaysField.Text)
            a.TaxID = Me.TaxIdField.Text.Trim
            a.DriversLicenseNumber = Me.DriversLicenseField.Text.Trim
            a.WebSiteURL = Me.WebsiteUrlField.Text.Trim
            a.CustomThemeName = Me.lstStyleSheet.SelectedValue
            a.Address = Me.AddressEditor1.GetAsAddress
            a.Notes = Me.NotesTextBox.Text
            If Me.BvinField.Value = String.Empty Then
                result = Contacts.Affiliate.Insert(a)
            Else
                result = Contacts.Affiliate.Update(a)
            End If

            If result = False Then
                Me.lblError.Text = "Unable to save affiliate. Unknown error."
            Else
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = a.Bvin
            End If

        End If

        Return result
    End Function

    Protected Sub RemoveButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemoveButton.Click
        Dim li As ListItem
        For Each li In MemberList.Items
            If li.Selected = True Then
                Contacts.Affiliate.RemoveUser(li.Value, Me.BvinField.Value)
            End If
        Next
        LoadGroups()
    End Sub

    Private Sub LoadGroups()
        MemberList.DataSource = Contacts.Affiliate.FindAssociatedUsers(Me.BvinField.Value)
        MemberList.DataValueField = "bvin"
        MemberList.DataTextField = "Username"
        MemberList.DataBind()
    End Sub

    Protected Sub UserSelected(ByVal args As Controls.UserSelectedEventArgs)
        If Me.BvinField.Value = String.Empty Then
            Save()
        End If
        Contacts.Affiliate.AddUser(args.UserAccount.Bvin, Me.BvinField.Value)
        LoadGroups()
    End Sub
End Class

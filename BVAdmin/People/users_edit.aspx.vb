Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.Linq

Partial Class BVAdmin_People_users_edit
    Inherits BaseAdminPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Not Page.IsPostBack Then
            PasswordRegularExpressionValidator.ErrorMessage = "Password must be at least " & WebAppSettings.PasswordMinimumLength & " characters long."
            PasswordRegularExpressionValidator.ValidationExpression = ".{" & WebAppSettings.PasswordMinimumLength.ToString() & ",50}"
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.UsernameField.Focus()

            SetSecurityModel()

            BindPricingGroups()
            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadUser()
                LoadOrders()
                LoadSearchResults()
                LoadWishlist()
                LoadLoyaltyPoints()
            Else
                Me.BvinField.Value = String.Empty
                Me.trResetPassword.Visible = False
                Me.phImpersonate.Visible = False
                SetDefaultEncryption()
                LoadGroups()
            End If
        End If
    End Sub

    Private Sub SetSecurityModel()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = False Then
            Me.btnSaveChanges.Enabled = False
            Me.btnSaveChanges.Visible = False
            Me.btnNewAddress.Enabled = False
            Me.btnNewAddress.Visible = False
            Me.UsernameField.ReadOnly = True
            Me.EmailField.ReadOnly = True
            Me.PasswordAnswerField.ReadOnly = True
            Me.PasswordField.ReadOnly = True
            Me.PasswordHintField.ReadOnly = True
            Me.CommentField.ReadOnly = True
            Me.FirstNameField.ReadOnly = True
            Me.LastNameField.ReadOnly = True
        End If

        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.RolesEdit) = False Then
            Me.AddButton.Enabled = False
            Me.AddButton.Visible = False
            Me.RemoveButton.Enabled = False
            Me.RemoveButton.Visible = False
        End If

        If SessionManager.CanImpersonateUser(Request.QueryString("id")) Then
            Me.btnImpersonate.Visible = True
            Me.lblImpersonate.Text = "Browse the site as this user."
        Else
            Me.btnImpersonate.Visible = False
            Me.lblImpersonate.Text = "You do not have the proper permissions to impersonate this user."
        End If
    End Sub

    Private Sub SetDefaultEncryption()
        Select Case WebAppSettings.PasswordDefaultEncryption
            Case Membership.UserPasswordFormat.ClearText
                If Me.PasswordFormatField.Items.FindByValue("0") IsNot Nothing Then
                    Me.PasswordFormatField.Items.FindByValue("0").Selected = True
                End If
            Case Membership.UserPasswordFormat.Encrypted
                If Me.PasswordFormatField.Items.FindByValue("2") IsNot Nothing Then
                    Me.PasswordFormatField.Items.FindByValue("2").Selected = True
                End If
            Case Membership.UserPasswordFormat.Hashed
                If Me.PasswordFormatField.Items.FindByValue("1") IsNot Nothing Then
                    Me.PasswordFormatField.Items.FindByValue("1").Selected = True
                End If
        End Select
    End Sub

    Private Sub LoadUser()
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.BvinField.Value)
        If Not u Is Nothing Then
            If u.Bvin <> String.Empty Then
                Me.UsernameField.Text = u.UserName
                Me.EmailField.Text = u.Email
                Me.FirstNameField.Text = u.FirstName
                Me.LastNameField.Text = u.LastName
                Me.chkTaxExempt.Checked = u.TaxExempt
                Select Case u.PasswordFormat
                    Case Membership.UserPasswordFormat.ClearText
                        If Me.PasswordFormatField.Items.FindByValue("0") IsNot Nothing Then
                            Me.PasswordFormatField.Items.FindByValue("0").Selected = True
                        End If
                    Case Membership.UserPasswordFormat.Encrypted
                        If Me.PasswordFormatField.Items.FindByValue("2") IsNot Nothing Then
                            Me.PasswordFormatField.Items.FindByValue("2").Selected = True
                        End If
                    Case Membership.UserPasswordFormat.Hashed
                        If Me.PasswordFormatField.Items.FindByValue("1") IsNot Nothing Then
                            Me.PasswordFormatField.Items.FindByValue("1").Selected = True
                        End If
                End Select
                Me.PasswordField.Text = u.DecryptPassword(u.Password)
                Me.PasswordHintField.Text = u.PasswordHint
                Me.PasswordAnswerField.Text = u.PasswordAnswer
                Me.CommentField.Text = u.Comment
                Me.LockedField.Checked = u.Locked
                Me.LockedField.Text = " until " & u.LockedUntil.ToString & " (" & u.FailedLoginCount & " failed attempts)"

                Me.BillingAddressField.Text = u.BillingAddress.ToHtmlString
                Me.ShippingAddressField.Text = u.ShippingAddress.ToHtmlString
                Me.PricingGroupDropDownList.SelectedValue = u.PricingGroupId
                Me.IsSalesPersonField.Checked = u.IsSalesPerson
                Me.CustomQuestionAnswerTextBox.Text = u.CustomQuestionAnswers

                Me.lnkNewOrder.NavigateUrl = String.Format("~/BVAdmin/Orders/NewOrder.aspx?uid={0}", u.Bvin)
                Me.lnkNewOrder.Visible = True
            End If
        End If

        If Not Page.IsPostBack Then
            AddressList.DataSource = u.Addresses
            AddressList.DataBind()
        End If
        LoadGroups()
    End Sub

    Private Sub LoadAddresses()
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.BvinField.Value)
        If u IsNot Nothing Then
            AddressList.DataSource = u.Addresses
            AddressList.DataBind()
        End If
        u = Nothing
    End Sub

    Private Sub BindPricingGroups()
        PricingGroupDropDownList.Items.Clear()
        PricingGroupDropDownList.DataSource = Contacts.PriceGroup.FindAll()
        PricingGroupDropDownList.DataTextField = "Name"
        PricingGroupDropDownList.DataValueField = "bvin"
        PricingGroupDropDownList.DataBind()
        Dim item As New ListItem("None", "")
        PricingGroupDropDownList.Items.Insert(0, item)
    End Sub

    Private Sub LoadGroups()
        MemberList.DataSource = Membership.Role.FindByUserId(Me.BvinField.Value)
        MemberList.DataValueField = "bvin"
        MemberList.DataTextField = "RoleName"
        MemberList.DataBind()

        If Me.BvinField.Value = String.Empty Then
            NonMemberList.DataSource = Membership.Role.FindAll
        Else
            NonMemberList.DataSource = Membership.Role.FindNotInUserId(Me.BvinField.Value)
        End If
        NonMemberList.DataValueField = "bvin"
        NonMemberList.DataTextField = "RoleName"
        NonMemberList.DataBind()
    End Sub

    Private Sub LoadOrders()

        Dim dtOrders As New Collection(Of Orders.Order)
        dtOrders = Orders.Order.FindByUser(Request.QueryString("id"))

        If Not dtOrders Is Nothing Then
            lblItems.Text = dtOrders.Count & " Orders Found"
            dgOrders.DataSource = dtOrders
            dgOrders.DataBind()
        Else
            lblItems.Text = "No Orders Could be Found"
        End If
    End Sub
    Private Sub LoadSearchResults()
        Dim sr As New Collection(Of Metrics.SearchQuery)
        sr = Metrics.SearchQuery.FindByShopperID(Me.BvinField.Value.ToString)

        If Not sr Is Nothing Then
            Me.dgSearchHistory.DataSource = sr
            Me.dgSearchHistory.DataBind()
        End If

    End Sub
    Private Sub LoadWishlist()
        Dim w As New Collection(Of Catalog.WishList)
        Dim p As New Collection(Of Catalog.Product)

        w = Catalog.WishList.FindByUserBvin(Request.QueryString("id"))

        For Each item As Catalog.WishList In w
            Dim n As Catalog.Product = Catalog.InternalProduct.FindByBvin(item.ProductBvin)
            p.Add(n)
        Next

        Me.DataList1.DataSource = p
        Me.DataList1.DataBind()

    End Sub

    Private Sub LoadLoyaltyPoints()
        If Not String.IsNullOrEmpty(Me.BvinField.Value) Then
            Me.lnkLoyaltyPoints.NavigateUrl = String.Format("~/BVAdmin/People/users_edit_loyaltypoints.aspx?id={0}", Me.BvinField.Value)

            Dim points As Integer = Membership.LoyaltyPoints.GetAvailablePointsForUser(Me.BvinField.Value)
            Dim pointsCurrency As Decimal = Membership.LoyaltyPoints.CalculateCurrencyEquivalent(points)

            Me.lblLoyaltyPoints.Text = points.ToString()
            Me.lblLoyaltyPointsCurrency.Text = String.Format(WebAppSettings.SiteCulture, "{0:c}", pointsCurrency)
        Else
            Me.lnkLoyaltyPoints.Visible = False
            Me.lblLoyaltyPoints.Text = "0"
            Me.lblLoyaltyPointsCurrency.Text = String.Format(WebAppSettings.SiteCulture, "{0:c}", 0)
        End If
    End Sub

    Protected Sub dgOrders_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgOrders.EditCommand
        Dim bvin As String = dgOrders.DataKeys(e.Item.ItemIndex).ToString
        Response.Redirect("~/BVadmin/Orders/ViewOrder.aspx?id=" & bvin)
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit User"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Private Sub AddressList_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles AddressList.EditCommand
        Save()
        Dim bvin As String = CType(Me.AddressList.DataKeys.Item(e.Item.ItemIndex), String)
        Response.Redirect("users_edit_address.aspx?userID=" & Me.BvinField.Value & "&id=" & bvin)
    End Sub

    Private Sub AddressList_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles AddressList.DeleteCommand
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = True Then
            Save()

            Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.BvinField.Value)
            If Not u Is Nothing Then
                Dim bvin As String = CType(Me.AddressList.DataKeys.Item(e.Item.ItemIndex), String)
                For i As Integer = 0 To u.Addresses.Count - 1
                    If u.Addresses(i).Bvin = bvin Then
                        u.Addresses.RemoveAt(u.Addresses.IndexOf(u.Addresses(i)))
                        Exit For
                    End If
                Next
                Dim s As Membership.CreateUserStatus = Membership.CreateUserStatus.None
                Membership.UserAccount.Update(u, s)
                LoadAddresses()
            End If
        End If
    End Sub

    Private Sub AddressList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles AddressList.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim AddressDisplay As System.Web.UI.WebControls.Label
            AddressDisplay = e.Item.FindControl("AddressDisplay")
            If Not AddressDisplay Is Nothing Then
                AddressDisplay.Text = CType(e.Item.DataItem, Contacts.Address).ToHtmlString
            End If

            Dim ShipTo As System.Web.UI.WebControls.ImageButton = e.Item.FindControl("ShipToImageButton")
            Dim BillTo As System.Web.UI.WebControls.ImageButton = e.Item.FindControl("BillToImageButton")
            ShipTo.CommandArgument = AddressList.DataKeys(e.Item.ItemIndex).ToString()
            BillTo.CommandArgument = ShipTo.CommandArgument
        End If
    End Sub

    Private Sub AddressList_ItemCommand(ByVal sender As Object, ByVal e As DataListCommandEventArgs) Handles AddressList.ItemCommand
        If e.CommandName.ToUpper() = "BILLTO" Then
            Dim u As Membership.UserAccount
            u = Membership.UserAccount.FindByBvin(Me.BvinField.Value)
            If u IsNot Nothing Then
                For Each item As Contacts.Address In u.Addresses
                    If item.Bvin = e.CommandArgument Then
                        u.BillingAddress = item
                        Membership.UserAccount.Update(u)
                        Exit For
                    End If
                Next
                LoadUser()
                LoadAddresses()
            End If
        ElseIf e.CommandName.ToUpper() = "SHIPTO" Then
            Dim u As Membership.UserAccount
            u = Membership.UserAccount.FindByBvin(Me.BvinField.Value)
            If u IsNot Nothing Then
                For Each item As Contacts.Address In u.Addresses
                    If item.Bvin = e.CommandArgument Then
                        u.ShippingAddress = item
                        Membership.UserAccount.Update(u)
                        Exit For
                    End If
                Next
                LoadUser()
                LoadAddresses()
            End If
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Page.IsValid Then
            Me.lblError.Text = String.Empty

            If Save() = True Then
                Response.Redirect("default.aspx")
            End If
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        ' Check password length
        If Me.PasswordField.Text.Trim.Length < WebAppSettings.PasswordMinimumLength Then
            Me.lblError.Text = "Password must be at least " & WebAppSettings.PasswordMinimumLength & " characters long."
            Return False
        End If

        Dim emailChanged As Boolean = False
        Dim oldEmailAddress As String = String.Empty

        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.BvinField.Value)
        If u IsNot Nothing Then

            ' PCI Validation
            If Me.PasswordField.Text <> u.Password AndAlso (Membership.UserAccount.IsPasswordStrong(Me.PasswordField.Text) = False) Then
                Me.lblError.Text = String.Format("Password must be at least {0} characters long and contain one letter and one number", WebAppSettings.PasswordMinimumLength.ToString())
                Return False
            End If

            u.Comment = Me.CommentField.Text.Trim
            If String.Compare(u.Email.Trim, Me.EmailField.Text.Trim, True) <> 0 Then
                oldEmailAddress = u.Email.Trim()
                emailChanged = True
            End If
            u.Email = Me.EmailField.Text.Trim
            u.FirstName = Me.FirstNameField.Text.Trim
            u.LastName = Me.LastNameField.Text.Trim
            u.PasswordAnswer = Me.PasswordAnswerField.Text.Trim
            u.PasswordHint = Me.PasswordHintField.Text.Trim
            u.TaxExempt = Me.chkTaxExempt.Checked
            u.UserName = Me.UsernameField.Text.Trim
            u.IsSalesPerson = Me.IsSalesPersonField.Checked
            u.CustomQuestionAnswers = Me.CustomQuestionAnswerTextBox.Text.Trim

            Dim oldPasswordFormat As Membership.UserPasswordFormat = u.PasswordFormat
            u.PasswordFormat = CType(Me.PasswordFormatField.SelectedValue, Membership.UserPasswordFormat)

            If u.Locked <> Me.LockedField.Checked Then
                ' Lock Status Changed                
                If Me.LockedField.Checked = True Then
                    u.Lock()
                Else
                    u.Unlock()
                End If
            End If

            u.PricingGroupId = PricingGroupDropDownList.SelectedValue

            Dim s As Membership.CreateUserStatus = Membership.CreateUserStatus.None

            If Me.BvinField.Value = String.Empty Then
                ' Insert automatically encrypts password when generating salt
                u.Password = Me.PasswordField.Text.Trim
                ' Create new user
                result = Membership.UserAccount.Insert(u, s)
                Me.BvinField.Value = u.Bvin
            Else
                If u.Password <> Me.PasswordField.Text.Trim() AndAlso u.IsOldPassword(Me.PasswordField.Text.Trim()) Then
                    Me.lblError.Text = "Password can not be any of the previous three passwords."
                    Return False
                End If

                ' Encrypt password if updating user
                If oldPasswordFormat <> u.PasswordFormat Then
                    ' Password format has changed so alway encrypt
                    u.RecordOldPassword(u.Password)
                    u.Password = u.EncryptPassword(Me.PasswordField.Text.Trim)
                Else
                    If u.PasswordFormat = Membership.UserPasswordFormat.Hashed Then
                        ' Only updated hashed password if the admin changed the password, otherwise leave it alone
                        If u.Password <> Me.PasswordField.Text.Trim Then
                            u.RecordOldPassword(u.Password)
                            u.Password = u.EncryptPassword(Me.PasswordField.Text.Trim)
                        End If
                    Else
                        ' Clear text and encrypted passwords are alway decrypted so we can view and encrypt them again.
                        u.RecordOldPassword(u.Password)
                        u.Password = u.EncryptPassword(Me.PasswordField.Text.Trim)
                    End If
                End If

                ' Update User
                result = Membership.UserAccount.Update(u, s)
            End If

            If result = False Then
                Select Case s
                    Case Membership.CreateUserStatus.DuplicateUsername
                        Me.lblError.Text = "That username already exists. Select another username."
                    Case Else
                        Me.lblError.Text = "Unable to save user. Uknown error."
                End Select
            Else
                'try to update all of the users orders with the new e-mail address
                For Each item As Orders.Order In Orders.Order.FindByUser(u.Bvin)
                    item.UserEmail = u.Email
                    Orders.Order.Update(item)
                Next

                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = u.Bvin
            End If

        End If

        Return result
    End Function

    Protected Sub btnNewAddress_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewAddress.Click
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = True Then
            If Me.Save = True Then
                Response.Redirect("users_edit_address.aspx?userID=" & Me.BvinField.Value)
            End If
        End If
    End Sub

    Protected Sub AddButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddButton.Click
        If Page.IsValid Then
            If Me.Save = True Then
                Dim li As ListItem
                For Each li In NonMemberList.Items
                    If li.Selected = True Then
                        Membership.Role.AddUser(Me.BvinField.Value, li.Value)
                    End If
                Next
            End If
            LoadUser()
            LoadGroups()
        End If
    End Sub

    Protected Sub RemoveButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles RemoveButton.Click
        If Me.Save = True Then
            Dim li As ListItem
            For Each li In MemberList.Items
                If li.Selected = True Then
                    Dim role As Membership.Role = Membership.Role.FindByBvin(li.Value)
                    If String.Compare(role.RoleName, "Administrators", True) = 0 Then
                        If Membership.Role.FindUsersInRole(li.Value).Count = 1 Then
                            lblError.Text = "You cannot remove the last administrator."
                            Return
                        End If
                    End If
                    Membership.Role.RemoveUser(Me.BvinField.Value, li.Value)
                End If
            Next
        End If
        LoadGroups()
    End Sub

    Protected Sub btnBillingAddressEdit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnBillingAddressEdit.Click
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = True Then
            If Me.Save = True Then
                Response.Redirect("users_edit_address.aspx?userID=" & Me.BvinField.Value & "&id=b")
            End If
        End If
    End Sub

    Protected Sub btnShippingAddressEdit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShippingAddressEdit.Click
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = True Then
            If Me.Save = True Then
                Response.Redirect("users_edit_address.aspx?userID=" & Me.BvinField.Value & "&id=s")
            End If
        End If
    End Sub

    Protected Sub btnResetPassword_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnResetPassword.Click
        Dim newPassword As String = Membership.UserAccount.GeneratePassword(10)

        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(Me.BvinField.Value)
        u.PasswordFormat = CType(Me.PasswordFormatField.SelectedValue, Membership.UserPasswordFormat)
        u.Password = u.EncryptPassword(newPassword)
        If Membership.UserAccount.Update(u) Then
            Dim t As Content.EmailTemplate = Content.EmailTemplate.FindByBvin(WebAppSettings.EmailTemplateID_ForgotPassword)
            If t IsNot Nothing Then
                Dim m As System.Net.Mail.MailMessage
                m = t.ConvertToMailMessage(t.From, u.Email, u, newPassword)

                If Utilities.MailServices.SendMail(m) Then
                    Me.MessageBox1.ShowOk("Your new password has been sent by email.")
                Else
                    Me.MessageBox1.ShowError("Error while sending mail!")
                End If
            Else
                Me.MessageBox1.ShowError("Unable to find password reset email template!")
            End If

            Me.PasswordField.Text = u.Password
        Else
            Me.MessageBox1.ShowError("An error occurred while trying to update password.")
        End If
    End Sub

    Protected Sub btnImpersonate_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnImpersonate.Click
        If SessionManager.ImpersonateUser(Me.BvinField.Value) Then
            Response.Redirect("~/MyAccount_Orders.aspx")
        Else
            Me.MessageBox1.ShowError("Unable to impersonate user!")
        End If
    End Sub

End Class
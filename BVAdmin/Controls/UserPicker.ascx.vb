Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Controls_UserPicker
    Inherits System.Web.UI.UserControl

    Private _tabIndex As Integer = -1

    Public Property UserName() As String
        Get
            Return Me.UserNameField.Text
        End Get
        Set(ByVal value As String)
            Me.UserNameField.Text = value
        End Set
    End Property

    Dim _messageBox As IMessageBox = Nothing

    Public Property MessageBox() As IMessageBox
        Get
            Return _messageBox
        End Get
        Set(ByVal value As IMessageBox)
            _messageBox = value
        End Set
    End Property

    Public Property TabIndex() As Integer
        Get
            Return _tabIndex
        End Get
        Set(ByVal value As Integer)
            _tabIndex = value
        End Set
    End Property

    Public Event UserSelected(ByVal args As Controls.UserSelectedEventArgs)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If _tabIndex <> -1 Then
            FilterField.TabIndex = _tabIndex
            btnGoUserSearch.TabIndex = _tabIndex + 1
            btnBrowserUserCancel.TabIndex = _tabIndex + 2
            NewUserNameField.TabIndex = _tabIndex + 3
            NewUserEmailField.TabIndex = _tabIndex + 4
            NewUserFirstNameField.TabIndex = _tabIndex + 5
            NewUserLastNameField.TabIndex = _tabIndex + 6
            btnNewUserCancel.TabIndex = _tabIndex + 7
            btnNewUserSave.TabIndex = _tabIndex + 8
        End If
    End Sub

    Protected Sub btnBrowseUsers_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnBrowseUsers.Click
        MessageBox.ClearMessage()
        Me.pnlNewUser.Visible = False
        If pnlUserBrowser.Visible = True Then
            pnlUserBrowser.Visible = False
        Else
            Me.pnlUserBrowser.Visible = True
            LoadUsers()
        End If
    End Sub

    Protected Sub btnBrowserUserCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnBrowserUserCancel.Click
        MessageBox.ClearMessage()
        Me.pnlUserBrowser.Visible = False
    End Sub

    Protected Sub btnNewUserCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewUserCancel.Click
        MessageBox.ClearMessage()
        Me.pnlNewUser.Visible = False
    End Sub

    Protected Sub btnNewUser_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewUser.Click
        MessageBox.ClearMessage()
        Me.pnlUserBrowser.Visible = False
        If Me.pnlNewUser.Visible = True Then
            Me.pnlNewUser.Visible = False
        Else
            Me.pnlNewUser.Visible = True
        End If
    End Sub

    Protected Sub btnGoUserSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGoUserSearch.Click
        MessageBox.ClearMessage()
        LoadUsers()
        Me.FilterField.Focus()
    End Sub

    Private Sub LoadUsers()
        Dim users As Collection(Of Membership.UserAccount)
        users = Membership.UserAccount.FindAllWithFilter(Me.FilterField.Text.Trim)
        Me.GridView1.DataSource = users
        Me.GridView1.DataBind()
    End Sub

    Protected Sub btnNewUserSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewUserSave.Click
        MessageBox.ClearMessage()
        Dim u As New Membership.UserAccount
        u.UserName = Me.NewUserNameField.Text.Trim
        u.Email = Me.NewUserEmailField.Text.Trim
        u.FirstName = Me.NewUserFirstNameField.Text.Trim
        u.LastName = Me.NewUserLastNameField.Text.Trim
        u.Password = Membership.UserAccount.GeneratePassword(12)
        u.PasswordFormat = WebAppSettings.PasswordDefaultEncryption
        Dim createResult As New Membership.CreateUserStatus
        If Membership.UserAccount.Insert(u, createResult) = True Then
            Me.UserNameField.Text = u.UserName
            ValidateUser()
            Me.pnlNewUser.Visible = False
        Else
            Select Case createResult
                Case Membership.CreateUserStatus.DuplicateUsername
                    MessageBox.ShowWarning("The username " & Me.NewUserNameField.Text.Trim & " already exists. Please select another username.")
                Case Membership.CreateUserStatus.InvalidPassword
                    MessageBox.ShowWarning("Unable to create this account. Invalid Password")
                Case Else
                    MessageBox.ShowWarning("Unable to create this account. Unknown Error.")
            End Select
        End If

    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        MessageBox.ClearMessage()
        Dim bvin As String = CStr(GridView1.DataKeys(e.NewEditIndex).Value)
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(bvin)
        Me.UserNameField.Text = u.UserName
        ValidateUser()
        Me.pnlUserBrowser.Visible = False
    End Sub

    Protected Sub btnValidateUser_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnValidateUser.Click
        MessageBox.ClearMessage()
        ValidateUser()
    End Sub

    Private Sub ValidateUser()
        Dim u As Membership.UserAccount = Membership.UserAccount.FindByUserName(Me.UserNameField.Text.Trim)
        If u IsNot Nothing Then
            If u.Bvin <> String.Empty Then
                Dim args As New Controls.UserSelectedEventArgs()
                args.UserAccount = u
                RaiseEvent UserSelected(args)                
            Else
                MessageBox.ShowWarning("User account " & Me.UserNameField.Text.Trim & " wasn't found. Please try again or create a new account.")
            End If
        End If        
    End Sub
End Class

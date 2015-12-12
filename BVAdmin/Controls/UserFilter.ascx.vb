Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Controls_UserFilter
    Inherits System.Web.UI.UserControl

    Public Event FilterChanged(ByVal criteria As Membership.UserSearchCriteria)
    Public Event GoPressed(ByVal criteria As Membership.UserSearchCriteria)

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Not Page.IsPostBack Then
            PopulateFilterFields()
        End If
    End Sub

    Public Overrides Sub Focus()
        Me.FirstNameTextBox.Focus()
    End Sub

    Public Function LoadUsers() As Membership.UserSearchCriteria

        Dim c As New Membership.UserSearchCriteria

        If Me.FirstNameTextBox.Text.Trim.Length > 0 Then
            c.FirstName = Me.FirstNameTextBox.Text.Trim
        End If
        If Me.LastNameTextBox.Text.Trim.Length > 0 Then
            c.LastName = Me.LastNameTextBox.Text.Trim
        End If
        If Me.UserNameTextBox.Text.Trim.Length > 0 Then
            c.Username = Me.UserNameTextBox.Text.Trim
        End If
        If Me.EmailTextBox.Text.Trim.Length > 0 Then
            c.Email = Me.EmailTextBox.Text.Trim
        End If

        ' Save Setting to Session        
        SessionManager.AdminUserSearchCriteriaFirstName = Me.FirstNameTextBox.Text.Trim
        SessionManager.AdminUserSearchCriteriaLastName = Me.LastNameTextBox.Text.Trim
        SessionManager.AdminUserSearchCriteriaUserName = Me.UserNameTextBox.Text.Trim
        SessionManager.AdminUserSearchCriteriaEmail = Me.EmailTextBox.Text.Trim

        Return c
    End Function

    Private Sub PopulateFilterFields()

        ' Save Setting to Session        
        Me.FirstNameTextBox.Text = SessionManager.AdminUserSearchCriteriaFirstName
        Me.LastNameTextBox.Text = SessionManager.AdminUserSearchCriteriaLastName
        Me.UserNameTextBox.Text = SessionManager.AdminUserSearchCriteriaUserName
        Me.EmailTextBox.Text = SessionManager.AdminUserSearchCriteriaEmail
    End Sub

    Protected Sub btnGo_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGo.Click
        RaiseEvent GoPressed(Me.LoadUsers())
        Me.FirstNameTextBox.Focus()
    End Sub
End Class

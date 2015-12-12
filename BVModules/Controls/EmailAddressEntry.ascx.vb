Imports BVSoftware.BVC5.Core

Partial Class BVModules_Controls_EmailAddressEntry
    Inherits System.Web.UI.UserControl

    Private _tabIndex As Integer = -1
    Public Property TabIndex() As Integer
        Get
            Return _tabIndex
        End Get
        Set(ByVal value As Integer)
            _tabIndex = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If SessionManager.IsUserAuthenticated Then
            Me.Visible = False
        Else
            Me.Visible = True
            If WebAppSettings.ForceEmailAddressOnAnonymousCheckout Then
                EmailAddressRequiredFieldValidator.Enabled = True
            Else
                EmailAddressRequiredFieldValidator.Enabled = False
            End If
            If Me.TabIndex <> -1 Then
                EmailTextBox.TabIndex = Me.TabIndex
            End If
        End If
    End Sub

    Public Function GetUserEmail() As String
        Return Me.EmailTextBox.Text
    End Function
End Class

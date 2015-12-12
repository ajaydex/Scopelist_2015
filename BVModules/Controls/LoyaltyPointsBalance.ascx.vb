Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_LoyaltyPointsBalance
    Inherits System.Web.UI.UserControl

    Private _DisplayAsCurrency As Boolean = False

#Region " Properties "

    Public Property DisplayAsCurrency() As Boolean
        Get
            Return Me._DisplayAsCurrency
        End Get
        Set(value As Boolean)
            Me._DisplayAsCurrency = value
        End Set
    End Property

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If WebAppSettings.LoyaltyPointsEnabled Then
            If Not Page.IsPostBack Then
                Dim points = Membership.LoyaltyPoints.GetAvailablePointsForUser(SessionManager.GetCurrentUserId())

                If Me.DisplayAsCurrency Then
                    Me.lblLoyaltyPointsBalance.Text = Membership.LoyaltyPoints.CalculateCurrencyEquivalent(points).ToString("c")
                Else
                    Me.lblLoyaltyPointsBalance.Text = points.ToString("n0")
                End If
            End If
        Else
            Me.Visible = False
        End If
    End Sub

End Class
Imports System.Collections.ObjectModel
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_People_users_edit_loyaltypoints
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.ddlPointsOrCurrency.Items.FindByValue("1").Text = String.Format(Me.ddlPointsOrCurrency.Items.FindByValue("1").Text, WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol)
            LoadUser()

            If WebAppSettings.LoyaltyPointsExpire Then
                Me.chkLoyaltyPointsExpire.Checked = True
                Me.txtLoyaltyPointsExpireDays.Text = WebAppSettings.LoyaltyPointsExpireDays.ToString()
            End If
        End If

        Me.rfvLoyaltyPointsExpireDays.Enabled = Me.chkLoyaltyPointsExpire.Checked
        Me.cvLoyaltyPointsExpireDaysMinimum.Enabled = Me.chkLoyaltyPointsExpire.Checked
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Adjust Loyalty Points"
        Me.CurrentTab = AdminTabType.Plugins
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsEdit)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        Me.rfvLoyaltyPointsExpireDays.Enabled = Me.chkLoyaltyPointsExpire.Checked   ' prevents server-side validator from firing where appropriate

        Page.Validate()
        If Page.IsValid Then
            If Not String.IsNullOrEmpty(Me.BvinField.Value) Then
                Dim pointsTransaction As Membership.LoyaltyPointsTransaction = Membership.LoyaltyPoints.CreditPoints(Me.BvinField.Value, Me.GetPoints())
                If Not String.IsNullOrEmpty(pointsTransaction.Bvin) Then
                    ' update expiration information if different than default settings
                    If WebAppSettings.LoyaltyPointsExpire <> Me.chkLoyaltyPointsExpire.Checked Then
                        pointsTransaction.Expires = Me.chkLoyaltyPointsExpire.Checked
                        If pointsTransaction.Expires Then
                            pointsTransaction.ExpirationDate = DateTime.Now.AddDays(Convert.ToDouble(Me.txtLoyaltyPointsExpireDays.Text))
                        Else
                            pointsTransaction.ExpirationDate = System.Data.SqlTypes.SqlDateTime.MaxValue.Value
                        End If

                        Membership.LoyaltyPointsTransaction.Update(pointsTransaction)
                    End If

                    ' close pop-up window and return to user account edit page
                    Page.ClientScript.RegisterClientScriptBlock(Me.GetType(), "popup", "<script type=""text/javascript"">if (window.opener && !window.opener.closed) window.opener.location.reload(); window.close();</script>")
                Else
                    Me.ucMessageBox.ShowError("Unable to save points adjustment!")
                End If
            Else
                Me.ucMessageBox.ShowError("Unable to find user account - points adjustment failed")
            End If

        End If
    End Sub

    Private Sub LoadUser()
        Dim userId As String = Request.QueryString("id")
        If Not String.IsNullOrEmpty(userId) Then
            Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(userId)
            If Not String.IsNullOrEmpty(u.Bvin) Then
                Me.BvinField.Value = u.Bvin

                Me.lblName.Text = String.Format("{0} {1}", u.FirstName, u.LastName)
                Me.lblUserName.Text = u.UserName
                Me.lblEmail.Text = u.Email

                Dim points As Integer = Membership.LoyaltyPoints.GetAvailablePointsForUser(u.Bvin)
                Me.lblLoyaltyPoints.Text = String.Format("{0} ({1:c})", points, Membership.LoyaltyPoints.CalculateCurrencyEquivalent(points))
            End If
        End If
    End Sub

    Private Function GetPoints() As Integer
        Dim result As Integer = 0
        Dim adjustment As Decimal = Convert.ToDecimal(Me.ddlPostiveOrNegative.SelectedValue) * Convert.ToDecimal(Me.txtPointsAdjustment.Text)

        If Me.ddlPointsOrCurrency.SelectedValue = "0" Then
            ' points
            result = Convert.ToInt32(adjustment)
        Else
            ' currency
            result = Membership.LoyaltyPoints.CalculatePointsEquivalent(adjustment)
        End If

        Return result
    End Function

End Class
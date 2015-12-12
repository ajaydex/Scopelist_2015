Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_People_Affiliates
    Inherits BaseAdminPage

    Private Const DisplayDisabledText As String = "Display Only Disabled"
    Private Const DisplayAllText As String = "Display All"

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Affiliates"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            GridView1.PageSize = WebAppSettings.RowsPerPage
            LoadAffiliates()
            Me.FilterField.Focus()

            LoadDisableFilter()            
        End If
    End Sub

    Private Sub LoadAffiliates()
        Me.GridView1.DataBind()
    End Sub

    Protected Sub btnGo_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGo.Click
        LoadAffiliates()
        Me.FilterField.Focus()
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.PeopleEdit) = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
            Contacts.Affiliate.Delete(bvin)
        End If
        LoadAffiliates()
        e.Cancel = True
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("Affiliates_edit.aspx?id=" & bvin)
    End Sub


    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "Enable" Then
            Dim affiliate As Contacts.Affiliate = Contacts.Affiliate.FindByBvin(e.CommandArgument)
            If affiliate IsNot Nothing Then
                If affiliate.Bvin <> String.Empty Then
                    affiliate.Enabled = True
                    Contacts.Affiliate.Update(affiliate)
                    LoadAffiliates()
                End If
            End If            
        ElseIf e.CommandName = "Disable" Then
            Dim affiliate As Contacts.Affiliate = Contacts.Affiliate.FindByBvin(e.CommandArgument)
            If affiliate IsNot Nothing Then
                If affiliate.Bvin <> String.Empty Then
                    affiliate.Enabled = False
                    Contacts.Affiliate.Update(affiliate)
                    LoadAffiliates()
                End If
            End If
        End If
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.DataItem IsNot Nothing Then
            Dim affiliate As Contacts.Affiliate = DirectCast(e.Row.DataItem, Contacts.Affiliate)
            If affiliate.Enabled Then
                DirectCast(e.Row.FindControl("EnableLinkButton"), LinkButton).Text = "Disable"
                DirectCast(e.Row.FindControl("EnableLinkButton"), LinkButton).CommandName = "Disable"
                DirectCast(e.Row.FindControl("EnableLinkButton"), LinkButton).CommandArgument = affiliate.Bvin
            Else
                DirectCast(e.Row.FindControl("EnableLinkButton"), LinkButton).Text = "Enable"
                DirectCast(e.Row.FindControl("EnableLinkButton"), LinkButton).CommandName = "Enable"
                DirectCast(e.Row.FindControl("EnableLinkButton"), LinkButton).CommandArgument = affiliate.Bvin
            End If
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource1.Selecting, ObjectDataSource2.Selecting
        If e.ExecutingSelectCount Then
            e.InputParameters("rowCount") = HttpContext.Current.Items("RowCount")
            Dim count As Integer = CInt(HttpContext.Current.Items("RowCount"))
            If count = 1 Then
                Me.lblResults.Text = count & " affiliate found"
            Else
                Me.lblResults.Text = count & " affiliates found"
            End If
            HttpContext.Current.Items("RowCount") = Nothing
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected, ObjectDataSource2.Selected
        If e.OutputParameters("RowCount") IsNot Nothing Then
            HttpContext.Current.Items("RowCount") = e.OutputParameters("RowCount")
        End If
    End Sub

    Protected Sub DisabledLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles DisabledLinkButton.Click
        LoadDisableFilter()        
    End Sub

    Private Sub LoadDisableFilter()
        If Session("DisplayOnlyDisabled") <> String.Empty Then
            Session("DisplayOnlyDisabled") = String.Empty
            GridView1.DataSourceID = "ObjectDataSource1"
            LoadAffiliates()
            DisabledLinkButton.Text = DisplayDisabledText
        Else
            Session("DisplayOnlyDisabled") = "#DISABLED#"
            GridView1.DataSourceID = "ObjectDataSource2"
            LoadAffiliates()
            DisabledLinkButton.Text = DisplayAllText
        End If
    End Sub
End Class

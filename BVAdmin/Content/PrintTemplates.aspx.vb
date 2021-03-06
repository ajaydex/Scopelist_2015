Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Content_PrintTemplates
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Print Templates"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadTemplates()
        End If
    End Sub

    Private Sub LoadTemplates()
        Dim templates As Collection(Of Content.PrintTemplate)
        templates = Content.PrintTemplate.FindAll
        Me.GridView1.DataSource = templates
        Me.GridView1.DataBind()
        Me.lblResults.Text = templates.Count & " Templates Found"
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        msg.ClearMessage()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
            Dim p As Content.PrintTemplate = Content.PrintTemplate.FindByBvin(bvin)
            If p.SystemTemplate = True Then
                Me.msg.ShowWarning("System templates can not be deleted.")
            Else
                If Content.PrintTemplate.Delete(bvin) = False Then
                    Me.msg.ShowWarning("Unable to delete this template.")
                End If
            End If
        End If
        LoadTemplates()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        msg.ClearMessage()
        Response.Redirect("PrintTemplates_Edit.aspx")
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("PrintTemplates_Edit.aspx?id=" & bvin)
    End Sub

End Class

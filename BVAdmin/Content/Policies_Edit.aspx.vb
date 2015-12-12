Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVAdmin_Content_Policies_Edit
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Policy"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString("id") IsNot Nothing Then
                Me.PolicyIDField.Value = Request.QueryString("id")
            End If
            LoadPolicy()
        End If
    End Sub

    Private Sub LoadPolicy()
        Dim p As Content.Policy = Content.Policy.FindByBvin(Me.PolicyIDField.Value)
        Me.lblTitle.Text = p.Title
        Me.GridView1.DataSource = p.Blocks
        Me.GridView1.DataBind()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Response.Redirect("Policies_EditBlock.aspx?policyId=" & Server.UrlEncode(Me.PolicyIDField.Value))
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        Me.msg.ClearMessage()
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        Content.PolicyBlock.MoveDown(bvin, Me.PolicyIDField.Value)
        LoadPolicy()
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Me.msg.ClearMessage()
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        Content.PolicyBlock.MoveUp(bvin, Me.PolicyIDField.Value)
        LoadPolicy()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim b As Content.PolicyBlock = CType(e.Row.DataItem, Content.PolicyBlock)

            If b IsNot Nothing Then
                Dim lblBlockName As Label = e.Row.FindControl("lblBlockName")
                Dim lblBlockDescription As Label = e.Row.FindControl("lblBlockDescription")

                If lblBlockName IsNot Nothing Then
                    lblBlockName.Text = b.Name
                End If

                If lblBlockDescription IsNot Nothing Then
                    lblBlockDescription.Text = b.Description
                End If
            End If

        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Me.msg.ClearMessage()
        Dim bvin As String = String.Empty
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        Content.PolicyBlock.Delete(bvin)
        LoadPolicy()
    End Sub

    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOk.Click
        Response.Redirect("Policies.aspx")
    End Sub

  

End Class

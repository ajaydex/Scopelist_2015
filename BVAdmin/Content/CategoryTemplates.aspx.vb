Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Content_PrintTemplates
    Inherits BaseAdminPage

    Private templates As StringCollection
    Private templateEditors As StringCollection

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Category Templates"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadTemplates()
        End If
    End Sub

    Private Sub LoadTemplates()
        templates = Content.ModuleController.FindCategoryTemplates()
        templateEditors = Content.ModuleController.FindCategoryTemplateEditors()

        Me.GridView1.DataSource = templates
        Me.GridView1.DataBind()
        Me.lblResults.Text = templates.Count & " Templates Found"
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim val As String = DirectCast(e.Row.DataItem, String)
            DirectCast(e.Row.FindControl("TemplateNameLabel"), Label).Text = val
            Dim EditLinkButton As LinkButton = DirectCast(e.Row.FindControl("EditLinkButton"), LinkButton)
            If templateEditors.Contains(val) Then
                EditLinkButton.Visible = True
                EditLinkButton.CommandArgument = val
            Else
                EditLinkButton.Visible = False
                EditLinkButton.CommandArgument = ""
            End If
        End If
    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "Edit" Then
            Response.Redirect("CategoryTemplatesEdit.aspx?template=" & HttpUtility.UrlEncode(e.CommandArgument))
        End If
    End Sub
End Class

Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Content_PrintTemplates
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Category Templates Edit"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString("template") Is Nothing Then                
                Response.Redirect("CategoryTemplates.aspx")
            Else
                ViewState("template") = Request.QueryString("template")
            End If
        End If
        LoadCategoryTemplate()
    End Sub

    Private Sub LoadCategoryTemplate()
        Dim categoryTemplateEditor As Content.CategoryEditorTemplate = Content.ModuleController.LoadCategoryEditor(ViewState("template"), Me)
        categoryTemplateEditor.ID = "ChoiceEditControl1"
        AddHandler categoryTemplateEditor.EditingComplete, AddressOf FinishedEditing
        CategoryEditorPanel.Controls.Add(categoryTemplateEditor)
    End Sub

    Protected Sub FinishedEditing(ByVal sender As Object, ByVal e As Content.BVModuleEventArgs)
        Response.Redirect("CategoryTemplates.aspx")
    End Sub
End Class

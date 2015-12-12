Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.IO

Partial Class BVAdmin_Content_Columns_Edit
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Content Column"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)        
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            PopulateAdvancedOptions()
            If Request.QueryString("id") IsNot Nothing Then
                ContentColumnEditor.ColumnId = Request.QueryString("id")
            End If
        End If
    End Sub

    Private Sub PopulateAdvancedOptions()
        Me.CopyToList.DataSource = Content.ContentColumn.FindAll
        Me.CopyToList.DataTextField = "DisplayName"
        Me.CopyToList.DataValueField = "bvin"
        Me.CopyToList.DataBind()
    End Sub

    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnOk.Click        
        Response.Redirect("Columns.aspx")
    End Sub

    Protected Sub btnCopyBlocks_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCopyBlocks.Click
        Me.msg.ClearMessage()

        Dim c As Content.ContentColumn = Content.ContentColumn.FindByBvin(ContentColumnEditor.ColumnId)
        If c IsNot Nothing Then
            If c.CopyAllBlocksTo(Me.CopyToList.SelectedValue) = True Then
                Me.msg.ShowOk("Column Copied")
            Else
                Me.msg.ShowError("Copy failed. Unknown Error.")
            End If
        Else
            Me.msg.ShowError("Copy failed. Unknown Error.")
        End If
        ContentColumnEditor.LoadColumn()
    End Sub

    Protected Sub btnClone_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnClone.Click
        Me.msg.ClearMessage()

        If Me.CloneNameField.Text.Trim.Length < 1 Then
            msg.ShowWarning("Please enter a name first.")
        Else
            Dim c As Content.ContentColumn = Content.ContentColumn.FindByBvin(ContentColumnEditor.ColumnId)
            If c IsNot Nothing Then
                If c.Clone(Me.CloneNameField.Text.Trim) = True Then
                    Me.msg.ShowOk("Column Copied")
                Else
                    Me.msg.ShowError("Copy failed. Unknown Error.")
                End If
            Else
                Me.msg.ShowError("Copy failed. Unknown Error.")
            End If
        End If
        ContentColumnEditor.LoadColumn()
    End Sub
End Class

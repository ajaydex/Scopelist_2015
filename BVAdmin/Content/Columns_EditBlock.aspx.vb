Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Content_Columns_EditBlock
    Inherits BaseAdminPage

    Private b As Content.ContentBlock
    Private WithEvents editor As Content.BVModule

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Request.QueryString("id") IsNot Nothing Then
            Me.BlockIDField.Value = Request.QueryString("id")
        End If
        b = Content.ContentBlock.FindByBvin(Me.BlockIDField.Value)
        LoadEditor()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            PopulateAdvancedOptions()
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Content Block"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Private Sub PopulateAdvancedOptions()
        Dim columns As Collection(Of Content.ContentColumn) = Content.ContentColumn.FindAll

        Me.CopyToList.DataSource = columns
        Me.CopyToList.DataTextField = "DisplayName"
        Me.CopyToList.DataValueField = "bvin"
        Me.CopyToList.DataBind()

        Me.MoveToList.DataSource = columns
        Me.MoveToList.DataTextField = "DisplayName"
        Me.MoveToList.DataValueField = "bvin"
        Me.MoveToList.DataBind()

    End Sub

    Private Sub LoadEditor()
        Dim tempControl As System.Web.UI.Control = Content.ModuleController.LoadContentBlockEditor(b.ControlName, Me)

        If TypeOf tempControl Is Content.BVModule Then
            editor = CType(tempControl, Content.BVModule)
            If Not editor Is Nothing Then
                editor.BlockId = b.Bvin
                Me.TitleLabel.Text = "Edit Block - " & b.ControlName
                Me.phEditor.Controls.Add(editor)
            End If
        Else
            Me.phEditor.Controls.Add(New LiteralControl("Error, editor is not based on Content.BVModule class"))
        End If
    End Sub

    Protected Sub editor_EditingComplete(ByVal sender As Object, ByVal e As BVSoftware.Bvc5.Core.Content.BVModuleEventArgs) Handles editor.EditingComplete
        Response.Redirect("Columns_Edit.aspx?id=" & b.ColumnId)
    End Sub

    Protected Sub btnGoCopy_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGoCopy.Click
        Me.msg.ClearMessage()
        If b.CopyToColumn(CopyToList.SelectedValue) = True Then
            Me.msg.ShowOk("Block Copied")
        Else
            Me.msg.ShowError("Copy failed. Unknown Error.")
        End If
    End Sub

    Protected Sub btnGoMove_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGoMove.Click
        Me.msg.ClearMessage()
        If b.MoveToColumn(MoveToList.SelectedValue) = True Then
            Me.msg.ShowOk("Block Moved")
        Else
            Me.msg.ShowError("Move failed. Unknown Error.")
        End If
    End Sub

End Class

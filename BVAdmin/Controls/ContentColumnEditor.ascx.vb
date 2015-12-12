Imports BVSoftware.BVC5.Core

Partial Class BVAdmin_Controls_ContentColumnEditor
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadBlockList()
            LoadColumn()
        End If
    End Sub

    Public Property ColumnId() As String
        Get
            Dim obj As Object = ViewState("ColumnId")
            If obj IsNot Nothing Then
                Return CStr(obj)
            Else
                Return ""
            End If
        End Get
        Set(ByVal value As String)
            ViewState("ColumnId") = value
        End Set
    End Property

    Private Sub LoadBlockList()
        Me.lstBlocks.DataSource = Content.ModuleController.FindContentBlocks
        Me.lstBlocks.DataBind()
    End Sub

    Public Sub LoadColumn()
        Dim c As Content.ContentColumn = Content.ContentColumn.FindByBvin(Me.ColumnId)
        Me.lblTitle.Text = c.DisplayName
        Me.GridView1.DataSource = c.Blocks
        Me.GridView1.DataBind()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click        

        Dim b As New Content.ContentBlock
        b.ControlName = Me.lstBlocks.SelectedValue
        b.ColumnId = Me.ColumnId
        Content.ContentBlock.Insert(b)
        LoadColumn()
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        Dim bvin As String = String.Empty
        Me.GridView1.UpdateAfterCallBack = True
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        Content.ContentBlock.MoveDown(bvin, Me.ColumnId)
        LoadColumn()
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Dim bvin As String = String.Empty
        Me.GridView1.UpdateAfterCallBack = True
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        Content.ContentBlock.MoveUp(bvin, Me.ColumnId)
        LoadColumn()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim b As Content.ContentBlock = CType(e.Row.DataItem, Content.ContentBlock)

            Dim controlFound As Boolean = False

            Dim viewControl As System.Web.UI.Control

            viewControl = Content.ModuleController.LoadContentBlockAdminView(b.ControlName, Me.Page)
            If viewControl Is Nothing Then
                'No admin view, try standard view
                viewControl = Content.ModuleController.LoadContentBlock(b.ControlName, Me.Page)
            End If


            If viewControl IsNot Nothing Then
                If TypeOf viewControl Is Content.BVModule Then
                    CType(viewControl, Content.BVModule).BlockId = b.Bvin
                    controlFound = True
                    e.Row.Cells(0).Controls.Add(viewControl)
                End If
            End If

            If controlFound = True Then
                ' Check for Editor
                Dim lnkEdit As HyperLink = e.Row.FindControl("lnkEdit")
                If lnkEdit IsNot Nothing Then
                    lnkEdit.Visible = EditorExists(b.ControlName)
                End If
            Else
                e.Row.Cells(0).Controls.Add(New LiteralControl("Control " & b.ControlName & "could not be located"))
            End If
        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim bvin As String = String.Empty
        Me.GridView1.UpdateAfterCallBack = True
        bvin = CType(sender, GridView).DataKeys(e.RowIndex).Value.ToString
        Content.ContentBlock.Delete(bvin)
        LoadColumn()
    End Sub

    Private Function EditorExists(ByVal controlName As String) As Boolean
        Dim result As Boolean = False
        Dim editorControl As System.Web.UI.Control
        editorControl = Content.ModuleController.LoadContentBlockEditor(controlName, Me.Page)
        If editorControl IsNot Nothing Then
            If TypeOf editorControl Is Content.BVModule Then
                result = True
            End If
        End If
        Return result
    End Function
End Class

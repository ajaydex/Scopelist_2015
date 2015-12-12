Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.IO

Partial Class BVModules_Controls_ContentColumnControl
    Inherits System.Web.UI.UserControl

    Private _ColumnID As String = String.Empty
    Private _ColumnName As String = String.Empty

    Public Property ColumnID() As String
        Get
            Return _ColumnID
        End Get
        Set(ByVal value As String)
            _ColumnID = value
        End Set
    End Property
    Public Property ColumnName() As String
        Get
            Return _ColumnName
        End Get
        Set(ByVal value As String)
            _ColumnName = value
        End Set
    End Property

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        LoadColumn()
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub

    Public Sub LoadColumn()
        Me.phColumn.Controls.Clear()

        Dim c As New Content.ContentColumn

        If _ColumnID <> String.Empty Then
            c = Content.ContentColumn.FindByBvin(_ColumnID)
        Else
            c = Content.ContentColumn.FindByDisplayName(_ColumnName)
        End If

        If c IsNot Nothing Then
            If c.Blocks.Count > 0 Then
                For i As Integer = 0 To c.Blocks.Count - 1
                    LoadContentBlock(c.Blocks(i))
                Next
                Me.Visible = True

                ' edit link
                Dim userId = SessionManager.GetCurrentUserId()
                If Not String.IsNullOrEmpty(userId) AndAlso Membership.UserAccount.DoesUserHaveAllPermissions(userId, New Collection(Of String)(New String() {Membership.SystemPermissions.ContentView})) Then
                    Dim lnkEdit As New HyperLink()
                    lnkEdit.Text = "Edit"
                    lnkEdit.ToolTip = c.DisplayName
                    lnkEdit.NavigateUrl = "~/BVAdmin/Content/Columns_Edit.aspx?id=" + c.Bvin
                    lnkEdit.CssClass = "customButton"
                    lnkEdit.Target = If(WebAppSettings.StoreAdminLinksInNewWindow, "_blank", "")
                    Me.phColumn.Controls.Add(lnkEdit)
                End If
            Else
                Me.Visible = False  ' hide empty Content Columns
            End If
        End If
    End Sub

    Private Sub LoadContentBlock(ByVal b As Content.ContentBlock)
        Dim plugin As System.Web.UI.Control = Content.ModuleController.LoadContentBlock(b.ControlName, Me.Page)
        If plugin IsNot Nothing Then
            If TypeOf plugin Is Content.BVModule Then
                CType(plugin, Content.BVModule).BlockId = b.Bvin
                Me.phColumn.Controls.Add(plugin)
            End If
        End If
    End Sub

End Class

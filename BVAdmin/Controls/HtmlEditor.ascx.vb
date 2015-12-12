Imports BVSoftware.Bvc5.Core
Imports System.IO

Partial Class BVAdmin_Controls_HtmlEditor
    Inherits System.Web.UI.UserControl

    Private _Editor As Content.TextEditorBase = Nothing

    Public Property Text() As String
        Get
            Return _Editor.Text
        End Get
        Set(ByVal value As String)
            _Editor.Text = value
        End Set
    End Property
    Public Property PreTransformText() As String
        Get
            Return _Editor.PreTransformText
        End Get
        Set(ByVal value As String)
            _Editor.PreTransformText = value
        End Set
    End Property
    Public ReadOnly Property SupportsTransform() As Boolean
        Get
            Return _Editor.SupportsTransform
        End Get
    End Property
    Public Property EditorWidth() As Integer
        Get
            Return Me.WidthField.Value
        End Get
        Set(ByVal value As Integer)
            Me.WidthField.Value = value
        End Set
    End Property
    Public Property EditorHeight() As Integer
        Get
            Return Me.HeightField.Value
        End Get
        Set(ByVal value As Integer)
            Me.HeightField.Value = value
        End Set
    End Property
    Public Property EditorWrap() As Boolean
        Get
            If Me.WrapField.Value = 1 Then
                Return True
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            If value = True Then
                Me.WrapField.Value = 1
            Else
                Me.WrapField.Value = 0
            End If
        End Set
    End Property

    Public Property TabIndex() As Integer
        Get
            Dim obj As Object = ViewState("TabIndex")
            If obj IsNot Nothing Then
                Return CInt(obj)
            Else
                Return -1
            End If
        End Get
        Set(ByVal value As Integer)
            ViewState("TabIndex") = value
        End Set
    End Property

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        _Editor = Content.ModuleController.LoadDefaultEditor(Me.Page)
        Me.phEditor.Controls.Add(_Editor)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            _Editor.EditorHeight = Me.EditorHeight
            _Editor.EditorWidth = Me.EditorWidth
            _Editor.EditorWrap = Me.EditorWrap
            If Me.TabIndex <> -1 Then
                _Editor.TabIndex = Me.TabIndex
            End If
        End If

    End Sub

End Class

Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Editors_None_editor
    Inherits Content.TextEditorBase


    Public Overrides Property EditorHeight() As Integer
        Get
            Return Me.EditorField.Height.Value
        End Get
        Set(ByVal value As Integer)
            Me.EditorField.Height = UI.WebControls.Unit.Pixel(value)
        End Set
    End Property

    Public Overrides Property EditorWidth() As Integer
        Get
            Return Me.EditorField.Width.Value
        End Get
        Set(ByVal value As Integer)
            Me.EditorField.Width = UI.WebControls.Unit.Pixel(value)
        End Set
    End Property

    Public Overrides Property EditorWrap() As Boolean
        Get
            Return Me.EditorField.Wrap
        End Get
        Set(ByVal value As Boolean)
            Me.EditorField.Wrap = value
        End Set
    End Property

    Public Overrides Property PreTransformText() As String
        Get
            Return Me.EditorField.Text
        End Get
        Set(ByVal value As String)
            Me.EditorField.Text = value
        End Set
    End Property

    Public Overrides ReadOnly Property SupportsTransform() As Boolean
        Get
            Return False
        End Get
    End Property

    Public Overrides Property TabIndex() As Integer
        Get
            Return Me.EditorField.TabIndex
        End Get
        Set(ByVal value As Integer)
            Me.EditorField.TabIndex = value
        End Set
    End Property

    Public Overrides Property Text() As String
        Get
            Return Me.EditorField.Text
        End Get
        Set(ByVal value As String)
            Me.EditorField.Text = value
        End Set
    End Property

End Class

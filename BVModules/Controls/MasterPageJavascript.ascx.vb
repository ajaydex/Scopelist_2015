
Partial Class BVModules_Controls_MasterPageJavascript
    Inherits System.Web.UI.UserControl

    Private _Src As String = String.Empty
    Public Property Src() As String
        Get
            Return _Src
        End Get
        Set(ByVal value As String)
            _Src = value
        End Set
    End Property

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        RenderTag()
    End Sub

    Private Sub RenderTag()
        Dim tag As String = "<script type=""text/javascript"" src=""" & Page.ResolveClientUrl(_Src) & """ language=""javascript""></script>"
        Me.litMain.Text = tag
    End Sub

End Class

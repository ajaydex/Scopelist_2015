Imports BVSoftware.Bvc5.Core.Controls

Partial Class BVAdmin_Controls_ProductDisplayType
    Inherits System.Web.UI.UserControl

#Region " Properties "

    Public Property DisplayMode() As ProductDisplayType
        Get
            Return CType(Me.rblProductDisplayMode.SelectedIndex, ProductDisplayType)
        End Get
        Set(ByVal value As ProductDisplayType)
            Me.rblProductDisplayMode.SelectedIndex = CType(value, ProductDisplayType)
        End Set
    End Property

    Public Property Columns() As Integer
        Get
            Return CType(Me.txtColumns.Text, Integer)
        End Get
        Set(ByVal value As Integer)
            Me.txtColumns.Text = value.ToString()
        End Set
    End Property

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.rblProductDisplayMode.AutoPostBack = True
            rblProductDisplayMode_Selected(Nothing, Nothing)
        End If
    End Sub

    Protected Sub rblProductDisplayMode_Selected(ByVal sender As Object, ByVal e As EventArgs) Handles rblProductDisplayMode.SelectedIndexChanged
        If Me.rblProductDisplayMode.SelectedIndex = CType(ProductDisplayType.Grid, Integer) Then
            phColumns.Visible = True
        Else
            phColumns.Visible = False
        End If
    End Sub


End Class
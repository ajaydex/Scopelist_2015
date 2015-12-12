Imports BVSoftware.BVC5.Core

Partial Class BVModules_Controls_CategoryDisplay
    Inherits System.Web.UI.UserControl

    Public Enum CategoryDisplayType
        Grid
        List
    End Enum

    Private _DisplayType As CategoryDisplayType = CategoryDisplayType.Grid

#Region " Properties "

    Public Property DispayType As CategoryDisplayType
        Get
            Return Me._DisplayType
        End Get
        Set(value As CategoryDisplayType)
            Me._DisplayType = value
        End Set
    End Property

#End Region

    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)

        Me.EnableViewState = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
    End Sub

    Public Function IsGridView() As Boolean
        Return (Me.DispayType = CategoryDisplayType.Grid)
    End Function

    Public Function IsListView() As Boolean
        Return (Me.DispayType = CategoryDisplayType.List)
    End Function

End Class
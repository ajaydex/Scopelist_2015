Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Public MustInherit Class BaseProductAdminPage
    Inherits BaseAdminPage

    Protected WithEvents _ProductNavigator As New Content.NotifyClickControl

    Protected MustOverride Function Save() As Boolean

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        PopulateMenuControl()
    End Sub

    Private Sub PopulateMenuControl()
        Dim c As System.Web.UI.Control = Page.Master.FindControl("ProductNavigator")
        If c IsNot Nothing Then
            Me._ProductNavigator = CType(c, Content.NotifyClickControl)
        End If
    End Sub

    Protected Sub _ProductNavigator_Clicked(ByVal sender As Object, ByVal e As BVSoftware.Bvc5.Core.Content.NotifyClickControl.ClickedEventArgs) Handles _ProductNavigator.Clicked
        If Not Me.Save() Then
            e.ErrorOccurred = True
        End If
    End Sub
End Class

Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Side_Menu_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadMenu()
    End Sub

    Private Sub LoadMenu()

        Me.TitlePlaceHolder.Controls.Clear()
        Dim title As String = SettingsManager.GetSetting("Title")
        If title.Trim.Length > 0 Then
            Me.TitlePlaceHolder.Controls.Add(New LiteralControl("<h4>" & title & "</h4>"))
        End If

        Me.MenuControl.Controls.Clear()
        MenuControl.EnableViewState = False
        Dim links As Collection(Of Content.ComponentSettingListItem)
        links = SettingsManager.GetSettingList("Links")
        If links IsNot Nothing Then
            Me.MenuControl.Controls.Add(New LiteralControl("<ul class=""side-nav"">"))
            For Each l As Content.ComponentSettingListItem In links
                AddSingleLink(l)
            Next
            Me.MenuControl.Controls.Add(New LiteralControl("</ul>"))
        End If
    End Sub

    Private Sub AddSingleLink(ByVal l As Content.ComponentSettingListItem)
        Me.MenuControl.Controls.Add(New LiteralControl("<li>"))
        Dim m As New HyperLink
        m.ToolTip = l.Setting4
        m.Text = l.Setting1
        m.NavigateUrl = l.Setting2
        If l.Setting3 = "1" Then
            m.Target = "_blank"
        End If
        m.EnableViewState = False
        Me.MenuControl.Controls.Add(m)
        Me.MenuControl.Controls.Add(New LiteralControl("</li>"))
    End Sub


End Class

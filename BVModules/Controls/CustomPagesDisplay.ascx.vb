Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_CustomPagesDisplay
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim pages As Collection(Of Content.CustomPage) = Content.CustomPage.FindByShowInBottomMenu()
        If pages.Count > 0 Then
            CustomPageRepeater.DataSource = pages
            CustomPageRepeater.DataBind()
            Me.Visible = True
        Else
            Me.Visible = False
        End If        
    End Sub

    Protected Sub CustomPageRepeater_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles CustomPageRepeater.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim customPageLink As HtmlAnchor = DirectCast(e.Item.FindControl("CustomPageLink"), HtmlAnchor)
            Dim customPage As Content.CustomPage = DirectCast(e.Item.DataItem, Content.CustomPage)
            customPageLink.InnerText = customPage.MenuName
            customPageLink.HRef = Utilities.UrlRewriter.BuildUrlForCustomPage(customPage, Me.Page)
        End If
    End Sub
End Class

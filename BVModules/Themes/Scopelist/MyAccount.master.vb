Imports System.IO
Imports System.Data
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel


Partial Class BVModules_Themes_OpticAuthority_MyAccount
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '    Me.ManualBreadCrumbTrail1.ClearTrail()
        '    Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("Home"), "~")
        '    Me.ManualBreadCrumbTrail1.AddLink(Content.SiteTerms.GetTerm("MyAccount"), "~/MyAccount_Orders.aspx")
        '    Me.ManualBreadCrumbTrail1.AddNonLink(Content.SiteTerms.GetTerm("OrderHistory"))
        Dim liMyAccount As HtmlControl = DirectCast(Header1.FindControl("liMyAccount"), HtmlControl)
        ' liMyAccount.Attributes.Add("class", "current_page_item")
    End Sub


End Class


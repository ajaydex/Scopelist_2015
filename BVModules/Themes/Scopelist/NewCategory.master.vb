Imports System.IO
Imports System.Data
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel


Partial Class BVModules_Themes_Scopelist_Category
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If BVSoftware.Bvc5.Core.Content.SiteTerms.GetTerm("PagesToExcludeInnerBanner").ToLower().Contains(Request.RawUrl.ToLower()) Then
            Me.dvBanner.InnerHtml = "<div></div>"
            Me.dvBanner.Attributes.Add("style", "display:none;")
        End If
    End Sub
End Class


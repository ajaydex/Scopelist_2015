Imports BVSoftware.Bvc5.Core.PersonalizationServices
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_Pages_SiteMap
    Inherits BaseStorePage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        LoadAllCategories()
        LoadAllCustomPages()
        If SessionManager.IsUserAuthenticated Then
            Dim affiliates As Collection(Of Contacts.Affiliate) = Contacts.Affiliate.FindEnabledByUserId(SessionManager.GetCurrentUserId)
            If affiliates.Count > 0 Then
                affiliateReportli.Visible = True
            Else
                affiliateReportli.Visible = False
            End If
        Else
            MyAccountDiv.Visible = False
            affiliateReportli.Visible = False
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Default.master")
        Me.PageTitle = Content.SiteTerms.GetTerm("SiteMap")
    End Sub

    Private Sub LoadAllCategories()
        Dim allCats As Collection(Of Catalog.Category) = Catalog.Category.FindAllLight()

        Dim cats As Collection(Of Catalog.Category) = Catalog.Category.FindVisibleChildren("0")
        Dim maxDepth As Integer = WebAppSettings.SiteMapMaxDepth
        AddCategoryCollection(cats, 0, maxDepth, allCats)
    End Sub

    Private Sub LoadAllCustomPages()
        Dim pages As Collection(Of Content.CustomPage) = Content.CustomPage.FindAll()

        For Each customPage As Content.CustomPage In pages
            Me.ColumnTwo.Controls.Add(New LiteralControl("<li><a href=""" & Utilities.UrlRewriter.BuildUrlForCustomPage(customPage, Me.Page) & """ class=""actuator"">" & customPage.Name & "</a></li>"))
        Next
        Me.ColumnTwo.Controls.Add(New LiteralControl("</ul>"))
    End Sub

    Private Sub AddCategoryCollection(ByVal cats As Collection(Of Catalog.Category), ByVal currentDepth As Integer, ByVal maxDepth As Integer, ByVal allCats As Collection(Of Catalog.Category))
        If cats IsNot Nothing Then
            For Each c As Catalog.Category In cats
                If c.Hidden = False Then

                    Me.ColumnOne.Controls.Add(New LiteralControl("<li>"))
                    AddSingleLink(c, allCats)
                    If (maxDepth = 0) OrElse (currentDepth + 1 < maxDepth) Then
                        Dim children As Collection(Of Catalog.Category) = Catalog.Category.FindVisibleChildren(c.Bvin)
                        If children IsNot Nothing Then
                            If children.Count > 0 Then
                                Me.ColumnOne.Controls.Add(New LiteralControl("<ul>"))
                                AddCategoryCollection(children, currentDepth + 1, maxDepth, allCats)
                                Me.ColumnOne.Controls.Add(New LiteralControl("</ul>"))
                            End If
                        End If
                    End If
                    Me.ColumnOne.Controls.Add(New LiteralControl("</li>"))
                End If
            Next
        End If
    End Sub

    Private Sub AddSingleLink(ByVal c As Catalog.Category, ByVal allCats As Collection(Of Catalog.Category))
        Dim m As New HyperLink
        m.ToolTip = c.MetaTitle
        m.Text = c.Name

        m.NavigateUrl = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, allCats)
        If c.SourceType = Catalog.CategorySourceType.CustomLink Then
            If c.CustomPageOpenInNewWindow = True Then
                m.Target = "_blank"
            End If
        End If

        m.EnableViewState = False
        Me.ColumnOne.Controls.Add(m)
    End Sub

    Protected Sub Page_SaveStateComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.SaveStateComplete

    End Sub
End Class

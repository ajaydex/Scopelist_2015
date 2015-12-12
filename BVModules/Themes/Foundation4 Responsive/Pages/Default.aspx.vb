Imports System.Collections.Generic
Imports System.IO
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Pages_Default
    Inherits BaseStorePage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Home.master")

        ' Reset Last Category Session Variable
        SessionManager.CategoryLastId = String.Empty
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not String.IsNullOrEmpty(WebAppSettings.HomepageMetaTitle) Then
            Me.PageTitle = WebAppSettings.HomepageMetaTitle
        End If
        If Not String.IsNullOrEmpty(WebAppSettings.HomepageMetaDescription) Then
            Me.MetaDescription = WebAppSettings.HomepageMetaDescription
        End If
        If Not String.IsNullOrEmpty(WebAppSettings.HomepageMetaKeywords) Then
            Me.MetaKeywords = WebAppSettings.HomepageMetaKeywords
        End If
    End Sub

End Class
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CustomPageTemplates_Default_Custom
    Inherits BaseStoreCustomPage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Custom.master")
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If LocalCustomPage.PreContentColumnId <> String.Empty Then
            Me.PreContentColumn.ColumnID = LocalCustomPage.PreContentColumnId
            Me.PreContentColumn.LoadColumn()
        End If
        If LocalCustomPage.PostContentColumnId <> String.Empty Then
            Me.PostContentColumn.ColumnID = LocalCustomPage.PostContentColumnId
            Me.PostContentColumn.LoadColumn()
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadCustomPage()
        End If
    End Sub

    Public Overrides Sub LoadCustomPage()
        Me.Page.Title = If(Not String.IsNullOrEmpty(LocalCustomPage.MetaTitle), LocalCustomPage.MetaTitle, LocalCustomPage.Name)
        Me.MetaDescription = LocalCustomPage.MetaDescription
        Me.MetaKeywords = LocalCustomPage.MetaKeywords
        Me.lblName.Text = LocalCustomPage.Name
        Me.litContent.Text = LocalCustomPage.Content
    End Sub

End Class
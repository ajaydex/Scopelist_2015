Imports System.IO
Imports System.Data
Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.PersonalizationServices

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_StyleSheetSelector
    Inherits System.Web.UI.UserControl


    Public Event ThemeChanged(ByVal Sender As Object, ByVal e As System.EventArgs)

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Me.btnCancel.ImageUrl = PersonalizationServices.GetThemedButton("Cancel")
            Me.btnSave.ImageUrl = PersonalizationServices.GetThemedButton("SaveChanges")
            LoadCurrentTheme()
        End If
    End Sub

    Private Sub LoadCurrentTheme()
        Me.ThemeField.DataSource = Content.ModuleController.FindThemes
        Me.ThemeField.DataBind()

        Dim currentTheme As String

        If SessionManager.PersonalThemeName = "" Then
            currentTheme = WebAppSettings.ThemeName
        Else
            currentTheme = SessionManager.PersonalThemeName.ToString
        End If

        If ThemeField.Items.FindByValue(currentTheme) IsNot Nothing Then
            ThemeField.Items.FindByValue(currentTheme).Selected = True
            LoadPreview()
        End If
    End Sub

    Private Sub LoadPreview()
        Me.PreviewImage.ImageUrl = Content.ModuleController.FindThemePreviewImage(Me.ThemeField.SelectedValue, Request.PhysicalApplicationPath)
    End Sub

    Private Function Save() As Boolean

        Dim result As Boolean = False
        SessionManager.PersonalThemeName = Me.ThemeField.SelectedValue
        result = True
        Return result

    End Function

    Protected Sub ThemeField_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ThemeField.SelectedIndexChanged
        LoadPreview()
    End Sub


    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            Response.Redirect("default.aspx")
        End If
    End Sub


End Class

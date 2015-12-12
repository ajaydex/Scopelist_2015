Imports System.IO
Imports System.Data
Imports BVSoftware.Bvc5.Core
Imports BVSoftware.Bvc5.Core.PersonalizationServices

Partial Class BVModules_Controls_StyleSheetSelector
    Inherits System.Web.UI.UserControl

    'Private _SiteWideMode As Boolean = False
    'Private _AffiliateTheme As Boolean = False

    'Public Event ThemeChanged(ByVal Sender As Object, ByVal e As System.EventArgs)

    'Public Property SiteWideMode() As Boolean
    '    Get
    '        Return _SiteWideMode
    '    End Get
    '    Set(ByVal Value As Boolean)
    '        _SiteWideMode = Value
    '    End Set
    'End Property

    'Public Property AffiliateTheme() As Boolean
    '    Get
    '        Return _AffiliateTheme
    '    End Get
    '    Set(ByVal Value As Boolean)
    '        _AffiliateTheme = Value
    '    End Set
    'End Property

    'Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    '    Me.StyleGrid.Visible = False

    '    'If _AffiliateTheme = True AndAlso WebAppSettings.AllowAffiliateThemes = True Then
    '    '    ' For Affiliate Page
    '    '    Me.StyleGrid.Visible = True
    '    'Else
    '    If _SiteWideMode = True Then
    '        ' Admin Mode
    '        Me.StyleGrid.Visible = True
    '    Else
    '        ' Front Page / Etc.
    '        ' Hide grid when personalized themes aren't allowed
    '        If WebAppSettings.AllowPersonalizedThemes = True Then
    '            Me.StyleGrid.Visible = True
    '        Else
    '            Me.StyleGrid.Visible = False
    '        End If
    '    End If
    '    'End If

    '    If Not Page.IsPostBack Then
    '        LoadStyles()
    '    End If
    'End Sub

    'Private Sub LoadStyles()
    '    Dim dtStyles As New DataTable
    '    dtStyles.Columns.Add("StyleName", System.Type.GetType("System.String"))
    '    dtStyles.Columns.Add("FileName", System.Type.GetType("System.String"))

    '    Dim sourceDirectory As String = Path.Combine(Request.PhysicalApplicationPath, "BVThemes")

    '    If Directory.Exists(sourceDirectory) = True Then

    '        Dim folders As String() = Directory.GetDirectories(sourceDirectory)
    '        For Each d As String In folders
    '            Dim dr As DataRow
    '            dr = dtStyles.NewRow
    '            dr.Item("StyleName") = Path.GetFileName(d)
    '            dr.Item("FileName") = Path.GetFileName(d)
    '            dtStyles.Rows.Add(dr)
    '            dr = Nothing
    '        Next
    '    End If

    '    Me.StyleGrid.DataSource = dtStyles
    '    Me.StyleGrid.DataBind()
    'End Sub

    'Private Sub StyleGrid_UpdateCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles StyleGrid.UpdateCommand

    '    If AffiliateTheme Then
    '        Session("AffiliateStyleSheet") = e.Item.Cells(3).Text
    '    Else
    '        If Me._SiteWideMode = True Then
    '            WebAppSettings.ThemeName = e.Item.Cells(3).Text
    '        Else
    '            SessionManager.PersonalThemeName = e.Item.Cells(3).Text

    '            If HttpContext.Current.Request.Browser.Cookies = True Then
    '                Try
    '                    Dim saveCookie As New System.Web.HttpCookie("BVC5PersonalizedStyleSheet", e.Item.Cells(3).Text)
    '                    saveCookie.Expires = System.DateTime.MaxValue
    '                    HttpContext.Current.Response.Cookies.Add(saveCookie)
    '                Catch Ex As Exception
    '                    HttpContext.Current.Trace.Warn(Ex.Message)
    '                End Try
    '            End If

    '        End If
    '    End If

    '    LoadStyles()
    '    RaiseEvent ThemeChanged(source, System.EventArgs.Empty)
    'End Sub

    'Private Sub StyleGrid_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles StyleGrid.ItemDataBound
    '    If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
    '        Dim selButton As System.Web.UI.WebControls.ImageButton
    '        selButton = e.Item.FindControl("SelectButton")
    '        If Not selButton Is Nothing Then
    '            'selButton.ImageUrl = Utilities.ImageHelper.GetThemedButton("Select.gif")
    '            selButton.ImageUrl = GetThemedButton("Select.png")
    '        End If
    '    End If
    'End Sub




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

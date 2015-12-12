Imports BVSoftware.Bvc5.Core

Partial Class closed
    Inherits BaseStorePage

    'Override is closed page in base so this page always shows
    Public Overrides ReadOnly Property IsClosedPage() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.Page.Title = WebAppSettings.SiteName
    End Sub

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not WebAppSettings.StoreClosed Then
            Response.Redirect(WebAppSettings.SiteStandardRoot)
        End If

        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Popup.master")
    End Sub

    Protected Overrides Sub StoreClosedCheck()
        ' Do Nothing
    End Sub

    Private Sub LoadData()
        Try
            Me.lblDescription.Text = WebAppSettings.StoreClosedDescription
        Catch Ex As Exception
            'msg.ShowException(Ex)
        End Try
    End Sub

End Class

Imports BVSoftware.Bvc5.Core

Public MustInherit Class BaseStoreCustomPage
    Inherits BaseStorePage

    Private _LocalCustomPage As Content.CustomPage = Nothing

    Public Property LocalCustomPage() As Content.CustomPage
        Get
            If _LocalCustomPage Is Nothing Then
                _LocalCustomPage = New Content.CustomPage()
            End If
            Return _LocalCustomPage
        End Get
        Set(ByVal value As Content.CustomPage)
            _LocalCustomPage = value
        End Set
    End Property

    Private Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Request.QueryString("id") IsNot Nothing Then
            LocalCustomPage = Content.CustomPage.FindByBvin(Request.QueryString("id"))
            If LocalCustomPage Is Nothing OrElse String.IsNullOrEmpty(LocalCustomPage.Bvin) Then
                EventLog.LogEvent("Custom Page", "Requested Page of id " & Request.QueryString("id") & " was not found", Metrics.EventLogSeverity.Error)
                Utilities.UrlRewriter.RedirectToErrorPage(BVSoftware.BVC5.Core.ErrorTypes.Generic, Response)
            End If
        Else
            Utilities.UrlRewriter.RedirectToErrorPage(BVSoftware.BVC5.Core.ErrorTypes.Generic, Response)
        End If
    End Sub

    Public MustOverride Sub LoadCustomPage()

    Protected Overrides Sub LoadCanonicalUrl()
        Me.CanonicalUrl = Utilities.UrlRewriter.ResolveServerUrl(Utilities.UrlRewriter.BuildUrlForCustomPage(Me.LocalCustomPage, Me))
    End Sub

    Protected Overrides Sub LoadFacebookOpenGraph()
        MyBase.LoadFacebookOpenGraph()

        If Me.LocalCustomPage IsNot Nothing Then
            ' Url
            Me.FbOpenGraph.Url = Me.CanonicalUrl

            ' Title
            Me.FbOpenGraph.Title = Me.LocalCustomPage.Name

            ' PageType
            Me.FbOpenGraph.PageType = "other"

            ' Description
            If String.IsNullOrEmpty(Me.FbOpenGraph.Description) Then
                Me.FbOpenGraph.Description = Me.LocalCustomPage.MetaDescription
            End If
        End If
    End Sub

End Class
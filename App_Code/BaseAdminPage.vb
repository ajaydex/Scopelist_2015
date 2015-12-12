Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Public Class BaseAdminPage
    Inherits System.Web.UI.Page
    Implements Controls.IBaseAdminPage

    Private _messageBox As IMessageBox = Nothing
    Private _LastViewedProduct As Catalog.Product = Nothing

    Public Property PageMessageBox() As IMessageBox
        Get
            Return _messageBox
        End Get
        Set(ByVal value As IMessageBox)
            _messageBox = value
        End Set
    End Property

    Protected Const DefaultCatalogPage As String = "~/BVAdmin/Catalog/Default.aspx"
    
    Public Property PageTitle() As String
        Get
            Return Me.Page.Title
        End Get
        Set(ByVal Value As String)
            Me.Page.Title = Value
        End Set
    End Property
    Public Property CurrentTab() As AdminTabType
        Get
            If Session("ActiveAdminTab") Is Nothing Then
                Return AdminTabType.Dashboard
            Else
                Return CType(Session("ActiveAdminTab"), AdminTabType)
            End If
        End Get
        Set(ByVal value As AdminTabType)
            Session("ActiveAdminTab") = value
        End Set
    End Property
    Public ReadOnly Property LastProductViewed() As Catalog.Product
        Get
            If Me._LastViewedProduct Is Nothing OrElse String.IsNullOrEmpty(Me._LastViewedProduct.Bvin) Then
                Dim produts As Collection(Of Catalog.Product) = PersonalizationServices.GetProductsViewed()
                If produts.Count > 0 Then
                    Me._LastViewedProduct = produts(0)
                Else
                    Me._LastViewedProduct = New Catalog.Product()
                End If
            End If

            Return Me._LastViewedProduct
        End Get
    End Property
    Public Property ReturnUrl() As String
        Get
            Dim result As String = String.Empty
            If ViewState("ReturnUrl") IsNot Nothing Then
                result = ViewState("ReturnUrl").ToString()
            End If

            Return result
        End Get
        Set(value As String)
            ViewState("ReturnUrl") = value
        End Set
    End Property

    Private Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

        ' Updated to required SSL for everything in the admin 
        ' Version 5.7 for PCI
        If Not Request.IsSecureConnection Then
            If (WebAppSettings.UseSsl) Then
                ' Assure that both URL's are not the same so the system doesn't try to redirect to the same URL and loop.
                If WebAppSettings.SiteSecureRoot.ToLower <> WebAppSettings.SiteStandardRoot.ToLower Then
                    Utilities.SSL.SSLRedirect(Me, Utilities.SSL.SSLRedirectTo.SSL)
                End If
            End If
        End If

        If Not Page.IsPostBack Then
            If Not String.IsNullOrEmpty(Request.QueryString("ReturnUrl")) Then
                ViewState("ReturnUrl") = Request.QueryString("ReturnUrl")
            Else
                If Request.UrlReferrer IsNot Nothing AndAlso WebAppSettings.SiteStandardRoot.Contains(Request.UrlReferrer.Host) Then
                    ViewState("ReturnUrl") = Request.UrlReferrer.PathAndQuery
                End If
            End If
        End If
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
    End Sub

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Anthem.Manager.Register(Me)        
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.LoginToAdmin)
    End Sub

    Public Sub ValidateCurrentUserHasPermission(ByVal p As String)
        Dim l As New Collection(Of String)
        l.Add(p)
        ValidateCurrentUserHasPermissions(l)
    End Sub

    Public Sub ValidateCurrentUserHasPermissions(ByVal p As Collection(Of String))
        If SessionManager.IsUserAuthenticated = False Then            
            ' Send to Login Page
            Dim url As String = Me.Request.RawUrl
            url = url.Replace("&Anthem_CallBack=true", "")
            url = url.Replace("?Anthem_CallBack=true", "")
            Response.Redirect("~/BVAdmin/Login.aspx?ReturnUrl=" & HttpUtility.UrlEncode(url))
        Else
            If Membership.UserAccount.DoesUserHaveAllPermissions(SessionManager.GetCurrentUserId, p) = False Then
                ' Send to no permissions page
                Response.Redirect("~/nopermissions.aspx")
            End If
        End If
    End Sub

    Public Sub ShowMessage(ByVal message As String, ByVal type As ErrorTypes)
        Select Case type
            Case ErrorTypes.Ok
                Me.PageMessageBox.ShowOk(message)
            Case ErrorTypes.Info
                Me.PageMessageBox.ShowInformation(message)
            Case ErrorTypes.Error
                Me.PageMessageBox.ShowError(message)
            Case ErrorTypes.Warning
                Me.PageMessageBox.ShowWarning(message)
        End Select
    End Sub

End Class

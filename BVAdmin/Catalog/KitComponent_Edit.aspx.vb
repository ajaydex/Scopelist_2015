Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_KitComponent_Edit
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Kit Component"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Me.RegisterWindowScripts()

        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Catalog

            If Not Request.QueryString("ID") Is Nothing Then
                Dim id As String = String.Empty
                id = Request.QueryString("ID")
                LoadComponent(id)
            End If
        End If
    End Sub

    Private Sub LoadComponent(ByVal id As String)
        Dim kg As Catalog.KitComponent = Catalog.KitComponent.FindByBvin(id)
        If kg IsNot Nothing Then
            Me.DisplaynameField.Text = kg.DisplayName
            If Me.ComponentTypeField.Items.FindByValue(CInt(kg.ComponentType).ToString()) IsNot Nothing Then
                Me.ComponentTypeField.ClearSelection()
                Me.ComponentTypeField.Items.FindByValue(CInt(kg.ComponentType).ToString()).Selected = True
            End If
            Me.ImageFileSmallField.Text = kg.SmallImage
            Me.ImageFileMediumField.Text = kg.LargeImage
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Dim pid As String = ""        
        If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
            Dim kc As Catalog.KitComponent = Services.KitService.FindKitComponent(Request.QueryString("id"))
            If kc IsNot Nothing Then
                pid = Services.KitService.GetComponentParentKitBvin(kc)
            End If
            If Request.QueryString("DOC") = "1" Then
                Catalog.KitComponent.Delete(Request.QueryString("id"))
            End If
            Response.Redirect("Kit_Edit.aspx?id=" & pid)
        Else
            Response.Redirect("Kit_Edit.aspx")
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
            Dim pid As String = ""
            Dim kc As Catalog.KitComponent = Services.KitService.FindKitComponent(Request.QueryString("id"))
            If kc IsNot Nothing Then
                pid = Services.KitService.GetComponentParentKitBvin(kc)
            End If
            If Page.IsValid Then
                kc.DisplayName = Me.DisplaynameField.Text.Trim
                kc.ComponentType = Me.ComponentTypeField.SelectedValue
                kc.SmallImage = Me.ImageFileSmallField.Text
                kc.LargeImage = Me.ImageFileMediumField.Text
                Services.KitService.UpdateKitComponent(kc)                
                Response.Redirect("Kit_Edit.aspx?id=" & pid)
            End If
        Else
            Response.Redirect("Kit_Edit.aspx")
        End If        
    End Sub

    Private Sub RegisterWindowScripts()

        'Dim f As String = WebAppSettings.ImageBrowserDefaultDirectory
        Dim sb As New StringBuilder

        sb.Append("var w;")
        sb.Append("function popUpWindow(parameters) {")
        sb.Append("w = window.open('../ImageBrowser.aspx' + parameters, 'imagebrowser', 'height=505, width=950');")
        sb.Append("}")

        'sb.Append("var w;")
        'sb.Append("function popUpWindow(parameters) {")
        'sb.Append("w = window.open('../ImageBrowser.aspx?startDir=" & f & " ' , null, 'height=480, width=640');")
        'sb.Append("}")

        sb.Append("function closePopup() {")
        sb.Append("w.close();")
        sb.Append("}")

        sb.Append("function SetSmallImage(fileName) {")
        sb.Append("document.getElementById('")
        sb.Append(Me.ImageFileSmallField.ClientID)
        sb.Append("').value = fileName;")
        'sb.Append("document.getElementById('")
        'sb.Append(Me.imgPreviewSmall.ClientID)
        'sb.Append("').src = '../../'+fileName;")
        sb.Append("w.close();")
        sb.Append("}")

        sb.Append("function SetMediumImage(fileName) {")
        sb.Append("document.getElementById('")
        sb.Append(Me.ImageFileMediumField.ClientID)
        sb.Append("').value = fileName;")
        'sb.Append("document.getElementById('")
        'sb.Append(Me.imgPreviewMedium.ClientID)
        'sb.Append("').src = '../../'+fileName;")
        sb.Append("w.close();")
        sb.Append("}")

        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "WindowScripts", sb.ToString, True)

    End Sub

End Class

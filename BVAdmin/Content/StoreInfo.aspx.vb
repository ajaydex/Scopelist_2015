Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Content_StoreInfo
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.RegisterWindowScripts()


        Me.ShipFromAddressField.RequireFirstName = False
        Me.ShipFromAddressField.RequireLastName = False
        Me.ShipFromAddressField.RequirePhone = False
        Me.ShipFromAddressField.RequirePostalCode = False
        Me.ShipFromAddressField.RequireRegion = False
        Me.ShipFromAddressField.RequireWebSiteURL = False
        Me.ShipFromAddressField.RequireAddress = False
        Me.ShipFromAddressField.RequireCity = False
        Me.ShipFromAddressField.RequireCompany = False
        Me.ShipFromAddressField.RequireFax = False

        If Not Page.IsPostBack Then


            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = False Then
                Me.btnSave.Enabled = False
            End If
            LoadData()
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Store Information"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        Me.MessageBox1.ClearMessage()
        If Me.Save() = True Then
            Me.MessageBox1.ShowOk("Changes Saved!")
        Else
            Me.MessageBox1.ShowWarning("Unable to save changes.")            
        End If
    End Sub

    Private Sub LoadData()
        Me.LogoField.Text = WebAppSettings.SiteLogo
        Me.ShipFromAddressField.LoadFromAddress(WebAppSettings.SiteShippingAddress)
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        WebAppSettings.SiteShippingAddress = Me.ShipFromAddressField.GetAsAddress
        WebAppSettings.SiteLogo = Me.LogoField.Text.Trim
        result = True
        Return result

    End Function

    Private Sub RegisterWindowScripts()

        Dim sb As New StringBuilder

        sb.Append("var w;")
        sb.Append("function popUpWindow(parameters) {")
        sb.Append("w = window.open('../ImageBrowser.aspx' + parameters, 'imagebrowser', 'height=505, width=950');")
        sb.Append("}")

        sb.Append("function closePopup() {")
        sb.Append("w.close();")
        sb.Append("}")

        sb.Append("function SetLogoImage(fileName) {")
        sb.Append("document.getElementById('")
        sb.Append(Me.LogoField.ClientID)
        sb.Append("').value = fileName;")
        sb.Append("w.close();")
        sb.Append("}")

        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "WindowScripts", sb.ToString, True)

    End Sub

End Class

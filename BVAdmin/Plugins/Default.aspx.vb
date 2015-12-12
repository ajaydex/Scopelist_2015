Imports BVSoftware.Bvc5.core

Partial Class BVAdmin_Plugins_Default
    Inherits BaseAdminPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.PageTitle = "Plug-ins"
        Me.CurrentTab = AdminTabType.Plugins

        If Request.QueryString("noredirect") Is Nothing Then
            If String.Compare(WebAppSettings.DefaultPlugin, "None", True) <> 0 Then
                Dim plugins As StringCollection = BVSoftware.Bvc5.Core.Content.ModuleController.FindAdminPlugins()
                For Each item As String In plugins
                    If String.Compare(item, WebAppSettings.DefaultPlugin, True) = 0 Then
                        Response.Redirect("~/BVAdmin/Plugins/" & item & "/default.aspx")
                    End If
                Next
            End If
        End If

        Dim adminPlugins As StringCollection = Content.ModuleController.FindAdminPlugins()
        If adminPlugins.Count > 0 Then
            MultiView1.SetActiveView(viewChooseDefault)
            DefaultPluginDropDownList.Items.Clear()
            DefaultPluginDropDownList.Items.Add("None")
            DefaultPluginDropDownList.AppendDataBoundItems = True
            DefaultPluginDropDownList.DataSource = adminPlugins
            DefaultPluginDropDownList.DataBind()

            DefaultPluginDropDownList.SelectedValue = WebAppSettings.DefaultPlugin
        Else
            MultiView1.SetActiveView(viewNoPlugins)
        End If        
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        WebAppSettings.DefaultPlugin = DefaultPluginDropDownList.SelectedValue
        Response.Redirect("~/BVAdmin/Plugins/Default.aspx")
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PluginView)
    End Sub
End Class

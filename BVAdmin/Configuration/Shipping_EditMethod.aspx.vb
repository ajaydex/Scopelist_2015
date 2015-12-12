Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Shipping_EditMethod
    Inherits BaseAdminPage

    Private m As Shipping.ShippingMethod
    Private WithEvents editor As Content.BVShippingModule

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadCountries()
            LoadNOTCountries()
            LoadRegions()
            LoadNOTRegions()
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Shipping Method"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub


    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Request.QueryString("id") IsNot Nothing Then
            Me.BlockIDField.Value = Request.QueryString("id")
        End If
        m = Shipping.ShippingMethod.FindByBvin(Me.BlockIDField.Value)
        LoadEditor()
    End Sub

    Private Function FindProvider(ByVal bvin As String) As Shipping.ShippingProvider
        Dim result As Shipping.ShippingProvider = New Shipping.Provider.NullProvider

        Dim found As Boolean = False

        For Each p As Shipping.ShippingProvider In Shipping.AvailableProviders.Providers
            If p.ProviderId = bvin Then
                result = p
                found = True
                Exit For
            End If
        Next

        Return result
    End Function

    Private Sub LoadEditor()
        Dim tempControl As System.Web.UI.Control = Nothing

        Dim p As Shipping.ShippingProvider = FindProvider(m.ShippingProviderId)

        tempControl = Content.ModuleController.LoadShippingEditor(p.Name, Me)

        If TypeOf tempControl Is Content.BVShippingModule Then
            editor = CType(tempControl, Content.BVShippingModule)
            If Not editor Is Nothing Then
                editor.BlockId = m.Bvin
                editor.ShippingMethod = m
                Me.phEditor.Controls.Add(editor)
            End If
        Else
            Me.phEditor.Controls.Add(New LiteralControl("Error, editor is not based on Content.BVShippingModule class"))
        End If
    End Sub

    Protected Sub editor_EditingComplete(ByVal sender As Object, ByVal e As BVSoftware.Bvc5.Core.Content.BVModuleEventArgs) Handles editor.EditingComplete        
        If (e.Info.ToUpper = "CANCELED") Then
            If (Request.QueryString("doc") = 1) Then
                Shipping.ShippingMethod.Delete(m.Bvin)
            End If
        Else
            If e.Info <> String.Empty Then
                m.Name = e.Info
                Shipping.ShippingMethod.Update(m)
            End If
        End If
        Response.Redirect("Shipping.aspx")
    End Sub

    Protected Sub btnAddCountry_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddCountry.Click
        Dim li As ListItem
        For Each li In inNOTCountries.Items
            If li.Selected = True Then
                Shipping.ShippingMethod.DeleteCountryRestriction(Me.BlockIDField.Value, li.Value)
            End If
        Next
        LoadCountries()
        LoadNOTCountries()
        LoadRegions()
        LoadNOTRegions()
    End Sub

    Protected Sub btnDelCountry_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDelCountry.Click
        Dim li As ListItem
        For Each li In inCountries.Items
            If li.Selected = True Then
                Shipping.ShippingMethod.AddCountryRestriction(Me.BlockIDField.Value, li.Value)
            End If
        Next
        LoadCountries()
        LoadNOTCountries()
        LoadRegions()
        LoadNOTRegions()
    End Sub

    Protected Sub btnAddRegion_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddRegion.Click
        Dim li As ListItem
        For Each li In inNOTRegions.Items
            If li.Selected = True Then
                Shipping.ShippingMethod.DeleteRegionRestriction(Me.BlockIDField.Value, li.Value)
            End If
        Next
        LoadRegions()
        LoadNOTRegions()
    End Sub

    Protected Sub btnDelRegion_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDelRegion.Click
        Dim li As ListItem
        For Each li In inRegions.Items
            If li.Selected = True Then
                Shipping.ShippingMethod.AddRegionRestriction(Me.BlockIDField.Value, li.Value)
            End If
        Next
        LoadRegions()
        LoadNOTRegions()
    End Sub

    Sub LoadRegions()
        inRegions.Items.Clear()
        inRegions.DataSource = Shipping.ShippingMethod.FindRegions(Me.BlockIDField.Value)
        inRegions.DataTextField = "Name"
        inRegions.DataValueField = "Bvin"
        inRegions.DataBind()
    End Sub

    Sub LoadNOTRegions()
        inNOTRegions.Items.Clear()
        inNOTRegions.DataSource = Shipping.ShippingMethod.FindNotRegions(Me.BlockIDField.Value)
        inNOTRegions.DataTextField = "Name"
        inNOTRegions.DataValueField = "Bvin"
        inNOTRegions.DataBind()
    End Sub

    Sub LoadCountries()
        inCountries.Items.Clear()
        inCountries.DataSource = Shipping.ShippingMethod.FindCountries(Me.BlockIDField.Value)
        inCountries.DataTextField = "DisplayName"
        inCountries.DataValueField = "Bvin"
        inCountries.DataBind()
    End Sub

    Sub LoadNOTCountries()
        inNOTCountries.Items.Clear()
        inNOTCountries.DataSource = Shipping.ShippingMethod.FindNotCountries(Me.BlockIDField.Value)
        inNOTCountries.DataTextField = "DisplayName"
        inNOTCountries.DataValueField = "Bvin"
        inNOTCountries.DataBind()
    End Sub

End Class

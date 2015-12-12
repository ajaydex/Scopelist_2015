Imports BVSoftware.Bvc5.Core

Partial Class Taxes_Edit
    Inherits BaseAdminPage

    Private t As Taxes.Tax

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Tax Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load

        t = New Taxes.Tax

        If Not Page.IsPostBack Then

            msg.ClearMessage()

            If Not Request.QueryString("mode") Is Nothing Then
                ViewState("Mode") = Request.QueryString("mode")
            End If

            If Not Request.QueryString("id") Is Nothing Then
                ViewState("ID") = Request.QueryString("id")
            End If

            Dim homeCountry As String = WebAppSettings.SiteCountryBvin
            lstCountry.SelectedValue = homeCountry

            PopulateCountries()
            PopulateTaxTypes()
            LoadTax()

        End If
    End Sub

    Private Sub LoadTax()
        If Not ViewState("ID") Is Nothing Then
            t = Taxes.Tax.FindByBvin(ViewState("ID"))
            If t.Bvin <> String.Empty Then
                SetCountry(t.CountryBvin)
                SetRegion(t.RegionID)
                SetCounty(t.CountyBvin)
                Me.postalCode.Text = t.PostalCode
                Me.Rate.Text = t.Rate
                SetTaxType(t.TaxClass)
                Me.ApplyToShippingCheckBox.Checked = t.ApplyToShipping
            Else
                msg.ShowError("Could not load tax!")
            End If
        End If
    End Sub

    Sub SetCountry(ByVal Code As String)
        For Each li As ListItem In lstCountry.Items
            If li.Value = Code Then
                lstCountry.ClearSelection()

                li.Selected = True
            End If
        Next
        PopulateRegions(lstCountry.SelectedValue)
    End Sub

    Sub PopulateCountries()
        Try
            lstCountry.DataSource = Content.Country.FindAll
            lstCountry.DataValueField = "Bvin"
            lstCountry.DataTextField = "DisplayName"
            lstCountry.DataBind()
        Catch Ex As Exception
            Throw New ArgumentException("Error Loading Countries: " & Ex.Message)
        End Try
    End Sub

    Sub SetRegion(ByVal ID As String)
        For Each li As ListItem In lstState.Items
            If li.Value = ID Then
                lstState.ClearSelection()
                li.Selected = True
            End If
        Next
        PopulateCounty(lstState.SelectedValue)
    End Sub

    Sub PopulateRegions(ByVal sID As String)
        lstState.Items.Clear()
        Try
            lstState.DataSource = Content.Region.FindByCountry(sID)
            lstState.DataTextField = "name"
            lstState.DataValueField = "Bvin"
            lstState.DataBind()

            Dim li As New ListItem
            li.Value = 0
            li.Text = "All States/Regions"
            lstState.Items.Insert(0, li)
            li = Nothing

        Catch Ex As Exception
            Throw New ArgumentException(Ex.Message)
        End Try
    End Sub

    Sub SetCounty(ByVal ID As String)
        For Each li As ListItem In lstCounty.Items
            If li.Value = ID Then
                lstCounty.ClearSelection()
                li.Selected = True
            End If
        Next
    End Sub

    Sub PopulateCounty(ByVal sID As String)
        Try
            lstCounty.AppendDataBoundItems = True
            lstCounty.DataSource = Content.County.FindByRegion(sID)
            lstCounty.DataTextField = "Name"
            lstCounty.DataValueField = "Bvin"
            lstCounty.DataBind()
        Catch Ex As Exception
            Throw New ArgumentException(Ex.Message)
        End Try
    End Sub

    Sub SetTaxType(ByVal id As String)
        For Each li As ListItem In lstTypes.Items
            If li.Value = id Then
                lstTypes.ClearSelection()
                li.Selected = True
            End If
        Next
    End Sub

    Sub PopulateTaxTypes()
        Me.lstTypes.Items.Clear()
        lstTypes.DataSource = Taxes.TaxClass.FindAll
        lstTypes.DataTextField = "DisplayName"
        lstTypes.DataValueField = "Bvin"
        lstTypes.DataBind()

        Dim li As New ListItem
        li.Value = Taxes.TaxClass.TaxableUnassignedItems
        li.Text = "Taxable Items Without A Class"
        Me.lstTypes.Items.Insert(0, li)

        li = New ListItem()
        li.Value = ""
        li.Text = "All Taxable Items"
        Me.lstTypes.Items.Insert(0, li)

    End Sub

    Sub lstCountry_SelectedIndexChanged(ByVal Sender As Object, ByVal E As EventArgs) Handles lstCountry.SelectedIndexChanged
        PopulateRegions(lstCountry.SelectedItem.Value)
    End Sub

    Protected Sub lstState_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lstState.SelectedIndexChanged
        PopulateCounty(lstState.SelectedItem.Value)
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        If Not ViewState("Mode") Is Nothing Then
            If (ViewState("Mode") = "new") AndAlso (Not ViewState("ID") Is Nothing) Then
                Taxes.Tax.Delete(ViewState("ID"))
            End If
        End If
        Response.Redirect("Taxes.aspx", True)
    End Sub

    Private Sub btnCreateAccount_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCreateAccount.Click
        msg.ClearMessage()
        t = Taxes.Tax.FindByBvin(ViewState("ID"))
        t.CountryBvin = Me.lstCountry.SelectedValue
        If Me.lstState.Visible = False Then
            t.RegionID = ""
        Else
            t.RegionID = Me.lstState.SelectedValue
        End If
        If Me.lstCounty.Visible = False Then
            t.CountyBvin = ""
        Else
            t.CountyBvin = Me.lstCounty.SelectedValue
        End If
        t.PostalCode = Me.postalCode.Text.Trim
        Me.Rate.Text.Trim()
        Me.Rate.Text.Replace("%", "")
        t.Rate = Convert.ToDecimal(Me.Rate.Text)
        t.TaxClass = Me.lstTypes.SelectedValue
        t.ApplyToShipping = Me.ApplyToShippingCheckBox.Checked
        If Taxes.Tax.Update(t) = False Then
            msg.ShowError("Couldn't save changes!")
        Else
            Response.Redirect("Taxes.aspx", True)
        End If
    End Sub


End Class

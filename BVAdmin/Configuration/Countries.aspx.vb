Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Configuration_Countries
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Countries"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadCountries()
            LoadFields()
        End If
    End Sub

    Private Sub LoadFields()
        PostalCodeValidationCheckBox.Checked = WebAppSettings.EnablePostalCodeValidation
    End Sub

    Private Sub LoadCountries()
        Dim countries As Collection(Of Content.Country)
        countries = Content.Country.FindAll

        Dim activeCountries As New Collection(Of Content.Country)
        Dim nonActiveCountries As New Collection(Of Content.Country)

        For i As Integer = 0 To countries.Count - 1
            If countries(i).Active = True Then
                activeCountries.Add(countries(i))
            Else
                nonActiveCountries.Add(countries(i))
            End If
        Next

        countries = Nothing

        Me.GridView1.DataSource = activeCountries
        Me.GridView1.DataBind()

        Me.GridView2.DataSource = nonActiveCountries
        Me.GridView2.DataBind()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        NewCountry()
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        NewCountry()
    End Sub

    Private Sub NewCountry()
        Response.Redirect("Countries_Edit.aspx")
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
        Dim c As Content.Country = Content.Country.FindByBvin(bvin)
        If c.Bvin <> String.Empty Then
            c.Active = False
            Content.Country.Update(c)
        End If
        LoadCountries()
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
        Content.Country.Delete(bvin)
        LoadCountries()
    End Sub

    Protected Sub GridView2_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView2.RowCancelingEdit
        Dim bvin As String = CType(GridView2.DataKeys(e.RowIndex).Value, String)
        Dim c As Content.Country = Content.Country.FindByBvin(bvin)
        If c.Bvin <> String.Empty Then
            c.Active = True
            Content.Country.Update(c)
        End If
        LoadCountries()
    End Sub

    Protected Sub GridView2_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView2.RowDeleting
        Dim bvin As String = CType(GridView2.DataKeys(e.RowIndex).Value, String)
        Content.Country.Delete(bvin)
        LoadCountries()
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("countries_edit.aspx?id=" & bvin)
    End Sub

    Protected Sub GridView2_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView2.RowEditing
        Dim bvin As String = CType(GridView2.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("countries_edit.aspx?id=" & bvin)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        WebAppSettings.EnablePostalCodeValidation = PostalCodeValidationCheckBox.Checked
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        LoadFields()
    End Sub
End Class

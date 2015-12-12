Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Globalization

Partial Class BVAdmin_Configuration_Countries_Edit
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.DisplayNameField.Focus()

            LoadCultures()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadCountry()
            Else
                Me.BvinField.Value = String.Empty
            End If
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Country"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Private Sub LoadCultures()
        Me.CultureCodeField.Items.Clear()
        Me.CultureCodeField.Items.Add(New ListItem("Default (en-US)", "en-US"))

        Dim sortedCultures As New SortedList()
        For Each ci As CultureInfo In System.Globalization.CultureInfo.GetCultures(CultureTypes.AllCultures)
            sortedCultures.Add(ci.Name, ci.Name)
        Next
        For Each d As DictionaryEntry In sortedCultures
            Me.CultureCodeField.Items.Add(d.Value)
        Next
    End Sub

    Private Sub LoadCountry()
        Dim c As Content.Country
        c = Content.Country.FindByBvin(Me.BvinField.Value)

        If Not c Is Nothing Then
            If c.Bvin <> String.Empty Then
                Me.ActiveField.Checked = c.Active
                Me.DisplayNameField.Text = c.DisplayName
                Me.ISOCodeField.Text = c.IsoCode
                Me.ISOAlpha3Field.Text = c.IsoAlpha3
                Me.ISONumericField.Text = c.IsoNumeric
                Me.PostalCodeValidationRegexTextBox.Text = c.PostalCodeValidationRegex

                If CultureCodeField.Items.FindByValue(c.CultureCode) IsNot Nothing Then
                    Me.CultureCodeField.Items.FindByValue(c.CultureCode).Selected = True
                End If

                Me.GridView1.DataSource = c.Regions
                Me.GridView1.DataBind()
            End If
        End If

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("countries.aspx")
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Page.IsValid Then
            If Save() = True Then
                Response.Redirect("countries.aspx")
            End If
        End If
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        If Me.Save = True Then
            Response.Redirect("countries_edit_region.aspx?countryID=" & Me.BvinField.Value)
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim c As content.Country
        c = Content.Country.FindByBvin(Me.BvinField.Value)

        If c IsNot Nothing Then
            c.DisplayName = Me.DisplayNameField.Text.Trim
            c.Active = Me.ActiveField.Checked
            c.IsoCode = Me.ISOCodeField.Text.Trim
            c.IsoAlpha3 = Me.ISOAlpha3Field.Text.Trim
            c.IsoNumeric = Me.ISONumericField.Text.Trim
            If Me.CultureCodeField.Items.Count > 0 Then
                c.CultureCode = Me.CultureCodeField.SelectedValue
            Else
                c.CultureCode = String.Empty
            End If
            c.PostalCodeValidationRegex = Me.PostalCodeValidationRegexTextBox.Text.Trim()

            If Me.BvinField.Value = String.Empty Then
                result = Content.Country.Insert(c)
            Else
                result = Content.Country.Update(c)
            End If

            If result = True Then
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = c.Bvin
            End If

        End If

        Return result
    End Function

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
        Content.Region.Delete(bvin)
        LoadRegions()
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        If Me.Save Then
            Response.Redirect("countries_edit_region.aspx?countryID=" & Me.BvinField.Value & "&id=" & bvin)
        End If
    End Sub

    Private Sub LoadRegions()
        Me.GridView1.DataSource = Content.Region.FindByCountry(Me.BvinField.Value)
        Me.GridView1.DataBind()
    End Sub

    Protected Sub BVCustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles BVCustomValidator1.ServerValidate
        Try
            If Not String.IsNullOrEmpty(args.Value) Then
                Dim regex As New RegularExpressions.Regex(args.Value)
            End If
            args.IsValid = True
        Catch ex As System.ArgumentException
            args.IsValid = False
            BVCustomValidator1.ErrorMessage = "Postal validation regex is invalid: " & ex.Message
        End Try
    End Sub
End Class

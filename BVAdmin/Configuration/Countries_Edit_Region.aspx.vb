Imports System.Collections.Generic
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Countries_Edit_Region
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.NameField.Focus()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadRegion()
            Else
                Me.BvinField.Value = String.Empty
                If Request.QueryString("countryID") IsNot Nothing Then
                    Me.CountryIDField.Value = Request.QueryString("countryID")
                End If
            End If

        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Region"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Private Sub LoadRegion()
        Dim r As Content.Region
        r = Content.Region.FindByBvin(Me.BvinField.Value)

        If Not r Is Nothing Then
            If r.Bvin <> String.Empty Then
                Me.NameField.Text = r.Name
                Me.AbbreviationField.Text = r.Abbreviation
                Me.CountryIDField.Value = r.CountryID
                Me.GridView1.DataSource = r.Counties
                Me.GridView1.DataBind()
            End If
        End If

    End Sub

    Private Sub LoadCounties()
        Me.GridView1.DataSource = Content.County.FindByRegion(Me.BvinField.Value)
        Me.GridView1.DataBind()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("Countries_Edit.aspx?id=" & Me.CountryIDField.Value)
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Me.Save() = True Then
            Response.Redirect("Countries_Edit.aspx?id=" & Me.CountryIDField.Value)
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim r As Content.Region
        r = Content.Region.FindByBvin(Me.BvinField.Value)

        If r IsNot Nothing Then
            r.Name = Me.NameField.Text.Trim
            r.Abbreviation = Me.AbbreviationField.Text.Trim
            r.CountryID = Me.CountryIDField.Value

            If Me.BvinField.Value = String.Empty Then
                result = Content.Region.Insert(r)
            Else
                result = Content.Region.Update(r)
            End If

            If result = True Then
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = r.Bvin
            End If

        End If

        Return result
    End Function

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        If Me.Save = True Then
            If Me.NewCountyField.Text.Trim = String.Empty Then
                Me.NewCountyField.Text = "Name is Required"
            Else
                Dim c As New Content.County
                c.Name = Me.NewCountyField.Text.Trim
                c.RegionID = Me.BvinField.Value
                Content.County.Insert(c)
                LoadCounties()
                Me.NewCountyField.Text = String.Empty
                Me.NewCountyField.Focus()
            End If            
        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
        Content.County.Delete(bvin)
        Me.LoadCounties()
    End Sub

End Class

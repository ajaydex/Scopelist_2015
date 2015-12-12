Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Content_PrintTemplates_Edit
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Template"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.RegisterWindowScripts()

        If Not Page.IsPostBack Then

            SetSecurityModel()

            PopulateTags()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadPrintTemplate()
            Else
                Me.BvinField.Value = String.Empty
            End If
        End If
    End Sub

    Private Sub RegisterWindowScripts()

        Dim sb As New StringBuilder
        sb.Append("function MoveEmailVars()")
        sb.Append("{")
        sb.Append("var textbox = document.getElementById('" & Me.BodyField.ClientID & "');")
        sb.Append("var listbox = document.getElementById('" & Me.Tags.ClientID & "');")
        sb.Append("textbox.value += listbox.options[listbox.selectedIndex].value;")
        sb.Append("textbox.focus();")
        sb.Append("}")
        sb.Append("function MoveEmailVars2()")
        sb.Append("{")
        sb.Append("var textbox = document.getElementById('" & Me.RepeatingSectionField.ClientID & "');")
        sb.Append("var listbox = document.getElementById('" & Me.Tags.ClientID & "');")
        sb.Append("textbox.value += listbox.options[listbox.selectedIndex].value;")
        sb.Append("textbox.focus();")
        sb.Append("}")

        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "WindowScripts", sb.ToString, True)
    End Sub

    Private Sub SetSecurityModel()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = False Then
            Me.btnSaveChanges.Enabled = False
            Me.btnSaveChanges.Visible = False
        End If
    End Sub

    Private Sub PopulateTags()
        Dim t As New Collection(Of Content.EmailTemplateTag)

        Dim l As New Orders.LineItem
        For Each tt As Content.EmailTemplateTag In l.ReplacementTags
            t.Add(tt)
        Next

        Dim e As New Content.PrintTemplate
        For Each tt As Content.EmailTemplateTag In e.ReplacementTags()
            t.Add(tt)
        Next

        Dim p As New Catalog.InternalProduct()
        For Each tt As Content.EmailTemplateTag In p.ReplacementTags
            t.Add(tt)
        Next

        Dim o As New Orders.Order
        For Each tt As Content.EmailTemplateTag In o.ReplacementTags
            t.Add(tt)
        Next

        Me.Tags.DataSource = t
        Me.Tags.DataValueField = "Tag"
        Me.Tags.DataTextField = "Tag"
        Me.Tags.DataBind()
    End Sub

    Private Sub LoadPrintTemplate()
        Dim p As Content.PrintTemplate
        p = Content.PrintTemplate.FindByBvin(Me.BvinField.Value)
        If Not p Is Nothing Then
            If p.Bvin <> String.Empty Then
                Me.DisplayNameField.Text = p.DisplayName
                Me.BodyField.Text = p.Body
                Me.RepeatingSectionField.Text = p.RepeatingSection
            End If
        End If
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Me.Save = True Then
            Response.Redirect("PrintTemplates.aspx")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("PrintTemplates.aspx")
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim p As Content.PrintTemplate
        p = Content.PrintTemplate.FindByBvin(Me.BvinField.Value)
        If Not p Is Nothing Then

            p.Body = Me.BodyField.Text.Trim
            p.DisplayName = Me.DisplayNameField.Text.Trim
            p.RepeatingSection = Me.RepeatingSectionField.Text.Trim

            If Me.BvinField.Value = String.Empty Then
                result = Content.PrintTemplate.Insert(p)
            Else
                result = Content.PrintTemplate.Update(p)
            End If

            If result = True Then
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = p.Bvin
            End If
        End If

        Return result
    End Function


End Class

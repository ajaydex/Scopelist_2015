Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Content_EmailTemplates_Edit
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
                LoadEmailTemplate()
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
        sb.Append("function MoveEmailVars3()")
        sb.Append("{")
        sb.Append("var textbox = document.getElementById('" & Me.BodyPlainTextField.ClientID & "');")
        sb.Append("var listbox = document.getElementById('" & Me.Tags.ClientID & "');")
        sb.Append("textbox.value += listbox.options[listbox.selectedIndex].value;")
        sb.Append("textbox.focus();")
        sb.Append("}")
        sb.Append("function MoveEmailVars4()")
        sb.Append("{")
        sb.Append("var textbox = document.getElementById('" & Me.RepeatingSectionPlainTextField.ClientID & "');")
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

        Dim e As New Content.EmailTemplate
        For Each tt As Content.EmailTemplateTag In e.ReplacementTags()
            t.Add(tt)
        Next

        Dim g As New Catalog.GiftCertificate
        For Each tt As Content.EmailTemplateTag In g.ReplacementTags()
            t.Add(tt)
        Next

        Dim l As New Orders.LineItem
        For Each tt As Content.EmailTemplateTag In l.ReplacementTags
            t.Add(tt)
        Next

        Dim ml As New Contacts.MailingListMember
        For Each tt As Content.EmailTemplateTag In ml.ReplacementTags
            t.Add(tt)
        Next

        Dim o As New Orders.Order
        For Each tt As Content.EmailTemplateTag In o.ReplacementTags
            t.Add(tt)
        Next

        Dim p As New Shipping.Package()
        For Each tt As Content.EmailTemplateTag In p.ReplacementTags
            t.Add(tt)
        Next

        Dim pr As New Catalog.InternalProduct
        For Each tt As Content.EmailTemplateTag In pr.ReplacementTags
            t.Add(tt)
        Next

        Dim u As New Membership.UserAccount
        For Each tt As Content.EmailTemplateTag In u.ReplacementTags
            t.Add(tt)
        Next

        Dim r As New Orders.RMA
        For Each tt As Content.EmailTemplateTag In r.ReplacementTags
            t.Add(tt)
        Next

        Dim ri As New Orders.RMAItem
        For Each tt As Content.EmailTemplateTag In ri.ReplacementTags
            t.Add(tt)
        Next

        Dim m As New Contacts.VendorManufacturerBase()
        For Each tt As Content.EmailTemplateTag In m.ReplacementTags
            t.Add(tt)
        Next

        Me.Tags.DataSource = t
        Me.Tags.DataValueField = "Tag"
        Me.Tags.DataTextField = "Tag"
        Me.Tags.DataBind()
    End Sub

    Private Sub LoadEmailTemplate()
        Dim e As Content.EmailTemplate
        e = Content.EmailTemplate.FindByBvin(Me.BvinField.Value)
        If Not e Is Nothing Then
            If e.Bvin <> String.Empty Then

                Me.FromField.Text = e.From
                Me.DisplayNameField.Text = e.DisplayName
                Me.SubjectField.Text = e.Subject
                Me.SendInPlaintTextField.Checked = e.SendInPlainText
                Me.BodyField.Text = e.Body
                Me.RepeatingSectionField.Text = e.RepeatingSection
                Me.BodyPlainTextField.Text = e.BodyPlainText
                Me.RepeatingSectionPlainTextField.Text = e.RepeatingSectionPlainText
            End If
        End If
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Me.Save = True Then
            Response.Redirect("EmailTemplates.aspx")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("EmailTemplates.aspx")
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim e As Content.EmailTemplate
        e = Content.EmailTemplate.FindByBvin(Me.BvinField.Value)
        If Not e Is Nothing Then

            e.Body = Me.BodyField.Text.Trim
            e.BodyPlainText = Me.BodyPlainTextField.Text.Trim
            e.BodyPreTransform = Me.BodyField.Text
            e.DisplayName = Me.DisplayNameField.Text.Trim
            e.From = Me.FromField.Text.Trim
            e.RepeatingSection = Me.RepeatingSectionField.Text.Trim
            e.RepeatingSectionPlainText = Me.RepeatingSectionPlainTextField.Text.Trim
            e.RepeatingSectionPreTransform = Me.RepeatingSectionField.Text
            e.SendInPlainText = Me.SendInPlaintTextField.Checked
            e.Subject = Me.SubjectField.Text.Trim

            If Me.BvinField.Value = String.Empty Then
                result = Content.EmailTemplate.Insert(e)
            Else
                result = Content.EmailTemplate.Update(e)
            End If

            If result = True Then
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = e.Bvin
            End If
        End If

        Return result
    End Function


End Class

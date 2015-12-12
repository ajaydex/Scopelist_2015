Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVAdmin_People_MailingList_Send
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            PopulateTemplates()
            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadList()
            Else
                Me.BvinField.Value = String.Empty
            End If
        End If
    End Sub

    Private Sub PopulateTemplates()
        Me.EmailTemplateField.DataSource = Content.EmailTemplate.FindAll
        Me.EmailTemplateField.DataTextField = "DisplayName"
        Me.EmailTemplateField.DataValueField = "Bvin"
        Me.EmailTemplateField.DataBind()
    End Sub

    Private Sub LoadList()
        Dim m As Contacts.MailingList
        m = Contacts.MailingList.FindByBvin(Me.BvinField.Value)
        If Not m Is Nothing Then
            If m.Bvin <> String.Empty Then
                Me.lblList.Text = m.Name & " (" & m.Members.Count & " members)"
            End If
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Send Email to Mailing List"
        Me.CurrentTab = AdminTabType.People
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.PeopleView)
    End Sub


    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("MailingLists.aspx")
    End Sub

    Protected Sub btnPreview_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnPreview.Click
        MessageBox1.ClearMessage()
        Preview()
        MessageBox1.ShowInformation("Preview Generated")
    End Sub

    Private Sub Preview()
        Dim m As Contacts.MailingList = Contacts.MailingList.FindByBvin(Me.BvinField.Value)
        If m IsNot Nothing Then
            Dim p As System.Net.Mail.MailMessage = m.PreviewMessage(Me.EmailTemplateField.SelectedValue)
            If p IsNot Nothing Then
                Me.PreviewSubjectField.Text = p.Subject
                Me.PreviewBodyField.Text = p.Body
            End If
        End If
    End Sub

    Protected Sub btnSend_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSend.Click
        MessageBox1.ClearMessage()
        Send()
        MessageBox1.ShowOk("Messages sent to list!")
    End Sub

    Private Sub Send()
        Preview()
        Dim m As Contacts.MailingList = Contacts.MailingList.FindByBvin(Me.BvinField.Value)
        If m IsNot Nothing Then
            m.SendToList(Me.EmailTemplateField.SelectedValue, False)
        End If
    End Sub
End Class

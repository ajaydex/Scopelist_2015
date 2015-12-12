Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Content_CustomPages_Edit
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Page"
        Me.CurrentTab = AdminTabType.Content
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ContentView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            SetSecurityModel()

            PopulateTemplates()
            PopulateColumns()

            Me.NameField.Focus()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                LoadPage()
            Else
                Me.BvinField.Value = String.Empty
            End If
        End If

        Me.TemplatePreviewImage.ImageUrl = Content.ModuleController.FindCustomPageTemplatePreviewImage(Me.TemplateList.SelectedValue, Request.PhysicalApplicationPath)
    End Sub

    Private Sub SetSecurityModel()
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.ContentEdit) = False Then
            Me.btnSaveChanges.Enabled = False
            Me.btnSaveChanges.Visible = False
        End If
    End Sub

    Private Sub PopulateTemplates()
        Me.TemplateList.DataSource = Content.ModuleController.FindCustomPageTemplates()
        Me.TemplateList.DataBind()
        Me.TemplateList.Items.Insert(0, New ListItem("- None - ", ""))
    End Sub

    Private Sub PopulateColumns()
        Dim columns As Collection(Of Content.ContentColumn) = Content.ContentColumn.FindAll()
        For Each col As Content.ContentColumn In columns
            Me.PreContentColumnIdField.Items.Add(New ListItem(col.DisplayName, col.Bvin))
            Me.PostContentColumnIdField.Items.Add(New ListItem(col.DisplayName, col.Bvin))
        Next
    End Sub

    Protected Sub TemplateList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TemplateList.SelectedIndexChanged
        Me.TemplatePreviewImage.ImageUrl = Content.ModuleController.FindCustomPageTemplatePreviewImage(Me.TemplateList.SelectedValue, Request.PhysicalApplicationPath)
    End Sub

    Private Sub LoadPage()
        Dim c As Content.CustomPage
        c = Content.CustomPage.FindByBvin(Me.BvinField.Value)
        If Not c Is Nothing Then
            If c.Bvin <> String.Empty Then
                Me.UrlLiteral.Text = WebAppSettings.SiteStandardRoot.TrimEnd("/"c) & Utilities.UrlRewriter.BuildUrlForCustomPage(c, Me.Page)

                Me.NameField.Text = c.Name
                Me.NameInMenuTextBox.Text = c.MenuName
                Me.ShowInBottomMenuCheckBox.Checked = c.ShowInBottomMenu
                Me.ContentField.Text = c.Content
                If Me.ContentField.SupportsTransform = True Then
                    If c.PreTransformContent.Length > 0 Then
                        Me.ContentField.Text = c.PreTransformContent
                    End If
                End If
                Me.MetaDescriptionField.Text = c.MetaDescription
                Me.MetaKeywordsField.Text = c.MetaKeywords

                Dim customUrl As Content.CustomUrl = Utilities.UrlRewriter.GetCustomUrlForCustomPage(c)
                If customUrl IsNot Nothing Then
                    Me.CustomUrlTextBox.Text = customUrl.RequestedUrl
                Else
                    Me.CustomUrlTextBox.Text = String.Empty
                End If

                Me.MetaTitleField.Text = c.MetaTitle
                If TemplateList.Items.FindByValue(c.TemplateName) IsNot Nothing Then
                    Me.TemplateList.ClearSelection()
                    Me.TemplateList.Items.FindByValue(c.TemplateName).Selected = True
                End If
                If c.PreContentColumnId.Trim <> String.Empty Then
                    If Me.PreContentColumnIdField.Items.FindByValue(c.PreContentColumnId) IsNot Nothing Then
                        Me.PreContentColumnIdField.Items.FindByValue(c.PreContentColumnId).Selected = True
                    End If
                End If
                If c.PostContentColumnId.Trim <> String.Empty Then
                    If Me.PostContentColumnIdField.Items.FindByValue(c.PostContentColumnId) IsNot Nothing Then
                        Me.PostContentColumnIdField.Items.FindByValue(c.PostContentColumnId).Selected = True
                    End If
                End If

                Me.lnkViewInStore.NavigateUrl = Utilities.UrlRewriter.BuildUrlForCustomPage(c.Bvin)
                Me.lnkViewInStore.Visible = True
            End If
        End If
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        If Me.Save() Then
            Response.Redirect("CustomPages.aspx")
        Else
            MessageBox1.ShowError("Unable to save Custom Page")
        End If
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnUpdate.Click
        If Me.Save() Then
            MessageBox1.ShowOk("Custom Page updated")
            LoadPage()
        Else
            MessageBox1.ShowError("Unable to update Custom Page")
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("CustomPages.aspx")
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim c As Content.CustomPage
        c = Content.CustomPage.FindByBvin(Me.BvinField.Value)
        If Not c Is Nothing Then
            ' make sure Custom Url is unique
            Dim url As String = Me.CustomUrlTextBox.Text.Trim()
            If Not String.IsNullOrEmpty(url) Then
                Dim customUrl As Content.CustomUrl = Content.CustomUrl.FindByRequestedUrl(url)
                If Not String.IsNullOrEmpty(customUrl.Bvin) Then
                    ' if we're not updating the custom page and there isn't a conflict between this new custom page and a Custom Url that isn't tied to a BV object
                    If customUrl.SystemData <> c.Bvin OrElse (String.IsNullOrEmpty(c.Bvin) AndAlso String.IsNullOrEmpty(customUrl.SystemData)) Then
                        MessageBox1.ShowError(String.Format("The Custom Url ""{0}"" is already in use. Please choose another Url.", Me.CustomUrlTextBox.Text.Trim()))
                        Return False
                    End If
                End If
            End If

            c.Name = Me.NameField.Text.Trim
            c.MenuName = Me.NameInMenuTextBox.Text.Trim
            c.ShowInBottomMenu = Me.ShowInBottomMenuCheckBox.Checked
            c.Content = Me.ContentField.Text
            c.PreTransformContent = Me.ContentField.PreTransformText
            c.MetaDescription = Me.MetaDescriptionField.Text.Trim()
            c.MetaKeywords = Me.MetaKeywordsField.Text.Trim()
            c.MetaTitle = Me.MetaTitleField.Text.Trim()
            If Me.TemplateList.SelectedValue IsNot Nothing Then
                c.TemplateName = Me.TemplateList.SelectedValue
            Else
                c.TemplateName = String.Empty
            End If
            c.PreContentColumnId = Me.PreContentColumnIdField.SelectedValue
            c.PostContentColumnId = Me.PostContentColumnIdField.SelectedValue

            If Me.BvinField.Value = String.Empty Then
                result = Content.CustomPage.Insert(c)
            Else
                result = Content.CustomPage.Update(c)
            End If

            If result = True Then
                If Not String.IsNullOrEmpty(Me.BvinField.Value) AndAlso String.IsNullOrEmpty(Me.CustomUrlTextBox.Text) Then
                    ' clear existing CustomUrl
                    Dim customUrl As Content.CustomUrl = Utilities.UrlRewriter.GetCustomUrlForCustomPage(c)
                    If customUrl IsNot Nothing Then
                        Content.CustomUrl.Delete(customUrl.Bvin)
                    End If
                End If

                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = c.Bvin

                If Not String.IsNullOrEmpty(Me.CustomUrlTextBox.Text) Then
                    Dim customUrl As Content.CustomUrl = Utilities.UrlRewriter.GetCustomUrlForCustomPage(c)
                    If customUrl IsNot Nothing Then
                        customUrl.SystemUrl = True
                        customUrl.SystemData = c.Bvin
                        customUrl.RedirectToUrl = Utilities.UrlRewriter.BuildPhysicalUrlForCustomPage(c, "")
                        customUrl.RequestedUrl = Me.CustomUrlTextBox.Text
                        Content.CustomUrl.Update(customUrl)
                    Else
                        customUrl = New Content.CustomUrl()
                        customUrl.SystemUrl = True
                        customUrl.SystemData = c.Bvin
                        customUrl.RedirectToUrl = Utilities.UrlRewriter.BuildPhysicalUrlForCustomPage(c, "")
                        customUrl.RequestedUrl = Me.CustomUrlTextBox.Text
                        Content.CustomUrl.Insert(customUrl)
                    End If
                End If
            End If
        End If

        Return result
    End Function

End Class

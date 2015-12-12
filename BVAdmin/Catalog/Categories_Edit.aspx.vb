Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Linq

Partial Class BVAdmin_Catalog_Categories_Edit
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.RegisterWindowScripts()

        If Not Page.IsPostBack Then
            PopulateTemplates()
            PopulateColumns()


            Dim children As New Collection(Of Catalog.Category)()
            If Not String.IsNullOrEmpty(Request.QueryString("id")) Then
                children = Catalog.Category.FindChildren(Request.QueryString("id"))
            End If

            For Each li As ListItem In Catalog.Category.ListFullTreeWithIndents(True)
                ' disable current category and categories that use this category as their parent to prevent recursion problems
                If li.Value = Request.QueryString("id") OrElse children.Any(Function(c) c.Bvin = li.Value) Then
                    li.Attributes.Add("disabled", "disabled")
                ElseIf True Then

                End If

                ParentCategoryDropDownList.Items.Add(li)
            Next

            CustomPageDropDownList.DataSource = Content.CustomPage.FindAll()
            CustomPageDropDownList.DataTextField = "Name"
            CustomPageDropDownList.DataValueField = "bvin"
            CustomPageDropDownList.DataBind()

            Me.NameField.Focus()

            If Request.QueryString("id") IsNot Nothing Then
                Me.BvinField.Value = Request.QueryString("id")
                If Request.QueryString("type") IsNot Nothing Then
                    ViewState("type") = Request.QueryString("type")
                End If
                Dim category As Catalog.Category = LoadCategory()
                If ViewState("type") Is Nothing Then
                    ViewState("type") = category.SourceType
                End If
                CategoryBreadCrumbTrail1.LoadTrail(Request.QueryString("id"))
                InitializeView(category)
                PopulateStoreLink(category, Catalog.Category.FindAllLight())
            Else
                Me.BvinField.Value = String.Empty
                If Request.QueryString("ParentID") IsNot Nothing Then
                    CategoryBreadCrumbTrail1.LoadTrail(Request.QueryString("ParentID"))
                    If Request.QueryString("type") IsNot Nothing Then
                        ViewState("type") = Request.QueryString("type")
                    End If
                    ParentCategoryDropDownList.SelectedValue = Request.QueryString("ParentID")
                    Me.ParentIDField.Value = Request.QueryString("ParentID")
                    InitializeView(Nothing)

                    ' set default template for new category
                    Me.TemplateList.ClearSelection()
                    Me.TemplateList.SelectedValue = WebAppSettings.DefaultCategoryTemplate
                Else
                    Response.Redirect("~/BVAdmin/Catalog/Categories.aspx")
                End If
            End If
        End If
        Me.TemplatePreviewImage.ImageUrl = Content.ModuleController.FindCategoryTemplatePreviewImage(Me.TemplateList.SelectedValue, Request.PhysicalApplicationPath)
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Category"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub PopulateTemplates()
        Me.TemplateList.DataSource = Content.ModuleController.FindCategoryTemplates
        Me.TemplateList.DataBind()
    End Sub

    Private Sub PopulateColumns()
        Dim columns As Collection(Of Content.ContentColumn) = Content.ContentColumn.FindAll
        For Each col As Content.ContentColumn In columns
            Me.PreContentColumnIdField.Items.Add(New ListItem(col.DisplayName, col.Bvin))
            Me.PostContentColumnIdField.Items.Add(New ListItem(col.DisplayName, col.Bvin))
        Next
    End Sub

    Private Function LoadCategory() As Catalog.Category
        Dim c As Catalog.Category
        c = Catalog.Category.FindByBvin(Me.BvinField.Value)
        If Not c Is Nothing Then
            If c.Bvin <> String.Empty Then
                Dim i As Integer = c.SourceType

                Select Case i
                    Case Catalog.CategorySourceType.ByRules
                        Me.lblProductSelection.Text = "Select Criteria"
                    Case Catalog.CategorySourceType.CustomLink
                        Me.lblProductSelection.Text = "Enter Custom Link"
                    Case Catalog.CategorySourceType.CustomPage
                        Me.lblProductSelection.Text = "Select Custom Page"
                    Case Catalog.CategorySourceType.Manual
                        Me.lblProductSelection.Text = "Product Selection"
                End Select

                Me.SourceTypeDropDownList.SelectedValue = i.ToString()

                Me.ParentCategoryDropDownList.SelectedValue = c.ParentId
                Me.NameField.Text = c.Name
                Me.DescriptionField.Text = c.Description
                If Me.DescriptionField.SupportsTransform = True Then
                    If c.PreTransformDescription.Trim.Length > 0 Then
                        Me.DescriptionField.Text = c.PreTransformDescription
                    End If
                End If
                Me.ShortDescriptionField.Text = c.ShortDescription
                Me.MetaDescriptionField.Text = c.MetaDescription
                Me.MetaKeywordsField.Text = c.MetaKeywords
                Me.MetaTitleField.Text = c.MetaTitle
                Me.chkHidden.Checked = c.Hidden
                Me.chkShowInTopMenu.Checked = c.ShowInTopMenu
                Me.BannerImageField.Text = c.BannerImageUrl.ToString
                Me.ImageField.Text = c.ImageUrl.ToString
                Me.MenuOffImageURLField.Text = c.MenuOffImageUrl.ToString
                Me.MenuOnImageURLField.Text = c.MenuOnImageUrl.ToString

                Me.chkCustomPageOpenInNewWindow.Checked = c.CustomPageOpenInNewWindow
                Me.CustomPageUrlField.Text = c.CustomPageUrl.ToString
                Me.CustomPageDropDownList.SelectedValue = c.CustomPageId

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

                If [Enum].IsDefined(GetType(Catalog.CategorySortOrder), c.DisplaySortOrder) AndAlso c.DisplaySortOrder <> Catalog.CategorySortOrder.None Then
                    Me.SortOrderDropDownList.SelectedValue = c.DisplaySortOrder
                Else
                    Me.SortOrderDropDownList.SelectedValue = Catalog.CategorySortOrder.ManualOrder
                End If

                Me.RewriteUrlField.Text = c.RewriteUrl
                Me.chkShowTitle.Checked = c.ShowTitle
                Me.keywords.Text = c.Keywords.ToString

                Me.CustomerOverridableSortOrderCheckBox.Checked = c.CustomerChangeableSortOrder

                LoadCustomUrl(c.Bvin)

                Me.ParentIDField.Value = c.ParentId
            End If
        End If        
        Return c
    End Function

    Private Sub InitializeView(ByVal category As Catalog.Category)
        Dim type As Catalog.CategorySourceType = Nothing
        If category IsNot Nothing Then
            type = category.SourceType
        ElseIf ViewState("type") IsNot Nothing Then
            type = CType(ViewState("type"), Catalog.CategorySourceType)
        End If

        Select Case type
            Case Catalog.CategorySourceType.CustomLink
                ProductSelectionMultiView.ActiveViewIndex = Catalog.CategorySourceType.CustomLink
                Me.lblProductSelection.Text = "Enter Custom Link"
                Me.RewriteUrlField.Enabled = False
            Case Catalog.CategorySourceType.Manual
                ProductSelectionMultiView.ActiveViewIndex = Catalog.CategorySourceType.Manual
                Me.lblProductSelection.Text = "Product Selection"
            Case Catalog.CategorySourceType.ByRules
                ProductSelectionMultiView.ActiveViewIndex = Catalog.CategorySourceType.ByRules
                Me.lblProductSelection.Text = "Select Criteria"
            Case Catalog.CategorySourceType.CustomPage
                ProductSelectionMultiView.ActiveViewIndex = Catalog.CategorySourceType.CustomPage
                Me.lblProductSelection.Text = "Select Custom Page"
                Me.RewriteUrlField.Enabled = False
        End Select
    End Sub

    Private Sub PopulateStoreLink(ByVal c As Catalog.Category, ByVal allCats As Collection(Of Catalog.Category))

        Dim m As New HyperLink
        m.ImageUrl = "~/BVAdmin/Images/Buttons/ViewInStore.png"
        m.ToolTip = c.MetaTitle
        m.NavigateUrl = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, allCats)

        If c.SourceType = Catalog.CategorySourceType.CustomLink Then
            If c.CustomPageOpenInNewWindow = True Then
                m.Target = "_blank"
            End If
        End If

        m.EnableViewState = False
        Me.inStore.Controls.Add(m)
    End Sub

    Private Sub LoadCustomUrl(ByVal categoryId As String)
        If Me.RewriteUrlField.Text.Trim = String.Empty Then
            ' Attempt to find existing rewrite records
            Dim c As Content.CustomUrl = Content.CustomUrl.FindBySystemData(categoryId)
            If c IsNot Nothing Then
                Me.RewriteUrlField.Text = c.RequestedUrl
            End If
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        Dim c As Catalog.Category
        c = Catalog.Category.FindByBvin(Me.BvinField.Value)
        If Not c Is Nothing Then
            ' make sure Rewrite Url is unique
            Dim rewriteUrl As String = Me.RewriteUrlField.Text.Trim()
            If Not String.IsNullOrEmpty(rewriteUrl) Then
                Dim customUrl As Content.CustomUrl = Content.CustomUrl.FindByRequestedUrl(rewriteUrl)
                If Not String.IsNullOrEmpty(customUrl.Bvin) Then
                    ' if we're not updating the category and there isn't a conflict between this new category and a Custom Url that isn't tied to a BV object
                    If customUrl.SystemData <> c.Bvin OrElse (String.IsNullOrEmpty(c.Bvin) AndAlso String.IsNullOrEmpty(customUrl.SystemData)) Then
                        Me.lblError.Text = "Rewrite Url already exists! Please choose another Url."
                        Return False
                    End If
                End If
            End If

            c.Name = Me.NameField.Text.Trim
            c.Description = Me.DescriptionField.Text.Trim
            c.PreTransformDescription = Me.DescriptionField.PreTransformText
            c.ShortDescription = Me.ShortDescriptionField.Text
            c.MetaDescription = Me.MetaDescriptionField.Text.Trim
            c.MetaTitle = Me.MetaTitleField.Text.Trim
            c.MetaKeywords = Me.MetaKeywordsField.Text.Trim
            c.ShowInTopMenu = Me.chkShowInTopMenu.Checked
            c.Hidden = Me.chkHidden.Checked
            c.BannerImageUrl = Me.BannerImageField.Text.Trim
            c.ImageUrl = Me.ImageField.Text.Trim
            c.MenuOnImageUrl = Me.MenuOnImageURLField.Text.Trim
            c.MenuOffImageUrl = Me.MenuOffImageURLField.Text.Trim
            If CType(ViewState("type"), Catalog.CategorySourceType) = Catalog.CategorySourceType.ByRules Then
                c.SourceType = Catalog.CategorySourceType.ByRules
            ElseIf CType(ViewState("type"), Catalog.CategorySourceType) = Catalog.CategorySourceType.CustomLink Then
                c.SourceType = Catalog.CategorySourceType.CustomLink
            ElseIf CType(ViewState("type"), Catalog.CategorySourceType) = Catalog.CategorySourceType.Manual Then
                c.SourceType = Catalog.CategorySourceType.Manual
            ElseIf CType(ViewState("type"), Catalog.CategorySourceType) = Catalog.CategorySourceType.CustomPage Then
                c.SourceType = Catalog.CategorySourceType.CustomPage
            End If
            c.CustomPageUrl = Me.CustomPageUrlField.Text.Trim
            c.CustomPageOpenInNewWindow = Me.chkCustomPageOpenInNewWindow.Checked
            If Me.TemplateList.SelectedValue IsNot Nothing Then
                c.TemplateName = Me.TemplateList.SelectedValue
            Else
                c.TemplateName = String.Empty
            End If
            c.PreContentColumnId = Me.PreContentColumnIdField.SelectedValue
            c.PostContentColumnId = Me.PostContentColumnIdField.SelectedValue
            c.DisplaySortOrder = Me.SortOrderDropDownList.SelectedValue
            c.RewriteUrl = Me.RewriteUrlField.Text.Trim
            c.ShowTitle = Me.chkShowTitle.Checked
            c.Keywords = Me.keywords.Text.Trim
            c.CustomPageId = Me.CustomPageDropDownList.SelectedValue
            c.CustomerChangeableSortOrder = Me.CustomerOverridableSortOrderCheckBox.Checked
            If c.ParentId <> Me.ParentCategoryDropDownList.SelectedValue Then
                c.ParentId = Me.ParentCategoryDropDownList.SelectedValue

                ' set SortOrder
                Dim siblings As Collection(Of Catalog.Category) = Catalog.Category.FindChildren(c.ParentId)
                If siblings.Count > 0 Then
                    c.SortOrder = siblings.Last().SortOrder + 1
                End If
            End If

            Me.ParentIDField.Value = Me.ParentCategoryDropDownList.SelectedValue

            If Me.BvinField.Value = String.Empty Then
                result = Catalog.Category.Insert(c)
            Else
                result = Catalog.Category.Update(c)
            End If

            If result = False Then
                Me.lblError.Text = "Unable to save category. Unknown error."
            Else
                ' Update bvin field so that next save will call updated instead of create
                Me.BvinField.Value = c.Bvin
            End If

            ' Save Customized Url
            If Me.RewriteUrlField.Text.Trim.Length > 0 Then
                ' Create or update Custom Url
                Dim curl As Content.CustomUrl = Content.CustomUrl.FindBySystemData(c.Bvin)
                If curl IsNot Nothing Then
                    curl.SystemUrl = True
                    curl.SystemData = c.Bvin
                    curl.RequestedUrl = Me.RewriteUrlField.Text.Trim
                    curl.RedirectToUrl = Utilities.UrlRewriter.BuildPhysicalUrlForCategory(c, "")
                    If curl.Bvin <> String.Empty Then
                        Content.CustomUrl.Update(curl)
                    Else
                        Content.CustomUrl.Insert(curl)
                    End If
                End If
            Else
                ' Delete any system custom Urls
                Dim target As Content.CustomUrl = Content.CustomUrl.FindBySystemData(c.Bvin)
                If target IsNot Nothing Then
                    If target.Bvin <> String.Empty Then
                        Content.CustomUrl.Delete(target.Bvin)
                    End If
                End If
            End If


        End If

        Return result
    End Function

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("Categories.aspx?id=" & Me.ParentIDField.Value)
    End Sub

    Protected Sub btnSaveChanges_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSaveChanges.Click
        Me.lblError.Text = String.Empty

        If Save() = True Then
            Response.Redirect("Categories.aspx?id=" & Me.ParentIDField.Value)
        End If
    End Sub

    Private Sub RegisterWindowScripts()

        Dim sb As New StringBuilder

        sb.Append("var w;")
        sb.Append("function popUpWindow(parameters) {")
        sb.Append("w = window.open('../ImageBrowser.aspx' + parameters, 'imagebrowser', 'height=505, width=950');")
        sb.Append("}")

        sb.Append("function closePopup() {")
        sb.Append("w.close();")
        sb.Append("}")

        sb.Append("function SetIconImage(fileName) {")
        sb.Append("document.getElementById('")
        sb.Append(Me.ImageField.ClientID)
        sb.Append("').value = fileName;")
        sb.Append("w.close();")
        sb.Append("}")

        sb.Append("function SetBannerImage(fileName) {")
        sb.Append("document.getElementById('")
        sb.Append(Me.BannerImageField.ClientID)
        sb.Append("').value = fileName;")
        sb.Append("w.close();")
        sb.Append("}")

        sb.Append("function SetMenuOnImage(fileName) {")
        sb.Append("document.getElementById('")
        sb.Append(Me.MenuOnImageURLField.ClientID)
        sb.Append("').value = fileName;")
        sb.Append("w.close();")
        sb.Append("}")

        sb.Append("function SetMenuOffImage(fileName) {")
        sb.Append("document.getElementById('")
        sb.Append(Me.MenuOffImageURLField.ClientID)
        sb.Append("').value = fileName;")
        sb.Append("w.close();")
        sb.Append("}")

        'Script for description counter
        sb.Append("function textCounter() {")
        sb.Append("var maxlimit;")
        sb.Append("maxlimit=512;")
        sb.Append("var field;")
        sb.Append("field = document.getElementById('")
        sb.Append(Me.ShortDescriptionField.ClientID)
        sb.Append("'); ")
        sb.Append("if (field.value.length > maxlimit) {")
        sb.Append(" field.value = field.value.substring(0, maxlimit); }")
        sb.Append("else")
        sb.Append("{ document.getElementById('")
        sb.Append(Me.CountField.ClientID)
        sb.Append("').value = maxlimit - field.value.length; }")
        sb.Append("}")

        Me.ShortDescriptionField.Attributes.Add("onkeyup", "textCounter();")

        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "WindowScripts", sb.ToString, True)

    End Sub

    Protected Sub TemplateList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TemplateList.SelectedIndexChanged
        Me.TemplatePreviewImage.ImageUrl = Content.ModuleController.FindCategoryTemplatePreviewImage(Me.TemplateList.SelectedValue, Request.PhysicalApplicationPath)
    End Sub

    Protected Sub btnSelectProducts_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSelectProducts.Click
        If Me.Save = True Then
            Response.Redirect("Categories_ManualSelection.aspx?id=" & Me.BvinField.Value & "&type=" & ViewState("type"))
        End If
    End Sub

    Protected Sub SelectDynamicProductImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SelectDynamicProductImageButton.Click
        If Me.Save = True Then
            Response.Redirect("Categories_AutomaticSelection.aspx?id=" & Me.BvinField.Value & "&type=" & ViewState("type"))
        End If
    End Sub

    Protected Sub UpdateButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles UpdateButton.Click
        Me.lblError.Text = String.Empty
        If Me.Save() Then
            MessageBox1.ShowOk("Category Updated Successfully.")
            Dim cat As Catalog.Category = Catalog.Category.FindByBvin(Me.BvinField.Value)
            If cat IsNot Nothing AndAlso cat.Bvin <> String.Empty Then

                PopulateStoreLink(cat, Catalog.Category.FindAllLight())
            End If
        Else
            MessageBox1.ShowError("Error during update. Please check event log.")
        End If
    End Sub

    Protected Sub SourceTypeDropDownList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles SourceTypeDropDownList.SelectedIndexChanged
        Me.lblError.Text = String.Empty

        Dim c As Catalog.Category = Catalog.Category.FindByBvin(Me.BvinField.Value)
        If Not String.IsNullOrEmpty(c.Bvin) Then
            ViewState("type") = Me.SourceTypeDropDownList.SelectedValue

            Dim result As Boolean = Me.Save()
            If result = True Then
                c = LoadCategory()
                CategoryBreadCrumbTrail1.LoadTrail(c.Bvin)
                InitializeView(c)
                PopulateStoreLink(c, Catalog.Category.FindAllLight())
            Else
                MessageBox1.ShowError("Unable to change Category Type. Please check the Audit Log for details.")
            End If
        End If
    End Sub

End Class
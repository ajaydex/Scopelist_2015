Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Plugins_FeedEngine_FeedEdit
    Inherits BaseAdminPage

    Private Feed As FeedEngine.BaseFeed = Nothing
    Private FeedTypeEditor As FeedEngine.FeedTemplate = Nothing
    Private FeedEditor As FeedEngine.FeedTemplate = Nothing

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Feed"
        Me.CurrentTab = AdminTabType.Plugins
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogEdit)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim bvin As String = Request.QueryString("id")
        If Not String.IsNullOrEmpty(bvin) Then
            Me.Feed = FeedEngine.AvailableFeeds.FindByBvin(bvin)
        End If

        If Not Page.IsPostBack Then
            If Feed IsNot Nothing Then
                InitializeBaseForm()
                LoadFeedEditor(True)
            Else
                Response.Redirect("Default.aspx")
            End If
        Else
            LoadFeedEditor(False)
        End If
    End Sub

    Protected Sub InitializeBaseForm()
        Me.hTitle.InnerText = String.Format("Edit {0} feed", Me.Feed.FeedName)

        Me.ddlAffiliateID.DataSource = Contacts.Affiliate.FindAll()
        Me.ddlAffiliateID.DataTextField = "DisplayName"
        Me.ddlAffiliateID.DataValueField = "bvin"
        Me.ddlAffiliateID.DataBind()
        Me.ddlAffiliateID.Items.Insert(0, New ListItem("-None-", String.Empty))

        If Not String.IsNullOrEmpty(Me.Feed.AffiliateID) Then
            For Each li As ListItem In ddlAffiliateID.Items
                If li.Value = Me.Feed.AffiliateID Then
                    li.Selected = True
                End If
            Next
        End If

        Me.lblFilePath.Text = "/" + Me.Feed.FileFolderPath.Replace("\", "/")
        Me.txtFileName.Text = Me.Feed.FileName

        If System.IO.File.Exists(Me.Feed.PhysicalFilePath) Then
            Me.lnkFeed.Visible = True
            Me.lnkFeed.Text = Me.Feed.FileUrl
            Me.lnkFeed.NavigateUrl = Me.Feed.FileUrl
        Else
            lnkFeed.Visible = False
        End If

        Me.txtHostName.Text = Me.Feed.HostName
        Me.txtUserName.Text = Me.Feed.UserName
        Me.txtPassword.Text = If(Me.Feed.Password.Length > 0, "**********", String.Empty)
    End Sub

    Protected Sub LoadFeedEditor(ByVal force As Boolean)
        Me.FeedEditor = CType(Content.ModuleController.LoadFeedEditor(Me.Feed.FeedName, Me), FeedEngine.FeedTemplate)
        If Me.FeedEditor IsNot Nothing Then
            Me.FeedEditor.ID = "FeedEditor"
            Me.FeedEditor.BlockId = Me.Feed.Bvin
            Me.FeedEditor.Feed = Me.Feed
            AddControlToEditPanel(Me.FeedEditor, Me.EditPlaceHolder)
            Me.FeedEditor.Initialize(force)
        End If

        Me.FeedTypeEditor = CType(Content.ModuleController.LoadFeedTypeEditor(Me.Feed.FeedType, Me), FeedEngine.FeedTemplate)
        If Me.FeedTypeEditor IsNot Nothing Then
            Me.FeedTypeEditor.ID = "FeedTypeEditor"
            Me.FeedTypeEditor.BlockId = Me.Feed.Bvin
            Me.FeedTypeEditor.Feed = Me.Feed
            AddControlToEditPanel(Me.FeedTypeEditor, Me.FeedTypeEditPlaceHolder)
            Me.FeedTypeEditor.Initialize(force)
        End If
    End Sub

    Protected Sub AddControlToEditPanel(ByVal control As UserControl, ByVal containerControl As PlaceHolder)
        containerControl.Controls.Clear()
        containerControl.Controls.Add(control)
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubmit.Click
        If Page.IsValid Then
            Try
                Me.Feed.FileName = Me.txtFileName.Text.Trim()
                Me.Feed.HostName = Me.txtHostName.Text.ToLower().Trim()
                Me.Feed.UserName = Me.txtUserName.Text.Trim()
                If Me.txtPassword.Text <> "**********" Then
                    Me.Feed.Password = Me.txtPassword.Text.Trim()
                End If
                Me.Feed.AffiliateID = Me.ddlAffiliateID.SelectedValue

                If Me.FeedEditor IsNot Nothing Then
                    Me.FeedEditor.Save()
                End If
                If Me.FeedTypeEditor IsNot Nothing Then
                    Me.FeedTypeEditor.Save()
                End If
                Me.Feed.SaveSettings()

                Response.Redirect("Default.aspx")
            Catch ex As Exception
                Me.ucMessageBox.ShowError("An error occurred while trying to save the feed settings to the database.")
            End Try
        End If
    End Sub

End Class
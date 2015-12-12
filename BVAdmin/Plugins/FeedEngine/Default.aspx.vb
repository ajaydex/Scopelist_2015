Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core

Partial Class BVAdmin_Plugins_FeedEngine_Default
    Inherits BaseAdminPage

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Feed Engine"
        Me.CurrentTab = AdminTabType.Plugins
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogEdit)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadFeedGroups()
        End If
    End Sub

    Private Sub LoadFeedGroups()
        Me.rpFeedTypes.DataSource = FeedEngine.AvailableFeeds.FindAllTypes()
        Me.rpFeedTypes.DataBind()
    End Sub

    Protected Sub rpFeedTypes_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles rpFeedTypes.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim feedType As String = e.Item.DataItem.ToString()
            Dim lblFeedType As Label = DirectCast(e.Item.FindControl("lblFeedType"), Label)
            lblFeedType.Text = String.Format("{0} Feeds", feedType)

            Dim ucFeedGroup As BVAdmin_Plugins_FeedEngine_FeedGroup = DirectCast(e.Item.FindControl("ucFeedGroup"), BVAdmin_Plugins_FeedEngine_FeedGroup)
            ucFeedGroup.Feeds = FeedEngine.AvailableFeeds.FindByType(feedType)
        End If
    End Sub

End Class
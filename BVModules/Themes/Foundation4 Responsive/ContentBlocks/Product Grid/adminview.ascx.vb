Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Product_Grid_adminview
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadProductGrid()
    End Sub

    Private Sub LoadProductGrid()
        Dim myProducts As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("ProductGrid")
        If myProducts IsNot Nothing Then
            Me.DataList1.DataSource = myProducts
            Me.DataList1.DataBind()
            Me.DataList1.RepeatColumns = SettingsManager.GetIntegerSetting("GridColumns")
        End If
        Me.PreHtml.Text = SettingsManager.GetSetting("PreHtml")
        Me.PostHtml.Text = SettingsManager.GetSetting("PostHtml")
    End Sub

End Class

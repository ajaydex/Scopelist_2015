Imports System.Collections.ObjectModel
Imports BVSoftware.BVC5.Core


Partial Class BVModules_ContentBlocks_Product_Reviews_List_view
    Inherits Content.BVModule

    Private _PreContentHtml As String = String.Empty
    Private _PostContentHtml As String = String.Empty

#Region " Properties "

    Public Property PreContentHtml() As String
        Get
            Return Me._PreContentHtml
        End Get
        Set(ByVal value As String)
            Me._PreContentHtml = value
        End Set
    End Property

    Public Property PostContentHtml() As String
        Get
            Return Me._PostContentHtml
        End Get
        Set(ByVal value As String)
            Me._PostContentHtml = value
        End Set
    End Property

#End Region

    Protected Overrides Sub OnInit(ByVal e As System.EventArgs)
        MyBase.OnInit(e)

        Me.EnableViewState = False
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.ucProductReviewsList.Title = SettingsManager.GetSetting("Title")
        Me.ucProductReviewsList.MinimumRating = SettingsManager.GetIntegerSetting("MinimumRating")
        Me.ucProductReviewsList.IgnoreBadKarma = SettingsManager.GetBooleanSetting("IgnoreBadKarma")
        Me.ucProductReviewsList.IgnoreAnonymousReviews = SettingsManager.GetBooleanSetting("IgnoreAnonymousReviews")
        Me.ucProductReviewsList.CategoryId = SettingsManager.GetSetting("CategoryId")
        Me.ucProductReviewsList.NumberOfItems = SettingsManager.GetIntegerSetting("NumberOfItems")
        Me.ucProductReviewsList.TruncateReview = SettingsManager.GetBooleanSetting("TruncateReview")
        Me.ucProductReviewsList.TruncateReviewLength = SettingsManager.GetIntegerSetting("TruncateReviewLength")
        Me.ucProductReviewsList.DateFormat = SettingsManager.GetSetting("DateFormat")

        Me.litPreContentHtml.Text = SettingsManager.GetSetting("PreContentHtml_HtmlData")
        Me.litPostContentHtml.Text = SettingsManager.GetSetting("PostContentHtml_HtmlData")
    End Sub

End Class
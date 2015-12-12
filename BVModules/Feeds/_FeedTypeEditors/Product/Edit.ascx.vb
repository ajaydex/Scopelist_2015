Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Feeds__FeedTypeEditors_Product_Edit
    Inherits FeedEngine.FeedTemplate


    Public Overloads Overrides Sub Initialize()
        Dim feed As FeedEngine.BaseProductFeed = DirectCast(Me.Feed, FeedEngine.BaseProductFeed)

        Me.chkIncludeChoiceCombinations.Checked = feed.IncludeChoiceCombinations
        Me.chkIncludeChoiceCombinationParents.Checked = feed.IncludeChoiceCombinationParents
    End Sub

    Public Overrides Sub Save()
        Dim feed As FeedEngine.BaseProductFeed = DirectCast(Me.Feed, FeedEngine.BaseProductFeed)

        feed.IncludeChoiceCombinations = Me.chkIncludeChoiceCombinations.Checked
        feed.IncludeChoiceCombinationParents = Me.chkIncludeChoiceCombinationParents.Checked

        feed.SaveSettings()
    End Sub

    Public Overrides Sub Cancel()

    End Sub

End Class
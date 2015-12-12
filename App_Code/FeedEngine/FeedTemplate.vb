Namespace FeedEngine

    Public MustInherit Class FeedTemplate
        Inherits BVSoftware.Bvc5.Core.Content.BVModule

        Private _Feed As FeedEngine.BaseFeed

        Public Property Feed As FeedEngine.BaseFeed
            Get
                Return Me._Feed
            End Get
            Set(value As FeedEngine.BaseFeed)
                Me._Feed = value
            End Set
        End Property

        Public MustOverride Sub Save()

        Public MustOverride Sub Cancel()

        Public MustOverride Sub Initialize()

        Public Sub Initialize(ByVal force As Boolean)
            If force OrElse (Not Page.IsPostBack) Then
                Initialize()
            End If
        End Sub

    End Class

End Namespace
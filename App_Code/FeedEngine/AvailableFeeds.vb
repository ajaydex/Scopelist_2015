Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.Linq

Namespace FeedEngine

    <Serializable()> _
    Public Class AvailableFeeds

        Private Shared _Feeds As New Collection(Of BaseFeed)
        Private Shared _FeedLock As New Object()

        Public Shared Property Feeds As Collection(Of BaseFeed)
            Get
                Return _Feeds
            End Get
            Set(value As Collection(Of BaseFeed))
                SyncLock _FeedLock
                    _Feeds = value
                End SyncLock
            End Set
        End Property


        Public Shared Function FindByBvin(ByVal bvin As String) As BaseFeed
            Return Feeds.FirstOrDefault(Function(f) String.Compare(f.Bvin, bvin, StringComparison.InvariantCultureIgnoreCase) = 0)
        End Function

        Public Shared Function FindByName(ByVal feedName As String) As BaseFeed
            Return Feeds.FirstOrDefault(Function(f) String.Compare(f.FeedName, feedName, StringComparison.InvariantCultureIgnoreCase) = 0)
        End Function

        Public Shared Function FindByType(ByVal feedType As String) As List(Of BaseFeed)
            Return Feeds.Where(Function(f) String.Compare(f.FeedType, feedType, StringComparison.InvariantCultureIgnoreCase) = 0).ToList()
        End Function

        Public Shared Function FindAllTypes() As List(Of String)
            Return Feeds.GroupBy(Function(g) g.FeedType).Select(Function(s) s.First()).Select(Function(t) t.FeedType).ToList()
        End Function

    End Class

End Namespace
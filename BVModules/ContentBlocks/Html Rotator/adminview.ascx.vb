Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_ContentBlocks_Html_Rotator_adminview
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadHtml()
    End Sub

    Private Sub LoadHtml()
        Dim myHtml As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Html")
        If myHtml IsNot Nothing Then
            If myHtml.Count > 0 Then
                Dim displayIndex As Integer = GetContentIndex(myHtml.Count - 1)
                Me.lblHtml.Text = Server.HtmlEncode(myHtml(displayIndex).Setting1)
            Else
                Me.lblHtml.Text = "No Html Configured"
            End If
        End If
    End Sub

    Private Function GetContentIndex(ByVal maxIndex As Integer) As Integer
        Dim result As Integer = 0

        If SettingsManager.GetBooleanSetting("ShowInOrder") = True Then

            ' Find the next image index to show in sequence
            Dim nextIndex As String = Me.NextContentIndex

            ' Make sure index is a valid integer
            If nextIndex = String.Empty Then
                result = 0
            Else
                result = Integer.Parse(nextIndex, System.Globalization.CultureInfo.InvariantCulture)
            End If

            ' Make sure result is at least zero
            If result < 0 Then
                result = 0
            End If

            ' Make sure result is not greater than the maximum allowed size
            If result > maxIndex Then
                result = maxIndex
            End If

            ' We have a valid number now, save the next index for next time.
            Dim saveIndex As Integer = result + 1
            If saveIndex > maxIndex Then
                saveIndex = 0
            End If
            Me.NextContentIndex = saveIndex.ToString(System.Globalization.CultureInfo.InvariantCulture)

        Else
            ' Select Random Image
            result = BVSoftware.Web.RandomNumbers.RandomInteger(maxIndex, 0)
        End If

        Return result
    End Function

    Private Property NextContentIndex() As String
        Get
            If Session(Me.BlockId & "BVSoftware.HtmlRotator.NextContentIndex") Is Nothing Then
                Return String.Empty
            Else
                Return CType(Session(Me.BlockId & "BVSoftware.HtmlRotator.NextContentIndex"), String)
            End If
        End Get
        Set(ByVal value As String)
            Session(Me.BlockId & "BVSoftware.HtmlRotator.NextContentIndex") = value
        End Set
    End Property

End Class

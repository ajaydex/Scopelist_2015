Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_ContentBlocks_Image_Rotator_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadImage()
    End Sub

    Private Sub LoadImage()
        Dim myImages As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Images")
        If myImages IsNot Nothing Then
            If myImages.Count > 0 Then
                Dim displayIndex As Integer = GetImageIndex(myImages.Count - 1)
                SetImage(myImages(displayIndex))
            End If
        End If
        Me.PreHtml.Text = SettingsManager.GetSetting("PreHtml")
        Me.PostHtml.Text = SettingsManager.GetSetting("PostHtml")
    End Sub

    Private Sub SetImage(ByVal data As Content.ComponentSettingListItem)
        Me.lnkMain.ImageUrl = Page.ResolveUrl(data.Setting1)
        If data.Setting2.Trim = String.Empty Then
            lnkMain.NavigateUrl = ""
            lnkMain.Target = ""
        Else
            lnkMain.NavigateUrl = data.Setting2
            If data.Setting3 = "1" Then
                lnkMain.Target = "_blank"
            Else
                lnkMain.Target = ""
            End If
        End If
        Me.lnkMain.ToolTip = data.Setting4
    End Sub

    Private Function GetImageIndex(ByVal maxIndex As Integer) As Integer
        Dim result As Integer = 0

        If SettingsManager.GetBooleanSetting("ShowInOrder") = True Then

            ' Find the next image index to show in sequence
            Dim nextIndex As String = Me.NextImageIndex

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
            Me.NextImageIndex = saveIndex.ToString(System.Globalization.CultureInfo.InvariantCulture)

        Else
            ' Select Random Image
            result = BVSoftware.Web.RandomNumbers.RandomInteger(maxIndex, 0)
        End If

        Return result
    End Function

    Private Property NextImageIndex() As String
        Get
            If Session(Me.BlockId & "BVSoftware.ImageRotator.NextImageIndex") Is Nothing Then
                Return String.Empty
            Else
                Return CType(Session(Me.BlockId & "BVSoftware.ImageRotator.NextImageIndex"), String)
            End If
        End Get
        Set(ByVal value As String)
            Session(Me.BlockId & "BVSoftware.ImageRotator.NextImageIndex") = value
        End Set
    End Property

End Class

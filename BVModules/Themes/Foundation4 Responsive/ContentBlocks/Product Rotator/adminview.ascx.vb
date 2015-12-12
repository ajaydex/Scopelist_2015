Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Product_Rotator_adminview
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadProduct()
    End Sub

    Private Sub LoadProduct()
        Dim myProducts As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("Products")
        If myProducts IsNot Nothing Then
            If myProducts.Count > 0 Then
                Dim displayIndex As Integer = GetProductIndex(myProducts.Count - 1)
                SetProducts(myProducts(displayIndex))
            End If
        End If
        Me.PreHtml.Text = Server.HtmlEncode(SettingsManager.GetSetting("PreHtml"))
        Me.PostHtml.Text = Server.HtmlEncode(SettingsManager.GetSetting("PostHtml"))
    End Sub

    Private Sub SetProducts(ByVal data As Content.ComponentSettingListItem)
        Me.lnkMain.ImageUrl = data.Setting4
        If data.Setting2.Trim = String.Empty Then
            lnkMain.NavigateUrl = ""
            lnkMain.Target = ""
        Else
            lnkMain.NavigateUrl = data.Setting5
        End If
        Me.lnkMain.ToolTip = data.Setting3
    End Sub

    Private Function GetProductIndex(ByVal maxIndex As Integer) As Integer
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
            If Session(Me.BlockId & "BVSoftware.ProductRotator.NextProductIndex") Is Nothing Then
                Return String.Empty
            Else
                Return CType(Session(Me.BlockId & "BVSoftware.ProductRotator.NextProductIndex"), String)
            End If
        End Get
        Set(ByVal value As String)
            Session(Me.BlockId & "BVSoftware.ProductRotator.NextProductIndex") = value
        End Set
    End Property

End Class

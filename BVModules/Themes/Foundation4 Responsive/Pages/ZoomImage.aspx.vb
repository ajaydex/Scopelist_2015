Imports BVSoftware.Bvc5.Core
Imports System.IO
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Drawing.Drawing2D
Imports System.Collections.Generic
Imports System.Collections.ObjectModel


Partial Class BVModules_Themes_Foundation4_Responsive_Pages_ZoomImage
    Inherits BaseStorePage

    Private _Images As New Collection(Of Catalog.ProductImage)

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Popup.master")
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Page.Title = "Additional Images"
            Me.ProductIdField.Value = Request.QueryString("ProductId")
            LoadImages("")
        End If
    End Sub

    Private Sub LoadImages(ByVal bvin As String)

        Try
            Dim images As Collection(Of Catalog.ProductImage) = Catalog.ProductImage.FindByProductId(Me.ProductIdField.Value)
            If images IsNot Nothing Then
                Me.lstImages.DataSource = images
                Me.lstImages.DataBind()
            End If

            If bvin = String.Empty Then
                If images.Count > 0 Then
                    Me.imgMain.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(images(0).FileName, True))
                    Me.imgMain.AlternateText = images(0).Caption
                    Me.imgMain.ToolTip = images(0).Caption
                    Me.defaultCaption.Text = images(0).Caption
                End If
            Else
                For i As Integer = 0 To images.Count - 1
                    If images(i).Bvin.Trim.ToLower = bvin.Trim.ToLower Then
                        Me.imgMain.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(images(i).FileName, True))
                        Me.imgMain.AlternateText = images(i).Caption
                        Me.imgMain.ToolTip = images(i).Caption
                        Me.defaultCaption.Text = images(i).Caption
                    End If
                Next
            End If
        Catch ex As Exception
            'EventLog.LogEvent(ex)
        End Try

    End Sub

    Protected Sub lstImages_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles lstImages.EditCommand
        Dim bvin As String = CStr(Me.lstImages.DataKeys(e.Item.ItemIndex))
        LoadImages(bvin)
    End Sub

    Protected Sub lstImages_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles lstImages.ItemDataBound
        Dim btnLink As ImageButton = e.Item.FindControl("btnLink")
        If btnLink IsNot Nothing Then
            Dim pi As Catalog.ProductImage = CType(e.Item.DataItem, Catalog.ProductImage)
            btnLink.AlternateText = pi.AlternateText
            btnLink.ToolTip = pi.AlternateText
            btnLink.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(pi.FileName, True))

            Dim newInfo As New Utilities.ImageInfo
            If pi.FileName.ToLower.StartsWith("http://") Then
                newInfo.Width = WebAppSettings.ImagesSmallWidth
                newInfo.Height = WebAppSettings.ImagesSmallHeight
            Else
                Dim filePath As String = Page.MapPath(pi.FileName)
                Dim iInfo As Utilities.ImageInfo = Utilities.ImageHelper.GetImageInformation(filePath)
                If iInfo.Width = 0 AndAlso iInfo.Height = 0 Then
                    iInfo.Width = WebAppSettings.ImagesSmallWidth
                    iInfo.Height = WebAppSettings.ImagesSmallHeight
                End If
                newInfo = Utilities.ImageHelper.GetProportionalImageDimensionsForImage(iInfo, WebAppSettings.ImagesSmallWidth, WebAppSettings.ImagesSmallHeight)
            End If
            btnLink.Width = System.Web.UI.WebControls.Unit.Pixel(newInfo.Width)
            btnLink.Height = System.Web.UI.WebControls.Unit.Pixel(newInfo.Height)
        End If
    End Sub

End Class

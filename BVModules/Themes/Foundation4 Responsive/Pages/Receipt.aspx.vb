Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_Pages_Receipt
    Inherits BaseStorePage

    Private _Order As Orders.Order = New Orders.Order()

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Public Property Order() As Orders.Order
        Get
            If Me._Order Is Nothing OrElse String.IsNullOrEmpty(Me._Order.Bvin) Then
                Dim bvin As String = Request.Params("id")
                If Not String.IsNullOrEmpty(bvin) Then
                    Me._Order = Orders.Order.FindByBvin(bvin)
                Else
                    Me._Order = New Orders.Order()
                End If
            End If

            Return Me._Order
        End Get
        Set(value As Orders.Order)
            Me._Order = value
        End Set
    End Property

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Checkout.master")
    End Sub

    Private Sub PageLoad(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
        If Not Page.IsPostBack Then
            Me.Page.Title = "Order Receipt"
            BindGrids()
            LoadOrder()
        End If
    End Sub

    Private Sub LoadOrder()
        If Request.Params("id") IsNot Nothing Then
            Dim o As Orders.Order = Orders.Order.FindByBvin(Request.Params("id"))
            If o IsNot Nothing Then
                Me.Order = o

                Me.ViewOrder1.OrderBvin = o.Bvin
                Me.ViewOrder1.LoadOrder()

                RenderAnalytics(o)
            End If
        Else
            Me.lblOrderNumber.Text = "Order Number missing. Please contact an administrator."
        End If
    End Sub

    Private Sub RenderAnalytics(ByVal o As Orders.Order)
        If Me.AnalyticsTags1 IsNot Nothing Then
            If WebAppSettings.AnalyticsUseGoogleAdwords Then
                Me.AnalyticsTags1.RenderGoogleAdwordTracker(o.GrandTotal, _
                                                         WebAppSettings.AnalyticsGoogleAdwordsConversionId, _
                                                         WebAppSettings.AnalyticsGoogleAdwordsConversionLabel, _
                                                         WebAppSettings.AnalyticsGoogleAdwordsBackgroundColor, _
                                                         Request.IsSecureConnection())
            End If

            If WebAppSettings.GoogleTrustedStoresEnabled Then
                Me.AnalyticsTags1.RenderGoogleTrustedStoresOrderConfirmation(o, _
                                                                             WebAppSettings.GoogleShoppingAccountID, _
                                                                             WebAppSettings.GoogleShoppingCountry, _
                                                                             WebAppSettings.GoogleShoppingLanguage)
            End If

            If WebAppSettings.AnalyticsUseYahoo Then
                Me.AnalyticsTags1.RenderYahooTracker(o, WebAppSettings.AnalyticsYahooAccountId)
            End If

            If WebAppSettings.AnalyticsUseMicrosoftAdCenter Then
                Me.AnalyticsTags1.RenderMicrosoftAdCenterTracker(o)
            End If
        End If
    End Sub

    Private Sub BindGrids()

        Dim o As Orders.Order
        o = Orders.Order.FindByBvin(Request.QueryString("id"))

        If (o.PaymentStatus = Orders.OrderPaymentStatus.Paid) AndAlso (o.StatusCode <> WebAppSettings.OrderStatusCodeOnHold) Then
            Dim files As New Collection(Of Catalog.ProductFile)
            For Each item As Orders.LineItem In o.Items
                If item.ProductId <> String.Empty Then
                    Dim productFiles As Collection(Of Catalog.ProductFile) = Catalog.ProductFile.FindByProductId(item.ProductId)
                    For Each file As Catalog.ProductFile In productFiles
                        files.Add(file)
                    Next
                End If
                If item.AssociatedProduct IsNot Nothing Then
                    If item.AssociatedProduct.ParentId <> String.Empty Then
                        Dim parentProductFiles As Collection(Of Catalog.ProductFile) = Catalog.ProductFile.FindByProductId(item.AssociatedProduct.ParentId)
                        For Each file As Catalog.ProductFile In parentProductFiles
                            files.Add(file)
                        Next
                    End If
                End If
            Next

            If files.Count > 0 Then
                DownloadsPanel.Visible = True
                FilesGridView.DataSource = files
                FilesGridView.DataBind()
            Else
                DownloadsPanel.Visible = False
            End If
        Else
            DownloadsPanel.Visible = False
        End If
    End Sub

    Protected Sub FilesGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles FilesGridView.RowCommand

        Dim o As Orders.Order
        o = Orders.Order.FindByBvin(Request.QueryString("id"))

        If e.CommandName = "Download" Then
            Dim primaryKey As String = DirectCast(sender, GridView).DataKeys(CInt(e.CommandArgument)).Value
            Dim file As Catalog.ProductFile = Catalog.ProductFile.FindByBvin(primaryKey)

            Dim count As Integer = 0
            Dim propertyKey As String = "file" & file.Bvin
            If o IsNot Nothing Then
                If o.CustomProperties(propertyKey) IsNot Nothing Then
                    If Integer.TryParse(o.CustomProperties(propertyKey).Value, count) Then
                        count += 1
                    Else
                        count = 1
                    End If
                    o.CustomProperties(propertyKey).Value = count.ToString()
                Else
                    count = 1
                    o.CustomProperties.Add("bvsoftware", propertyKey, count.ToString())
                End If
            End If
            Orders.Order.Update(o)

            ' Hack
            If (file.MaxDownloads = 0) Then
                file.MaxDownloads = 32000
            End If

            If count > file.MaxDownloads Then
                MessageBox1.ShowError("File has been downloaded the maximum number of " & file.MaxDownloads & " times.")
                Return
            End If

            If file.AvailableMinutes <> 0 Then
                If DateTime.Now.AddMinutes(file.AvailableMinutes * -1) > o.TimeOfOrder Then
                    MessageBox1.ShowError("File can no longer be downloaded. Its available time period has elapsed.")
                    Return
                End If
            End If

            If Not ViewUtilities.DownloadFile(file) Then
                MessageBox1.ShowError("The file to download could not be found.")
            End If
        End If
    End Sub

    Protected Sub FilesGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles FilesGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim DownloadImageButton As ImageButton = DirectCast(e.Row.FindControl("DownloadImageButton"), ImageButton)
            DownloadImageButton.ImageUrl = PersonalizationServices.GetThemedButton("Download")
            DownloadImageButton.CommandArgument = e.Row.RowIndex
        End If
    End Sub

End Class
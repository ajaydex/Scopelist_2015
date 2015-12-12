Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_Pages_ViewOrder
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Service.master")
    End Sub

    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Utilities.WebForms.MakePageNonCacheable(Me)

        If Not Page.IsPostBack Then
            Me.ViewOrderMultiView.SetActiveView(Me.SelectOrderView)
            Me.ViewOrderButton.ImageUrl = PersonalizationServices.GetThemedButton("View")

            LoadOrder()
        End If
    End Sub

    Protected Sub LoadOrder()
        Dim orderNubmer As String = Request.QueryString("order")
        Dim postalCode As String = Request.QueryString("postal")

        If Not String.IsNullOrEmpty(orderNubmer) AndAlso Not String.IsNullOrEmpty(postalCode) Then
            Dim criteria As New Orders.OrderSearchCriteria()
            criteria.OrderNumber = orderNubmer.Trim()

            Dim results As Collection(Of Orders.Order) = Orders.Order.FindByCriteria(criteria)
            If results.Count > 0 Then
                If String.Compare(results(0).ShippingAddress.PostalCode, postalCode.Trim(), True) = 0 Then
                    Me.ViewOrderMultiView.SetActiveView(Me.OrderView)

                    Me.ucViewOrder.DisableReturns = Not WebAppSettings.EnableReturns
                    Me.ucViewOrder.OrderBvin = results(0).Bvin
                    Me.ucViewOrder.LoadOrder()
                    BindGrids(results(0).Bvin)
                Else
                    Me.ucMessageBox.ShowError("Sorry, we could not find an order with the given information.")
                End If
            Else
                Me.ucMessageBox.ShowError("Sorry, we could not find an order with the given information.")
            End If
        End If
    End Sub

    Private Sub BindGrids(ByVal bvin As String)

        Dim o As Orders.Order = Orders.Order.FindByBvin(bvin)

        Dim showDownloads As Boolean = True
        For Each payment As Orders.OrderPayment In o.Payments
            If payment.PaymentMethodId <> WebAppSettings.PaymentIdCreditCard AndAlso payment.PaymentMethodId <> WebAppSettings.PaymentIdGiftCertificate Then
                showDownloads = False
            End If
        Next

        If (o.PaymentStatus = Orders.OrderPaymentStatus.Paid OrElse showDownloads) AndAlso (o.StatusCode <> WebAppSettings.OrderStatusCodeOnHold) Then  ' <DEVELISYS/>
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

    Protected Sub ViewOrderButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ViewOrderButton.Click
        Dim orderNubmer As String = Me.OrderNumberTextBox.Text.Trim()
        Dim postalCode As String = Me.ZipCodeTextBox.Text.Trim()

        Dim redirectUrl As String = String.Format("~{0}?order={1}&postal={2}", Request.Url.AbsolutePath, orderNubmer, postalCode)
        Response.Redirect(redirectUrl)
    End Sub

End Class
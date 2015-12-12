Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_Pages_MyAccount_Orders_Details
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Public Property OrderBvin() As String
        Get
            Dim obj As Object = ViewState("OrderBvin")
            If obj IsNot Nothing Then
                Return CStr(obj)
            Else
                Return String.Empty
            End If
        End Get
        Set(ByVal value As String)
            ViewState("OrderBvin") = value
        End Set
    End Property

    Dim o As Orders.Order

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("MyAccount.master")

        If SessionManager.IsUserAuthenticated = False Then
            Response.Redirect("login.aspx?ReturnURL=" & Server.UrlEncode(Request.Url.PathAndQuery))
        End If

    End Sub

    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        Utilities.WebForms.MakePageNonCacheable(Me)

        If Not Page.IsPostBack Then
            Me.BackButton.ImageUrl = PersonalizationServices.GetThemedButton("Previous")

            Dim orderID As String
            orderID = Request.Params("id")
            If Not orderID Is Nothing Then
                ViewState("OrderID") = orderID
                Me.OrderBvin = Request.Params("id")
            End If
        End If

        'o = OrderServices.GetExistingOrder(ViewState("OrderID"))
        o = Orders.Order.FindByBvin(Me.OrderBvin)

        ViewOrder1.DisableReturns = Not WebAppSettings.EnableReturns

        If Not Page.IsPostBack Then
            BindGrids()
            LoadOrder()
        End If
    End Sub

    Private Sub BindGrids()
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

    Sub LoadOrder()

        Try
            If Not o Is Nothing Then
                'If o.UserID = BVC2004Store.GetCurrentUser.ID Then
                If o.UserID = SessionManager.GetCurrentUserId Then
                    ViewOrder1.OrderBvin = o.Bvin
                    ViewOrder1.LoadOrder()
                    'OrderViewer1.LoadOrder(o)
                Else
                    'OrderViewer1.ErrorMessage = "You are not authorized to view this order."
                End If
            Else
                'OrderViewer1.ErrorMessage = "There was an error while loading this order."
            End If

        Catch Ex As Exception
            'OrderViewer1.ErrorMessage += "<br>" & Ex.Message & Ex.Source
        End Try

    End Sub

    Private Sub BackButton_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles BackButton.Click
        Response.Redirect("myaccount_Orders.aspx", True)
    End Sub


    Protected Sub FilesGridView_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles FilesGridView.RowCommand
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

            If (file.MaxDownloads > 0) AndAlso (count > file.MaxDownloads) Then
                MessageBox1.ShowError("File has been downloaded the maximum number of times.")
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

    Protected Sub OrderViewThrowError(ByVal message As String) Handles ViewOrder1.ThrowError
        Me.MessageBox1.ShowError(message)
    End Sub
End Class

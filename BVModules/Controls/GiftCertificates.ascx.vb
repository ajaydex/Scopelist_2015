Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_GiftCertificates
    Inherits System.Web.UI.UserControl

    Public Event CertificatesChanged()

    Private _tabIndex As Integer = -1
    Private _tempTabIndex As Integer = 0
    Private _orderId As String = String.Empty

    Public Property TabIndex() As Integer
        Get
            Return _tabIndex
        End Get
        Set(ByVal value As Integer)
            _tabIndex = value
        End Set
    End Property

    Public Property ShowTitle() As Boolean
        Get
            Return title.Visible
        End Get
        Set(ByVal value As Boolean)
            title.Visible = value
        End Set
    End Property

    Public Property OrderId() As String
        Get
            Return _orderId
        End Get
        Set(value As String)
            _orderId = value
        End Set
    End Property

    Public Sub BindGiftCertificatesGrid()
        GiftCertificatesGridView.DataSource = Me.GetOrder().GetGiftCertificates()
        GiftCertificatesGridView.DataBind()
    End Sub

    Protected Sub AddGiftCertificateImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddGiftCertificateImageButton.Click
        Me.litMessages.Text = String.Empty
        If Page.IsValid Then
            If GiftCertificateTextBox.Text <> String.Empty Then
                Dim Basket As Orders.Order = Me.GetOrder()
                If Not Basket.GiftCertificates.Contains(GiftCertificateTextBox.Text) Then
                    Dim gc As Catalog.GiftCertificate = Catalog.GiftCertificate.FindByCertificateCode(GiftCertificateTextBox.Text)
                    If gc IsNot Nothing Then
                        If gc.IsValid() Then
                            Basket.GiftCertificates.Add(GiftCertificateTextBox.Text)
                            Orders.Order.Update(Basket)
                        Else
                            Me.litMessages.Text = "That certificate has expired"
                        End If

                    End If
                End If
            End If
            BindGiftCertificatesGrid()
        End If
        GiftCertificateTextBox.Text = ""

        RaiseEvent CertificatesChanged()
    End Sub

    Protected Sub GiftCertificatesGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GiftCertificatesGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim RemoveImageButton As ImageButton = DirectCast(e.Row.FindControl("RemoveImageButton"), ImageButton)
            RemoveImageButton.ImageUrl = PersonalizationServices.GetThemedButton("Delete")
            RemoveImageButton.TabIndex = _tempTabIndex
            _tempTabIndex += 1
        End If
    End Sub

    Protected Sub GiftCertificatesGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GiftCertificatesGridView.RowDeleting
        Dim key As String = GiftCertificatesGridView.DataKeys(e.RowIndex).Value
        Dim gc As Catalog.GiftCertificate = Catalog.GiftCertificate.FindByBvin(key)
        Dim basket As Orders.Order = Me.GetOrder()
        If gc IsNot Nothing Then
            basket.GiftCertificates.Remove(gc.CertificateCode)
            Orders.Order.Update(basket)
        End If
        BindGiftCertificatesGrid()

        RaiseEvent CertificatesChanged()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim enabledMethods As Collection(Of Payment.PaymentMethod)
            enabledMethods = Payment.AvailablePayments.EnabledMethods()

            Me.Visible = False
            For Each method As Payment.PaymentMethod In enabledMethods
                If method.MethodId = WebAppSettings.PaymentIdGiftCertificate Then
                    Me.Visible = True
                End If
            Next

            Me.AddGiftCertificateImageButton.ImageUrl = PersonalizationServices.GetThemedButton("AddGiftCertificate")

            If Me.TabIndex <> -1 Then
                GiftCertificateTextBox.TabIndex = Me.TabIndex
                AddGiftCertificateImageButton.TabIndex = Me.TabIndex + 1
            End If
            _tempTabIndex = Me.TabIndex + 2
            BindGiftCertificatesGrid()
        End If
    End Sub

    ' allow the control to add gift certificates to orders other than the current cart
    Private Function GetOrder() As Orders.Order
        Dim result As Orders.Order = Nothing

        If Not String.IsNullOrEmpty(Me.OrderId) Then
            result = Orders.Order.FindByBvin(Me.OrderId)
        Else
            result = SessionManager.CurrentShoppingCart()
        End If

        Return result
    End Function

End Class
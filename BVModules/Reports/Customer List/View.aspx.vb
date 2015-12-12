Imports BVSoftware.Bvc5.Core
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.ObjectModel
Imports System.Collections.Generic

Partial Class BVModules_Reports_Customer_List_View
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Custom Report for Greenspring"
        Me.CurrentTab = AdminTabType.Reports
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ReportsView)
    End Sub

    Private _SelectedProducts As New List(Of Catalog.Product)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub LoadUsers()
        _SelectedProducts = New List(Of Catalog.Product)
        PopulateProducts()

        lblResult.Text = ""
        Me.txtResults.Text = String.Empty

        Dim conn As New SqlConnection(WebAppSettings.ConnectionString)

        RenderHeader()

        Dim users As Collection(Of Membership.UserAccount) = BVSoftware.Bvc5.Core.Membership.UserAccount.FindAll()

        If users IsNot Nothing Then
            For Each u As Membership.UserAccount In users
                Try
                    RenderUser(u)
                Catch ex As Exception
                    EventLog.LogEvent(ex)
                End Try
            Next
        End If

    End Sub

    Private Sub PopulateProducts()
        Dim s() As String = Me.PurchasedSkuField.Text.Split(",")
        If s IsNot Nothing Then
            For i As Integer = 0 To s.Length - 1
                Dim p As Catalog.Product = Catalog.InternalProduct.FindBySku(CleanInputForSQL(s(i)))
                If p IsNot Nothing Then
                    _SelectedProducts.Add(p)
                End If
            Next
        End If
    End Sub

    Private Sub RenderHeader()
        Dim sb As New StringBuilder()

        sb.Append(AddString("Email"))
        'sb.Append(AddString("OnMailingList"))
        sb.Append(AddString("LastName"))
        sb.Append(AddString("FirstName"))
        sb.Append(AddString("Address"))
        sb.Append(AddString("City"))
        sb.Append(AddString("State"))
        sb.Append(AddString("Zip"))        

        For Each p As Catalog.Product In _SelectedProducts
            sb.Append(AddString(p.Sku))
        Next

        sb.Append(vbNewLine)

        Me.txtResults.Text += sb.ToString()
    End Sub

    Private Sub RenderUser(ByVal u As Membership.UserAccount)
        Dim sb As New StringBuilder()

        Dim orders As Collection(Of Orders.Order) = BVSoftware.Bvc5.Core.Orders.Order.FindByUser(u.Bvin)
        If orders Is Nothing Then
            orders = New Collection(Of Orders.Order)
        End If

        sb.Append(AddString(u.Email))
        'If Contacts.MailingList.CheckMembership("8858e25b-d9a0-4ae7-b74b-bdecd0c77a8d", u.Email) Then
        '    sb.Append(AddString("YES"))
        'Else
        '    sb.Append(AddString("NO"))
        'End If

        sb.Append(AddString(u.LastName))
        sb.Append(AddString(u.FirstName))

        Dim renderEmpty As Boolean = False

        If (u.Addresses IsNot Nothing) Then
            If u.Addresses.Count > 0 Then
                sb.Append(AddString(u.Addresses(u.Addresses.Count - 1).Line1 + u.Addresses(u.Addresses.Count - 1).Line2))
                sb.Append(AddString(u.Addresses(u.Addresses.Count - 1).RegionName))
                sb.Append(AddString(u.Addresses(u.Addresses.Count - 1).City))
                sb.Append(AddString(u.Addresses(u.Addresses.Count - 1).PostalCode))
            Else
                renderEmpty = True
            End If
        Else
            If orders.Count > 0 Then
                If orders(0).ShippingAddress IsNot Nothing Then
                    sb.Append(AddString(orders(0).ShippingAddress.Line1 + orders(0).ShippingAddress.Line2))
                    sb.Append(AddString(orders(0).ShippingAddress.RegionName))
                    sb.Append(AddString(orders(0).ShippingAddress.City))
                    sb.Append(AddString(orders(0).ShippingAddress.PostalCode))
                Else
                    renderEmpty = True
                End If
            Else
                If u.ShippingAddress IsNot Nothing Then
                    If u.ShippingAddress.Line1.Trim.Length > 0 Then
                        sb.Append(AddString(u.ShippingAddress.Line1 + orders(0).ShippingAddress.Line2))
                        sb.Append(AddString(u.ShippingAddress.RegionName))
                        sb.Append(AddString(u.ShippingAddress.City))
                        sb.Append(AddString(u.ShippingAddress.PostalCode))
                    Else
                        renderEmpty = True
                    End If
                Else
                    renderEmpty = True
                End If
            End If

            If renderEmpty Then
                sb.Append(AddString(" "))
                sb.Append(AddString(" "))
                sb.Append(AddString(" "))
                sb.Append(AddString(" "))
            End If
        End If


        For Each p As Catalog.Product In _SelectedProducts
            sb.Append(AddString(CountPurchases(u.Bvin, p.Bvin, orders)))
        Next

        sb.Append(vbNewLine)
        Me.txtResults.Text += sb.ToString()
    End Sub

    Private Function AddString(ByVal data As String) As String
        Return AddString(data, True)
    End Function

    Private Function AddString(ByVal data As String, ByVal withDelimeter As Boolean) As String
        Dim result As String = data.Replace(vbTab, " ")
        If withDelimeter Then
            result += vbTab
        End If
        Return result
    End Function

    Private Function CleanInputForSQL(ByVal input As String) As String
        Dim result As String = input

        Dim rx As New Regex("[^0-9a-zA-Z]")
        result = rx.Replace(result, "")
        result = result.Replace("drop ", "drop")
        result = result.Replace("update ", "update")
        result = result.Replace("select ", "select")
        result = result.Replace("delete ", "delete")
        result = result.Replace("xp_", "")

        Return result
    End Function

    Protected Sub btnGo_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGo.Click
        LoadUsers()
    End Sub

    Private Function AlreadyPurchased(ByVal uid As String, ByVal skus As StringCollection) As Boolean
        Dim result As Boolean = False

        Dim conn As New SqlConnection(WebAppSettings.ConnectionString)
        Dim outFilter As String = " ProductSku=''"

        If skus.Count > 0 Then
            outFilter = ""
            For i As Integer = 0 To skus.Count - 1
                outFilter += " ProductSku='" & skus(i) & "'"
                If i < skus.Count - 1 Then
                    outFilter += " OR "
                End If
            Next
        End If
        Dim cmdText As String = "Select bvin,UserId from bvc_Order WHERE bvin IN (SELECT OrderBvin FROM bvc_LineItem WHERE " & outFilter & ") AND (IsPlaced=1) AND userID=@userID"
        Dim cmd As New SqlCommand(cmdText, conn)
        cmd.Parameters.AddWithValue("@UserID", uid)
        Dim dt As New DataTable
        Dim adapt As New SqlDataAdapter(cmd)

        Try
            adapt.Fill(dt)
            If dt IsNot Nothing Then
                If dt.Rows.Count > 0 Then
                    result = True
                Else
                    result = False
                End If
            End If
        Catch ex As Exception
            EventLog.LogEvent(ex)
        Finally
            conn.Dispose()
        End Try

        Return result
    End Function

    Private Function CountPurchases(ByVal userId As String, ByVal productId As String, ByVal orders As Collection(Of Orders.Order)) As String
        Dim result As String = "0"
        Dim counter As Integer = 0

        For Each o As Orders.Order In orders
            If o.IsPlaced Then
                'If o.PaymentStatus = BVSoftware.Bvc5.Core.Orders.OrderPaymentStatus.Paid OrElse o.PaymentStatus = BVSoftware.Bvc5.Core.Orders.OrderPaymentStatus.Overpaid Then
                If o.Items.Count < 1 Then
                    'counter = -1
                    o.Items = BVSoftware.Bvc5.Core.Orders.LineItem.FindByOrderId(o.Bvin)
                End If
                For Each li As Orders.LineItem In o.Items
                    If li.ProductId = productId Then
                        counter += li.Quantity
                    End If
                Next
                'End If
            End If

        Next

        result = counter.ToString()
        Return result
    End Function

End Class


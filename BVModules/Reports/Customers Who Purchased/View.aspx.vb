Imports BVSoftware.BVC5.Core
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.ObjectModel


Partial Class BVModules_Reports_Customers_Who_Purchased_View
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Customers Who Purchased"
        Me.CurrentTab = AdminTabType.Reports
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ReportsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub LoadUsers()
        lblResult.Text = ""




        Dim conn As New SqlConnection(WebAppSettings.ConnectionString)
        'Dim outFilter As String = " ProductSku='BVC5S' OR ProductSKU='BVC5D' OR ProductSKU='BVC5UE' OR ProductSKU='BVC5UEX' OR ProductSKU='BVC5UP' OR ProductSKU='BVC5D-PRE' OR ProductSKU='BVC5S-PRE'  OR ProductSKU='BVC5-PS'  OR ProductSKU='BVC5-PS-COMP'  OR ProductSKU='BVC5-PSE-COMP' OR ProductSKU='BVC5-PSE' OR ProductSKU='BVC5-PSP' OR ProductSKU='BVC5-PSP-COMP' "
        Dim cmdText As String = "Select Bvin,OrderNumber,BillingAddress,UserEmail,UserId from bvc_Order WHERE bvin IN (SELECT OrderBvin FROM bvc_LineItem WHERE ProductSku=@PurchasedSKU) AND (IsPlaced=1) AND TimeOfOrder>@starttime AND TimeOfOrder<@endtime"
        Dim cmd As New SqlCommand(cmdText, conn)
        cmd.Parameters.AddWithValue("@PurchasedSKU", CleanInputForSQL(Me.PurchasedSkuField.Text))
        cmd.Parameters.AddWithValue("@starttime", Me.DateRangeField.StartDate)
        cmd.Parameters.AddWithValue("endtime", Me.DateRangeField.EndDate)
        Dim dt As New DataTable
        Dim adapt As New SqlDataAdapter(cmd)

        Dim users As New BVSoftware.Bvc5.Core.Utilities.SortableCollection(Of UserData)

        Dim emailList As String = String.Empty

        Try
            adapt.Fill(dt)


            If dt IsNot Nothing Then


                ' Also Purchased
                Dim alsoPurchasedSkus As New StringCollection
                If AlsoPurchasedField.Text.Trim.Length > 0 Then
                    Dim alsos() As String = AlsoPurchasedField.Text.Split(",")
                    For j As Integer = 0 To alsos.Length - 1
                        alsoPurchasedSkus.Add(alsos(j).Trim)
                    Next
                End If

                For i As Integer = 0 To dt.Rows.Count - 1
                    With dt.Rows(i)
                        Dim u As New UserData(.Item("OrderNumber"), .Item("BillingAddress"), .Item("UserEmail"), .Item("userId"))

                        Dim found As Boolean = False
                        For k As Integer = 0 To users.Count - 1
                            If users(k).Email.ToLower = u.Email.ToLower Then
                                found = True
                                users(k).OrderHistoryLiteral += "<a href='../../../BVAdmin/Orders/ViewOrder.aspx?id=" & .Item("Bvin") & "'>" & .Item("OrderNumber") & "</a><br/>"
                                Exit For
                            End If
                        Next
                        If found = False Then
                            u.OrderHistoryLiteral = "<a href='../../../BVAdmin/Orders/ViewOrder.aspx?id=" & .Item("Bvin") & "'>" & .Item("OrderNumber") & "</a><br/>"
                            If alsoPurchasedSkus.Count > 0 Then
                                If AlreadyPurchased(u.UserId, alsoPurchasedSkus) = False Then
                                    emailList += u.Email + "; "
                                    users.Add(u)
                                End If
                            Else
                                emailList += u.Email + "; "
                                users.Add(u)
                            End If
                            'Response.Write("Adding User " & u.Email)

                        End If
                    End With
                Next
            End If

        Catch ex As Exception
            lblResult.Text = ex.Message
            EventLog.LogEvent(ex)
        Finally
            conn.Dispose()
        End Try

        users.Sort("LastName", Utilities.SortDirection.Ascending)

        lblResult.Text = "Found " & users.Count & " Customers"

        Me.GridView1.DataSource = users
        Me.GridView1.DataBind()

        txtEmailCollection.Text = emailList


    End Sub

    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        GridView1.PageIndex = e.NewPageIndex
        LoadUsers()
    End Sub

    Protected Sub Date_OnRangeTypeChanged(ByVal e As EventArgs) Handles DateRangeField.RangeTypeChanged
        LoadUsers()
    End Sub

    Private Function CleanInputForSQL(ByVal input As String) As String
        Dim result As String = input

        Dim rx As New Regex("[^0-9a-zA-Z\-_]")
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

    Private Class UserData

        Private _FirstName As String = String.Empty
        Private _LastName As String = String.Empty
        Private _Company As String = String.Empty
        Private _Phone As String = String.Empty
        Private _BillAddress As String = String.Empty
        Private _OrderNumber As String = String.Empty
        Private _OrderHistoryLiteral As String = String.Empty
        Private _Email As String = String.Empty
        Private _UserId As String = String.Empty

        Public Property FirstName() As String
            Get
                Return _FirstName
            End Get
            Set(ByVal value As String)
                _FirstName = value
            End Set
        End Property
        Public Property LastName() As String
            Get
                Return _LastName
            End Get
            Set(ByVal value As String)
                _LastName = value
            End Set
        End Property
        Public Property Company() As String
            Get
                Return _Company
            End Get
            Set(ByVal value As String)
                _Company = value
            End Set
        End Property
        Public Property Phone() As String
            Get
                Return _Phone
            End Get
            Set(ByVal value As String)
                _Phone = value
            End Set
        End Property
        Public Property BillAddress() As String
            Get
                Return _BillAddress
            End Get
            Set(ByVal value As String)
                _BillAddress = value
            End Set
        End Property
        Public Property OrderNumber() As String
            Get
                Return _OrderNumber
            End Get
            Set(ByVal value As String)
                _OrderNumber = value
            End Set
        End Property
        Public Property OrderHistoryLiteral() As String
            Get
                Return _OrderHistoryLiteral
            End Get
            Set(ByVal value As String)
                _OrderHistoryLiteral = value
            End Set
        End Property
        Public Property Email() As String
            Get
                Return _Email
            End Get
            Set(ByVal value As String)
                _Email = value
            End Set
        End Property
        Public Property UserId() As String
            Get
                Return _UserId
            End Get
            Set(ByVal value As String)
                _UserId = value
            End Set
        End Property

        Public Sub New()

        End Sub

        Public Sub New(ByVal order As String, ByVal billing As String, ByVal e As String, ByVal uid As String)
            _OrderNumber = order
            _BillAddress = billing
            _Email = e
            _UserId = uid
            ParseBillingAddress()
        End Sub

        Public Sub ParseBillingAddress()
            Dim a As New Contacts.Address()
            If a.FromXmlString(_BillAddress) = True Then
                _FirstName = a.FirstName
                _LastName = a.LastName
                _Company = a.Company
                _Phone = a.Phone
            End If
        End Sub

    End Class

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

End Class


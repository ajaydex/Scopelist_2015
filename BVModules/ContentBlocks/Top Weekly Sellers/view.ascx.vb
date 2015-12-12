Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Data

Partial Class BVModules_ContentBlocks_Top_Weekly_Sellers_view
    Inherits Content.BVModule

    Private _StartDate As DateTime = DateTime.Now
    Private _EndDate As DateTime = DateTime.Now

    Public Property StartDate() As DateTime
        Get
            Return _StartDate
        End Get
        Set(ByVal value As DateTime)
            _StartDate = value
        End Set
    End Property
    Public Property EndDate() As DateTime
        Get
            Return _EndDate
        End Get
        Set(ByVal value As DateTime)
            _EndDate = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim c As Date = DateTime.Now
        CalculateDates(c)
        LoadProducts()
    End Sub

    Public Sub CalculateDates(ByVal currentTime As DateTime)
        _StartDate = FindStartOfWeek(currentTime)
        _EndDate = _StartDate.AddDays(7)
        _EndDate = _EndDate.AddMilliseconds(-1)
    End Sub

    Private Function FindStartOfWeek(ByVal currentDate As DateTime) As DateTime
        Dim result As DateTime = currentDate
        Select Case currentDate.DayOfWeek
            Case DayOfWeek.Sunday
                result = New DateTime(currentDate.Year, currentDate.Month, currentDate.Day, 0, 0, 0, 0)
            Case DayOfWeek.Monday
                result = currentDate.AddDays(-1)
            Case DayOfWeek.Tuesday
                result = currentDate.AddDays(-2)
            Case DayOfWeek.Wednesday
                result = currentDate.AddDays(-3)
            Case DayOfWeek.Thursday
                result = currentDate.AddDays(-4)
            Case DayOfWeek.Friday
                result = currentDate.AddDays(-5)
            Case DayOfWeek.Saturday
                result = currentDate.AddDays(-6)
        End Select
        result = New DateTime(result.Year, result.Month, result.Day, 0, 0, 0, 0)
        Return result
    End Function

    Private Sub LoadProducts()
        Dim s As Date = StartDate
        Dim e As Date = EndDate

        Dim products As Collection(Of Catalog.Product) = Catalog.InternalProduct.FindTopSellingProducts(s, e, False, 1000)

        RenderList(products)
    End Sub

    Private Sub RenderList(ByVal products As Collection(Of Catalog.Product))
        If products IsNot Nothing Then
            Me.ProductList.Controls.Clear()
            Me.ProductList.Text = String.Empty

            Dim sb As New StringBuilder
            If products.Count > 0 Then
                sb.Append("<ol>")
                For i As Integer = 0 To products.Count - 1
                    sb.Append(RenderProduct(products(i)))
                Next
                sb.Append("</ol>")
                Me.ProductList.Text = sb.ToString()
            End If
        End If
    End Sub

    Private Function RenderProduct(ByVal p As Catalog.Product) As String
        Dim result As String = String.Empty

        If p IsNot Nothing Then
            result += "<li>" & p.ProductName & "</li>"
        End If

        Return result
    End Function

End Class
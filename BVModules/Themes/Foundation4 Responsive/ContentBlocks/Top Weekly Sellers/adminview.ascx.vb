Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Top_Weekly_Sellers_adminview
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
        If Not Page.IsPostBack Then
            Dim c As Date = DateTime.Now
            CalculateDates(c)
            LoadProducts()
        End If
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

        Dim t As Data.DataTable = Catalog.InternalProduct.FindTotalProductsOrdered(s, e)

        Me.GridView1.DataSource = t
        Me.GridView1.DataBind()

    End Sub

End Class

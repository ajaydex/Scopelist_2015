Imports System.Globalization

Partial Class BVAdmin_Controls_DropDownDate
    Inherits System.Web.UI.UserControl

    Public Sub SetYearRange(ByVal startYear As Integer, ByVal endYear As Integer)
        Me.EnsureChildControls()
        _YearList.Items.Clear()
        For i As Integer = startYear To endYear
            _YearList.Items.Add(i)
        Next
    End Sub

    Protected Sub BVAdmin_Controls_DropDownDate_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Not Page.IsPostBack Then
            PopulateDefaults()
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
    End Sub

    Private Sub PopulateDefaults()

        For i As Integer = 1 To 12
            Dim li As New ListItem
            li.Value = i
            li.Text = CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(i)
            _MonthList.Items.Add(li)
            li = Nothing
        Next

        For i As Integer = 1 To 31
            _DayList.Items.Add(i)
        Next

        For i As Integer = Date.Now.AddYears(-5).Year To Date.Now.AddYears(10).Year
            _YearList.Items.Add(i)
        Next

    End Sub

    Property SelectedDate() As Date
        Get
            Try
                Dim d As New Date(_YearList.SelectedValue, _MonthList.SelectedValue, _DayList.SelectedValue)
                Return d
            Catch ex As Exception
                Return New Date(1900, 1, 1)
            End Try
        End Get
        Set(ByVal Value As Date)
            If _DayList.Items.FindByValue(Value.Day) IsNot Nothing Then
                _DayList.ClearSelection()
                _DayList.Items.FindByValue(Value.Day).Selected = True
            End If
            If _MonthList.Items.FindByValue(Value.Month) IsNot Nothing Then
                _MonthList.ClearSelection()
                _MonthList.Items.FindByValue(Value.Month).Selected = True
            End If
            If _YearList.Items.FindByValue(Value.Year) IsNot Nothing Then
                _YearList.ClearSelection()
                _YearList.Items.FindByValue(Value.Year).Selected = True
            End If
        End Set
    End Property

End Class

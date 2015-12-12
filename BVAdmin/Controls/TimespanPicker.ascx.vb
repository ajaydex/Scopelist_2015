
Partial Class BVAdmin_Controls_TimespanPicker
    Inherits System.Web.UI.UserControl

    Public Property Months() As Integer
        Get
            If MonthsDropDownList.SelectedIndex <> 0 Then
                Return CInt(MonthsDropDownList.SelectedValue)
            Else
                Return 0
            End If
        End Get
        Set(ByVal value As Integer)
            If value > 0 Then
                MonthsDropDownList.SelectedIndex = value
            End If
        End Set
    End Property

    Public Property Days() As Integer
        Get
            If DaysDropDownList.SelectedIndex <> 0 Then
                Return CInt(DaysDropDownList.SelectedValue)
            Else
                Return 0
            End If
        End Get
        Set(ByVal value As Integer)
            If value > 0 Then
                DaysDropDownList.SelectedIndex = value
            End If
        End Set
    End Property

    Public Property Hours() As Integer
        Get
            If HoursDropDownList.SelectedIndex <> 0 Then
                Return CInt(HoursDropDownList.SelectedValue)
            Else
                Return 0
            End If
        End Get
        Set(ByVal value As Integer)
            If value > 0 Then
                HoursDropDownList.SelectedIndex = value
            End If
        End Set
    End Property

    Public Property Minutes() As Integer
        Get
            If MinutesDropDownList.SelectedIndex <> 0 Then
                Return CInt(MinutesDropDownList.SelectedValue)
            Else
                Return 0
            End If
        End Get
        Set(ByVal value As Integer)
            If value > 0 Then
                MinutesDropDownList.SelectedIndex = value
            End If
        End Set
    End Property
End Class

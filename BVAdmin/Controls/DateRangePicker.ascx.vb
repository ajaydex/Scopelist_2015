
Partial Class BVAdmin_Controls_DateRangePicker
    Inherits System.Web.UI.UserControl

    Private _range As New BVSoftware.Bvc5.Core.Utilities.DateRange

    Public Event RangeTypeChanged(ByVal e As EventArgs)

    Protected Sub lstRangeType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lstRangeType.SelectedIndexChanged        
        If Me.lstRangeType.SelectedValue = "99" Then
            Me.pnlCustom.Visible = True            
        Else
            Me.pnlCustom.Visible = False
            Me.StartDateField.SelectedDate = Me.StartDate
            Me.EndDateField.SelectedDate = Me.EndDate
        End If
        RaiseEvent RangeTypeChanged(New EventArgs)
    End Sub

    Public Property StartDate() As DateTime
        Get
            If RangeType = BVSoftware.Bvc5.Core.Utilities.DateRangeType.Custom Then
                Return Me.StartDateField.SelectedDate
            Else
                _range.RangeType = Me.RangeType
                Return _range.StartDate
            End If
        End Get
        Set(ByVal value As DateTime)
            Me.StartDateField.SelectedDate = value
            RangeType = BVSoftware.Bvc5.Core.Utilities.DateRangeType.Custom
        End Set
    End Property

    Public Property EndDate() As DateTime
        Get
            If RangeType = BVSoftware.Bvc5.Core.Utilities.DateRangeType.Custom Then
                Return Me.EndDateField.SelectedDate
            Else
                _range.RangeType = Me.RangeType
                Return _range.EndDate
            End If
        End Get
        Set(ByVal value As DateTime)
            Me.EndDateField.SelectedDate = value
            RangeType = BVSoftware.Bvc5.Core.Utilities.DateRangeType.Custom
        End Set
    End Property

    Public Property RangeType() As BVSoftware.Bvc5.Core.Utilities.DateRangeType
        Get
            Return CType(Me.lstRangeType.SelectedValue, BVSoftware.Bvc5.Core.Utilities.DateRangeType)
        End Get
        Set(ByVal value As BVSoftware.Bvc5.Core.Utilities.DateRangeType)
            If Me.lstRangeType.Items.FindByValue(CInt(value).ToString) IsNot Nothing Then
                Me.lstRangeType.ClearSelection()
                Me.lstRangeType.Items.FindByValue(CInt(value).ToString).Selected = True
            End If
        End Set
    End Property

End Class

Imports BVSoftware.Bvc5.Core

<ValidationProperty("Text")> _
Partial Class BVAdmin_Controls_DatePicker
    Inherits System.Web.UI.UserControl

    Public Event DateChanged As EventHandler(Of Content.BVModuleEventArgs)

    <ComponentModel.Browsable(False)> _
    Public Property SelectedDate() As Date
        Get
            Dim val As Date
            If Date.TryParse(DateTextBox.Text, val) Then
                Return val
            Else
                Return Date.MinValue
            End If
        End Get
        Set(ByVal value As Date)
            DateTextBox.Text = value.ToShortDateString()
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property Text() As String
        Get
            Return DateTextBox.Text
        End Get
        Set(ByVal value As String)
            DateTextBox.Text = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property RequiredErrorMessage() As String
        Get
            Return DateRequiredValidator.ErrorMessage
        End Get
        Set(ByVal value As String)
            DateRequiredValidator.ErrorMessage = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property InvalidFormatErrorMessage() As String
        Get
            Return DateCustomValidator.ErrorMessage
        End Get
        Set(ByVal value As String)
            DateCustomValidator.ErrorMessage = value
        End Set
    End Property

    <ComponentModel.Browsable(True)> _
    Public Property TabIndex() As Integer
        Get
            Return DateTextBox.TabIndex
        End Get
        Set(ByVal value As Integer)
            DateTextBox.TabIndex = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack() Then
            If DateTextBox.Text = String.Empty Then
                DateTextBox.Text = Date.Now().ToShortDateString()
            End If
        End If
    End Sub

    Protected Sub CalendarShowImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CalendarShowImageButton.Click
        Calendar.Visible = (Not Calendar.Visible)
        Calendar.UpdateAfterCallBack = True
    End Sub

    Protected Sub Calendar_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Calendar.SelectionChanged
        DateTextBox.Text = Calendar.SelectedDate
        DateTextBox.UpdateAfterCallBack = True
        Calendar.Visible = False
        RaiseEvent DateChanged(Me, New Content.BVModuleEventArgs())
    End Sub

    Protected Sub DateCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles DateCustomValidator.ServerValidate
        If Date.TryParse(args.Value, Threading.Thread.CurrentThread.CurrentUICulture, System.Globalization.DateTimeStyles.None, Nothing) Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub
End Class
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_PaymentMethodList
    Inherits System.Web.UI.UserControl

    Public Property SelectMethodId() As String
        Get
            Dim result As String = String.Empty
            If Me.lstPaymentMethods.SelectedItem IsNot Nothing Then
                result = Me.lstPaymentMethods.SelectedValue
            End If
            Return result
        End Get
        Set(ByVal value As String)
            If Me.lstPaymentMethods.Items.FindByValue(value) IsNot Nothing Then
                Me.lstPaymentMethods.ClearSelection()
                Me.lstPaymentMethods.Items.FindByValue(value).Selected = True
            End If
        End Set
    End Property

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Not Page.IsPostBack Then
            PopulateMethodList()
        End If
        LoadView()
    End Sub

    Private Sub LoadView()
        Me.phOptions.Controls.Clear()

        Dim m As Payment.PaymentMethod = FindMethod(Me.lstPaymentMethods.SelectedValue)
        Dim tempControl As System.Web.UI.Control = Content.ModuleController.LoadPaymentMethodView(m.MethodName, Me.Page)
        If TypeOf tempControl Is Content.BVModule Then
            Dim view As Content.BVModule
            view = CType(tempControl, Content.BVModule)
            If Not view Is Nothing Then
                view.BlockId = m.MethodId
                Me.phOptions.Controls.Add(view)
            End If
        Else
            'Me.phOptions.Controls.Add(New LiteralControl("Error, editor is not based on Content.BVModule class"))
        End If
    End Sub

    Private Function FindMethod(ByVal methodId As String) As Payment.PaymentMethod
        Dim result As Payment.PaymentMethod = New Payment.Method.NullPayment

        For i As Integer = 0 To Payment.AvailablePayments.EnabledMethods.Count - 1
            If Payment.AvailablePayments.EnabledMethods(i).MethodId = Me.lstPaymentMethods.SelectedValue Then
                result = Payment.AvailablePayments.EnabledMethods(i)
                Exit For
            End If
        Next

        Return result
    End Function

    Private Sub PopulateMethodList()
        Me.lstPaymentMethods.Items.Clear()
        For i As Integer = 0 To Payment.AvailablePayments.EnabledMethods.Count - 1
            lstPaymentMethods.Items.Add(New ListItem(Payment.AvailablePayments.EnabledMethods(i).MethodId, Payment.AvailablePayments.EnabledMethods(i).MethodId))
        Next
    End Sub

    Protected Sub lstPaymentMethods_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles lstPaymentMethods.SelectedIndexChanged
        LoadView()
    End Sub

End Class

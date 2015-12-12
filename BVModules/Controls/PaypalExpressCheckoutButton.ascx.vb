Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_PaypalExpressCheckoutButton
    Inherits System.Web.UI.UserControl

    Public Property DisplayText() As Boolean
        Get
            Dim obj As Object = ViewState("DisplayText")
            If obj IsNot Nothing Then
                Return CType(obj, Boolean)
            Else
                Return True
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplayText") = value
        End Set
    End Property

    Public Property Text() As String
        Get
            Dim obj As Object = ViewState("Text")
            If obj IsNot Nothing Then
                Return obj.ToString()
            Else
                Return String.Empty
            End If
        End Get
        Set(value As String)
            ViewState("Text") = value
        End Set
    End Property

    Public Event WorkflowFailed(ByVal Message As String)
    Public Event CheckoutButtonClicked(ByVal args As PaypalExpressCheckoutArgs)

    Protected Sub PaypalImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles PaypalImageButton.Click        
        Dim args As New PaypalExpressCheckoutArgs()
        RaiseEvent CheckoutButtonClicked(args)
        If Not args.Failed Then
            Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart
            ' Save as Order
            Dim c As New BusinessRules.OrderTaskContext
            c.UserId = SessionManager.GetCurrentUserId
            c.Order = Basket
            Dim checkoutFailed As Boolean = False
            If Not BusinessRules.Workflow.RunByBvin(c, WebAppSettings.WorkflowIdCheckoutSelected) Then
                checkoutFailed = True
                Dim customerMessageFound As Boolean = False
                For Each msg As BusinessRules.WorkflowMessage In c.Errors
                    EventLog.LogEvent(msg.Name, msg.Description, Metrics.EventLogSeverity.Error)
                    If msg.CustomerVisible Then
                        customerMessageFound = True
                        RaiseEvent WorkflowFailed(msg.Description)
                    End If
                Next
                If Not customerMessageFound Then
                    EventLog.LogEvent("Checkout Selected Workflow", "Checkout failed but no errors were recorded.", Metrics.EventLogSeverity.Error)
                    RaiseEvent WorkflowFailed("Checkout Failed. If problem continues, please contact customer support.")
                End If
            End If

            If Not checkoutFailed Then
                c.Inputs.Add("bvsoftware", "Mode", "PaypalExpress")
                If Not BusinessRules.Workflow.RunByBvin(c, WebAppSettings.WorkflowIdThirdPartyCheckoutSelected) Then
                    Dim customerMessageFound As Boolean = False
                    EventLog.LogEvent("Paypal Express Checkout Failed", "Specific Errors to follow", Metrics.EventLogSeverity.Error)
                    For Each item As BusinessRules.WorkflowMessage In c.Errors
                        EventLog.LogEvent("Paypal Express Checkout Failed", item.Name + ": " + item.Description, Metrics.EventLogSeverity.Error)
                        If item.CustomerVisible Then
                            RaiseEvent WorkflowFailed(item.Description)
                            customerMessageFound = True
                        End If
                    Next
                    If Not customerMessageFound Then
                        RaiseEvent WorkflowFailed("Paypal Express Checkout Failed. If this problem persists please notify customer support.")
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.pnlSubText.Visible = Me.DisplayText
            If Not String.IsNullOrEmpty(Me.Text) Then
                Me.PaypalExpressLabel.Text = Me.Text
            End If
            
            Me.Visible = False
            For Each m As Payment.PaymentMethod In Payment.AvailablePayments.EnabledMethods()
                Select Case m.MethodId
                    Case WebAppSettings.PaymentIdPaypalExpress
                        Me.Visible = True
                        Exit For
                    Case Else
                        ' do nothing
                End Select
            Next
        End If
    End Sub

End Class
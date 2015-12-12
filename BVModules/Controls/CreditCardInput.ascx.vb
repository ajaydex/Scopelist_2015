Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_CreditCardInput
    Inherits System.Web.UI.UserControl

    Private _ValidateErrors As New Collection(Of String)()
    Private _tabIndex As Integer = -1

    Public Property CardNumber() As String
        Get
            Dim result As String = Me.CardNumberField.Text.Trim
            If result.StartsWith("*") = False Then
                result = Utilities.CreditCardValidator.CleanCardNumber(result)
            End If
            Return result
        End Get
        Set(ByVal value As String)
            Me.CardNumberField.Text = value
        End Set
    End Property
    Public Property CardHolderName() As String
        Get            
            Return Me.CardholderNameField.Text.Trim
        End Get
        Set(ByVal value As String)
            Me.CardholderNameField.Text = value
        End Set
    End Property
    Public Property SecurityCode() As String
        Get
            Return Me.CVVField.Text.Trim
        End Get
        Set(ByVal value As String)
            Me.CVVField.Text = value
        End Set
    End Property
    Public Property CardCode() As String
        Get
            Return Me.CardTypeField.SelectedValue
        End Get
        Set(ByVal value As String)
            If Me.CardTypeField.Items.FindByValue(value) IsNot Nothing Then
                Me.CardTypeField.ClearSelection()
                Me.CardTypeField.Items.FindByValue(value).Selected = True
            End If
        End Set
    End Property
    Public Property ExpirationMonth() As Integer
        Get
            Return Me.ExpMonthField.SelectedValue
        End Get
        Set(ByVal value As Integer)
            If Me.ExpMonthField.Items.FindByValue(value) IsNot Nothing Then
                Me.ExpMonthField.ClearSelection()
                Me.ExpMonthField.Items.FindByValue(value).Selected = True
            End If
        End Set
    End Property
    Public Property ExpirationYear() As Integer
        Get
            Return Me.ExpYearField.SelectedValue
        End Get
        Set(ByVal value As Integer)
            If Me.ExpYearField.Items.FindByValue(value) IsNot Nothing Then
                Me.ExpYearField.ClearSelection()
                Me.ExpYearField.Items.FindByValue(value).Selected = True
            End If
        End Set
    End Property
    Public ReadOnly Property ValidateErrors() As Collection(Of String)
        Get
            Return _ValidateErrors
        End Get
    End Property

    Public Property TabIndex() As Integer
        Get
            Return _tabIndex
        End Get
        Set(ByVal value As Integer)
            _tabIndex = value
        End Set
    End Property

    Public Sub EnabledValidators()
        CardTypeFieldBVRequiredFieldValidator.Enabled = True
        CardNumberBVRequiredFieldValidator.Enabled = True
        ExpMonthFieldBVRequiredFieldValidator.Enabled = True
        ExpYearFieldBVRequiredFieldValidator.Enabled = True
        CVVFieldBVRequiredFieldValidator.Enabled = WebAppSettings.PaymentCreditCardRequireCVV
        CardholderNameFieldBVRequiredFieldValidator.Enabled = True
    End Sub

    Public Sub DisableValidators()
        CardTypeFieldBVRequiredFieldValidator.Enabled = False
        CardNumberBVRequiredFieldValidator.Enabled = False
        ExpMonthFieldBVRequiredFieldValidator.Enabled = False
        ExpYearFieldBVRequiredFieldValidator.Enabled = False
        CVVFieldBVRequiredFieldValidator.Enabled = False
        CardholderNameFieldBVRequiredFieldValidator.Enabled = False
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        InitializeFields()        
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If TypeOf Me.Page Is BaseAdminPage Then
            Me.cvvdesclink.Visible = False        
        End If
        If TabIndex <> -1 Then
            CardTypeField.TabIndex = Me.TabIndex
            CardNumberField.TabIndex = Me.TabIndex + 1
            ExpMonthField.TabIndex = Me.TabIndex + 2
            ExpYearField.TabIndex = Me.TabIndex + 3
            CVVField.TabIndex = Me.TabIndex + 4
            CardholderNameField.TabIndex = Me.TabIndex + 5
        End If
    End Sub

    Public Sub InitializeFields()
        LoadMonths()
        LoadYears()
        LoadCardTypes()
    End Sub

    Private Sub LoadYears()
        ExpYearField.Items.Clear()
        ExpYearField.Items.Add(New ListItem("----", 0))

        Dim CurrentYear As Integer = System.DateTime.UtcNow.ToLocalTime.Year
        For iTempCounter As Integer = 0 To 15 Step 1
            Dim liTemp As New ListItem
            liTemp.Text = iTempCounter + CurrentYear
            liTemp.Value = iTempCounter + CurrentYear
            ExpYearField.Items.Add(liTemp)
            liTemp = Nothing
        Next
    End Sub

    Private Sub LoadMonths()
        ExpMonthField.Items.Clear()
        ExpMonthField.Items.Add(New ListItem("--", 0))
        For iTempCounter As Integer = 1 To 12 Step 1
            Dim liTemp As New ListItem
            liTemp.Text = iTempCounter.ToString()
            liTemp.Value = iTempCounter
            ExpMonthField.Items.Add(liTemp)
            liTemp = Nothing
        Next
    End Sub

    Private Sub LoadCardTypes()
        CardTypeField.Items.Clear()
        Try
            CardTypeField.Items.Add(New ListItem("< Select A Card Type >", 0))

            For Each ct As Payment.CreditCardType In Payment.CreditCardType.FindAllActive()
                CardTypeField.Items.Add(New ListItem(ct.LongName, ct.Code))
                If (ct.LongName.ToUpper() = "SWITCH") OrElse (ct.LongName.ToUpper() = "SOLO") OrElse (ct.LongName.ToUpper() = "MAESTRO / SWITCH") Then
                    issueNumberRow.Visible = True
                End If
            Next

        Catch Ex As Exception
            Throw New ArgumentException("Couldn't Load Card Types: " & Ex.Message)
        End Try
    End Sub

    Public Sub LoadFromPayment(ByVal op As Orders.OrderPayment)
        CardCode = op.CreditCardType
        ExpirationMonth = op.CreditCardExpMonth
        ExpirationYear = op.CreditCardExpYear
        CardHolderName = op.CreditCardHolder
        If op.CreditCardNumber.Trim.Length >= 4 Then
            If WebAppSettings.DisplayFullCreditCardNumber Then
                CardNumber = op.CreditCardNumber
            Else
                CardNumber = "****-****-****-" & op.CreditCardNumber.Substring(op.CreditCardNumber.Length - 4)
            End If

        End If
        If op.CustomPropertyExists("bvsoftware", "issuenumber") Then
            IssueNumberTextBox.Text = op.CustomPropertyGet("bvsoftware", "issuenumber")
        End If
    End Sub

    Public Sub CopyToPayment(ByVal op As Orders.OrderPayment)
        op.CreditCardExpMonth = ExpirationMonth
        op.CreditCardExpYear = ExpirationYear
        op.CreditCardHolder = CardHolderName
        If CardNumber.StartsWith("*") = False Then
            op.CreditCardNumber = CardNumber
        End If
        op.CreditCardType = CardCode
        op.CreditCardSecurityCode = SecurityCode
        If IssueNumberTextBox.Text.Trim() <> String.Empty Then
            op.CustomPropertySet("bvsoftware", "issuenumber", IssueNumberTextBox.Text)
        End If
    End Sub

    Public Function Validate() As Boolean
        _ValidateErrors.Clear()

        Dim bRet As Boolean = True

        Dim CCVal As New Utilities.CreditCardValidator

        Dim testCardNumber As String = ""

        If CardNumber.StartsWith("****-****-****-") Then

            'If paymentId.Trim.Length > 0 Then

            'End If
            'For i As Integer = 0 To thisOrder.Payments.Length - 1
            '    With thisOrder.Payments(i)
            '        If .PaymentType = BVSoftware.BVC.Interfaces.PaymentRecordType.Information Then
            '            If .PaymentMethod = BVSoftware.BVC.Interfaces.PaymentMethod.CreditCard Then
            '                testCardNumber = .CreditCardNumber
            '            End If
            '        End If
            '    End With
            'Next
        Else
            CardNumber = Utilities.CreditCardValidator.CleanCardNumber(CardNumber)
            testCardNumber = CardNumber
        End If


        If CardCode = "0" Then
            _ValidateErrors.Add("Please select a card type.")
            bRet = False
        Else
            Dim cardValidated As Boolean = False
            cardValidated = CCVal.ValidateCard(testCardNumber, CardCode)
            If cardValidated = True Then
                bRet = True
            Else
                For Each message As String In CCVal.ErrorMessages
                    _ValidateErrors.Add(message)
                Next                
                bRet = False
            End If
        End If

        If ExpirationMonth < 1 Then
            _ValidateErrors.Add("Please select an expiration month.")
            bRet = False
        End If
        If ExpirationYear < 1 Then
            _ValidateErrors.Add("Please select an expiration year.")
            bRet = False
        End If

        If CardHolderName.Length < 1 Then
            _ValidateErrors.Add("Please enter a card holder name.")
            bRet = False
        End If

        If WebAppSettings.PaymentCreditCardRequireCVV = True Then
            If SecurityCode.Length < 3 Then
                _ValidateErrors.Add("Please enter a security code.")
                bRet = False
            End If
        End If

        If _ValidateErrors.Count > 0 Then            
            bRet = False
        End If

        Return bRet
    End Function

End Class

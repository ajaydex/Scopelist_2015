Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_Checkouts_One_Page_Checkout_Plus_CreditCardInput
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
        CardNumberValidator.Enabled = True
        ExpDateValidator.Enabled = True
        ExpMonthValidator.Enabled = True
        ExpYearValidator.Enabled = True
        CVVFieldBVRequiredFieldValidator.Enabled = WebAppSettings.PaymentCreditCardRequireCVV
        CardholderNameFieldBVRequiredFieldValidator.Enabled = True
    End Sub

    Public Sub DisableValidators()
        CardTypeFieldBVRequiredFieldValidator.Enabled = False
        CardNumberValidator.Enabled = False
        ExpDateValidator.Enabled = False
        ExpMonthValidator.Enabled = False
        ExpYearValidator.Enabled = False
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
        SecurityCodeLabel.CssClass = If(WebAppSettings.PaymentCreditCardRequireCVV, "required", String.Empty)
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
        phAcceptedCreditCards.Controls.Clear()
        Try
            CardTypeField.Items.Add(New ListItem("< Select A Card Type >", 0))

            For Each ct As Payment.CreditCardType In Payment.CreditCardType.FindAllActive()
                CardTypeField.Items.Add(New ListItem(ct.LongName, ct.Code))
                If (ct.LongName.ToUpper() = "SWITCH") OrElse (ct.LongName.ToUpper() = "SOLO") OrElse (ct.LongName.ToUpper() = "MAESTRO / SWITCH") Then
                    issueNumberRow.Visible = True
                End If

                Dim img As New Image()
                Dim fileName As String = ct.LongName.Replace(" ", "").Replace("/", "-").ToLower()
                img.ImageUrl = Me.ResolveUrl(String.Format("~/Images/System/CreditCards/{0}.png", fileName))
                img.AlternateText = ct.LongName
                img.CssClass = ct.Code
                phAcceptedCreditCards.Controls.Add(img)
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
        ExpDateValidator.IsValid = (ExpMonthValidator.IsValid AndAlso ExpYearValidator.IsValid)

        Return (CardNumberValidator.IsValid AndAlso ExpDateValidator.IsValid)
    End Function

    Public Sub CardNumberValidator_ServerValidate(ByVal sender As Object, ByVal e As ServerValidateEventArgs) Handles CardNumberValidator.ServerValidate
        CardNumberValidator.ErrorMessage = String.Empty

        If CardNumberField.Text.Trim().Length = 0 Then
            e.IsValid = False
        Else
            Dim CCVal As New Utilities.CreditCardValidator()

            Dim testCardNumber As String = ""

            If CardNumber.StartsWith("****-****-****-") Then
                ' do nothing
            Else
                CardNumber = Utilities.CreditCardValidator.CleanCardNumber(CardNumber)
                testCardNumber = CardNumber
            End If

            e.IsValid = CCVal.ValidateCard(testCardNumber, CardCode)
            If Not e.IsValid Then
                If CCVal.ErrorMessages.Count > 0 Then
                    ' only display the first error message as this is the most relevant one
                    CardNumberValidator.ErrorMessage = "<br/>" + CCVal.ErrorMessages(0)
                End If
            End If
        End If
    End Sub

    Public Sub ExpDate_ServerValidate(ByVal sender As Object, ByVal e As ServerValidateEventArgs) Handles ExpMonthValidator.ServerValidate, ExpYearValidator.ServerValidate
        e.IsValid = True
        ExpDateValidator.ErrorMessage = String.Empty

        ' required field validation
        Dim validator As CustomValidator = CType(sender, CustomValidator)
        If validator.ControlToValidate = "ExpMonthField" Then
            If ExpMonthField.SelectedValue = "0" Then
                e.IsValid = False
            End If
        ElseIf validator.ControlToValidate = "ExpYearField" Then
            If ExpYearField.SelectedValue = "0" Then
                e.IsValid = False
            End If
        End If

        If e.IsValid Then
            ' make sure expiration date is current
            Dim expDate As DateTime = New DateTime(Convert.ToInt32(ExpYearField.SelectedValue), Convert.ToInt32(ExpMonthField.SelectedValue), 1).AddMonths(1).AddDays(-1)
            If DateTime.Today > expDate Then
                e.IsValid = False
                ExpDateValidator.ErrorMessage = "<br/>" + "Your credit card is expired"
            End If
        End If
    End Sub

End Class
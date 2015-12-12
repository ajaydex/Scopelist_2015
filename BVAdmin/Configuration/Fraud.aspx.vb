Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Configuration_Fraud
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            LoadLists()
        End If

    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Fraud Screen Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Private Sub LoadLists()

        Dim rules As Collection(Of Security.FraudRule) = Security.FraudRule.FindAll
        Dim emailRules As New Utilities.SortableCollection(Of Security.FraudRule)
        Dim domainRules As New Utilities.SortableCollection(Of Security.FraudRule)
        Dim ipRules As New Utilities.SortableCollection(Of Security.FraudRule)
        Dim PHrules As New Utilities.SortableCollection(Of Security.FraudRule)
        Dim CCrules As New Utilities.SortableCollection(Of Security.FraudRule)

        For i As Integer = 0 To rules.Count - 1
            Select Case rules(i).RuleType
                Case Security.FraudRuleType.DomainName
                    domainRules.Add(rules(i))
                Case Security.FraudRuleType.EmailAddress
                    emailRules.Add(rules(i))
                Case Security.FraudRuleType.IPAddress
                    ipRules.Add(rules(i))
                Case Security.FraudRuleType.PhoneNumber
                    PHrules.Add(rules(i))
                Case Security.FraudRuleType.CreditCardNumber
                    CCrules.Add(rules(i))
            End Select
        Next

        emailRules.Sort("RuleValue")
        domainRules.Sort("RuleValue")
        ipRules.Sort("RuleValue")
        PHrules.Sort("RuleValue")
        CCrules.Sort("RuleValue")

        Me.lstEmail.DataSource = emailRules
        Me.lstEmail.DataTextField = "RuleValue"
        Me.lstEmail.DataValueField = "Bvin"
        Me.lstEmail.DataBind()

        Me.lstDomain.DataTextField = "RuleValue"
        Me.lstDomain.DataValueField = "Bvin"
        Me.lstDomain.DataSource = domainRules
        Me.lstDomain.DataBind()

        Me.lstIP.DataTextField = "RuleValue"
        Me.lstIP.DataValueField = "Bvin"
        Me.lstIP.DataSource = ipRules
        Me.lstIP.DataBind()

        Me.lstPhoneNumber.DataTextField = "RuleValue"
        Me.lstPhoneNumber.DataValueField = "Bvin"
        Me.lstPhoneNumber.DataSource = PHrules
        Me.lstPhoneNumber.DataBind()

        Me.lstCreditCard.DataTextField = "RuleValue"
        Me.lstCreditCard.DataValueField = "Bvin"
        Me.lstCreditCard.DataSource = CCrules
        Me.lstCreditCard.DataBind()

        Me.EmailField.Text = ""
        Me.DomainField.Text = ""
        Me.IPField.Text = ""
        Me.PhoneNumberField.Text = ""
        Me.CreditCardField.Text = ""

    End Sub

    'Email Address
    Private Sub btnNewEmail_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewEmail.Click
        If Me.EmailField.Text.Trim.Length > 0 Then
            Dim r As New Security.FraudRule
            r.RuleType = Security.FraudRuleType.EmailAddress
            r.RuleValue = Me.EmailField.Text.Trim.ToLower
            Security.FraudRule.SaveAsNew(r)
        End If
        LoadLists()
    End Sub

    Private Sub btnDeleteEmail_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDeleteEmail.Click
        For i As Integer = 0 To Me.lstEmail.Items.Count - 1
            If Me.lstEmail.Items(i).Selected = True Then
                DeleteRule(Me.lstEmail.Items(i).Value)
            End If
        Next
        LoadLists()
    End Sub

    'IP Address
    Private Sub btnNewIP_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewIP.Click
        If Me.IPField.Text.Trim.Length > 0 Then
            Dim r As New Security.FraudRule
            r.RuleType = Security.FraudRuleType.IPAddress
            r.RuleValue = Me.IPField.Text.Trim.ToLower
            Security.FraudRule.SaveAsNew(r)
        End If
        LoadLists()
    End Sub

    Private Sub btnDeleteIP_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDeleteIP.Click
        For i As Integer = 0 To Me.lstIP.Items.Count - 1
            If Me.lstIP.Items(i).Selected = True Then
                DeleteRule(Me.lstIP.Items(i).Value)
            End If
        Next
        LoadLists()
    End Sub

    'Domain Name
    Private Sub btnNewDomain_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewDomain.Click
        If Me.DomainField.Text.Trim.Length > 0 Then
            Dim r As New Security.FraudRule
            r.RuleType = Security.FraudRuleType.DomainName
            r.RuleValue = Me.DomainField.Text.Trim.ToLower
            Security.FraudRule.SaveAsNew(r)
        End If
        LoadLists()
    End Sub

    Private Sub btnDeleteDomain_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDeleteDomain.Click
        For i As Integer = 0 To Me.lstDomain.Items.Count - 1
            If Me.lstDomain.Items(i).Selected = True Then
                DeleteRule(Me.lstDomain.Items(i).Value)
            End If
        Next
        LoadLists()
    End Sub

    'Phone Number

    Private Sub btnNewPhoneNumber_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewPhoneNumber.Click
        If Me.PhoneNumberField.Text.Trim.Length > 0 Then
            Dim r As New Security.FraudRule
            r.RuleType = Security.FraudRuleType.PhoneNumber
            r.RuleValue = Me.PhoneNumberField.Text.Trim.ToLower
            Security.FraudRule.SaveAsNew(r)
        End If
        LoadLists()
    End Sub

    Private Sub btnDeletePhoneNumber_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDeletePhoneNumber.Click
        For i As Integer = 0 To Me.lstPhoneNumber.Items.Count - 1
            If Me.lstPhoneNumber.Items(i).Selected = True Then
                DeleteRule(Me.lstPhoneNumber.Items(i).Value)
            End If
        Next
        LoadLists()
    End Sub


    'CreditCard Number

    Private Sub btnNewCCNumber_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewCCNumber.Click
        If Me.CreditCardField.Text.Trim.Length > 0 Then
            Dim r As New Security.FraudRule
            r.RuleType = Security.FraudRuleType.CreditCardNumber
            r.RuleValue = Me.CreditCardField.Text.Trim.ToLower
            Security.FraudRule.SaveAsNew(r)
        End If
        LoadLists()
    End Sub

    Private Sub btnDeleteCCNumber_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDeleteCCNumber.Click
        For i As Integer = 0 To Me.lstCreditCard.Items.Count - 1
            If Me.lstCreditCard.Items(i).Selected = True Then
                DeleteRule(Me.lstCreditCard.Items(i).Value)
            End If
        Next
        LoadLists()
    End Sub


    Private Sub DeleteRule(ByVal bvin As String)
        Security.FraudRule.Delete(bvin)
    End Sub

End Class

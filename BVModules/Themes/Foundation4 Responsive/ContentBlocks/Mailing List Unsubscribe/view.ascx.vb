Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Mailing_List_Unsubscribe_view
    Inherits Content.BVModule

    Private _ListId As String = String.Empty

    Public Property ListId() As String
        Get
            Return _ListId
        End Get
        Set(ByVal Value As String)
            _ListId = Value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            SetDefaultControlValues()
        End If
        Me.ListId = SettingsManager.GetSetting("MailingListId")
    End Sub

    Private Sub SetDefaultControlValues()
        lblTitle.Text = SettingsManager.GetSetting("Title")
        If lblTitle.Text = String.Empty Then
            lblTitle.Text = "Mailing List Unsubscribe"
        End If
        Me.lblError.Text = SettingsManager.GetSetting("ErrorMessage")
        If Me.lblError.Text = String.Empty Then
            Me.lblError.Text = "<i class='fa fa-exclamation-triangle'></i> Please enter a valid email address"
            Me.lblError.Visible = True
        End If
        Me.lblSuccess.Text = SettingsManager.GetSetting("SuccessMessage")
        If Me.lblSuccess.Text = String.Empty Then
            Me.lblSuccess.Text = "Thank You!"
        End If
        Me.lblInstructions.Text = SettingsManager.GetSetting("Instructions")
        If Me.lblInstructions.Text = String.Empty Then
            Me.lblInstructions.Text = "Please enter your email address"
        End If
        btnGoEmail.ImageUrl = PersonalizationServices.GetThemedButton("GoMailingList")
        btnGoEmail.AlternateText = "Submit Form"
    End Sub

    Protected Sub btnGoEmail_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGoEmail.Click

        lblError.Text = ""
        lblSuccess.Visible = False
        'lblInstructions.Visible = False

        valEmail.Validate()
        If valEmail.IsValid = False Then
            lblError.Text = valEmail.ErrorMessage
            lblError.Visible = True
        Else
            Try
                If EmailAddressField.Text.Trim.Length > 3 Then
                    If ListId <> String.Empty Then
                        Contacts.MailingListMember.DeleteByEmail(EmailAddressField.Text.Trim, ListId)
                    Else
                        Dim lists As Collection(Of Contacts.MailingList) = Contacts.MailingList.FindAllPublic()
                        If lists.Count > 0 Then
                            Contacts.MailingListMember.DeleteByEmail(EmailAddressField.Text.Trim, lists(0).Bvin)
                        End If
                        lists = Nothing
                    End If
                    lblSuccess.Visible = True
                    lblInstructions.Visible = False
                    pnlMailingListSignupForm.Visible = False
                Else
                    lblError.Text = "<i class='fa fa-exclamation-triangle'></i> Please enter your email address"
                    lblError.Visible = True
                End If
            Catch ex As Exception
                lblError.Text = ex.Message
                lblError.Visible = True
            End Try
        End If
    End Sub


End Class

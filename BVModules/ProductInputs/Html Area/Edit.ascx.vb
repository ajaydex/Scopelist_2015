Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVModules_ProductInputs_Text_Input_ProductInputEdit
    Inherits ProductInputTemplate

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub ChoiceOptionSaveButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ChoiceInputContinueButton.Click
        Me.Product.ChoicesAndInputs.FindBusinessObject(BlockId).Name = PropertyNameTextBox.Text
        Me.Product.ChoicesAndInputs.FindBusinessObject(BlockId).DisplayName = PropertyNameTextBox.Text
        SettingsManager.SaveSetting("PropertyName", PropertyNameTextBox.Text, "bvsoftware", "Input", "HTML Area")
        SettingsManager.SaveSetting("Html", HtmlTextBox.Text, "bvsoftware", "Input", "HTML Area")
        NotifyFinishedEditing()
    End Sub

    Protected Sub ChoiceOptionCancelButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ChoiceInputCancelButton.Click
        Me.NotifyFinishedEditing("Canceled")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            InitializeFields()
        End If
    End Sub

    Protected Sub InitializeFields()
        PropertyNameTextBox.Text = SettingsManager.GetSetting("PropertyName")
        HtmlTextBox.Text = SettingsManager.GetSetting("Html")
    End Sub

    Public Overrides Sub InitializeDisplay()
        'not used in edit mode
    End Sub

    Public Overrides Function GetValue() As String
        'not used in edit mode
        Return String.Empty
    End Function

    Public Overrides Sub SetValue(ByVal value As String)
        'not used in edit mode
    End Sub
End Class

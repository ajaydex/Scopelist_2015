Imports BVSoftware.Bvc5.Core.Content
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic

Partial Class BVModules_ProductInputs_File_Upload_Edit
    Inherits ProductInputTemplate

    Public Overrides ReadOnly Property IsValid() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub ChoiceOptionSaveButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ChoiceInputContinueButton.Click
        Me.Product.ChoicesAndInputs.FindBusinessObject(BlockId).Name = PropertyNameTextBox.Text
        SettingsManager.SaveSetting("DisplayName", DisplayNameTextBox.Text, "bvsoftware", "Input", "File Upload")
        SettingsManager.SaveBooleanSetting("Required", RequiredFieldCheckBox.Checked, "bvsoftware", "Input", "File Upload")
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
        PropertyNameTextBox.Text = Me.Product.ChoicesAndInputs.FindBusinessObject(BlockId).Name
        DisplayNameTextBox.Text = SettingsManager.GetSetting("DisplayName")
        RequiredFieldCheckBox.Checked = SettingsManager.GetBooleanSetting("Required")
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
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
        SettingsManager.SaveSetting("DisplayName", DisplayNameTextBox.Text, "bvsoftware", "Input", "Text Input")
        SettingsManager.SaveBooleanSetting("Required", RequiredFieldCheckBox.Checked, "bvsoftware", "Input", "Text Input")
        SettingsManager.SaveBooleanSetting("WrapText", WrapTextCheckBox.Checked, "bvsoftware", "Input", "Text Input")
        SettingsManager.SaveIntegerSetting("Rows", CInt(RowsTextBox.Text), "bvsoftware", "Input", "Text Input")
        SettingsManager.SaveIntegerSetting("Columns", CInt(ColumnsTextBox.Text), "bvsoftware", "Input", "Text Input")
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
        WrapTextCheckBox.Checked = SettingsManager.GetBooleanSetting("WrapText")
        RowsTextBox.Text = CStr(SettingsManager.GetIntegerSetting("Rows"))
        ColumnsTextBox.Text = CStr(SettingsManager.GetIntegerSetting("Columns"))
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


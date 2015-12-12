Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ContentBlocks_Mailing_List_Signup_adminview
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim listID As String = SettingsManager.GetSetting("MailingListId")
        If listID <> String.Empty Then
            Dim m As Contacts.MailingList = Contacts.MailingList.FindByBvin(listID)
            If m.Bvin <> String.Empty Then
                Me.lblInfo.Text = "List: " & m.Name
            Else
                Me.lblInfo.Text = "Unknown mailing list selected."
            End If
        Else
            Me.lblInfo.Text = "No mailing list selected."
        End If
    End Sub

End Class

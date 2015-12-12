Imports BVSoftware.Bvc5.Core

Partial Class CVV
    Inherits BaseStorePage

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Popup.master")
    End Sub
End Class

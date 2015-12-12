Imports BVSoftware.BVC5.Core

Partial Class GiftCertificate
    Inherits BaseStorePage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Service.master")
    End Sub

End Class

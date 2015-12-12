Imports BVSoftware.Bvc5.Core

Partial Class Modify_Your_Subscription
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Custom.master")
    End Sub

End Class

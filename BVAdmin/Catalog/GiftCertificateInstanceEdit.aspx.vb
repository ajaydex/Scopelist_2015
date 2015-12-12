Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Catalog_GiftCertificateInstanceEdit
    Inherits BaseAdminPage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Gift Certificate Edit"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersEdit)
    End Sub

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        If Request.QueryString("id") Is Nothing Then
            Response.Redirect("~/BVAdmin/Catalog/GiftCertificates.aspx")
        Else
            ViewState("id") = Request.QueryString("id")
            If Not Page.IsPostBack Then
                Dim GiftCertificate As Catalog.GiftCertificate = Catalog.GiftCertificate.FindByBvin(ViewState("id"))
                If GiftCertificate IsNot Nothing Then
                    InitializeEntry(GiftCertificate)
                Else
                    Response.Redirect("~/BVAdmin/Catalog/GiftCertificates.aspx")
                End If
            End If
        End If
    End Sub

    Protected Sub InitializeEntry(ByVal gc As Catalog.GiftCertificate)
        IssueDateModifierField.InitializeValue(gc.DateIssued)
    End Sub

    Protected Sub SaveChangesImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveChangesImageButton.Click
        Dim giftCertificate As Catalog.GiftCertificate = Catalog.GiftCertificate.FindByBvin(ViewState("id"))
        If giftCertificate IsNot Nothing Then
            Dim originalDate As Date = giftCertificate.DateIssued
            giftCertificate.DateIssued = IssueDateModifierField.ApplyChanges(giftCertificate.DateIssued)
            If Catalog.GiftCertificate.Update(giftCertificate) Then

                AuditLog.LogEvent(BVSoftware.Commerce.Metrics.AuditLogSourceModule.Payment, _
                                   BVSoftware.Commerce.Metrics.AuditLogEntrySeverity.Information, _
                                    "Gift Certificate Edit", "Gift certificate issue date for certificate " & giftCertificate.CertificateCode & _
                                      " was changed from " & _
                                        originalDate.ToShortDateString & " to " & giftCertificate.DateIssued.ToShortDateString)
                Response.Redirect("~/BVAdmin/Catalog/GiftCertificates.aspx")
            Else
                MessageBox1.ShowError("An error occurred while trying to update the gift certificate")
                MessageBox2.ShowError("An error occurred while trying to update the gift certificate")
            End If
        Else
            MessageBox1.ShowError("An error occurred while trying to update the gift certificate")
            MessageBox2.ShowError("An error occurred while trying to update the gift certificate")
        End If
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        Response.Redirect("~/BVAdmin/Catalog/GiftCertificates.aspx")
    End Sub
End Class

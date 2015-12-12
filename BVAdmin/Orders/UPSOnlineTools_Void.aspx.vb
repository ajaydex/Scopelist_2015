Imports BVSoftware.Bvc5.Core
Imports System.IO

Partial Class BVAdmin_Orders_UPSOnlineTools_Void
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Ups Online Tools - Void Shipments"
        Me.CurrentTab = AdminTabType.Orders
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersView)
    End Sub

    Protected Sub btnGo_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGo.Click
        Dim req As New BVSoftware.BVC5.Shipping.Ups.VoidShipmentRequest
        req.Settings.UserID = WebAppSettings.ShippingUPSUsername
        req.Settings.Password = WebAppSettings.ShippingUPSPassword
        req.Settings.License = WebAppSettings.ShippingUPSLicense
        req.Settings.ServerUrl = WebAppSettings.ShippingUPSServer
        req.ShipmentIdentificationNumber = Me.TrackingNumberField.Text.Trim

        Dim res As BVSoftware.BVC5.Shipping.Ups.VoidShipmentResponse
        res = BVSoftware.BVC5.Shipping.Ups.XmlTools.SendVoidShipmentRequest(req)

        If Not res Is Nothing Then

            If WebAppSettings.ShippingUPSWriteXml = True Then
                Me.SaveXmlStringToFile("Void_" & req.ShipmentIdentificationNumber & "_Request.xml", req.XmlRequest)
                Me.SaveXmlStringToFile("Void_" & req.ShipmentIdentificationNumber & "_Response.xml", req.XmlResponse)
            End If

            If res.Success = True Then
                Me.msg.ShowOK("Shipment " & Me.TrackingNumberField.Text.Trim & " was voided.")
                Me.TrackingNumberField.Text = "1Z"
            Else
                Me.msg.ShowWarning("Error " & res.ErrorCode & ": " & res.ErrorMessage)
            End If
        Else
            msg.ShowWarning("Response object was empty")
        End If

    End Sub

    Private Function SaveXmlStringToFile(ByVal filename As String, ByVal data As String) As Boolean
        Dim result As Boolean = False
        Dim UPSLabelDirectory As String = Path.Combine(Request.PhysicalApplicationPath, "images\UPS\Xml")
        Try
            If Directory.Exists(UPSLabelDirectory) = False Then
                Directory.CreateDirectory(UPSLabelDirectory)
            End If
            Dim writer As New StreamWriter(Path.Combine(UPSLabelDirectory, filename), False)
            writer.Write(data)
            writer.Flush()
            writer.Close()
        Catch ex As Exception
            'EventLog.LogEvent(ex)
        End Try
        Return result
    End Function

End Class

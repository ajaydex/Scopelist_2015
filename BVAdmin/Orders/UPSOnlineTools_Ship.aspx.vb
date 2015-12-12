Imports BVSoftware.Bvc5.Core
Imports System.IO
Imports System.Text
Imports System.Data
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Orders_UPSOnlineTools_Ship
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Ups Online Tools - Ship Items"
        Me.CurrentTab = AdminTabType.Orders
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.OrdersView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Orders
            LoadCountries()

            SetDefaults()
            PopulateFromAddress()

            If Request.QueryString("PackageID") <> Nothing Then
                Me.PackageIdField.Value = Request.QueryString("PackageID")
            End If
            If Request.QueryString("ReturnURL") <> Nothing Then
                Me.ReturnUrlField.Value = Request.QueryString("ReturnURL")
            End If
            If Me.PackageIdField.Value <> String.Empty Then
                LoadPackageSettings()
            End If
        End If

    End Sub

    Private Sub LoadCountries()
        Dim dt As Collection(Of Content.Country) = Content.Country.FindActive
        If dt.Count > 0 Then
            Me.FromCountryField.Items.Clear()
            Me.ToCountryField.Items.Clear()

            Me.FromCountryField.DataSource = dt
            Me.FromCountryField.DataTextField = "DisplayName"
            Me.FromCountryField.DataValueField = "ISOCode"
            Me.FromCountryField.DataBind()
            Me.FromCountryField.Items.FindByValue("US").Selected = True

            Me.ToCountryField.DataSource = dt
            Me.ToCountryField.DataTextField = "DisplayName"
            Me.ToCountryField.DataValueField = "ISOCode"
            Me.ToCountryField.DataBind()
            Me.ToCountryField.Items.FindByValue("US").Selected = True

        End If


    End Sub

    Private Sub SetDefaults()
        Me.ServiceField.SelectedValue = WebAppSettings.ShippingUpsDefaultService.ToString
        Me.PackageTypeField.SelectedValue = WebAppSettings.ShippingUpsDefaultPackaging.ToString
        Me.BillToAccountNumberField.Text = WebAppSettings.ShippingUpsAccountNumber
        Me.BillToField.SelectedValue = WebAppSettings.ShippingUpsDefaultPayment.ToString

        Me.CCExpYearField.Items.Clear()
        For i As Integer = DateTime.Now.Year To DateTime.Now.Year + 10
            Me.CCExpYearField.Items.Add(New ListItem(i, i))
        Next

        BVSoftware.Bvc5.Shipping.Ups.UpsProvider.PopulateListWithCurrencies(Me.CODCurrencyField.Items)
        BVSoftware.BVC5.Shipping.Ups.UpsProvider.PopulateListWithCurrencies(Me.DeclaredValueCurrencyField.Items)

        If Request.IsSecureConnection = False Then
            Me.trWarning.Visible = True
        Else
            Me.trWarning.Visible = False
        End If
    End Sub

    Private Sub PopulateFromAddress()
        Dim siteAddress As Contacts.Address = WebAppSettings.SiteShippingAddress

        If Not siteAddress Is Nothing Then
            Me.FromCompanyField.Text = siteAddress.Company
            Me.FromNameField.Text = siteAddress.FirstName & " " & siteAddress.LastName
            Me.FromPhoneField.Text = siteAddress.Phone
            Me.FromAddress1Field.Text = siteAddress.Line1
            Me.FromAddress2Field.Text = siteAddress.Line2
            Me.FromCityField.Text = siteAddress.City
            Dim r As New Content.Region
            r = Content.Region.FindByBvin(siteAddress.RegionBvin)
            If Not r Is Nothing Then
                Me.FromStateField.Text = r.Abbreviation
            End If
            Me.FromPostalCodeField.Text = siteAddress.PostalCode
        End If

    End Sub

    Private Sub LoadPackageSettings()
        Dim p As Shipping.Package = Shipping.Package.FindByBvin(Me.PackageIdField.Value)
        If Not p Is Nothing Then

            Dim orderID As String = p.OrderId
            Dim o As BVSoftware.BVC5.Core.Orders.Order = BVSoftware.BVC5.Core.Orders.Order.FindByBvin(orderID)

            If o IsNot Nothing Then
                ' To Address
                Me.ToAddress1Field.Text = o.ShippingAddress.Line1
                Me.ToAddress2Field.Text = o.ShippingAddress.Line2
                Me.ToCityField.Text = o.ShippingAddress.City
                Me.ToCompanyField.Text = o.ShippingAddress.Company
                If Me.ToCountryField.Items.FindByValue(o.ShippingAddress.CountryBvin) IsNot Nothing Then
                    Me.ToCountryField.ClearSelection()
                    Me.ToCountryField.Items.FindByValue(o.ShippingAddress.CountryBvin).Selected = True
                End If
                Me.ToNameField.Text = o.ShippingAddress.FirstName
                If o.ShippingAddress.MiddleInitial.Length > 0 Then
                    Me.ToNameField.Text += " " & o.ShippingAddress.MiddleInitial
                End If
                Me.ToNameField.Text += " " & o.ShippingAddress.LastName
                Me.ToPhoneField.Text = o.ShippingAddress.Phone
                Me.ToPostalCodeField.Text = o.ShippingAddress.PostalCode
                If o.ShippingAddress.RegionBvin.Length > 0 Then
                    Dim r As New Content.Region
                    r = Content.Region.FindByBvin(o.ShippingAddress.RegionBvin)
                    If Not r Is Nothing Then
                        Me.ToStateField.Text = r.Abbreviation
                    Else
                        Me.ToStateField.Text = o.ShippingAddress.RegionName
                    End If
                Else
                    Me.ToStateField.Text = o.ShippingAddress.RegionName
                End If
                Me.NotificationEmailField.Text = o.UserEmail
            End If


            If Me.ServiceField.Items.FindByValue(p.ShippingProviderServiceCode) IsNot Nothing Then
                Me.ServiceField.ClearSelection()
                Me.ServiceField.Items.FindByValue(p.ShippingProviderServiceCode).Selected = True
            End If

            If p.Weight > 0 Then
                Me.WeightField.Text = p.Weight
            End If

            If p.Height > 0 Then
                Me.HeightField.Text = p.Height
            End If
            If p.Width > 0 Then
                Me.WidthField.Text = p.Width
            End If
            If p.Length > 0 Then
                Me.LengthField.Text = p.Length
            End If

            Dim declaredValue As Decimal = p.FindDeclaredValue
            If declaredValue > 0 Then
                Me.DeclaredValueField.Text = declaredValue.ToString("#.00")
            End If

            Me.Reference1Field.Text = "Order " & o.OrderNumber & "-P" & Me.PackageIdField.Value
            Me.Reference2Field.Text = o.ShippingAddress.Phone

        End If
    End Sub

    Private Sub btnCanel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCanel.Click
        OnContinue(True)
    End Sub

    Private Sub btnShip_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnShip.Click
        Me.pnlPrint.Visible = False
        Me.pnlRates.Visible = False

        msg.ClearMessage()

        Dim req As New BVSoftware.BVC5.Shipping.Ups.ShipRequest


        req.AddressVerification = Me.chkAddressVerification.Checked

        req.BillTo = Me.BillToField.SelectedValue
        If req.BillTo = BVSoftware.BVC5.Shipping.Ups.PaymentType.ShipperCreditCard Then
            req.BillToCreditCardExpirationMonth = Me.CCExpMonthField.SelectedValue
            req.BillToCreditCardExpirationYear = Me.CCExpYearField.SelectedValue
            req.BillToCreditCardNumber = Utilities.CreditCardValidator.CleanCardNumber(Me.CCNumberField.Text)
            req.BillToCreditCardType = Me.CCTypeField.SelectedValue
        Else
            req.BillToAccountNumber = Me.BillToAccountNumberField.Text
            If Me.BillToPostalCodeField.Text.Trim.Length > 0 Then
                req.BillToPostalCode = Me.BillToPostalCodeField.Text.Trim
            End If
        End If
        req.BillToCountryCode = Me.BillToCountryField.SelectedValue

        req.BrowserHttpUserAgentString = Request.UserAgent
        req.COD = False

        If Me.DescriptionField.Text.Trim <> String.Empty Then
            req.ShipmentDescription = Me.DescriptionField.Text.Trim
        End If
        req.InvoiceLineTotal = False
        req.LabelFormat = BVSoftware.BVC5.Shipping.Ups.ShipLabelFormat.Gif
        'req.LabelStockSizeHeight = 4
        'req.LabelStockSizeWidth = 6
        req.NonValuedDocumentsOnly = False

        req.Notification = Me.chkNotification.Checked
        req.NotificationEmailAddress = Me.NotificationEmailField.Text
        req.NotificationFromName = Me.NotificationFromField.Text
        req.NotificationMemo = Me.NotificationMessage.Text
        req.NotificationSubjectType = Me.NotificationSubjectField.SelectedValue
        req.NotificationType = Me.NotificationTypeField.SelectedValue

        req.SaturdayDelivery = Me.chkSaturdayDelivery.Checked
        req.Service = CType(Me.ServiceField.SelectedValue, BVSoftware.BVC5.Shipping.Ups.ServiceType)
        req.Settings.UserID = WebAppSettings.ShippingUpsUsername
        req.Settings.Password = WebAppSettings.ShippingUpsPassword
        req.Settings.License = WebAppSettings.ShippingUpsLicense
        req.Settings.ServerUrl = WebAppSettings.ShippingUpsServer

        If Me.FromCompanyField.Text.Trim.Length < 1 Then
            req.ShipFrom.CompanyOrContactName = Me.FromNameField.Text
        Else
            req.ShipFrom.CompanyOrContactName = Me.FromCompanyField.Text
        End If
        req.ShipFrom.AttentionName = Me.FromNameField.Text
        req.ShipFrom.AccountNumber = WebAppSettings.ShippingUpsAccountNumber
        req.ShipFrom.PhoneNumber = Me.FromPhoneField.Text
        req.ShipFrom.AddressLine1 = Me.FromAddress1Field.Text.Trim
        req.ShipFrom.AddressLine2 = Me.FromAddress2Field.Text.Trim
        req.ShipFrom.City = Me.FromCityField.Text
        req.ShipFrom.StateProvinceCode = Me.FromStateField.Text
        req.ShipFrom.PostalCode = Me.FromPostalCodeField.Text.Trim
        req.ShipFrom.CountryCode = Me.FromCountryField.SelectedValue

        req.Shipper = req.ShipFrom

        If Me.ToCompanyField.Text.Trim.Length < 1 Then
            req.ShipTo.CompanyOrContactName = Me.ToNameField.Text
        Else
            req.ShipTo.CompanyOrContactName = Me.ToCompanyField.Text
        End If
        req.ShipTo.AttentionName = Me.ToNameField.Text
        req.ShipTo.PhoneNumber = Me.ToPhoneField.Text
        req.ShipTo.AddressLine1 = Me.ToAddress1Field.Text.Trim
        req.ShipTo.AddressLine2 = Me.ToAddress2Field.Text.Trim
        req.ShipTo.City = Me.ToCityField.Text
        req.ShipTo.StateProvinceCode = Me.ToStateField.Text
        req.ShipTo.PostalCode = Me.ToPostalCodeField.Text.Trim
        req.ShipTo.CountryCode = Me.ToCountryField.SelectedValue
        req.ShipTo.ResidentialAddress = Me.chkResidential.Checked


        Dim useDeclaredValueInsteadOfInsurance As Boolean = False

        req.InvoiceLineTotal = False
        '2004.6
        If Me.DeclaredValueField.Text.Trim <> String.Empty Then
            If req.ShipFrom.CountryCode = "US" Then
                If Me.PackageTypeField.SelectedValue <> 1 Then
                    If req.ShipTo.CountryCode = "CA" OrElse req.ShipTo.CountryCode = "PR" Then
                        useDeclaredValueInsteadOfInsurance = True
                        req.InvoiceLineTotal = True
                        req.InvoiceLineTotalAmount = Me.DeclaredValueField.Text.Trim
                        req.InvoiceLineTotalCurrency = BVSoftware.BVC5.Shipping.Ups.XmlTools.ConvertStringToCurrencyCode(Me.DeclaredValueCurrencyField.SelectedValue)
                    End If
                End If
            End If
        End If

        Dim p As New BVSoftware.BVC5.Shipping.Ups.Package
        p.AdditionalHandlingIsRequired = Me.chkAdditionalHandling.Checked

        If Me.CODAmountField.Text.Trim <> String.Empty Then
            p.COD = True
            p.CODAmount = Me.CODAmountField.Text.Trim
            p.CODCurrencyCode = BVSoftware.BVC5.Shipping.Ups.XmlTools.ConvertStringToCurrencyCode(Me.CODCurrencyField.SelectedValue)
        Else
            p.COD = False
        End If

        If Me.DeliveryConfirmationField.SelectedValue = 0 Then
            p.DeliveryConfirmation = False
        Else
            p.DeliveryConfirmation = True
            p.DeliveryConfirmationType = Me.DeliveryConfirmationField.SelectedValue
        End If

        p.DimensionalUnits = Me.DimensionalUnitsField.SelectedValue
        If Me.HeightField.Text.Trim <> String.Empty Then
            p.Height = Me.HeightField.Text
        End If

        '2004.6
        If useDeclaredValueInsteadOfInsurance = False Then
            If Me.DeclaredValueField.Text.Trim <> String.Empty Then
                p.InsuredValue = Me.DeclaredValueField.Text.Trim
                p.InsuredValueCurrency = BVSoftware.BVC5.Shipping.Ups.XmlTools.ConvertStringToCurrencyCode(Me.DeclaredValueCurrencyField.SelectedValue)
            End If
        End If

        If Me.LengthField.Text.Trim <> String.Empty Then
            p.Length = Me.LengthField.Text
        End If
        p.Packaging = Me.PackageTypeField.SelectedValue



        If Me.Reference1Field.Text.Trim <> String.Empty Then
            p.ReferenceNumber = Me.Reference1Field.Text
            p.ReferenceNumberType = BVSoftware.BVC5.Shipping.Ups.ReferenceNumberCode.TransactionReferenceNumber
        End If
        If Me.Reference2Field.Text.Trim <> String.Empty Then
            p.ReferenceNumber2 = Me.Reference2Field.Text
            p.ReferenceNumber2Type = BVSoftware.BVC5.Shipping.Ups.ReferenceNumberCode.TransactionReferenceNumber
        End If

        p.VerbalConfirmation = False
        If Me.WeightField.Text.Trim <> String.Empty Then
            p.Weight = Me.WeightField.Text
        End If
        p.WeightUnits = Me.WeightUnitsField.SelectedValue
        If Me.WidthField.Text.Trim <> String.Empty Then
            p.Width = Me.WidthField.Text
        End If

        p.VerbalConfirmation = Me.chkVerbalConfirmation.Checked
        If p.VerbalConfirmation = True Then
            p.VerbalConfirmationName = Me.VerbalNameField.Text.Trim
            p.VerbalConfirmationPhoneNumber = Me.VerbalPhoneField.Text.Trim
        End If
        req.AddPackage(p)


        ViewState("ShipDigest") = Nothing
        ViewState("TrackingNumber") = Nothing

        Dim res As BVSoftware.BVC5.Shipping.Ups.ShipResponse
        res = BVSoftware.BVC5.Shipping.Ups.XmlTools.SendConfirmRequest(req)

        If Not res Is Nothing Then

            If WebAppSettings.ShippingUpsWriteXml = True Then
                Me.SaveXmlStringToFile("Confirm_" & res.TrackingNumber & "_Request.xml", req.XmlConfirmRequest)
                Me.SaveXmlStringToFile("Confirm_" & res.TrackingNumber & "_Response.xml", req.XmlConfirmResponse)
            End If

            If res.Success = True Then
                ViewState("ShipDigest") = res.ShipmentDigest
                ViewState("TrackingNumber") = res.TrackingNumber
                msg.ShowInformation("Please review the courtesy rate and select an action.")
                Me.lblServiceOptions.Text = String.Format("{0:C}", res.ServiceOptionsCharge)
                Me.lblShipCharges.Text = String.Format("{0:C}", res.TransportationCharge)
                Me.lblRate.Text = String.Format("{0:C}", res.TotalCharge)

                Me.pnlGetRates.Visible = False
                Me.pnlRates.Visible = True
            Else
                Me.msg.ShowWarning("Error " & res.ErrorCode & ": " & res.ErrorMessage)
            End If
        Else
            msg.ShowError("Response object was empty")
        End If

    End Sub

    Private Sub Imagebutton1_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles Imagebutton1.Click
        msg.ClearMessage()
        Me.pnlPrint.Visible = False
        Me.pnlRates.Visible = False
        Me.pnlGetRates.Visible = True
    End Sub

    Private Sub Imagebutton2_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles Imagebutton2.Click
        msg.ClearMessage()

        Dim digest As String = String.Empty
        If Not (ViewState("ShipDigest") Is Nothing) Then
            digest = ViewState("ShipDigest")
        End If
        ' Send accept here
        If digest <> String.Empty Then

            Dim req As New BVSoftware.BVC5.Shipping.Ups.ShipAcceptRequest
            req.Settings.UserID = WebAppSettings.ShippingUpsUsername
            req.Settings.Password = WebAppSettings.ShippingUpsPassword
            req.Settings.License = WebAppSettings.ShippingUpsLicense
            req.Settings.ServerUrl = WebAppSettings.ShippingUpsServer
            req.ShipDigest = digest

            Dim res As BVSoftware.BVC5.Shipping.Ups.ShipAcceptResponse
            res = BVSoftware.BVC5.Shipping.Ups.XmlTools.SendShipAcceptRequest(req)

            If WebAppSettings.ShippingUpsWriteXml = True Then
                Me.SaveXmlStringToFile("Accept_" & ViewState("TrackingNumber") & "_Request.xml", req.XmlAcceptRequest)
                Me.SaveXmlStringToFile("Accept_" & ViewState("TrackingNumber") & "_Response.xml", req.XmlAcceptResponse)
            End If

            If Not res Is Nothing Then

                If res.Success = True Then

                    If Not (res.Packages Is Nothing) Then
                        If res.Packages.Count > 0 Then
                            Dim pak As BVSoftware.BVC5.Shipping.Ups.ShippedPackageInformation
                            pak = res.Packages(0)
                            If Not pak Is Nothing Then


                                If pak.LabelFormat = BVSoftware.BVC5.Shipping.Ups.ShipLabelFormat.Epl2 Then
                                    SaveBase64ToFile(pak.TrackingNumber & ".elp2", pak.Base64Image)
                                Else
                                    SaveBase64ToFile("label" & pak.TrackingNumber & ".gif", pak.Base64Image)
                                End If
                                SaveBase64ToFile(pak.TrackingNumber & ".htm", pak.Base64Html)

                                AddPopUpWindow(Path.Combine(WebAppSettings.SiteStandardRoot, "images/UPS/" & pak.TrackingNumber & ".htm"))
                                Me.pnlPrint.Visible = True
                                Me.lnkLabel.NavigateUrl = Path.Combine(WebAppSettings.SiteStandardRoot, "images/UPS/" & pak.TrackingNumber & ".htm")

                                msg.ShowOK("Package Shipped with UPS Tracking Number: " & res.TrackingNumber)

                                If Me.PackageIdField.Value <> String.Empty Then
                                    Dim p As Shipping.Package = Shipping.Package.FindByBvin(Me.PackageIdField.Value)
                                    If Not p Is Nothing Then                                        
                                        Dim o As Orders.Order = Orders.Order.FindByBvin(p.OrderId)
                                        Dim previousShippingStatus As Orders.OrderShippingStatus = o.ShippingStatus

                                        p.TrackingNumber = res.TrackingNumber
                                        p.ShippingProviderId = BVSoftware.BVC5.Shipping.Ups.UpsProvider.UPSProviderID
                                        p.ShippingProviderServiceCode = Me.ServiceField.SelectedValue
                                        p.Ship()
                                        Shipping.Package.Update(p)

                                        o = Orders.Order.FindByBvin(p.OrderId)
                                        Dim context As New BusinessRules.OrderTaskContext
                                        context.Order = o
                                        context.UserId = o.UserID
                                        context.Inputs.Add("bvsoftware", "PreviousShippingStatus", previousShippingStatus)
                                        BusinessRules.Workflow.RunByBvin(context, WebAppSettings.WorkflowIdShippingChanged)
                                    End If
                                End If

                            Else
                                msg.ShowError("Unable to load label for shipment!")
                            End If
                        Else
                            msg.ShowError("Empty Package List Found!")
                        End If
                    Else
                        msg.ShowError("No package list was found!")
                    End If


                Else
                    Me.msg.ShowWarning("Error " & res.ErrorCode & ": " & res.ErrorMessage)
                End If
            Else
                msg.ShowError("Unable to parse response with label!")
            End If

        Else
            msg.ShowError("Ship Response Object was empty.")
        End If

        Me.pnlGetRates.Visible = True
        Me.pnlRates.Visible = False


    End Sub

    Private Function SaveBase64ToFile(ByVal filename As String, ByVal base64data As String) As Boolean
        Dim result As Boolean = False

        Dim UPSLabelDirectory As String = Path.Combine(Request.PhysicalApplicationPath, "images\UPS")
        Try
            If Directory.Exists(UPSLabelDirectory) = False Then
                Directory.CreateDirectory(UPSLabelDirectory)
            End If

            Dim fs As New FileStream(Path.Combine(UPSLabelDirectory, filename), FileMode.Create)

            Dim data As Byte() = Utilities.Cryptography.Base64.ConvertFromBase64(base64data)
            fs.Write(data, 0, data.Length - 1)
            fs.Flush()
            fs.Close()

        Catch ex As Exception
            'EventLog.LogEvent(ex)
        End Try

        Return result
    End Function

    Private Sub AddPopUpWindow(ByVal url As String)

        Dim sb As New StringBuilder
        sb.Append("")
        sb.Append("<Script Language=Javascript>")
        sb.Append("javascript:window.open( '")
        sb.Append(url)
        sb.Append("', 'UPSLabel', 'menubar=1,scrollbars=yes,toolbar=1,resizable=")
        sb.Append("1,")
        sb.Append("');")
        sb.Append("</Script>")
        ClientScript.RegisterStartupScript(Me.GetType, "onLoad", sb.ToString())
        sb = Nothing

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

    Private Sub btnContinue_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnContinue.Click
        OnContinue(False)
    End Sub

    Private Sub OnContinue(ByVal deletePackage As Boolean)
        If deletePackage Then
            Dim p As Shipping.Package = Shipping.Package.FindByBvin(Me.PackageIdField.Value)
            If p IsNot Nothing Then
                If p.Bvin <> String.Empty Then
                    Shipping.Package.Delete(p.Bvin)
                End If
            End If
        End If
        
        If Me.ReturnUrlField.Value.Length > 0 Then
            Response.Redirect(Me.ReturnUrlField.Value)
        Else
            Response.Redirect("Default.aspx")
        End If
    End Sub

End Class

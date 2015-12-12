Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Configuration_Shipping_UpsLicense
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "UPS Online Tools License"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then

            Try
                LoadStates()

                Dim contactAddress As Contacts.Address = WebAppSettings.SiteShippingAddress

                With contactAddress
                    Dim c As Content.Country = Content.Country.FindByBvin(.CountryBvin)
                    If c IsNot Nothing Then
                        inCountry.SelectedValue = c.IsoCode
                    End If
                    inAddress1.Text = .Line1
                    inAddress2.Text = .Line2
                    inCity.Text = .City
                    Dim r As Content.Region = Content.Region.FindByBvin(.RegionBvin)
                    If r IsNot Nothing Then
                        inState.SelectedValue = r.Abbreviation
                    End If
                    inEmail.Text = WebAppSettings.ContactEmail
                    inPhone.Text = .Phone
                    inZip.Text = .PostalCode
                End With

            Catch Ex As Exception
                msg.ShowException(Ex)
            End Try

            ' Get License
            Try
                Dim UPSReg As New BVSoftware.Bvc5.Shipping.Ups.Registration
                If UPSReg.GetLicense(WebAppSettings.ShippingUpsServer) = True Then
                    lblLicense.Text = Server.HtmlEncode(UPSReg.License)
                    lblLicense.Text = lblLicense.Text.Replace(Chr(10), "&nbsp;<br>")
                Else
                    msg.ShowError("There was an error getting a license agreement: " & UPSReg.ErrorMessage)
                End If
                UPSReg = Nothing
            Catch Exx As Exception
                msg.ShowWarning(Exx.Message & "There was an error loading a license agreement.")
            End Try

        End If
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("Shipping.aspx", True)
    End Sub

    Private Sub btnAccept_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAccept.Click
        Trace.Write("Starting btnAccept_OnClick")
        msg.ClearMessage()


        If rbContactYes.Checked = False AndAlso rbContactNo.Checked = False Then
            msg.ShowWarning("Please select yes or no as your answer to the contact me question at the bottom of this page.")
        Else
            Try
                Dim UPSReg As New BVSoftware.BVC5.Shipping.Ups.Registration

                UPSReg.Address1 = inAddress1.Text.Trim()
                If inAddress2.Text.Trim.Length() > 0 Then
                    UPSReg.Address2 = inAddress2.Text.Trim()
                End If
                If inAddress3.Text.Trim.Length() > 0 Then
                    UPSReg.Address3 = inAddress3.Text.Trim()
                End If
                UPSReg.City = inCity.Text.Trim()
                UPSReg.Company = inCompany.Text.Trim()
                UPSReg.Title = inTitle.Text.Trim()
                UPSReg.Country = inCountry.SelectedValue
                UPSReg.Email = inEmail.Text.Trim()
                UPSReg.Name = inName.Text.Trim()
                UPSReg.URL = inURL.Text.Trim()
                UPSReg.Phone = inPhone.Text.Trim()
                If inCountry.SelectedValue = "US" OrElse inCountry.SelectedValue = "CA" Then
                    UPSReg.State = inState.SelectedItem.Value()
                End If
                If inCountry.SelectedValue = "US" OrElse inCountry.SelectedValue = "CA" Then
                    UPSReg.Zip = inZip.Text.Trim()
                End If
                If rbContactYes.Checked = True Then
                    UPSReg.ContactMe = "yes"
                Else
                    UPSReg.ContactMe = "no"
                End If
                UPSReg.AccountNumber = inUPSAccountNumber.Text.Trim()

                Dim sTempLicense As String = lblLicense.Text
                sTempLicense = sTempLicense.Replace("&nbsp;<br>", Chr(10))
                sTempLicense = Server.HtmlDecode(sTempLicense)
                'UPSReg.License = Server.HtmlDecode(lblLicense.Text)
                UPSReg.License = sTempLicense

                If UPSReg.AcceptLicense(WebAppSettings.ShippingUpsServer) = True Then

                    WebAppSettings.ShippingUpsLicense = UPSReg.LicenseNumber

                    ' Complete Registration process here...

                    Dim tempUsername As String = "bvc5"
                    If Me.inPhone.Text.Trim.Length > 3 Then
                        tempUsername += Me.inPhone.Text.Trim.Substring(inPhone.Text.Trim.Length - 4, 4)
                    End If
                    UPSReg.Password = Membership.UserAccount.GeneratePassword(10)
                    If UPSReg.Password.Length > 10 Then
                        UPSReg.Password = UPSReg.Password.Substring(0, 10)
                    End If

                    Dim RegistrationComplete As Boolean = False
                    Dim MaxRegistrationAttempts As Integer = 10
                    Dim CurrentAttempts As Integer = 0


                    While True
                        CurrentAttempts += 1
                        If (RegistrationComplete = True) OrElse (CurrentAttempts > MaxRegistrationAttempts) Then
                            Exit While
                        Else
                            UPSReg.Username = tempUsername

                            UPSReg.RequestSuggestedUsername = True
                            If UPSReg.Register(WebAppSettings.ShippingUpsServer) = True Then
                                ' Got Suggested Username
                                UPSReg.Username = UPSReg.SuggestedUsername

                                ' Now attempt actual registration
                                UPSReg.RequestSuggestedUsername = False
                                If UPSReg.Register(WebAppSettings.ShippingUpsServer) = True Then
                                    WebAppSettings.ShippingUpsUsername = UPSReg.Username
                                    WebAppSettings.ShippingUpsPassword = UPSReg.Password
                                    RegistrationComplete = True
                                    Exit While
                                End If
                            End If

                            UPSReg.RequestSuggestedUsername = False
                        End If
                    End While

                    If RegistrationComplete = True Then
                        Response.Redirect("Shipping_UPSThanks.aspx")
                    Else
                        Me.msg.ShowError("The registration process could not be completed at this time. Please try again later.")
                    End If

                Else
                    msg.ShowError(UPSReg.ErrorMessage & "<br>ErrorCode:" & UPSReg.ErrorCode)
                End If

            Catch Ex As Exception
                msg.ShowException(Ex)
            End Try
        End If
        Trace.Write("Ending btnAccept_OnClick")
    End Sub

    Sub LoadStates()
        Trace.Write("Starting LoadStates")
        Try

            ' US Country Code as default
            Dim USCode As String = "bf7389a2-9b21-4d33-b276-23c9c18ea0c0"
            Dim CanadaCode As String = "94052dcf-1ac8-4b65-813b-b17b12a0491f"

            Dim regions As Collection(Of Content.Region)
            regions = Content.Region.FindByCountry(USCode)

            Dim caRegions As Collection(Of Content.Region) = Content.Region.FindByCountry(CanadaCode)
            For Each r As Content.Region In caRegions
                regions.Add(r)
            Next
            inState.DataSource = regions
            inState.DataTextField = "Name"
            inState.DataValueField = "abbreviation"
            inState.DataBind()
        Catch Ex As Exception
            msg.ShowException(Ex)
        End Try
        Trace.Write("Ending LoadStates")
    End Sub

    Sub LoadCountries()
        inCountry.DataSource = Content.Country.FindActive
        inCountry.DataTextField = "DisplayName"
        inCountry.DataValueField = "Bvin"
        inCountry.DataBind()
    End Sub

    Sub SetCountry(ByVal sCode As String)
        Me.inCountry.SelectedValue = sCode        
    End Sub

    Sub SetState(ByVal sCode As String)
        Me.inState.SelectedValue = sCode        
    End Sub

End Class

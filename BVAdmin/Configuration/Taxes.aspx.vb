Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Taxes
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Tax Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Me.chkChargeTaxOnGiftWrap.Checked = WebAppSettings.ChargeTaxOnGiftWrap
            Me.chkChargeTaxOnNonShipping.Checked = WebAppSettings.ChargeTaxOnNonShippingItems            
            LoadTaxes()
        End If
    End Sub

    Sub LoadTaxes()
        Try
            dgTaxes.DataSource = Taxes.Tax.FindAll()
            dgTaxes.DataBind()
        Catch Ex As Exception
            msgBox.Visible = True
            msg.ShowException(Ex)
        End Try
    End Sub

    Public Sub dgTaxes_Delete(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgTaxes.DeleteCommand
        Dim deleteID As String = dgTaxes.DataKeys(e.Item.ItemIndex)
        Taxes.Tax.Delete(deleteID)
        LoadTaxes()
    End Sub

    Public Sub dgTaxes_PageIndexChanged(ByVal sender As System.Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles dgTaxes.PageIndexChanged
        dgTaxes.CurrentPageIndex = e.NewPageIndex
        LoadTaxes()
    End Sub

    Private Sub btnAddTax_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAddTax.Click
        msg.ClearMessage()
        Try
            Dim responseID As String = String.Empty

            Dim t As New Taxes.Tax
            t.CountryBvin = "en-US"
            t.CountyBvin = ""
            t.RegionID = 0
            t.PostalCode = ""
            t.Rate = 0.0

            If Taxes.Tax.SaveAsNew(t) = True Then
                responseID = t.Bvin
            End If

            If responseID IsNot Nothing Then
                Response.Redirect("taxes_edit.aspx?mode=new&id=" & responseID.ToString, True)
            Else
                msgBox.Visible = True
                msg.ShowError("Unable to add new tax!")
            End If
        Catch Ex As Exception
            msg.Visible = True
            msg.ShowException(Ex)
        End Try
    End Sub

    Private Sub dgTaxes_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataGridItemEventArgs) Handles dgTaxes.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
            Dim editID As String = dgTaxes.DataKeys(e.Item.ItemIndex)
            Dim t As New Taxes.Tax

            t = Taxes.Tax.FindByBvin(editID)

            If t IsNot Nothing Then
                Dim CountryInfo As Label = e.Item.FindControl("CountryInfo")
                Dim RegionInfo As Label = e.Item.FindControl("RegionInfo")
                Dim CountyInfo As Label = e.Item.FindControl("CountyInfo")
                Dim PostalCodeInfo As Label = e.Item.FindControl("PostalCodeInfo")
                Dim TaxTypeInfo As Label = e.Item.FindControl("TaxTypeInfo")
                Dim RateInfo As Label = e.Item.FindControl("RateInfo")
                Dim AppliesToShippingLabel As Label = e.Item.FindControl("AppliesToShippingLabel")

                If Not CountryInfo Is Nothing Then
                    Dim c As Content.Country = Content.Country.FindByBvin(t.CountryBvin)
                    If Not c Is Nothing Then
                        CountryInfo.Text = c.DisplayName
                    Else
                        CountryInfo.Text = t.CountryBvin
                    End If
                    c = Nothing
                End If
                If Not RegionInfo Is Nothing Then
                    If t.RegionID IsNot Nothing Then
                        Dim r As New Content.Region
                        r = Content.Region.FindByBvin(t.RegionID)
                        If r IsNot Nothing Then
                            RegionInfo.Text = r.Name
                        Else
                            RegionInfo.Text = t.CountryBvin
                        End If
                        r = Nothing
                    Else
                        RegionInfo.Text = "All States/Regions"
                    End If

                End If
                If Not CountyInfo Is Nothing Then
                    If t.CountyBvin IsNot Nothing Then
                        Dim r As New Content.County
                        r = Content.County.FindByBvin(t.CountyBvin)
                        If r IsNot Nothing Then
                            CountyInfo.Text = r.Name
                        Else
                            CountyInfo.Text = t.CountyBvin
                        End If
                        r = Nothing
                    Else
                        CountyInfo.Text = "All Counties"
                    End If

                End If
                If Not PostalCodeInfo Is Nothing Then
                    If t.PostalCode.Trim.Length > 0 Then
                        PostalCodeInfo.Text = t.PostalCode
                    Else
                        PostalCodeInfo.Text = "All Zip/Postal Codes"
                    End If

                End If
                If Not TaxTypeInfo Is Nothing Then
                    If t.TaxClass.ToString.Length > 0 Then
                        If t.TaxClass = Taxes.TaxClass.TaxableUnassignedItems Then
                            TaxTypeInfo.Text = "All Taxable Items Without A Tax Class"
                        Else
                            Dim tc As New Taxes.TaxClass
                            tc = Taxes.TaxClass.FindByBvin(t.TaxClass)
                            If tc.ToString.Length > 0 Then
                                TaxTypeInfo.Text = tc.DisplayName
                            Else
                                TaxTypeInfo.Text = t.TaxClass
                            End If
                            tc = Nothing
                        End If
                    Else
                        TaxTypeInfo.Text = "All Taxable Items"
                    End If

                End If

                If AppliesToShippingLabel IsNot Nothing Then
                    If t.ApplyToShipping Then
                        AppliesToShippingLabel.Text = "Yes"
                    Else
                        AppliesToShippingLabel.Text = "No"
                    End If
                End If
                If Not RateInfo Is Nothing Then
                    RateInfo.Text = String.Format("{0:p4}", t.Rate / 100)
                End If

                CountryInfo = Nothing
                RegionInfo = Nothing
                PostalCodeInfo = Nothing
                TaxTypeInfo = Nothing
                RateInfo = Nothing
            End If
            t = Nothing
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            msg.ShowOk("Settings Saved")
            msgBox.Visible = True
            'Response.Redirect("taxes.aspx")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        'WebAppSettings.ChargeTaxOnGiftWrap = Me.chkChargeTaxOnGiftWrap.Checked
        WebAppSettings.ChargeTaxOnNonShippingItems = Me.chkChargeTaxOnNonShipping.Checked        

        result = True

        Return result
    End Function

End Class

Imports BVSoftware.Bvc5.Core


Partial Class Products_ProductProperties_Edit
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Properties Edit"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load        
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Catalog

            Dim productID As String = String.Empty
            If Not Request("ID") Is Nothing Then
                productID = Request.QueryString("id")
            Else
                msg.ShowError("No product property ID was found.")
            End If

            ViewState("ID") = productID
            PopulateCultureCodeList()
            LoadProduct()
        End If

    End Sub

    Private Sub PopulateCultureCodeList()
        lstCultureCode.DataSource = Content.Country.FindActive
        lstCultureCode.DataValueField = "CultureCode"
        lstCultureCode.DataTextField = "SampleNameAndCurrency"
        lstCultureCode.DataBind()      
    End Sub

    Private Sub LoadProduct()
        Dim prop As New Catalog.ProductProperty
        prop = Catalog.ProductProperty.FindByBvin(ViewState("ID"))

        If Not prop Is Nothing Then
            Me.PropertyNameField.Text = prop.PropertyName
            Me.DisplayNameField.Text = prop.DisplayName
            Me.chkDisplayOnSite.Checked = prop.DisplayOnSite
            Me.chkDisplayToDropShipper.Checked = prop.DisplayToDropShipper
            Me.DefaultValueField.Text = prop.DefaultValue

            For Each li As ListItem In lstCultureCode.Items
                If li.Value = prop.CultureCode Then
                    lstCultureCode.ClearSelection()
                    li.Selected = True
                End If
            Next

            Me.DefaultValueField.TextMode = TextBoxMode.MultiLine
            'Me.DefaultDate.SetYearRange(Date.Now.Year - 50, Date.Now.Year + 50)

            If prop.TypeCode = Catalog.ProductPropertyType.DateField Then
                Dim d As New Date
                d = Date.Now
                Try
                    If prop.DefaultValue.Trim.Length > 0 Then
                        d = System.DateTime.Parse(prop.DefaultValue)                        
                    End If
                Catch ex As Exception

                End Try
                Me.DefaultDate.SelectedDate = d
            End If

            DisplayProperControls(prop.TypeCode)
        Else
            msg.ShowError("Unable to load Product Property ID " & ViewState("ID"))
        End If
    End Sub

    Private Sub DisplayProperControls(ByVal typeCode As Catalog.ProductPropertyType)
        Me.pnlChoiceControls.Visible = False
        pnlCultureCode.Visible = False
        Me.DefaultDate.Visible = False

        Select Case typeCode
            Case Catalog.ProductPropertyType.CurrencyField
                pnlCultureCode.Visible = True
                DefaultValueField.Visible = True
                lstDefaultValue.Visible = False
                ChoiceNote.InnerText = "Default Value"
            Case Catalog.ProductPropertyType.DateField
                DefaultValueField.Visible = False
                lstDefaultValue.Visible = False
                Me.DefaultDate.Visible = True
                ChoiceNote.InnerText = "Default Value"
            Case Catalog.ProductPropertyType.MultipleChoiceField
                lstDefaultValue.Visible = True
                DefaultValueField.Visible = False
                PopulateMultipleChoice()
                ChoiceNote.InnerText = "To select a default simply select the item in the list before you hit save."
                Me.pnlChoiceControls.Visible = True                
            Case Catalog.ProductPropertyType.TextField
                DefaultValueField.Visible = True
                lstDefaultValue.Visible = False
                ChoiceNote.InnerText = "Default Value"
        End Select
    End Sub

    Private Sub PopulateVendors()

        Me.lstDefaultValue.DataSource = Contacts.Vendor.FindAll
        Me.lstDefaultValue.DataTextField = "DisplayName"
        Me.lstDefaultValue.DataValueField = "bvin"
        Me.lstDefaultValue.DataBind()
        For Each li As ListItem In lstDefaultValue.Items
            If li.Value = DefaultValueField.Text.Trim Then
                lstDefaultValue.ClearSelection()
                li.Selected = True
            End If
        Next

    End Sub

    Private Sub PopulateManufacturers()
        Me.lstDefaultValue.DataSource = Contacts.Manufacturer.FindAll
        Me.lstDefaultValue.DataTextField = "DisplayName"
        Me.lstDefaultValue.DataValueField = "bvin"
        Me.lstDefaultValue.DataBind()
        For Each li As ListItem In lstDefaultValue.Items
            If li.Value = DefaultValueField.Text.Trim Then
                lstDefaultValue.ClearSelection()
                li.Selected = True
            End If
        Next
    End Sub

    Private Sub PopulateMultipleChoice()

        Me.lstDefaultValue.DataSource = Catalog.ProductPropertyChoice.FindByPropertyId(ViewState("ID"))
        Me.lstDefaultValue.DataTextField = "ChoiceName"
        Me.lstDefaultValue.DataValueField = "bvin"
        Me.lstDefaultValue.DataBind()

        For Each li As ListItem In lstDefaultValue.Items
            If li.Value = DefaultValueField.Text.Trim Then
                lstDefaultValue.ClearSelection()
                li.Selected = True
            End If
        Next
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        ' Delete newly created item if user cancels so we don't leave a bunch of "new property"
        If Request.QueryString("newmode") = 1 Then
            Catalog.ProductProperty.Delete(ViewState("ID"))
        End If
        Response.Redirect("~/BVAdmin/Catalog/ProductTypeProperties.aspx")
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        msg.ClearMessage()
        Dim prop As New Catalog.ProductProperty
        prop = Catalog.ProductProperty.FindByBvin(ViewState("ID"))
        If Not prop Is Nothing Then
            prop.PropertyName = PropertyNameField.Text
            prop.DisplayName = DisplayNameField.Text
            prop.DisplayOnSite = chkDisplayOnSite.Checked
            prop.DisplayToDropShipper = chkDisplayToDropShipper.Checked
            Select Case prop.TypeCode
                Case Catalog.ProductPropertyType.CurrencyField
                    prop.CultureCode = lstCultureCode.SelectedValue
                    prop.DefaultValue = DefaultValueField.Text.Trim
                Case Catalog.ProductPropertyType.MultipleChoiceField
                    prop.DefaultValue = lstDefaultValue.SelectedValue
                Case Catalog.ProductPropertyType.DateField
                    prop.DefaultValue = String.Format("{0:d}", DefaultDate.SelectedDate)                    
                Case Catalog.ProductPropertyType.TextField
                    prop.DefaultValue = DefaultValueField.Text.Trim
            End Select
            If Catalog.ProductProperty.Save(prop) = True Then
                prop = Nothing
                Response.Redirect("~/BVAdmin/Catalog/ProductTypeProperties.aspx")
            Else
                prop = Nothing
                msg.ShowError("Error: Couldn't Save Property!")
            End If
        Else
            msg.ShowError("Couldn't Load Property to Update!")
        End If

    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDelete.Click
        If Me.lstDefaultValue.Items.Count > 0 Then
            Catalog.ProductPropertyChoice.Delete(lstDefaultValue.SelectedValue)
            PopulateMultipleChoice()
        End If
    End Sub

    Private Sub btnNewChoice_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNewChoice.Click
        msg.ClearMessage()

        Dim ppc As New Catalog.ProductPropertyChoice
        ppc.ChoiceName = Me.NewChoiceField.Text.Trim
        ppc.PropertyBvin = ViewState("ID")
        Dim prop As Catalog.ProductProperty = Catalog.ProductProperty.FindByBvin(ViewState("ID"))
        If prop.Bvin <> String.Empty Then
            If prop.Choices.Count > 0 Then
                ppc.SortOrder = prop.Choices(prop.Choices.Count - 1).SortOrder + 1
            Else
                ppc.SortOrder = 1
            End If
            If Catalog.ProductPropertyChoice.SaveAsNew(ppc) = True Then
                PopulateMultipleChoice()
            Else
                msg.ShowError("Couldn't add choice!")
            End If
            Me.NewChoiceField.Text = String.Empty
        End If
    End Sub

    Private Sub btnMoveUp_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnMoveUp.Click
        msg.ClearMessage()
        Me.DefaultValueField.Text = Me.lstDefaultValue.SelectedValue
        Catalog.ProductPropertyChoice.MoveUp(ViewState("ID"), lstDefaultValue.SelectedValue)
        PopulateMultipleChoice()
    End Sub

    Private Sub btnMoveDown_Click(ByVal sender As System.Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnMoveDown.Click
        msg.ClearMessage()
        Me.DefaultValueField.Text = Me.lstDefaultValue.SelectedValue
        Catalog.ProductPropertyChoice.MoveDown(ViewState("ID"), lstDefaultValue.SelectedValue)
        PopulateMultipleChoice()
    End Sub

End Class

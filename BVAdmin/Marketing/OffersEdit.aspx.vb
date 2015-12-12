Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Marketing_OffersEdit
    Inherits BaseAdminPage

    Private OfferEditor As Content.OfferTemplate

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        InitializeErrorMessages()
        If Not Page.IsPostBack Then
            If Request.QueryString("id") IsNot Nothing Then
                Dim offer As Marketing.Offer = Marketing.Offer.FindByBvin(Request.QueryString("id"))
                If offer IsNot Nothing Then
                    InitializeBaseForm(offer)
                    LoadOfferEditor(offer, True)
                Else
                    Response.Redirect("~/BVAdmin/Marketing/Default.aspx")
                End If
            ElseIf Request.QueryString("type") IsNot Nothing Then
                Dim offer As New Marketing.Offer()
                offer.OfferType = Request.QueryString("type")
                InitializeBaseForm(offer)
                LoadOfferEditor(offer, True)
            Else
                Response.Redirect("~/BVAdmin/Marketing/Default.aspx")
            End If
        Else
            If ViewState("Offer") IsNot Nothing Then
                LoadOfferEditor(DirectCast(ViewState("Offer"), Marketing.Offer), False)
            End If
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Offers Edit"
        Me.CurrentTab = AdminTabType.Marketing        
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.MarketingView)
    End Sub

    Protected Sub InitializeErrorMessages()
        MessageBox1.ClearMessage()
        MessageBox2.ClearMessage()
        StartDatePicker.RequiredErrorMessage = "Start date is required."
        EndDatePicker.RequiredErrorMessage = "End date is required."
        StartDatePicker.InvalidFormatErrorMessage = "Start date format is invalid. Please enter a valid date."
        EndDatePicker.InvalidFormatErrorMessage = "End date format is invalid. Please enter a valid date."
    End Sub

    Protected Sub LoadOfferEditor(ByVal offer As Marketing.Offer, ByVal force As Boolean)
        OfferEditor = CType(Content.ModuleController.LoadOfferEditor(offer.OfferType, Me), Content.OfferTemplate)                
        OfferEditor.ID = "OfferEditor"
        OfferEditor.BlockId = offer.Bvin
        OfferEditor.Offer = offer
        AddControlToEditPanel(OfferEditor)
        ViewState("Offer") = offer
        OfferEditor.Initialize(force)
    End Sub

    Protected Sub AddControlToEditPanel(ByVal control As System.Web.UI.UserControl)
        EditPlaceHolder.Controls.Clear()
        EditPlaceHolder.Controls.Add(control)
    End Sub

    Protected Sub SaveImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SaveImageButton.Click
        If Page.IsValid Then
            Dim offer As Marketing.Offer = DirectCast(ViewState("Offer"), Marketing.Offer)
            GetFormValues(offer)
            If offer.Commit() Then
                OfferEditor.Save()
                Response.Redirect("~/BVAdmin/Marketing/default.aspx")
            Else
                MessageBox1.ShowError("An error occurred while trying to save the offer to the database.")
            End If
        End If
    End Sub

    Protected Sub GetFormValues(ByVal offer As Marketing.Offer)
        offer.Name = OfferNameTextBox.Text
        offer.StartDate = StartDatePicker.SelectedDate
        offer.EndDate = EndDatePicker.SelectedDate
        offer.RequiresCouponCode = RequiresCouponCodeCheckBox.Checked
        'offer.GenerateUniquePromotionalCodes = UniquePromotionalCodesCheckBox.Checked
        offer.PromotionalCode = PromotionCodeTextBox.Text
        If UnlimitedRadioButton.Checked Then
            offer.UseType = Marketing.OfferUseTypes.Unlimited
            offer.UseTimes = -1
        ElseIf PerStoreRadioButton.Checked Then
            offer.UseType = Marketing.OfferUseTypes.PerStore
            offer.UseTimes = CInt(UsePerStoreTextBox.Text)
        ElseIf PerCustomerRadioButton.Checked Then
            offer.UseType = Marketing.OfferUseTypes.PerCustomer
            offer.UseTimes = CInt(UsePerPersonTextBox.Text)
        End If

        offer.CantBeCombined = PromotionCodeCantBeCombinedCheckBox.Checked
    End Sub

    Protected Sub CancelImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CancelImageButton.Click
        Response.Redirect("~/BVAdmin/Marketing/Default.aspx")
    End Sub

    Protected Sub InitializeBaseForm(ByVal offer As Marketing.Offer)
        OfferNameTextBox.Text = offer.Name
        StartDatePicker.Text = offer.StartDate.ToShortDateString()
        EndDatePicker.Text = offer.EndDate.ToShortDateString()
        RequiresCouponCodeCheckBox.Checked = offer.RequiresCouponCode
        'UniquePromotionalCodesCheckBox.Checked = offer.GenerateUniquePromotionalCodes
        PromotionCodeTextBox.Text = offer.PromotionalCode
        If offer.UseType = Marketing.OfferUseTypes.Unlimited Then
            UnlimitedRadioButton.Checked = True
            PerStoreRadioButton.Checked = False
            PerCustomerRadioButton.Checked = False
            UsePerPersonTextBox.Text = "0"
            UsePerStoreTextBox.Text = "0"
        ElseIf offer.UseType = Marketing.OfferUseTypes.PerStore Then
            UnlimitedRadioButton.Checked = False
            PerStoreRadioButton.Checked = True
            PerCustomerRadioButton.Checked = False
            UsePerPersonTextBox.Text = "0"
            UsePerStoreTextBox.Text = CType(offer.UseTimes, String)
        ElseIf offer.UseType = Marketing.OfferUseTypes.PerCustomer Then
            UnlimitedRadioButton.Checked = False
            PerStoreRadioButton.Checked = False
            PerCustomerRadioButton.Checked = True
            UsePerPersonTextBox.Text = CType(offer.UseTimes, String)
            UsePerStoreTextBox.Text = "0"
        End If
        PromotionCodeCantBeCombinedCheckBox.Checked = offer.CantBeCombined
    End Sub

    Protected Sub PerCustomerCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles PerCustomerCustomValidator.ServerValidate
        If PerCustomerRadioButton.Checked Then
            Dim val As Integer
            If Integer.TryParse(UsePerPersonTextBox.Text, val) Then
                If val <= 0 Then
                    args.IsValid = False
                End If
            Else
                args.IsValid = False
            End If
        End If
    End Sub

    Protected Sub PerStoreCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles PerStoreCustomValidator.ServerValidate
        If PerStoreRadioButton.Checked Then
            Dim val As Integer
            If Integer.TryParse(UsePerStoreTextBox.Text, val) Then
                If val <= 0 Then
                    args.IsValid = False
                End If
            Else
                args.IsValid = False
            End If
        End If
    End Sub

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        If Date.Compare(StartDatePicker.SelectedDate, EndDatePicker.SelectedDate) = 1 Then
            args.IsValid = False
        End If
    End Sub
End Class

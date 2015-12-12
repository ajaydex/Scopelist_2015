// Copyright Structured Solutions
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using BVSoftware.Bvc5.Core.Shipping;
using StructuredSolutions.Bvc5.Shipping.Providers.Controls;
using StructuredSolutions.Bvc5.Shipping.Providers;
using ASPNET = System.Web.UI.WebControls;

public partial class BVModules_Shipping_Order_Rules_Edit : OrderRulesEditor
{
    #region Overrides

    public override void DataBind()
    {
        base.DataBind();
        LoadData();
    }

    #endregion

    #region Event Handlers

    protected void CancelButton_Click(Object sender, ImageClickEventArgs e)
    {
        NotifyFinishedEditing("Canceled");
    }

    protected void MethodAdjustmentAmountNumericValidate_ServerValidate(Object sender, ServerValidateEventArgs e)
    {
        ShippingMethodAdjustmentType adjustmentType =
            (ShippingMethodAdjustmentType)
            Enum.Parse(typeof (ShippingMethodAdjustmentType), MethodAdjustmentTypeField.SelectedValue);
        if (adjustmentType == ShippingMethodAdjustmentType.Amount)
        {
            MethodAdjustmentAmountNumericValidator.ErrorMessage = "The adjustment amount must be a number.";
            MethodAdjustmentAmountNumericValidator.Text = "<div>Must be a number</div>";
        }
        else
        {
            MethodAdjustmentAmountNumericValidator.ErrorMessage = "The adjustment percentage must be a non-zero number.";
            MethodAdjustmentAmountNumericValidator.Text = "<div>Must be a non-zero number</div>";
        }

        decimal value;
        if (Decimal.TryParse(e.Value, out value))
        {
            if (adjustmentType == ShippingMethodAdjustmentType.Percentage)
                e.IsValid = (value != 0);
            else
                e.IsValid = true;
        }
        else
        {
            e.IsValid = false;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) DataBind();
    }

    protected void SaveButton_Click(Object sender, ImageClickEventArgs e)
    {
        if (Page.IsValid)
        {
            SaveData();
            NotifyFinishedEditing(NameField.Text.Trim());
        }
    }

    protected void ShippingProviderField_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList list = sender as DropDownList;
        if (list != null)
        {
            ShippingProviderServiceCodeField.Items.Clear();
            ShippingProviderServiceCodeField.Items.AddRange(GetShippingProviderServiceCodes());
            if (ShippingProviderServiceCodeField.Items.Count > 0)
            {
                if (ShippingProviderServiceCodeField.Items.FindByValue(Settings.ShippingProviderServiceCode) == null)
                {
                    Settings.ShippingProviderServiceCode = ShippingProviderServiceCodeField.Items[0].Value;
                }
                ShippingProviderServiceCodeField.SelectedValue = Settings.ShippingProviderServiceCode;
            }
            ShippingProviderServiceCodeField.Visible = (ShippingProviderServiceCodeField.Items.Count > 0);
            ShippingProviderServiceCodeField.UpdateAfterCallBack = true;
        }
    }

    protected void UpdateButton_Click(Object sender, ImageClickEventArgs e)
    {
        if (Page.IsValid)
        {
            SaveData();
        }
    }

    #endregion

    #region Properties

    protected ExtendedShippingProvider Provider
    {
        get
        {
            ShippingProvider provider = AvailableProviders.FindProviderById(ShippingMethod.ShippingProviderId);
            return provider as ExtendedShippingProvider;
        }
    }

    #endregion

    #region Methods

    private ListItem[] GetShippingProviders()
    {
        List<ListItem> providers = new List<ListItem>();
        providers.Add(new ListItem("- none -", String.Empty));
        foreach (ShippingProvider provider in AvailableProviders.Providers)
        {
            if (String.Compare(provider.ProviderId, ShippingMethod.ShippingProviderId, true) != 0)
            {
                if (provider.SupportsTracking)
                {
                    providers.Add(new ListItem(provider.Name, provider.ProviderId));
                }
            }
        }
        return providers.ToArray();
    }

    private ListItem[] GetShippingProviderServiceCodes()
    {
        List<ListItem> codes = new List<ListItem>();
        ShippingProvider provider = AvailableProviders.FindProviderById(ShippingProviderField.SelectedValue);
        if (String.Compare(provider.ProviderId, ShippingProviderField.SelectedValue, true) == 0)
        {
            foreach (ListItem item in provider.ListServiceCodes())
            {
                codes.Add(item);
            }
        }
        return codes.ToArray();
    }

    private void LoadData()
    {
        NameField.Text = ShippingMethod.Name;
        if (string.IsNullOrEmpty(NameField.Text))
            NameField.Text = Provider.Name;
        ShippingProviderField.Items.Clear();
        ShippingProviderField.Items.AddRange(GetShippingProviders());
        if (ShippingProviderField.Items.FindByValue(Settings.ShippingProviderId) == null)
        {
            Settings.ShippingProviderId = ShippingProviderField.Items[0].Value;
        }
        ShippingProviderField.SelectedValue = Settings.ShippingProviderId;
        ShippingProviderServiceCodeField.Items.Clear();
        ShippingProviderServiceCodeField.Items.AddRange(GetShippingProviderServiceCodes());
        if (ShippingProviderServiceCodeField.Items.Count > 0)
        {
            if (ShippingProviderServiceCodeField.Items.FindByValue(Settings.ShippingProviderServiceCode) == null)
            {
                Settings.ShippingProviderServiceCode = ShippingProviderServiceCodeField.Items[0].Value;
            }
            ShippingProviderServiceCodeField.SelectedValue = Settings.ShippingProviderServiceCode;
        }
        ShippingProviderServiceCodeField.Visible = (ShippingProviderServiceCodeField.Items.Count > 0);
        MethodAdjustmentAmountField.Text = ShippingMethod.Adjustment.ToString("n");
        MethodAdjustmentTypeField.SelectedValue = ShippingMethod.AdjustmentType.ToString();
        ShipMethodVisibleField.Checked = Settings.Visible;
    }

    private void SaveData()
    {
        ShippingMethod.Name = NameField.Text.Trim();
        Settings.Visible = ShipMethodVisibleField.Checked;
        Settings.ShippingProviderId = ShippingProviderField.SelectedValue;
        Settings.ShippingProviderServiceCode = ShippingProviderServiceCodeField.SelectedValue;
        if (string.IsNullOrEmpty(MethodAdjustmentAmountField.Text))
            ShippingMethod.Adjustment = 0M;
        else
            ShippingMethod.Adjustment = Decimal.Parse(MethodAdjustmentAmountField.Text);
        ShippingMethod.AdjustmentType =
            (ShippingMethodAdjustmentType)
            Enum.Parse(typeof (ShippingMethodAdjustmentType), MethodAdjustmentTypeField.SelectedValue);
        ShippingMethod.Update(ShippingMethod);
    }

    #endregion
}
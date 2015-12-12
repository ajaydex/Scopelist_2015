// Copyright Structured Solutions
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;
using BVSoftware.Bvc5.Core.Catalog;
using BVSoftware.Bvc5.Core.Contacts;
using BVSoftware.Bvc5.Core.Content;
using BVSoftware.Bvc5.Core.Membership;
using BVSoftware.Bvc5.Core.Shipping;
using StructuredSolutions.Bvc5.Shipping.Providers;
using StructuredSolutions.Bvc5.Shipping.Providers.Controls;
using StructuredSolutions.Bvc5.Shipping.Providers.Settings;
using ASPNET = System.Web.UI.WebControls;
using ListItem = System.Web.UI.WebControls.ListItem;

public partial class BVModules_Shipping_Order_Rules_OrderMatchEditor : UserControl
{
    #region Properties

    public object DataSource
    {
        get { return ViewState["DataSource"]; }
        set { ViewState["DataSource"] = value; }
    }

    public string Prompt
    {
        get
        {
            object value = ViewState["Prompt"];
            if (value == null)
                return string.Empty;
            else
                return (string) value;
        }
        set { ViewState["Prompt"] = value; }
    }

    public ShippingMethod ShippingMethod
    {
        get { return ((BVShippingModule) NamingContainer.NamingContainer.NamingContainer.NamingContainer).ShippingMethod; }
    }

    public string RuleId
    {
        get
        {
            object value = ViewState["RuleId"];
            if (value == null)
                return string.Empty;
            else
                return (string) value;
        }
        set { ViewState["RuleId"] = value; }
    }

    #endregion

    #region Event Handlers

    protected void LimitItemPropertyField_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (sender != null)
        {
            DropDownList itemPropertyField = (DropDownList) sender;
            DropDownList customPropertyField =
                (DropDownList) itemPropertyField.NamingContainer.FindControl("LimitCustomPropertyField");
            HelpLabel customPropertyLabel =
                (HelpLabel) itemPropertyField.NamingContainer.FindControl("LimitCustomPropertyLabel");

            Label multiplierLabel = (Label) itemPropertyField.NamingContainer.FindControl("LimitMultiplierLabel");
            HelpLabel limitLabel = (HelpLabel) itemPropertyField.NamingContainer.FindControl("LimitLabel");
            TextBox limitField = (TextBox) itemPropertyField.NamingContainer.FindControl("LimitField");
            BaseValidator limitRequired = (BaseValidator) itemPropertyField.NamingContainer.FindControl("LimitRequired");
            BaseValidator limitNumeric = (BaseValidator) itemPropertyField.NamingContainer.FindControl("LimitNumeric");

            ItemProperties itemProperty =
                (ItemProperties) Enum.Parse(typeof (ItemProperties), itemPropertyField.SelectedValue);

            PrepareCustomPropertyField(customPropertyLabel, customPropertyField, itemProperty);
            PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric, itemProperty);
        }
    }

    protected void LimitOrderPropertyField_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (sender != null)
        {
            DropDownList orderPropertyField = (DropDownList) sender;
            DropDownList itemPropertyField =
                (DropDownList) orderPropertyField.NamingContainer.FindControl("LimitItemPropertyField");
            DropDownList packagePropertyField =
                (DropDownList) orderPropertyField.NamingContainer.FindControl("LimitPackagePropertyField");
            DropDownList customPropertyField =
                (DropDownList) orderPropertyField.NamingContainer.FindControl("LimitCustomPropertyField");
            HelpLabel customPropertyLabel =
                (HelpLabel) orderPropertyField.NamingContainer.FindControl("LimitCustomPropertyLabel");

            Label multiplierLabel = (Label) orderPropertyField.NamingContainer.FindControl("LimitMultiplierLabel");
            HelpLabel limitLabel = (HelpLabel) orderPropertyField.NamingContainer.FindControl("LimitLabel");
            TextBox limitField = (TextBox) orderPropertyField.NamingContainer.FindControl("LimitField");
            BaseValidator limitRequired =
                (BaseValidator) orderPropertyField.NamingContainer.FindControl("LimitRequired");
            BaseValidator limitNumeric = (BaseValidator) orderPropertyField.NamingContainer.FindControl("LimitNumeric");

            OrderProperties orderProperty =
                (OrderProperties) Enum.Parse(typeof (OrderProperties), orderPropertyField.SelectedValue);
            ItemProperties itemProperty =
                (ItemProperties) Enum.Parse(typeof (ItemProperties), itemPropertyField.SelectedValue);
            PackageProperties packageProperty =
                (PackageProperties) Enum.Parse(typeof (PackageProperties), packagePropertyField.SelectedValue);

            if (orderProperty == OrderProperties.ItemProperty)
            {
                itemPropertyField.Visible = true;
                packagePropertyField.Visible = false;
                PrepareCustomPropertyField(customPropertyLabel, customPropertyField, itemProperty);
                PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric, itemProperty);
            }
            else if (orderProperty == OrderProperties.PackageProperty)
            {
                itemPropertyField.Visible = false;
                packagePropertyField.Visible = true;
                PrepareCustomPropertyField(customPropertyLabel, customPropertyField, packageProperty);
                PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric, packageProperty);
            }
            else
            {
                itemPropertyField.Visible = false;
                packagePropertyField.Visible = false;
                customPropertyField.Visible = false;
                PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric, orderProperty);
                Page.Validate("RuleGroup");
                if (Page.IsValid)
                {
                    PrepareCustomPropertyField(customPropertyLabel, customPropertyField, orderProperty);
                }
            }
        }
    }

    protected void LimitPackagePropertyField_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (sender != null)
        {
            DropDownList packagePropertyField = (DropDownList) sender;
            DropDownList customPropertyField =
                (DropDownList) packagePropertyField.NamingContainer.FindControl("LimitCustomPropertyField");
            HelpLabel customPropertyLabel =
                (HelpLabel) packagePropertyField.NamingContainer.FindControl("LimitCustomPropertyLabel");

            Label multiplierLabel = (Label) packagePropertyField.NamingContainer.FindControl("LimitMultiplierLabel");
            HelpLabel limitLabel = (HelpLabel) packagePropertyField.NamingContainer.FindControl("LimitLabel");
            TextBox limitField = (TextBox) packagePropertyField.NamingContainer.FindControl("LimitField");
            BaseValidator limitRequired =
                (BaseValidator) packagePropertyField.NamingContainer.FindControl("LimitRequired");
            BaseValidator limitNumeric =
                (BaseValidator) packagePropertyField.NamingContainer.FindControl("LimitNumeric");

            PackageProperties packageProperty =
                (PackageProperties) Enum.Parse(typeof (PackageProperties), packagePropertyField.SelectedValue);

            PrepareCustomPropertyField(customPropertyLabel, customPropertyField, packageProperty);
            PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric, packageProperty);
        }
    }

    protected void Matches_ItemCommand(object sender, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "New")
        {
            OrderMatchList matches = GetMatches();
            OrderMatch match = new OrderMatch();
            matches.Insert(e.Item.ItemIndex + 1, match);
            DataSource = matches;
            DataBindChildren();
        }
        else if (e.CommandName == "Delete")
        {
            OrderMatchList matches = GetMatches();
            matches.RemoveAt(e.Item.ItemIndex);
            DataSource = matches;
            DataBindChildren();
        }
    }

    protected void Matches_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            OrderMatchList matches = (OrderMatchList) DataSource;
            OrderMatch match = matches[e.Item.ItemIndex];

            DropDownList orderPropertyList = (DropDownList) e.Item.FindControl("MatchOrderPropertyField");
            DropDownList itemPropertyList = (DropDownList) e.Item.FindControl("MatchItemPropertyField");
            DropDownList packagePropertyList = (DropDownList) e.Item.FindControl("MatchPackagePropertyField");
            DropDownList customPropertyList = (DropDownList) e.Item.FindControl("MatchCustomPropertyField");
            DropDownList comparisonList = (DropDownList) e.Item.FindControl("MatchComparisonTypeField");
            DropDownList limitOrderPropertyList = (DropDownList) e.Item.FindControl("LimitOrderPropertyField");
            DropDownList limitPackagePropertyList = (DropDownList) e.Item.FindControl("LimitPackagePropertyField");
            DropDownList limitItemPropertyList = (DropDownList) e.Item.FindControl("LimitItemPropertyField");
            DropDownList limitCustomPropertyList = (DropDownList) e.Item.FindControl("LimitCustomPropertyField");

            HelpLabel customPropertyLabel = (HelpLabel) e.Item.FindControl("MatchCustomPropertyLabel");
            HelpLabel limitCustomPropertyLabel = (HelpLabel) e.Item.FindControl("LimitCustomPropertyLabel");

            Label multiplierLabel = (Label) e.Item.FindControl("LimitMultiplierLabel");
            HelpLabel limitLabel = (HelpLabel) e.Item.FindControl("LimitLabel");
            TextBox limitField = (TextBox) e.Item.FindControl("LimitField");
            BaseValidator limitRequired = (BaseValidator) e.Item.FindControl("LimitRequired");
            BaseValidator limitNumeric = (BaseValidator) e.Item.FindControl("LimitNumeric");

            orderPropertyList.Items.Clear();
            orderPropertyList.Items.AddRange(GetMatchOrderProperties());

            itemPropertyList.Items.Clear();
            itemPropertyList.Items.AddRange(GetItemProperties());
            itemPropertyList.Visible = false;

            packagePropertyList.Items.Clear();
            packagePropertyList.Items.AddRange(GetPackageProperties());
            packagePropertyList.Visible = false;

            customPropertyList.Visible = false;

            if (match.OrderProperty == OrderProperties.ItemProperty)
            {
                itemPropertyList.Visible = true;
                PrepareCustomPropertyField(customPropertyLabel, customPropertyList, match.ItemProperty);
            }
            else if (match.OrderProperty == OrderProperties.PackageProperty)
            {
                packagePropertyList.Visible = true;
                PrepareCustomPropertyField(customPropertyLabel, customPropertyList, match.PackageProperty);
            }
            else
            {
                PrepareCustomPropertyField(customPropertyLabel, customPropertyList, match.OrderProperty);
            }

            if (customPropertyList.Items.Count == 0)
                customPropertyList.Items.Add(new ListItem("", match.CustomProperty));
            if (customPropertyList.Items.FindByValue(match.CustomProperty) == null)
                match.CustomProperty = customPropertyList.Items[0].Value;

            comparisonList.Items.Clear();
            comparisonList.Items.AddRange(GetComparisons());

            limitOrderPropertyList.Items.Clear();
            limitOrderPropertyList.Items.AddRange(GetLimitOrderProperties());

            limitItemPropertyList.Items.Clear();
            limitItemPropertyList.Items.AddRange(GetItemProperties());
            limitItemPropertyList.Visible = false;

            limitPackagePropertyList.Items.Clear();
            limitPackagePropertyList.Items.AddRange(GetPackageProperties());
            limitPackagePropertyList.Visible = false;

            limitCustomPropertyList.Visible = false;

            multiplierLabel.Visible = match.LimitOrderProperty != OrderProperties.FixedAmountOne;

            if (match.LimitOrderProperty == OrderProperties.ItemProperty)
            {
                limitItemPropertyList.Visible = true;
                PrepareCustomPropertyField(limitCustomPropertyLabel, limitCustomPropertyList, match.LimitItemProperty);
                PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric,
                                  match.LimitItemProperty);
            }
            else if (match.LimitOrderProperty == OrderProperties.PackageProperty)
            {
                limitPackagePropertyList.Visible = true;
                PrepareCustomPropertyField(limitCustomPropertyLabel, limitCustomPropertyList, match.LimitPackageProperty);
                PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric,
                                  match.LimitPackageProperty);
            }
            else
            {
                PrepareCustomPropertyField(limitCustomPropertyLabel, limitCustomPropertyList, match.LimitOrderProperty);
                PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric,
                                  match.LimitOrderProperty);
            }

            if (limitCustomPropertyList.Items.Count == 0)
                limitCustomPropertyList.Items.Add(new ListItem("", match.LimitCustomProperty));
            if (limitCustomPropertyList.Items.FindByValue(match.LimitCustomProperty) == null)
                match.LimitCustomProperty = limitCustomPropertyList.Items[0].Value;
        }
    }

    protected void MatchItemPropertyField_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (sender != null)
        {
            DropDownList itemPropertyField = (DropDownList) sender;
            DropDownList customPropertyField =
                (DropDownList) itemPropertyField.NamingContainer.FindControl("MatchCustomPropertyField");
            HelpLabel customPropertyLabel =
                (HelpLabel) itemPropertyField.NamingContainer.FindControl("MatchCustomPropertyLabel");
            ItemProperties itemProperty =
                (ItemProperties) Enum.Parse(typeof (ItemProperties), itemPropertyField.SelectedValue);

            PrepareCustomPropertyField(customPropertyLabel, customPropertyField, itemProperty);
        }
    }

    protected void MatchPackagePropertyField_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (sender != null)
        {
            DropDownList packagePropertyField = (DropDownList) sender;
            DropDownList customPropertyField =
                (DropDownList) packagePropertyField.NamingContainer.FindControl("MatchCustomPropertyField");
            HelpLabel customPropertyLabel =
                (HelpLabel) packagePropertyField.NamingContainer.FindControl("MatchCustomPropertyLabel");
            PackageProperties packageProperty =
                (PackageProperties) Enum.Parse(typeof (PackageProperties), packagePropertyField.SelectedValue);

            PrepareCustomPropertyField(customPropertyLabel, customPropertyField, packageProperty);
        }
    }

    protected void MatchOrderPropertyField_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (sender != null)
        {
            DropDownList orderPropertyField = (DropDownList) sender;
            DropDownList itemPropertyField =
                (DropDownList) orderPropertyField.NamingContainer.FindControl("MatchItemPropertyField");
            DropDownList packagePropertyField =
                (DropDownList) orderPropertyField.NamingContainer.FindControl("MatchPackagePropertyField");
            DropDownList customPropertyField =
                (DropDownList) orderPropertyField.NamingContainer.FindControl("MatchCustomPropertyField");
            HelpLabel customPropertyLabel =
                (HelpLabel) orderPropertyField.NamingContainer.FindControl("MatchCustomPropertyLabel");
            OrderProperties orderProperty =
                (OrderProperties) Enum.Parse(typeof (OrderProperties), orderPropertyField.SelectedValue);
            ItemProperties itemProperty =
                (ItemProperties) Enum.Parse(typeof (ItemProperties), itemPropertyField.SelectedValue);
            PackageProperties packageProperty =
                (PackageProperties) Enum.Parse(typeof (PackageProperties), packagePropertyField.SelectedValue);

            if (orderProperty == OrderProperties.ItemProperty)
            {
                itemPropertyField.Visible = true;
                packagePropertyField.Visible = false;
                PrepareCustomPropertyField(customPropertyLabel, customPropertyField, itemProperty);
            }
            else if (orderProperty == OrderProperties.PackageProperty)
            {
                itemPropertyField.Visible = false;
                packagePropertyField.Visible = true;
                PrepareCustomPropertyField(customPropertyLabel, customPropertyField, packageProperty);
            }
            else
            {
                itemPropertyField.Visible = false;
                packagePropertyField.Visible = false;
                customPropertyField.Visible = false;
                Page.Validate("RuleGroup");
                if (Page.IsValid)
                {
                    PrepareCustomPropertyField(customPropertyLabel, customPropertyField, orderProperty);
                }
            }
        }
    }

    #endregion

    #region Methods

    private readonly Regex hiddenCustomerProperties =
        new Regex("bvin|password|salt|address", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private readonly Regex hiddenItemProperties =
        new Regex("FixedAmountOne", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private readonly Regex hiddenLimitOrderProperties =
        new Regex("Invisible|PackageProperty", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private readonly Regex hiddenMatchOrderProperties =
        new Regex("FixedAmountOne|Invisible|PackageProperty", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private readonly Regex hiddenPackageProperties =
        new Regex("FixedAmountOne|Invisible|UseMethod|ItemProperty|Separator0",
                  RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private readonly Regex hiddenVendorManufacturerProperties =
        new Regex("address|bvin|lastupdated|dropshipemailtemplateid", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    protected override void DataBindChildren()
    {
        Matches.RuleId = RuleId;
        Matches.DataSource = DataSource;
        base.DataBindChildren();
    }

    private static ListItem[] GetAddressProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (PropertyInfo property in typeof (Address).GetProperties(BindingFlags.Instance | BindingFlags.Public))
        {
            if (property.Name.ToLowerInvariant().IndexOf("bvin") == -1)
                properties.Add(new ListItem(property.Name, property.Name));
        }
        properties.Sort(delegate(ListItem item1, ListItem item2) { return string.Compare(item1.Text, item2.Text); });
        return properties.ToArray();
    }

    private static ListItem[] GetComparisons()
    {
        List<ListItem> comparisons = new List<ListItem>();
        foreach (RuleComparisons comparison in Enum.GetValues(typeof(RuleComparisons)))
        {
            comparisons.Add(new ListItem(RuleComparisonsHelper.GetDisplayName(comparison), comparison.ToString()));
        }
        return comparisons.ToArray();
    }

    private ListItem[] GetCustomerProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (
            PropertyInfo property in typeof (UserAccount).GetProperties(BindingFlags.Instance | BindingFlags.Public))
        {
            if (!hiddenCustomerProperties.IsMatch(property.Name))
                properties.Add(new ListItem(property.Name, property.Name));
        }
        properties.Sort(delegate(ListItem item1, ListItem item2) { return string.Compare(item1.Text, item2.Text); });
        return properties.ToArray();
    }

    private ListItem[] GetItemProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (ItemProperties property in Enum.GetValues(typeof (ItemProperties)))
        {
            if (!hiddenItemProperties.IsMatch(property.ToString()))
            {
                properties.Add(new ListItem(ItemPropertiesHelper.GetDisplayName(property), property.ToString()));
            }
        }
        return properties.ToArray();
    }

    public OrderMatchList GetMatches()
    {
        return Matches.GetMatches();
    }

    private ListItem[] GetLimitOrderProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (OrderProperties property in Enum.GetValues(typeof (OrderProperties)))
        {
            if (!hiddenLimitOrderProperties.IsMatch(property.ToString()))
            {
                properties.Add(new ListItem(OrderPropertiesHelper.GetDisplayName(property), property.ToString()));
            }
        }
        return properties.ToArray();
    }

    private ListItem[] GetMatchOrderProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (OrderProperties property in Enum.GetValues(typeof (OrderProperties)))
        {
            if (!hiddenMatchOrderProperties.IsMatch(property.ToString()))
            {
                properties.Add(new ListItem(OrderPropertiesHelper.GetDisplayName(property), property.ToString()));
            }
        }
        return properties.ToArray();
    }

    private ListItem[] GetPackageProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (PackageProperties property in Enum.GetValues(typeof (PackageProperties)))
        {
            if (!hiddenPackageProperties.IsMatch(property.ToString()))
            {
                properties.Add(new ListItem(PackagePropertiesHelper.GetDisplayName(property), property.ToString()));
            }
        }
        return properties.ToArray();
    }

    private static ListItem[] GetPropertyTypes()
    {
        List<ListItem> propertyTypes = new List<ListItem>();
        Collection<ProductProperty> properties = ProductProperty.FindAll();

        foreach (ProductProperty property in properties)
        {
            propertyTypes.Add(new ListItem(property.DisplayName, property.Bvin));
        }
        if (propertyTypes.Count == 0)
        {
            propertyTypes.Add(new ListItem("- n/a -", string.Empty));
        }

        return propertyTypes.ToArray();
    }

    private ListItem[] GetShippingMethods()
    {
        List<ListItem> methods = new List<ListItem>();
        methods.Add(new ListItem("-n/a-", ""));
        foreach (ShippingMethod method in ShippingMethod.FindAll())
        {
            if (String.Compare(method.Bvin, ShippingMethod.Bvin, true) != 0)
            {
                methods.Add(new ListItem(method.Name, method.Bvin));
            }
        }
        return methods.ToArray();
    }

    private ListItem[] GetVendorManufacturerProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (
            PropertyInfo property in
                typeof (VendorManufacturerBase).GetProperties(BindingFlags.Instance | BindingFlags.Public))
        {
            if (!hiddenVendorManufacturerProperties.IsMatch(property.Name))
                properties.Add(new ListItem(property.Name, property.Name));
        }
        properties.AddRange(GetAddressProperties());
        properties.Sort(delegate(ListItem item1, ListItem item2) { return string.Compare(item1.Text, item2.Text); });
        return properties.ToArray();
    }

    private void PrepareCustomPropertyField(WebControl label, ListControl list, ItemProperties property)
    {
        list.Items.Clear();
        if (property == ItemProperties.CustomProperty)
        {
            label.ToolTip = "<p>Select the custom property to use.</p>";
            list.Items.AddRange(GetPropertyTypes());
            list.Visible = true;
        }
        else if (property == ItemProperties.Manufacturer || property == ItemProperties.Vendor)
        {
            label.ToolTip = string.Format("<p>Select the {0} property to use.</p>", property.ToString().ToLower());
            list.Items.AddRange(GetVendorManufacturerProperties());
            list.Visible = true;
        }
        else
        {
            label.ToolTip = "";
            list.Items.Add(new ListItem("n/a", ""));
            list.Visible = false;
        }
    }

    private static void PrepareCustomPropertyField(WebControl label, ListControl list, PackageProperties property)
    {
        list.Items.Clear();
        if (property == PackageProperties.DestinationAddress || property == PackageProperties.SourceAddress)
        {
            label.ToolTip = "<p>Select the address property to use.</p>";
            list.Items.AddRange(GetAddressProperties());
            list.Visible = true;
        }
        else
        {
            label.ToolTip = "";
            list.Items.Add(new ListItem("n/a", ""));
            list.Visible = false;
        }
    }

    private void PrepareCustomPropertyField(WebControl label, ListControl list, OrderProperties property)
    {
        list.Items.Clear();
        if (property == OrderProperties.BillingAddress || property == OrderProperties.ShippingAddress)
        {
            label.ToolTip = "<p>Select the address property to use.</p>";
            list.Items.AddRange(GetAddressProperties());
            list.Visible = true;
        }
        else if (property == OrderProperties.Customer)
        {
            label.ToolTip = "<p>Select the customer property to use.</p>";
            list.Items.AddRange(GetCustomerProperties());
            list.Visible = true;
        }
        else if (property == OrderProperties.UseMethod)
        {
            label.ToolTip = "<p>Select the shipping method to use.</p>";
            list.Items.AddRange(GetShippingMethods());
            list.Visible = true;
        }
        else
        {
            label.ToolTip = "";
            list.Items.Add(new ListItem("n/a", ""));
            list.Visible = false;
        }
    }

    private static void PrepareLimitField(Control multiplier, Label label, Control field, WebControl requiredValidator, WebControl numericValidator, ItemProperties property)
    {
        PropertyTypes propertyType = ItemPropertiesHelper.GetPropertyType(property);
        PrepareLimitField(multiplier, label, field, requiredValidator, numericValidator, propertyType);
    }

    private static void PrepareLimitField(Control multiplier, Label label, Control field, WebControl requiredValidator, WebControl numericValidator, OrderProperties property)
    {
        PropertyTypes propertyType = OrderPropertiesHelper.GetPropertyType(property);
        PrepareLimitField(multiplier, label, field, requiredValidator, numericValidator, propertyType);
    }

    private static void PrepareLimitField(Control multiplier, Label label, Control field, WebControl requiredValidator, WebControl numericValidator, PackageProperties property)
    {
        PropertyTypes propertyType = PackagePropertiesHelper.GetPropertyType(property);
        PrepareLimitField(multiplier, label, field, requiredValidator, numericValidator, propertyType);
    }

    private static void PrepareLimitField(Control multiplier, Label label, Control field, WebControl requiredValidator, WebControl numericValidator, PropertyTypes propertyType)
    {
        if (propertyType == PropertyTypes.Numeric)
        {
            multiplier.Visible = true;
            field.Visible = true;
            label.Text = "Multiplier";
            label.ToolTip = "<p>Enter the multiplier.</p>";
            requiredValidator.Enabled = true;
            numericValidator.Enabled = true;
        }
        else if (propertyType == PropertyTypes.Fixed)
        {
            multiplier.Visible = false;
            field.Visible = true;
            label.Text = "Limit";
            label.ToolTip = "<p>Enter the limit used in the comparison.</p>";
            requiredValidator.Enabled = false;
            numericValidator.Enabled = false;
        }
        else
        {
            multiplier.Visible = false;
            field.Visible = false;
            requiredValidator.Enabled = false;
            numericValidator.Enabled = false;
        }
    }

    #endregion
}
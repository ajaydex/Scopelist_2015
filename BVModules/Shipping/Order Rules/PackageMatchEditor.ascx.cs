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
using BVSoftware.Bvc5.Core.Shipping;
using StructuredSolutions.Bvc5.Shipping.Providers.Controls;
using StructuredSolutions.Bvc5.Shipping.Providers.Settings;
using ASPNET = System.Web.UI.WebControls;
using ListItem = System.Web.UI.WebControls.ListItem;

public partial class BVModules_Shipping_Order_Rules_PackageMatchEditor : UserControl
{
    #region Properties

    public object DataSource
    {
        get { return ViewState["DataSource"]; }
        set { ViewState["DataSource"] = value; }
    }

    public ShippingMethod ShippingMethod
    {
        get { return ((BVShippingModule) NamingContainer.NamingContainer.NamingContainer.NamingContainer).ShippingMethod; }
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
            ItemProperties itemProperty =
                (ItemProperties) Enum.Parse(typeof (ItemProperties), itemPropertyField.SelectedValue);
            DropDownList customPropertyField =
                (DropDownList) itemPropertyField.NamingContainer.FindControl("LimitCustomPropertyField");
            HelpLabel customPropertyLabel =
                (HelpLabel) itemPropertyField.NamingContainer.FindControl("LimitCustomPropertyLabel");

            Label multiplierLabel = (Label) itemPropertyField.NamingContainer.FindControl("LimitMultiplierLabel");
            HelpLabel limitLabel = (HelpLabel) itemPropertyField.NamingContainer.FindControl("LimitLabel");
            TextBox limitField = (TextBox) itemPropertyField.NamingContainer.FindControl("LimitField");
            BaseValidator limitRequired = (BaseValidator) itemPropertyField.NamingContainer.FindControl("LimitRequired");
            BaseValidator limitNumeric = (BaseValidator) itemPropertyField.NamingContainer.FindControl("LimitNumeric");

            PrepareCustomPropertyField(customPropertyLabel, customPropertyField, itemProperty);
            PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric, itemProperty);
        }
    }

    protected void LimitPackagePropertyField_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (sender != null)
        {
            DropDownList propertyField = (DropDownList) sender;
            PackageProperties packageProperty =
                (PackageProperties) Enum.Parse(typeof (PackageProperties), propertyField.SelectedValue);
            DropDownList itemPropertyField =
                (DropDownList) propertyField.NamingContainer.FindControl("LimitItemPropertyField");
            ItemProperties itemProperty =
                (ItemProperties) Enum.Parse(typeof (ItemProperties), itemPropertyField.SelectedValue);
            DropDownList customPropertyField =
                (DropDownList) propertyField.NamingContainer.FindControl("LimitCustomPropertyField");
            HelpLabel customPropertyLabel =
                (HelpLabel) propertyField.NamingContainer.FindControl("LimitCustomPropertyLabel");

            Label multiplierLabel = (Label) propertyField.NamingContainer.FindControl("LimitMultiplierLabel");
            HelpLabel limitLabel = (HelpLabel) propertyField.NamingContainer.FindControl("LimitLabel");
            TextBox limitField = (TextBox) propertyField.NamingContainer.FindControl("LimitField");
            BaseValidator limitRequired = (BaseValidator) propertyField.NamingContainer.FindControl("LimitRequired");
            BaseValidator limitNumeric = (BaseValidator) propertyField.NamingContainer.FindControl("LimitNumeric");

            if (packageProperty == PackageProperties.ItemProperty)
            {
                itemPropertyField.Visible = true;
                PrepareCustomPropertyField(customPropertyLabel, customPropertyField, itemProperty);
                PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric, itemProperty);
            }
            else
            {
                itemPropertyField.Visible = false;
                customPropertyField.Visible = false;
                PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric, packageProperty);
                Page.Validate("RuleGroup");
                if (Page.IsValid)
                {
                    PrepareCustomPropertyField(customPropertyLabel, customPropertyField, packageProperty);
                }
            }
        }
    }

    protected void LimitValidator_Validate(object sender, ServerValidateEventArgs e)
    {
        // Do not validate fixed values
        DropDownList propertyField =
            (DropDownList) ((Control) sender).NamingContainer.FindControl("LimitPackagePropertyField");
        PackageProperties packageProperty =
            (PackageProperties) Enum.Parse(typeof (PackageProperties), propertyField.SelectedValue);
        if (packageProperty != PackageProperties.FixedAmountOne && packageProperty != PackageProperties.Separator0)
        {
            if (string.IsNullOrEmpty(e.Value))
            {
                e.IsValid = false;
            }
            else
            {
                Decimal result;
                e.IsValid = Decimal.TryParse(e.Value, out result);
            }
        }
        else
        {
            e.IsValid = true;
        }
    }

    protected void Matches_ItemCommand(object sender, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "New")
        {
            PackageMatchList matches = GetMatches();
            PackageMatch match = new PackageMatch();
            matches.Insert(e.Item.ItemIndex + 1, match);
            DataSource = matches;
            DataBindChildren();
        }
        else if (e.CommandName == "Delete")
        {
            PackageMatchList matches = GetMatches();
            matches.RemoveAt(e.Item.ItemIndex);
            DataSource = matches;
            DataBindChildren();
        }
    }

    protected void Matches_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            PackageMatchList matches = (PackageMatchList) DataSource;
            PackageMatch match = matches[e.Item.ItemIndex];

            DropDownList packagePropertyList = (DropDownList) e.Item.FindControl("MatchPackagePropertyField");
            DropDownList itemPropertyList = (DropDownList) e.Item.FindControl("MatchItemPropertyField");
            DropDownList customPropertyList = (DropDownList) e.Item.FindControl("MatchCustomPropertyField");
            DropDownList comparisonList = (DropDownList) e.Item.FindControl("MatchComparisonTypeField");
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

            packagePropertyList.Items.Clear();
            packagePropertyList.Items.AddRange(GetMatchPackageProperties());

            itemPropertyList.Items.Clear();
            itemPropertyList.Items.AddRange(GetItemProperties());
            itemPropertyList.Visible = false;

            customPropertyList.Visible = false;

            if (match.PackageProperty == PackageProperties.ItemProperty)
            {
                itemPropertyList.Visible = true;
                PrepareCustomPropertyField(customPropertyLabel, customPropertyList, match.ItemProperty);
            }
            else
            {
                PrepareCustomPropertyField(customPropertyLabel, customPropertyList, match.PackageProperty);
            }

            if (customPropertyList.Items.Count == 0)
                customPropertyList.Items.Add(new ListItem("", match.CustomProperty));
            if (customPropertyList.Items.FindByValue(match.CustomProperty) == null)
                match.CustomProperty = customPropertyList.Items[0].Value;

            comparisonList.Items.Clear();
            comparisonList.Items.AddRange(GetComparisons());

            limitPackagePropertyList.Items.Clear();
            limitPackagePropertyList.Items.AddRange(GetLimitPackageProperties());

            limitItemPropertyList.Items.Clear();
            limitItemPropertyList.Items.AddRange(GetItemProperties());
            limitItemPropertyList.Visible = false;

            limitCustomPropertyList.Visible = false;

            multiplierLabel.Visible = match.LimitPackageProperty != PackageProperties.FixedAmountOne;

            if (match.LimitPackageProperty == PackageProperties.ItemProperty)
            {
                limitItemPropertyList.Visible = true;
                PrepareCustomPropertyField(limitCustomPropertyLabel, limitCustomPropertyList, match.LimitItemProperty);
                PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric,
                                  match.LimitItemProperty);
            }
            else
            {
                PrepareCustomPropertyField(limitCustomPropertyLabel, limitCustomPropertyList, match.LimitPackageProperty);
                PrepareLimitField(multiplierLabel, limitLabel, limitField, limitRequired, limitNumeric,
                                  match.LimitPackageProperty);
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
            ItemProperties itemProperty =
                (ItemProperties) Enum.Parse(typeof (ItemProperties), itemPropertyField.SelectedValue);
            DropDownList customPropertyField =
                (DropDownList) itemPropertyField.NamingContainer.FindControl("MatchCustomPropertyField");
            HelpLabel customPropertyLabel =
                (HelpLabel) itemPropertyField.NamingContainer.FindControl("MatchCustomPropertyLabel");
            PrepareCustomPropertyField(customPropertyLabel, customPropertyField, itemProperty);
        }
    }

    protected void MatchPackagePropertyField_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (sender != null)
        {
            DropDownList propertyField = (DropDownList) sender;
            PackageProperties matchProperty =
                (PackageProperties) Enum.Parse(typeof (PackageProperties), propertyField.SelectedValue);
            DropDownList itemPropertyField =
                (DropDownList) propertyField.NamingContainer.FindControl("MatchItemPropertyField");
            ItemProperties itemProperty =
                (ItemProperties) Enum.Parse(typeof (ItemProperties), itemPropertyField.SelectedValue);
            DropDownList customPropertyField =
                (DropDownList) propertyField.NamingContainer.FindControl("MatchCustomPropertyField");
            HelpLabel customPropertyLabel =
                (HelpLabel) propertyField.NamingContainer.FindControl("MatchCustomPropertyLabel");

            if (matchProperty == PackageProperties.ItemProperty)
            {
                itemPropertyField.Visible = true;
                PrepareCustomPropertyField(customPropertyLabel, customPropertyField, itemProperty);
            }
            else
            {
                itemPropertyField.Visible = false;
                customPropertyField.Visible = false;
                Page.Validate("RuleGroup");
                if (Page.IsValid)
                {
                    PrepareCustomPropertyField(customPropertyLabel, customPropertyField, matchProperty);
                }
            }
        }
    }

    #endregion

    #region Methods

    private readonly Regex hiddenAddressProperties =
        new Regex("bvin|lastupdated", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private readonly Regex hiddenItemProperties =
        new Regex("FixedAmountOne", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private readonly Regex hiddenLimitPackageProperties =
        new Regex("Invisible|UseMethod", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private readonly Regex hiddenMatchPackageProperties =
        new Regex("FixedAmountOne|Invisible|UseMethod", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private readonly Regex hiddenVendorManufacturerProperties =
        new Regex("address|bvin|lastupdated|dropshipemailtemplateid", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    protected override void DataBindChildren()
    {
        Matches.RuleId = RuleId;
        Matches.DataSource = DataSource;
        base.DataBindChildren();
    }

    private ListItem[] GetAddressProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (PropertyInfo property in typeof (Address).GetProperties(BindingFlags.Instance | BindingFlags.Public))
        {
            if (!hiddenAddressProperties.IsMatch(property.Name))
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

    public PackageMatchList GetMatches()
    {
        return Matches.GetMatches();
    }

    private ListItem[] GetLimitPackageProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (PackageProperties property in Enum.GetValues(typeof (PackageProperties)))
        {
            if (!hiddenLimitPackageProperties.IsMatch(property.ToString()))
            {
                properties.Add(new ListItem(PackagePropertiesHelper.GetDisplayName(property), property.ToString()));
            }
        }
        return properties.ToArray();
    }

    private ListItem[] GetMatchPackageProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (PackageProperties property in Enum.GetValues(typeof (PackageProperties)))
        {
            if (!hiddenMatchPackageProperties.IsMatch(property.ToString()))
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

    private void PrepareCustomPropertyField(WebControl label, ListControl list, PackageProperties property)
    {
        list.Items.Clear();
        if (property == PackageProperties.DestinationAddress || property == PackageProperties.SourceAddress)
        {
            label.ToolTip = "<p>Select the address property to use.</p>";
            list.Items.AddRange(GetAddressProperties());
            list.Visible = true;
        }
        else if (property == PackageProperties.UseMethod)
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
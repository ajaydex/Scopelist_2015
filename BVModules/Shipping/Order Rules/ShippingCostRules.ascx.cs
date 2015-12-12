// Copyright Structured Solutions
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Serialization;
using BVSoftware.Bvc5.Core.Catalog;
using BVSoftware.Bvc5.Core.Contacts;
using BVSoftware.Bvc5.Core.Content;
using BVSoftware.Bvc5.Core.Membership;
using BVSoftware.Bvc5.Core.Orders;
using BVSoftware.Bvc5.Core.Shipping;
using StructuredSolutions.Bvc5.Shipping.Providers.Controls;
using StructuredSolutions.Bvc5.Shipping.PostalCodes;
using StructuredSolutions.Bvc5.Shipping.Providers.Settings;
using ASPNET = System.Web.UI.WebControls;
using ListItem = System.Web.UI.WebControls.ListItem;

public partial class BVModules_Shipping_Order_Rules_ShippingCostRules : UserControl
{
    #region Overrides

    /// <summary>
    /// Add script to the page that hides the import validation message when
    /// the dialog is closed.
    /// Also add script to perform client-side validation of the file import
    /// field (built in RequiredFieldValidator does not work).
    /// </summary>
    /// <param name="e"></param>
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);
        String script = String.Format(
            @"function hideImportCostDialogValidation(type, args) {{
    el = document.getElementById('{0}');
    if (typeof(el) != 'undefined' && el != null) {{
        el.style.display = 'none';
    }}
}}
",
            ImportCostUploadRequired.ClientID);
        Page.ClientScript.RegisterStartupScript(GetType(), script, script, true);
        script = String.Format(
            @"function validateImportCostUpload(source, args) {{
    el = document.getElementById('{0}');
    if (typeof(el) != 'undefined' && el != null) {{
        args.IsValid = (el.value != null && el.value.length > 0);
        el = document.getElementById(source.id);
        el.style.display = args.IsValid ? 'none' : 'inline';
    }}
}}
",
            ImportCostUpload.ClientID);
        Page.ClientScript.RegisterStartupScript(GetType(), script, script, true);
    }

    #endregion

    #region Properties

    protected OrderRuleProviderSettings Settings
    {
        get { return ((OrderRulesEditor) NamingContainer).Settings; }
    }

    #endregion

    #region Event Handlers

    protected void Export_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.ContentType = "text/xml";
        Response.AddHeader("Content-Disposition", "attachment;filename=OrderCost.rules");
        XmlSerializer serializer = new XmlSerializer(typeof (OrderRuleList));
        serializer.Serialize(Response.OutputStream, Settings.CostingRules);
        Response.End();
    }

    protected void Import_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            XmlSerializer serializer = new XmlSerializer(typeof (OrderRule[]));
            try
            {
                OrderRule[] rules = serializer.Deserialize(ImportCostUpload.FileContent) as OrderRule[];
                if (rules != null)
                {
                    Settings.CostingRules.Clear();
                    foreach (OrderRule rule in rules)
                        Settings.CostingRules.Add(rule);
                    Settings.CostingRules.Save();
                    DataBind();
                }
            }
            catch
            {
                ImportCostUploadRequired.Text = "<br />Invalid file format<br />";
                ImportCostUploadRequired.IsValid = false;
                RedisplayImportCostDialog();
            }
        }
    }

    protected void ImportCostUploadRequired_ServerValidate(object source, ServerValidateEventArgs e)
    {
        e.IsValid = ImportCostUpload.HasFile;
        if (!e.IsValid)
        {
            ImportCostUploadRequired.Text = "<br />Please select a rules file<br />";
            RedisplayImportCostDialog();
        }
    }

    protected void RuleDataSource_Deleting(object sender, ObjectDataSourceMethodEventArgs e)
    {
        e.InputParameters["settings"] = Settings;
    }

    protected void RuleDataSource_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["settings"] = Settings;
    }

    protected void RuleDataSource_Updating(object sender, ObjectDataSourceMethodEventArgs e)
    {
        if (Page.IsValid)
        {
            e.InputParameters["settings"] = Settings;
            e.InputParameters["matches"] = Page.Items["matches"];
        }
        else
        {
            e.Cancel = true;
        }
    }

    protected void Rules_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "New")
        {
            String id = e.CommandArgument.ToString();
            Int32 index = Settings.CostingRules.IndexOf(id);
            OrderRule rule = new OrderRule();
            rule.Matches.Add(new OrderMatch());
            Settings.CostingRules.Insert(index, rule);
            Settings.CostingRules.Save();
            Rules.DataBind();
            Rules.EditIndex = index;
        }
        else if (e.CommandName == "MoveUp")
        {
            String id = e.CommandArgument.ToString();
            Int32 index = Settings.CostingRules.IndexOf(id);
            if (index > 0)
            {
                OrderRule rule = Settings.CostingRules[index];
                Settings.CostingRules.RemoveAt(index);
                Settings.CostingRules.Insert(index - 1, rule);
                Settings.CostingRules.Save();
                Rules.DataBind();
            }
        }
        else if (e.CommandName == "MoveDown")
        {
            String id = e.CommandArgument.ToString();
            Int32 index = Settings.CostingRules.IndexOf(id);
            if (index < (Settings.CostingRules.Count - 2))
            {
                OrderRule rule = Settings.CostingRules[index];
                Settings.CostingRules.RemoveAt(index);
                Settings.CostingRules.Insert(index + 1, rule);
                Settings.CostingRules.Save();
                Rules.DataBind();
            }
        }
        else if (e.CommandName == "Update")
        {
            if (Page.IsValid)
            {
                GridViewRow row = Rules.Rows[Rules.EditIndex];
                if (row != null)
                {
                    OrderMatchList matches = ((BVModules_Shipping_Order_Rules_OrderMatchEditor) row.FindControl("OrderMatchEditor")).GetMatches();

                    DropDownList orderPropertyList = (DropDownList)row.FindControl("ValueOrderPropertyField");
                    DropDownList packagePropertyList = (DropDownList)row.FindControl("ValuePackagePropertyField");

                    OrderProperties orderProperty = (OrderProperties)Enum.Parse(typeof(OrderProperties), orderPropertyList.SelectedValue);
                    PackageProperties packageProperty = (PackageProperties)Enum.Parse(typeof(PackageProperties), packagePropertyList.SelectedValue);

                    if (orderProperty == OrderProperties.PackageProperty && packageProperty == PackageProperties.Distance)
                    {
                        if (PostalCode.IsPostalDataInstalled())
                        {
                            Anthem.Manager.AddScriptForClientSideEval("alert('No postal code data has been installed. The Distance property will always return -1.');");
                        }
                    }
                    else
                    {
                        foreach (OrderMatch match in matches)
                        {
                            if (match.OrderProperty == OrderProperties.PackageProperty && match.PackageProperty == PackageProperties.Distance)
                            {
                                if (PostalCode.IsPostalDataInstalled())
                                {
                                    Anthem.Manager.AddScriptForClientSideEval("alert('No postal code data has been installed. The Distance property will always return -1.');");
                                    break;
                                }
                            }
                        }
                    }

                    Page.Items["matches"] = matches;
                }
            }
        }
        else if (e.CommandName == "View")
        {
            if (Page.IsValid)
            {
                GridViewRow row = Rules.Rows[Rules.EditIndex];
                if (row != null)
                {
                    GridView grid = row.FindControl("SampleShippingCosts") as GridView;
                    if (grid != null)
                    {
                        Int32 count;
                        grid.Visible = true;
                        Session["SampleData"] = GetSampleOrders(row, out count);
                        grid.DataSource = Session["SampleData"];
                        grid.DataBind();
                        if (count > grid.PageSize*5)
                        {
                            grid.Caption = string.Format("{0}+ matching orders", grid.PageSize*5);
                        }
                        else
                        {
                            grid.Caption = string.Format("{0} matching order", count);
                            if (count == 0 || count > 1) grid.Caption += "s";
                        }
                    }
                }
            }
        }
    }

    protected void Rules_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            String id = Rules.DataKeys[e.Row.RowIndex].Value.ToString();
            OrderRule rule = Settings.CostingRules[id];
            Int32 rowIndex = (Rules.PageIndex*Rules.PageSize) + e.Row.RowIndex;

            if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
            {
                if (rowIndex == Settings.CostingRules.Count - 1)
                {
                    e.Row.FindControl("DeleteRow").Visible = false;
                    e.Row.FindControl("MoveRuleUp").Visible = false;
                    e.Row.FindControl("MoveRuleDown").Visible = false;
                }
                if (rowIndex == Settings.CostingRules.Count - 2)
                {
                    e.Row.FindControl("MoveRuleDown").Visible = false;
                }
                if (rowIndex == 0)
                {
                    e.Row.FindControl("MoveRuleUp").Visible = false;
                }
            }
            else if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
            {
                DropDownList orderPropertyList = (DropDownList) e.Row.FindControl("ValueOrderPropertyField");
                DropDownList packagePropertyList = (DropDownList) e.Row.FindControl("ValuePackagePropertyField");
                DropDownList itemPropertyList = (DropDownList) e.Row.FindControl("ValueItemPropertyField");
                DropDownList customPropertyList = (DropDownList) e.Row.FindControl("ValueCustomPropertyField");
                HelpLabel customPropertyLabel = (HelpLabel)e.Row.FindControl("ValueCustomPropertyLabel");

                Label multiplierLabel = (Label)e.Row.FindControl("ValueMultiplierLabel");
                HelpLabel valueLabel = (HelpLabel)e.Row.FindControl("ValueLabel");
                TextBox valueField = (TextBox)e.Row.FindControl("ValueField");
                BaseValidator valueRequired = (BaseValidator)e.Row.FindControl("ValueRequired");
                BaseValidator valueNumeric = (BaseValidator)e.Row.FindControl("ValueNumeric");

                orderPropertyList.Items.Clear();
                orderPropertyList.Items.AddRange(GetOrderProperties());

                packagePropertyList.Items.Clear();
                packagePropertyList.Items.AddRange(GetPackageProperties());
                packagePropertyList.Visible = false;

                itemPropertyList.Items.Clear();
                itemPropertyList.Items.AddRange(GetItemProperties());
                itemPropertyList.Visible = false;

                if (rule.ValueOrderProperty == OrderProperties.ItemProperty)
                {
                    itemPropertyList.Visible = true;
                    PrepareCustomPropertyField(customPropertyLabel, customPropertyList, rule.ValueItemProperty);
                    PrepareValueField(multiplierLabel, valueLabel, valueField, valueRequired, valueNumeric, rule.ValueItemProperty);
                }
                else if (rule.ValueOrderProperty == OrderProperties.PackageProperty)
                {
                    packagePropertyList.Visible = true;
                    PrepareCustomPropertyField(customPropertyLabel, customPropertyList, rule.ValuePackageProperty);
                    PrepareValueField(multiplierLabel, valueLabel, valueField, valueRequired, valueNumeric, rule.ValuePackageProperty);
                }
                else
                {
                    PrepareCustomPropertyField(customPropertyLabel, customPropertyList, rule.ValueOrderProperty);
                    PrepareValueField(multiplierLabel, valueLabel, valueField, valueRequired, valueNumeric, rule.ValueOrderProperty);
                }

                if (customPropertyList.Items.Count == 0)
                    customPropertyList.Items.Add(new ListItem("", rule.ValueCustomProperty));
                if (customPropertyList.Items.FindByValue(rule.ValueCustomProperty) == null)
                    rule.ValueCustomProperty = customPropertyList.Items[0].Value;
            }
        }
    }

    protected void SampleShippingCosts_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView grid = (GridView) sender;
        grid.DataSource = Session["SampleData"];
        grid.PageIndex = e.NewPageIndex;
        grid.DataBind();
    }

    protected void ValueItemPropertyField_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (sender != null)
        {
            DropDownList itemPropertyField = (DropDownList) sender;
            DropDownList customPropertyField = (DropDownList) itemPropertyField.NamingContainer.FindControl("ValueCustomPropertyField");
            HelpLabel customPropertyLabel = (HelpLabel) itemPropertyField.NamingContainer.FindControl("ValueCustomPropertyLabel");

            Label multiplierLabel = (Label)itemPropertyField.NamingContainer.FindControl("ValueMultiplierLabel");
            HelpLabel valueLabel = (HelpLabel)itemPropertyField.NamingContainer.FindControl("ValueLabel");
            TextBox valueField = (TextBox)itemPropertyField.NamingContainer.FindControl("ValueField");
            BaseValidator valueRequired = (BaseValidator)itemPropertyField.NamingContainer.FindControl("ValueRequired");
            BaseValidator valueNumeric = (BaseValidator)itemPropertyField.NamingContainer.FindControl("ValueNumeric");

            ItemProperties itemProperty = (ItemProperties)Enum.Parse(typeof(ItemProperties), itemPropertyField.SelectedValue);

            PrepareCustomPropertyField(customPropertyLabel, customPropertyField, itemProperty);
            PrepareValueField(multiplierLabel, valueLabel, valueField, valueRequired, valueNumeric, itemProperty);
        }
    }

    protected void ValuePackagePropertyField_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (sender != null)
        {
            DropDownList packagePropertyField = (DropDownList) sender;
            DropDownList customPropertyField = (DropDownList) packagePropertyField.NamingContainer.FindControl("ValueCustomPropertyField");
            HelpLabel customPropertyLabel = (HelpLabel) packagePropertyField.NamingContainer.FindControl("ValueCustomPropertyLabel");

            Label multiplierLabel = (Label)packagePropertyField.NamingContainer.FindControl("ValueMultiplierLabel");
            HelpLabel valueLabel = (HelpLabel)packagePropertyField.NamingContainer.FindControl("ValueLabel");
            TextBox valueField = (TextBox)packagePropertyField.NamingContainer.FindControl("ValueField");
            BaseValidator valueRequired = (BaseValidator)packagePropertyField.NamingContainer.FindControl("ValueRequired");
            BaseValidator valueNumeric = (BaseValidator)packagePropertyField.NamingContainer.FindControl("ValueNumeric");

            PackageProperties packageProperty = (PackageProperties) Enum.Parse(typeof (PackageProperties), packagePropertyField.SelectedValue);

            PrepareCustomPropertyField(customPropertyLabel, customPropertyField, packageProperty);
            PrepareValueField(multiplierLabel, valueLabel, valueField, valueRequired, valueNumeric, packageProperty);
        }
    }

    protected void ValueOrderPropertyField_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (sender != null)
        {
            DropDownList orderPropertyField = (DropDownList) sender;
            DropDownList itemPropertyField = (DropDownList) orderPropertyField.NamingContainer.FindControl("ValueItemPropertyField");
            DropDownList packagePropertyField = (DropDownList) orderPropertyField.NamingContainer.FindControl("ValuePackagePropertyField");
            DropDownList customPropertyField = (DropDownList) orderPropertyField.NamingContainer.FindControl("ValueCustomPropertyField");
            HelpLabel customPropertyLabel = (HelpLabel) orderPropertyField.NamingContainer.FindControl("ValueCustomPropertyLabel");

            Label multiplierLabel = (Label)orderPropertyField.NamingContainer.FindControl("ValueMultiplierLabel");
            HelpLabel valueLabel = (HelpLabel)orderPropertyField.NamingContainer.FindControl("ValueLabel");
            TextBox valueField = (TextBox)orderPropertyField.NamingContainer.FindControl("ValueField");
            BaseValidator valueRequired = (BaseValidator)orderPropertyField.NamingContainer.FindControl("ValueRequired");
            BaseValidator valueNumeric = (BaseValidator)orderPropertyField.NamingContainer.FindControl("ValueNumeric");

            OrderProperties orderProperty = (OrderProperties) Enum.Parse(typeof (OrderProperties), orderPropertyField.SelectedValue);
            ItemProperties itemProperty = (ItemProperties) Enum.Parse(typeof (ItemProperties), itemPropertyField.SelectedValue);
            PackageProperties packageProperty = (PackageProperties) Enum.Parse(typeof (PackageProperties), packagePropertyField.SelectedValue);

            if (orderProperty == OrderProperties.ItemProperty)
            {
                itemPropertyField.Visible = true;
                packagePropertyField.Visible = false;
                PrepareCustomPropertyField(customPropertyLabel, customPropertyField, itemProperty);
                PrepareValueField(multiplierLabel, valueLabel, valueField, valueRequired, valueNumeric, itemProperty);
            }
            else if (orderProperty == OrderProperties.PackageProperty)
            {
                itemPropertyField.Visible = false;
                packagePropertyField.Visible = true;
                PrepareCustomPropertyField(customPropertyLabel, customPropertyField, packageProperty);
                PrepareValueField(multiplierLabel, valueLabel, valueField, valueRequired, valueNumeric, packageProperty);
            }
            else
            {
                itemPropertyField.Visible = false;
                packagePropertyField.Visible = false;
                customPropertyField.Visible = false;
                PrepareValueField(multiplierLabel, valueLabel, valueField, valueRequired, valueNumeric, orderProperty);
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

    private readonly Regex hiddenAddressProperties =
        new Regex("bvin|lastupdated", RegexOptions.IgnoreCase | RegexOptions.Compiled);

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

    private readonly Regex hiddenCustomerProperties =
        new Regex("bvin|password|salt|address", RegexOptions.IgnoreCase | RegexOptions.Compiled);

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

    private readonly Regex hiddenItemProperties = 
        new Regex("FixedAmountOne", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private ListItem[] GetItemProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (ItemProperties property in Enum.GetValues(typeof (ItemProperties)))
        {
            if (!hiddenItemProperties.IsMatch(property.ToString()))
            {
                if (ItemPropertiesHelper.GetPropertyType(property) != PropertyTypes.Alphabetic)
                {
                    properties.Add(new ListItem(ItemPropertiesHelper.GetDisplayName(property), property.ToString()));
                }
            }
        }
        return properties.ToArray();
    }

    private readonly Regex hiddenOrderProperties =
        new Regex("PackageProperty", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private ListItem[] GetOrderProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (OrderProperties property in Enum.GetValues(typeof(OrderProperties)))
        {
            if (!hiddenOrderProperties.IsMatch(property.ToString()))
            {
                if (OrderPropertiesHelper.GetPropertyType(property) != PropertyTypes.Alphabetic)
                {
                    properties.Add(new ListItem(OrderPropertiesHelper.GetDisplayName(property), property.ToString()));
                }
            }
        }
        return properties.ToArray();
    }

    private readonly Regex hiddenPackageProperties =
        new Regex("FixedAmountOne|UseMethod|ItemProperty|Name|Invisible|Separator0", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    private ListItem[] GetPackageProperties()
    {
        List<ListItem> properties = new List<ListItem>();
        foreach (PackageProperties property in Enum.GetValues(typeof (PackageProperties)))
        {
            if (!hiddenPackageProperties.IsMatch(property.ToString()))
            {
                if (PackagePropertiesHelper.GetPropertyType(property) != PropertyTypes.Alphabetic)
                {
                    properties.Add(new ListItem(PackagePropertiesHelper.GetDisplayName(property), property.ToString()));
                }
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
            if (property.TypeCode == ProductPropertyType.TextField
                || property.TypeCode == ProductPropertyType.CurrencyField)
            {
                propertyTypes.Add(new ListItem(property.DisplayName, property.Bvin));
            }
        }
        if (propertyTypes.Count == 0)
        {
            propertyTypes.Add(new ListItem("- n/a -", string.Empty));
        }

        return propertyTypes.ToArray();
    }

    protected String GetRuleAsString(String id)
    {
        OrderRule rule = Settings.CostingRules[id];
        return rule.ToString();
    }

    private List<SampleOrderResult> GetSampleOrders(GridViewRow row, out int count)
    {
        GridView grid = (GridView) row.FindControl("SampleShippingCosts");

        OrderRule rule = new OrderRule(Rules.DataKeys[row.RowIndex].Value.ToString());
        rule.Matches.AddRange(
            ((BVModules_Shipping_Order_Rules_OrderMatchEditor) row.FindControl("OrderMatchEditor")).GetMatches());
        rule.Value = Decimal.Parse(((TextBox) row.FindControl("ValueField")).Text);
        rule.ValueCustomProperty = ((DropDownList) row.FindControl("ValueCustomPropertyField")).SelectedValue;
        rule.ValueItemPropertyAsString = ((DropDownList) row.FindControl("ValueItemPropertyField")).SelectedValue;
        rule.ValuePackagePropertyAsString = ((DropDownList) row.FindControl("ValuePackagePropertyField")).SelectedValue;
        rule.ValuePropertyAsString = ((DropDownList) row.FindControl("ValueOrderPropertyField")).SelectedValue;

        count = 0;

        // Scan all placed orders
        List<SampleOrderResult> results = new List<SampleOrderResult>();
        foreach (Order order in Order.FindByCriteria(new OrderSearchCriteria()))
        {
            Order heavyOrder = Order.FindByBvin(order.Bvin);

            // "Unship" all of the items so that the samples look like they
            // were just placed. Skip any orders with deleted items.
            bool skipOrder = false;
            foreach (LineItem lineitem in heavyOrder.Items)
            {
                if (lineitem.AssociatedProduct == null || lineitem.AssociatedProduct.ShippingMode == ShippingMode.None)
                    skipOrder = true;
                else
                    lineitem.QuantityShipped = 0;
            }
            if (skipOrder) break;

            if (rule.IsMatch(heavyOrder))
            {
                count += 1;
                if (count > grid.PageSize*5) break;
                SampleOrderResult result = new SampleOrderResult();
                result.OrderNumber = order.OrderNumber;
                result.OrderDisplay = string.Format("<a href=\"{0}\" target=\"order\">{1}</a>",
                                                    Page.ResolveUrl(
                                                        string.Format("~/BVAdmin/Orders/ViewOrder.aspx?id={0}",
                                                                      order.Bvin)),
                                                    order.OrderNumber);
                List<string> matchValues = new List<string>();
                List<string> limitValues = new List<string>();
                if (rule.IsDefaultRule)
                {
                    matchValues.Add("n/a");
                    limitValues.Add("n/a");
                }
                else
                {
                    for (int index = 0; index < rule.Matches.Count; index++)
                    {
                        OrderMatch match = rule.Matches[index];
                        string matchValue =
                            OrderPropertiesHelper.GetOrderPropertyValue(heavyOrder, match.OrderProperty, match.PackageProperty, 
                            match.ItemProperty, match.CustomProperty, "1").ToString();
                        if (string.IsNullOrEmpty(matchValue)) matchValue = "(empty)";
                        matchValues.Add(matchValue);
                        string limitValue =
                            OrderPropertiesHelper.GetOrderPropertyValue(heavyOrder, match.LimitOrderProperty, match.LimitPackageProperty, 
                            match.LimitItemProperty, match.LimitCustomProperty, match.Limit).ToString();
                        if (string.IsNullOrEmpty(limitValue)) limitValue = "(empty)";
                        limitValues.Add(limitValue);
                    }
                }
                result.MatchValues = string.Join(", ", matchValues.ToArray());
                result.LimitValues = string.Join(", ", limitValues.ToArray());
                object value =
                    OrderPropertiesHelper.GetOrderPropertyValue(heavyOrder, rule.ValueOrderProperty, rule.ValuePackageProperty,
                    rule.ValueItemProperty, rule.ValueCustomProperty, "1");
                result.Value = value == null ? "n/a" : value.ToString(); 
                if (String.IsNullOrEmpty(result.Value)) result.Value = "(empty)";
                ShippingRate rate =
                    new ShippingRate(((OrderRulesEditor) NamingContainer).NameFieldText, string.Empty, string.Empty,
                                     0, string.Empty);
                decimal? cost = rule.GetCost(heavyOrder);
                if (cost.HasValue)
                {
                    rate.Rate = cost.Value;
                    result.RateDisplay = rate.RateAndNameForDisplay;
                }
                else
                {
                    result.RateDisplay = "Hidden";
                }
                results.Add(result);
            }
        }
        results.Sort();
        return results;
    }

    private ListItem[] GetShippingMethods()
    {
        List<ListItem> methods = new List<ListItem>();
        methods.Add(new ListItem("-n/a-", ""));
        foreach (ShippingMethod method in ShippingMethod.FindAll())
        {
            if (String.Compare(method.Bvin, ((BVShippingModule) NamingContainer).ShippingMethod.Bvin, true) != 0)
            {
                methods.Add(new ListItem(method.Name, method.Bvin));
            }
        }
        return methods.ToArray();
    }

    private readonly Regex hiddenVendorManufacturerProperties =
        new Regex("address|bvin|lastupdated|dropshipemailtemplateid", RegexOptions.IgnoreCase | RegexOptions.Compiled);

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

    private static void PrepareValueField(Control multiplier, Label label, Control field, WebControl requiredValidator, WebControl numericValidator, ItemProperties property)
    {
        PropertyTypes propertyType = ItemPropertiesHelper.GetPropertyType(property);
        PrepareValueField(multiplier, label, field, requiredValidator, numericValidator, propertyType);
    }

    private static void PrepareValueField(Control multiplier, Label label, Control field, WebControl requiredValidator, WebControl numericValidator, OrderProperties property)
    {
        PropertyTypes propertyType = OrderPropertiesHelper.GetPropertyType(property);
        PrepareValueField(multiplier, label, field, requiredValidator, numericValidator, propertyType);
    }

    private static void PrepareValueField(Control multiplier, Label label, Control field, WebControl requiredValidator, WebControl numericValidator, PackageProperties property)
    {
        PropertyTypes propertyType = PackagePropertiesHelper.GetPropertyType(property);
        PrepareValueField(multiplier, label, field, requiredValidator, numericValidator, propertyType);
    }

    private static void PrepareValueField(Control multiplier, Label label, Control field, WebControl requiredValidator, WebControl numericValidator, PropertyTypes propertyType)
    {
        if (propertyType == PropertyTypes.Numeric)
        {
            multiplier.Visible = true;
            field.Visible = true;
            label.Text = "Multiplier";
            label.ToolTip = "<p>Enter the multiplier. If the final cost is less than 0, the rate will not be displayed to the customer.</p>";
            requiredValidator.Enabled = true;
            numericValidator.Enabled = true;
        }
        else if (propertyType == PropertyTypes.Fixed)
        {
            multiplier.Visible = false;
            field.Visible = true;
            label.Text = "Value";
            label.ToolTip = "<p>Enter the fixed cost.</p>";
            requiredValidator.Enabled = true;
            numericValidator.Enabled = true;
        }
        else
        {
            multiplier.Visible = false;
            field.Visible = false;
            requiredValidator.Enabled = false;
            numericValidator.Enabled = false;
        }
    }

    private void RedisplayImportCostDialog()
    {
        Page.ClientScript.RegisterStartupScript(GetType(), "showImportCostDialog",
                                                "YAHOO.util.Event.addListener(window, \"load\", showImportCostDialog);",
                                                true);
    }

    #endregion

    #region Private Classes

    [Serializable]
    private class SampleOrderResult : IComparable
    {
        private String _orderDisplay = String.Empty;

        public String OrderDisplay
        {
            get { return _orderDisplay; }
            set { _orderDisplay = value; }
        }

        private String _orderNumber = String.Empty;

        public String OrderNumber
        {
            get { return _orderNumber; }
            set { _orderNumber = value; }
        }

        private String _limitValues = String.Empty;

        public String LimitValues
        {
            get { return _limitValues; }
            set { _limitValues = value; }
        }

        private String _matchValues = String.Empty;

        public String MatchValues
        {
            get { return _matchValues; }
            set { _matchValues = value; }
        }

        private String _value = String.Empty;

        public String Value
        {
            get { return _value; }
            set { _value = value; }
        }

        private String _rateDisplay = String.Empty;

        public String RateDisplay
        {
            get { return _rateDisplay; }
            set { _rateDisplay = value; }
        }

        #region IComparable Members

        public int CompareTo(object obj)
        {
            if (obj == null) throw new ArgumentNullException("obj");
            SampleOrderResult result = obj as SampleOrderResult;
            if (result == null) throw new ArgumentException("obj must be a SampleOrderResult.");
            return String.Compare(OrderNumber, result.OrderNumber, true);
        }

        #endregion
    }

    #endregion
}
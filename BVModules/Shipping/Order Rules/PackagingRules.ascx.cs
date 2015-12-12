// Copyright Structured Solutions
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Serialization;
using BVSoftware.Bvc5.Core.Orders;
using BVSoftware.Bvc5.Core.Shipping;
using StructuredSolutions.Bvc5.Shipping;
using StructuredSolutions.Bvc5.Shipping.Providers.Controls;
using StructuredSolutions.Bvc5.Shipping.Providers.Packaging;
using StructuredSolutions.Bvc5.Shipping.PostalCodes;
using StructuredSolutions.Bvc5.Shipping.Providers.Settings;
using ASPNET=System.Web.UI.WebControls;

public partial class BVModules_Shipping_Order_Rules_PackagingRules : UserControl
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
            @"function hideImportPackagingDialogValidation(type, args) {{
    el = document.getElementById('{0}');
    if (typeof(el) != 'undefined' && el != null) {{
        el.style.display = 'none';
    }}
}}
",
            ImportPackagingUploadRequired.ClientID);
        Page.ClientScript.RegisterStartupScript(GetType(), script, script, true);
        script = String.Format(
            @"function validateImportPackagingUpload(source, args) {{
    el = document.getElementById('{0}');
    if (typeof(el) != 'undefined' && el != null) {{
        args.IsValid = (el.value != null && el.value.length > 0);
        el = document.getElementById(source.id);
        el.style.display = args.IsValid ? 'none' : 'inline';
    }}
}}
",
            ImportPackagingUpload.ClientID);
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
        Response.AddHeader("Content-Disposition", "attachment;filename=Packaging.rules");
        XmlSerializer serializer = new XmlSerializer(typeof (PackagingRuleList));
        serializer.Serialize(Response.OutputStream, Settings.PackagingRules);
        Response.End();
    }

    protected void Import_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            XmlSerializer serializer = new XmlSerializer(typeof (PackagingRule[]));
            try
            {
                PackagingRule[] rules = serializer.Deserialize(ImportPackagingUpload.FileContent) as PackagingRule[];
                if (rules != null)
                {
                    Settings.PackagingRules.Clear();
                    foreach (PackagingRule rule in rules)
                        Settings.PackagingRules.Add(rule);
                    Settings.PackagingRules.Save();
                    DataBind();
                }
            }
            catch
            {
                ImportPackagingUploadRequired.Text = "<br />Invalid file format<br />";
                ImportPackagingUploadRequired.IsValid = false;
                RedisplayImportPackagingDialog();
            }
        }
    }

    protected void ImportPackagingUploadRequired_ServerValidate(object source, ServerValidateEventArgs e)
    {
        e.IsValid = ImportPackagingUpload.HasFile;
        if (!e.IsValid)
        {
            ImportPackagingUploadRequired.Text = "<br />Please select a rules file<br />";
            RedisplayImportPackagingDialog();
        }
    }

    protected void SamplePackages_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView grid = (GridView) sender;
        grid.DataSource = Session["SamplePackagesData"];
        grid.PageIndex = e.NewPageIndex;
        grid.DataBind();
    }

    protected void PackagingRules_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MoveDown")
        {
            String id = e.CommandArgument.ToString();
            Int32 index = Settings.PackagingRules.IndexOf(id);
            PackagingRule packagingRule = Settings.PackagingRules[index];
            Settings.PackagingRules.RemoveAt(index);
            Settings.PackagingRules.Insert(index + 1, packagingRule);
            Settings.PackagingRules.Save();
            PackagingRules.DataBind();
        }
        else if (e.CommandName == "MoveUp")
        {
            String id = e.CommandArgument.ToString();
            Int32 index = Settings.PackagingRules.IndexOf(id);
            PackagingRule packagingRule = Settings.PackagingRules[index];
            Settings.PackagingRules.RemoveAt(index);
            Settings.PackagingRules.Insert(index - 1, packagingRule);
            Settings.PackagingRules.Save();
            PackagingRules.DataBind();
        }
        else if (e.CommandName == "New")
        {
            // Create the default packaging rule
            PackagingRule packagingRule = new PackagingRule();
            packagingRule.Limits.Add(new PackageMatch());

            // Add or insert the settings into the list
            String id = e.CommandArgument.ToString();
            Int32 index = Settings.PackagingRules.IndexOf(id);
            Settings.PackagingRules.Insert(index + 1, packagingRule);
            Settings.PackagingRules.Save();
            PackagingRules.DataBind();
            PackagingRules.EditIndex = index + 1;

            Page.Items["PackagingRules"] = packagingRule;
        }
        else if (e.CommandName == "Update")
        {
            if (Page.IsValid)
            {
                GridViewRow row = PackagingRules.Rows[PackagingRules.EditIndex];
                if (Page.IsValid)
                {
                    if (row != null)
                    {
                        PackageMatchList matches = ((BVModules_Shipping_Order_Rules_PackageMatchEditor)row.FindControl("PackageMatchEditor")).GetMatches();
                        foreach (PackageMatch match in matches)
                        {
                            if (match.PackageProperty == PackageProperties.Distance)
                            {
                                if (PostalCode.IsPostalDataInstalled())
                                {
                                    Anthem.Manager.AddScriptForClientSideEval("alert('No postal code data has been installed. The Distance property will always return -1.');");
                                    break;
                                }
                            }
                        }
                        Page.Items["Limits"] = matches;
                    }
                }
            }
        }
        else if (e.CommandName == "View")
        {
            if (Page.IsValid)
            {
                GridViewRow row = PackagingRules.Rows[PackagingRules.EditIndex];
                if (row != null)
                {
                    GridView grid = row.FindControl("SamplePackages") as GridView;
                    if (grid != null)
                    {
                        Int32 count;
                        grid.Visible = true;
                        Session["SamplePackagesData"] = GetSamplePackages(row, out count);
                        grid.DataSource = Session["SamplePackagesData"];
                        grid.DataBind();
                        if (count > grid.PageSize*5)
                        {
                            grid.Caption = string.Format("This rule would create {0}+ packages", grid.PageSize*5);
                        }
                        else
                        {
                            grid.Caption = string.Format("This rule would create {0} package", count);
                            if (count == 0 || count > 1) grid.Caption += "s";
                        }
                        grid.Caption += " from your existing orders";
                    }
                }
            }
        }
    }

    protected void PackagingRules_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Int32 rowIndex = (PackagingRules.PageIndex*PackagingRules.PageSize) + e.Row.RowIndex;

            if (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate)
            {
                if (rowIndex == Settings.PackagingRules.Count - 1)
                {
                    e.Row.FindControl("PackagingRuleMoveDown").Visible = false;
                }
                if (rowIndex == 0)
                {
                    e.Row.FindControl("PackagingRuleMoveUp").Visible = false;
                }
            }
        }
    }

    protected void PackagingRulesDataSource_Deleting(object sender, ObjectDataSourceMethodEventArgs e)
    {
        e.InputParameters["settings"] = Settings;
    }

    protected void PackagingRulesDataSource_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        e.InputParameters["settings"] = Settings;
    }

    protected void PackagingRulesDataSource_Updating(object sender, ObjectDataSourceMethodEventArgs e)
    {
        if (Page.IsValid)
        {
            e.InputParameters["settings"] = Settings;
            e.InputParameters["limits"] = Page.Items["Limits"];
        }
        else
        {
            e.Cancel = true;
        }
    }

    #endregion

    #region Methods

    private List<SamplePackageResult> GetSamplePackages(Control row, out int count)
    {
        GridView grid = (GridView) row.FindControl("SamplePackages");

        PackagingRule rule = new PackagingRule();
        rule.BoxHeight = decimal.Parse(((TextBox)row.FindControl("HeightField")).Text);
        rule.BoxLength = decimal.Parse(((TextBox)row.FindControl("LengthField")).Text);
        rule.BoxWidth = decimal.Parse(((TextBox)row.FindControl("WidthField")).Text);
        rule.Limits.AddRange(
            ((BVModules_Shipping_Order_Rules_PackageMatchEditor) row.FindControl("PackageMatchEditor")).GetMatches());
        rule.Name = ((TextBox)row.FindControl("NameField")).Text.Trim();
        rule.TareWeight = decimal.Parse(((TextBox)row.FindControl("TareWeightField")).Text);
        Packager packager = new Packager(rule);

        count = 0;

        // Scan all placed orders
        List<SamplePackageResult> results = new List<SamplePackageResult>();
        int rowCount = 0;
        foreach (Order order in Order.FindByCriteria(new OrderSearchCriteria(), -1, grid.PageSize * 5, ref rowCount))
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

            ExtendedShippingGroupList groups = new ExtendedShippingGroupList();
            foreach (ShippingGroup group in heavyOrder.GetShippingGroups())
            {
                groups.Add(new ExtendedShippingGroup(0, group, group.Items));
            }

            foreach (ExtendedShippingGroup group in groups)
            {
                ExtendedShippingGroupList splitGroups = packager.Split(group);
                List<String> remainingItems = new List<string>();
                SamplePackageResult result;

                Boolean matchingPackage = false;

                foreach (ExtendedShippingGroup splitGroup in splitGroups)
                {
                    if (splitGroup.Name.Equals(rule.Name))
                    {
                        matchingPackage = true;
                        count += 1;

                        result = new SamplePackageResult();
                        result.OrderNumber = order.OrderNumber;
                        result.OrderDisplay = string.Format("<a href=\"{0}\" target=\"order\">{1}</a>",
                                                            Page.ResolveUrl(
                                                                string.Format("~/BVAdmin/Orders/ViewOrder.aspx?id={0}",
                                                                              order.Bvin)),
                                                            order.OrderNumber);
                        List<string> matchValues = new List<string>();
                        List<string> limitValues = new List<string>();
                        for (int index = 0; index < rule.Limits.Count; index++)
                        {
                            PackageMatch match = rule.Limits[index];
                            string matchValue =
                                PackagePropertiesHelper.GetPackagePropertyValue(splitGroup, match.PackageProperty, match.ItemProperty,
                                                             match.CustomProperty, "1").ToString();
                            if (string.IsNullOrEmpty(matchValue)) matchValue = "(empty)";
                            matchValues.Add(matchValue);
                            string limitValue =
                                PackagePropertiesHelper.GetPackagePropertyValue(splitGroup, match.LimitPackageProperty, match.LimitItemProperty,
                                    match.LimitCustomProperty, match.Limit).ToString();
                            if (string.IsNullOrEmpty(limitValue)) limitValue = "(empty)";
                            limitValues.Add(limitValue);
                        }
                        result.MatchValues = string.Join(", ", matchValues.ToArray());
                        result.LimitValues = string.Join(", ", limitValues.ToArray());
                        result.Volume = splitGroup.GetShippingVolume().ToString("0.000");
                        result.Weight = splitGroup.GetShippingWeight().ToString("0.000");
                        if (splitGroup.HasBoxDimensions)
                        {
                            decimal boxVolume = splitGroup.BoxHeight * splitGroup.BoxLength * splitGroup.BoxWidth;
                            result.FillFactor = string.Format("{0:0.000}%", splitGroup.GetShippingVolume() * 100M / boxVolume);
                        }
                        else
                        {
                            result.FillFactor = "n/a";
                        }
                        List<string> lineitems = new List<string>();
                        foreach (LineItem lineitem in splitGroup.Items)
                        {
                            lineitems.Add(string.Format("{0:0} &times; {1}", lineitem.Quantity, lineitem.ProductSku));
                        }
                        result.Items = string.Join(", ", lineitems.ToArray());
                        results.Add(result);
                    }
                    else
                    {
                        foreach (LineItem lineitem in splitGroup.Items)
                        {
                            remainingItems.Add(string.Format("{0:0} &times; {1}", lineitem.Quantity, lineitem.ProductSku));
                        }
                    }

                    if (count > grid.PageSize * 5) break;
                }

                // If there was at least one matching package, then list the unmatched items
                if (matchingPackage && (remainingItems.Count > 0))
                {
                    result = new SamplePackageResult();
                    result.OrderNumber = order.OrderNumber;
                    result.OrderDisplay = string.Format("<a href=\"{0}\" target=\"order\">{1}</a>",
                                                        Page.ResolveUrl(
                                                            string.Format("~/BVAdmin/Orders/ViewOrder.aspx?id={0}",
                                                                          order.Bvin)),
                                                        order.OrderNumber);
                    result.MatchValues = "unpackaged items";
                    result.Items = string.Join(", ", remainingItems.ToArray());
                    results.Add(result);
                }
            }
            if (count > grid.PageSize*5) break;
        }
        results.Sort();
        return results;
    }

    private void RedisplayImportPackagingDialog()
    {
        Page.ClientScript.RegisterStartupScript(GetType(), "showImportPackagingDialog",
                                                "YAHOO.util.Event.addListener(window, \"load\", showImportPackagingDialog);",
                                                true);
    }

    #endregion

    #region Private Classes

    [Serializable]
    private class SamplePackageResult : IComparable
    {
        private String _fillFactor = String.Empty;

        public String FillFactor
        {
            get { return _fillFactor; }
            set { _fillFactor = value; }
        }

        private String _items = String.Empty;

        public String Items
        {
            get { return _items; }
            set { _items = value; }
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

        private String _remainingItems = String.Empty;

        public String RemainingItems
        {
            get { return _remainingItems; }
            set { _remainingItems = value; }
        }

        private String _volume = String.Empty;

        public String Volume
        {
            get { return _volume; }
            set { _volume = value; }
        }

        private String _weight = String.Empty;

        public String Weight
        {
            get { return _weight; }
            set { _weight = value; }
        }

        #region IComparable Members

        public int CompareTo(object obj)
        {
            if (obj == null) throw new ArgumentNullException("obj");
            SamplePackageResult result = obj as SamplePackageResult;
            if (result == null) throw new ArgumentException("obj must be a SamplePackageResult.");
            return String.Compare(OrderNumber, result.OrderNumber, true);
        }

        #endregion
    }

    #endregion
}
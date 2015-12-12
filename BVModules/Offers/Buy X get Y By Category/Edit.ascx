<%@ Control Language="C#" AutoEventWireup="true" Inherits="BVSoftware.Bvc5.Core.Content.OfferTemplate" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core.Content" %>
<%@ Import Namespace="System.Collections.ObjectModel" %>
<script runat="server">
    private static string _QualificationCategories = "QualificationCategories";
    private static string _PromoCategories = "PromoCategories";
    private static string _QualificationQty = "QualificationQty";

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void LoadCategories()
    {
        Collection<ListItem> allcats = BVSoftware.Bvc5.Core.Catalog.Category.ListFullTreeWithIndents();

        this.lstCategory.Items.Clear();
        foreach (ListItem li in allcats)
        {
            this.lstCategory.Items.Add(li);
            this.lstCategory2.Items.Add(li);
        }
    }

    public override void Cancel()
    {

    }

    public override void Initialize()
    {
        LoadCategories();
        BindCategories();
        this.QualifyingQuantity.Text = SettingsManager.GetIntegerSetting(_QualificationQty).ToString();
    }

    private void BindCategories()
    {
        Collection<ComponentSettingListItem> categories = SettingsManager.GetSettingList(_QualificationCategories);

        // do not show deleted categories
        Collection<ComponentSettingListItem> undeletedCategories = new Collection<ComponentSettingListItem>();
        foreach (ComponentSettingListItem category in categories)
        {
            BVSoftware.Bvc5.Core.Catalog.Category cat = BVSoftware.Bvc5.Core.Catalog.Category.FindByBvin(category.Setting1);
            if (cat != null && cat.Bvin != string.Empty)
            {
                undeletedCategories.Add(category);
            }
            else
            {
                SettingsManager.DeleteSettingListItem(category.Bvin);
            }
        }
        
        this.QualifyingCategories.DataSource = undeletedCategories;
        this.QualifyingCategories.DataBind();

        Collection<ComponentSettingListItem> promos = SettingsManager.GetSettingList(_PromoCategories);

        // do not show deleted categories
        Collection<ComponentSettingListItem> undeletedPromos = new Collection<ComponentSettingListItem>();
        foreach (ComponentSettingListItem category in promos)
        {
            BVSoftware.Bvc5.Core.Catalog.Category cat = BVSoftware.Bvc5.Core.Catalog.Category.FindByBvin(category.Setting1);
            if (cat != null && cat.Bvin != string.Empty)
            {
                undeletedPromos.Add(category);
            }
            else
            {
                SettingsManager.DeleteSettingListItem(category.Bvin);
            }
        }
        
        this.PromoCategories.DataSource = undeletedPromos;
        this.PromoCategories.DataBind();
    }

    public override void Save()
    {
        SettingsManager.SaveIntegerSetting(_QualificationQty, int.Parse(this.QualifyingQuantity.Text), "bvsoftware", "Offer", "Buy X get Y By Category");
    }

    protected void AddQualifyingCategory_Click(object sender, EventArgs e)
    {
        BVSoftware.Bvc5.Core.Content.ComponentSettingListItem c = new ComponentSettingListItem();
        c.Setting1 = this.lstCategory.SelectedItem.Value;
        c.Setting2 = this.lstCategory.SelectedItem.Text;
        SettingsManager.InsertSettingListItem(_QualificationCategories, c, "bvsoftware", "Offer", "Buy X get Y by Category Qual");
        BindCategories();
    }

    protected void AddPromoCategory_Click(object sender, EventArgs e)
    {
        BVSoftware.Bvc5.Core.Content.ComponentSettingListItem c = new ComponentSettingListItem();
        c.Setting1 = this.lstCategory2.SelectedItem.Value;
        c.Setting2 = this.lstCategory2.SelectedItem.Text;
        SettingsManager.InsertSettingListItem(_PromoCategories, c, "bvsoftware", "Offer", "Buy X get Y by Category Promo");
        BindCategories();
    }

    protected void QualifyingCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string bvin = this.QualifyingCategories.DataKeys[e.RowIndex].Value.ToString();
        SettingsManager.DeleteSettingListItem(bvin);
        BindCategories();
    }

    protected void PromoCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string bvin = this.PromoCategories.DataKeys[e.RowIndex].Value.ToString();
        SettingsManager.DeleteSettingListItem(bvin);
        BindCategories();
    }

</script>


<h2>Buy X Get Y By Category</h2>
<table cellspacing="0" cellpadding="0" border="0" class="linedTable">
    <tr>
        <td class="formlabel wide">
            When customer buys:</td>
        <td class="formfield">
            <asp:TextBox ID="QualifyingQuantity" runat="server" Columns="3"></asp:TextBox> &nbsp;items<bvc5:BVRegularExpressionValidator
                ID="OrderQuantityRegularExpressionValidator" runat="server" ErrorMessage="Quantity must be a whole number greater than 0."
                ValidationExpression="[1-9]\d{0,49}" ControlToValidate="QualifyingQuantity">*</bvc5:BVRegularExpressionValidator></td>
    </tr>
    <tr>
        <td class="formlabel">from any of these categories:</td>
        <td class="formfield">
            <asp:DropDownList ID="lstCategory" runat="server"></asp:DropDownList>&nbsp;<asp:Button 
        ID="AddCategory" Text="Add" runat="server" onclick="AddQualifyingCategory_Click" />
            
            <div style="border:1px solid #ccc;margin-top:10px;padding:5px;">
        	    <asp:GridView DataKeyNames="Bvin" ID="QualifyingCategories" runat="server" AutoGenerateColumns="False" onrowdeleting="QualifyingCategories_RowDeleting" GridLines="none" style="width:100%;">
                    <EmptyDataTemplate>
                        <em>Select at least one category.</em>
                    </EmptyDataTemplate>
                    <Columns>                
                        <asp:BoundField DataField="Setting2" HeaderText="Name" />                
                        <asp:ButtonField ButtonType="Button" CommandName="Delete" Text="X" />
                    </Columns>
                    <RowStyle CssClass="row" />
                    <HeaderStyle CssClass="rowheader" />
                    <AlternatingRowStyle CssClass="alternaterow" />
                </asp:GridView>
            </div>
        </td>
    </tr>
    <tr>
        <td class="formlabel">give 1 free item from any of these categories:</td>
        <td class="formfield">
            <asp:DropDownList ID="lstCategory2" runat="server"></asp:DropDownList>&nbsp;<asp:Button 
        ID="AddPromoCategory" Text="Add" runat="server" onclick="AddPromoCategory_Click" />
            
            <div style="border:1px solid #ccc;margin-top:10px;padding:5px;">
                <asp:GridView DataKeyNames="Bvin" ID="PromoCategories" runat="server" AutoGenerateColumns="False" onrowdeleting="PromoCategories_RowDeleting" GridLines="none" style="width:100%;">
                    <EmptyDataTemplate>
                        <em>Select at least one category.</em>
                    </EmptyDataTemplate>
                    <Columns>                
                        <asp:BoundField DataField="Setting2" HeaderText="Name" />                
                        <asp:ButtonField ButtonType="Button" CommandName="Delete" Text="X" />
                    </Columns>
                    <RowStyle CssClass="row" />
                    <HeaderStyle CssClass="rowheader" />
                    <AlternatingRowStyle CssClass="alternaterow" />
                </asp:GridView> 
            </div>
        </td>
    </tr>
</table>
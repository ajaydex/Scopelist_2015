<%@ Control Language="C#" AutoEventWireup="true" Inherits="BVSoftware.Bvc5.Core.Content.OfferTemplate" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>
<%@ Register Src="../../../BVAdmin/Controls/ProductPicker.ascx" TagName="ProductPicker"
    TagPrefix="uc1" %>
    <%@ Import Namespace="BVSoftware.Bvc5.Core.Content" %>
<%@ Import Namespace="System.Collections.ObjectModel" %>
<script runat="server">
    private static string _QualificationCategories = "QualificationCategories";
    private static string _PromoProductId = "PromoProductId";
    private static string _QualificationQty = "QualificationQty";
    private static string _PromoProductName = "PromoProductName";

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
        LoadProduct();
    }

    private void LoadProduct()
    {
        string id = SettingsManager.GetSetting(_PromoProductId);
        string name = SettingsManager.GetSetting(_PromoProductName);
        BVSoftware.Bvc5.Core.Catalog.Product prod = BVSoftware.Bvc5.Core.Catalog.InternalProduct.FindByBvin(id);    // make sure the product hasn't been deleted
        
        if (id == string.Empty || name == string.Empty)
        {
            this.lblProduct.Text = "No Product Selected";
        }
        else if (prod == null)
        {
            // if product has been deleted
            SettingsManager.SaveSetting(_PromoProductId, "", "bvsoftware", "Offer", "Free Promo Item");
            SettingsManager.SaveSetting(_PromoProductName, "", "bvsoftware", "Offer", "Free Promo Item");
            this.lblProduct.Text = "No Product Selected";
        }
        else
        {
            this.lblProduct.Text = name;
        }
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
    }

    public override void Save()
    {
        SettingsManager.SaveIntegerSetting(_QualificationQty, int.Parse(this.QualifyingQuantity.Text), "bvsoftware", "Offer", "Free Promo Item");
    }

    protected void AddQualifyingCategory_Click(object sender, EventArgs e)
    {
        BVSoftware.Bvc5.Core.Content.ComponentSettingListItem c = new ComponentSettingListItem();
        c.Setting1 = this.lstCategory.SelectedItem.Value;
        c.Setting2 = this.lstCategory.SelectedItem.Text;
        SettingsManager.InsertSettingListItem(_QualificationCategories, c, "bvsoftware", "Offer", "Free Promo Item Quals");
        BindCategories();
    }


    protected void QualifyingCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string bvin = this.QualifyingCategories.DataKeys[e.RowIndex].Value.ToString();
        SettingsManager.DeleteSettingListItem(bvin);
        BindCategories();
    }

    protected void btnAddProduct_Click(object sender, EventArgs e)
    {

        string id = this.ProductPicker2.SelectedProducts[0];
        SettingsManager.SaveSetting(_PromoProductId, id, "bvsoftware", "Offer", "Free Promo Item");
        string name = string.Empty;
        BVSoftware.Bvc5.Core.Catalog.Product p = BVSoftware.Bvc5.Core.Catalog.InternalProduct.FindByBvin(id);
        if (p != null)
        {
            name = p.ProductName;
        }
        SettingsManager.SaveSetting(_PromoProductName, name, "bvsoftware", "Offer", "Free Promo Item");
        LoadProduct();
    }
    protected void btnRemove_Click(object sender, EventArgs e)
    {
        SettingsManager.SaveSetting(_PromoProductId, "", "bvsoftware", "Offer", "Free Promo Item");
        SettingsManager.SaveSetting(_PromoProductName, "", "bvsoftware", "Offer", "Free Promo Item");
        LoadProduct();
    }
</script>


<h2>Free Promo Item</h2>
<table cellspacing="0" cellpadding="0" border="0">
    <tr>
        <td class="formlabel">
            When customer buys:
        </td>
        <td class="formfield">
            <asp:TextBox ID="QualifyingQuantity" runat="server" Columns="3"></asp:TextBox> &nbsp;items<bvc5:BVRegularExpressionValidator
                ID="OrderQuantityRegularExpressionValidator" runat="server" ErrorMessage="Quantity must be a whole number greater than 0."
                ValidationExpression="[1-9]\d{0,49}" ControlToValidate="QualifyingQuantity">*</bvc5:BVRegularExpressionValidator>
       	</td>
    </tr>
    <tr>
        <td class="formlabel">from any of these categories:</td>
        <td class="formfield">
            <asp:DropDownList ID="lstCategory" runat="server"></asp:DropDownList>&nbsp;<asp:Button ID="AddCategory" Text="Add" runat="server" onclick="AddQualifyingCategory_Click" />
             <br /><br />
            <asp:GridView DataKeyNames="Bvin" ID="QualifyingCategories" runat="server" AutoGenerateColumns="False" onrowdeleting="QualifyingCategories_RowDeleting" GridLines="none" style="width:100%;">
                <EmptyDataTemplate>
                    You must select at least one category
                </EmptyDataTemplate>
                <Columns>                
                    <asp:BoundField DataField="Setting2" HeaderText="Name" />                
                    <asp:ButtonField ButtonType="Button" CommandName="Delete" Text="X" />
                </Columns>
                <RowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
            <br />
            <br />
        </td>
    </tr>
    
    <tr>
        <td class="formlabel">Give them 1 of this product for free:</td>
        <td class="formfield">
        	<asp:Label ID="lblProduct" runat="server" Text="No Product Selected" ></asp:Label> 
            <asp:Button ID="btnRemove" runat="server" Text="X" onclick="btnRemove_Click" />
            
            <br />
            <br />
            
            <div style="background:#ddd;padding: 20px;">
                Select a product
                <uc1:ProductPicker ID="ProductPicker2" runat="server" Visible="true" DisplayPrice="true" /> 
                <br />
                <asp:Button ID="btnAddProduct" runat="server" Text="Select Product" onclick="btnAddProduct_Click" />
            </div>
        </td>
    </tr>
</table>
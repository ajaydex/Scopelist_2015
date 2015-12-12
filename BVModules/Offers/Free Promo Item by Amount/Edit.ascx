<%@ Control Language="C#" AutoEventWireup="true" Inherits="BVSoftware.Bvc5.Core.Content.OfferTemplate" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>
<%@ Register Src="../../../BVAdmin/Controls/ProductPicker.ascx" TagName="ProductPicker"
    TagPrefix="uc1" %>
    <script runat="server">
        private static string _QualificationAmount = "QualificationAmount";
        private static string _PromoProductId = "PromoProductId";
        private static string _PromoProductName = "PromoProductName";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public override void Cancel()
        {

        }

        public override void Initialize()
        {
            this.OrderTotalTextBox.Text = SettingsManager.GetDecimalSetting(_QualificationAmount).ToString("c");
            if (Decimal.Parse(this.OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency) <= 0)
            {
                Decimal val = 0.01m;
                this.OrderTotalTextBox.Text = val.ToString("c");
            }
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

        public override void Save()
        {
            Decimal a = 0;
            a = Decimal.Parse(this.OrderTotalTextBox.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture);
            if (a < 0.01m)
            {
                a = 0.01m;
            }
            SettingsManager.SaveDecimalSetting(_QualificationAmount, a, "bvsoftware", "Offer", "Free Promo Item By Amount");
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
        protected void OrderTotalCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
        {
            Decimal temp = 0;
            if (Decimal.TryParse(args.Value, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, out temp))
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }
    </script>
    
<h2>Free Promo Item by Amount</h2>
<table cellspacing="0" cellpadding="0" border="0">
    <tr>
        <td class="formlabel">
            When the order total is at least</td>
        <td class="formfield">
            <asp:TextBox ID="OrderTotalTextBox" runat="server"></asp:TextBox>
            <bvc5:BVCustomValidator ID="OrderTotalCustomValidator" runat="server" ErrorMessage="Order amount must be a monetary amount." ControlToValidate="OrderTotalTextBox" onservervalidate="OrderTotalCustomValidator_ServerValidate" >*</bvc5:BVCustomValidator>
        </td>
    </tr>
    <tr>
        <td class="formlabel">give them 1 of this product for free:</td>
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
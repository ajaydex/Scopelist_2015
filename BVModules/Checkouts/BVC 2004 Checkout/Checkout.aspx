<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Checkout.aspx.vb" Inherits="BVModules_Checkouts_BVC_2004_Checkout_Checkout" title="Checkout" %>

<%@ Register Src="../../Controls/PaypalExpressCheckoutButton.ascx" TagName="PaypalExpressCheckoutButton"
    TagPrefix="uc5" %>

<%@ Register Src="../../Controls/EmailAddressEntry.ascx" TagName="EmailAddressEntry"
    TagPrefix="uc4" %>

<%@ Register Src="../../Controls/AddressBook.ascx" TagName="AddressBook" TagPrefix="uc3" %>

<%@ Register Src="../../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<%@ Register Src="../../Controls/StoreAddressEditor.ascx" TagName="StoreAddressEditor"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
<h1>Step 1 of 3 - Address</h1>
<div>
    <uc2:MessageBox ID="MessageBox1" runat="server" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="errormessage" />    
    <div><uc3:AddressBook ID="AddressBook1" runat="server" TabIndex="90" /></div>
    <uc4:EmailAddressEntry ID="EmailAddressEntry1" runat="server" />
    <h2 id="ShipToHeader" runat="server">Ship To:</h2>    
    <anthem:Panel ID="ShippingPanel" runat="server">
        <uc1:StoreAddressEditor ID="StoreAddressEditorShipping" runat="server" TabOrderOffSet="100" />
    </anthem:Panel>
</div>
<div id="BillingSection" runat="server">
    <h2>Bill To:</h2>
    <anthem:CheckBox ID="SameAsShippingCheckBox" runat="server" Text="Same as Shipping" AutoPostBack="true" EnableCallBack="false" TabIndex="199" Checked="true" />
    <anthem:Panel ID="BillingPanel" runat="server" Visible="false">
        <uc1:StoreAddressEditor ID="StoreAddressEditorBilling" runat="server" TabOrderOffSet="200" />
    </anthem:Panel>    
</div>
<br />
<asp:ImageButton ID="btnNext" runat="server" AlternateText="Next" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Next.png" TabIndex="300" />
<br /><br />
</asp:Content>


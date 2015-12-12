<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Payment.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Checkouts_One_Page_Checkout_Plus_Payment" %>
<%@ Register Src="CreditCardInput.ascx" TagName="CreditCardInput" TagPrefix="uc1" %>

<table cellspacing="0" cellpadding="0" style="width:100%;">
    <tr runat="server" id="rowNoPaymentNeeded" visible="false">
        <td class="radiobuttoncol">
            <div style="width:100px;">
                <asp:RadioButton ID="rbNoPayment" GroupName="PaymentGroup" runat="server" Checked="false" />
            </div>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    
    <tr runat="server" id="trCredEx" visible="false">
        <td class="radiobuttoncol" style="width:140px;">
            <asp:RadioButton ID="rbCredEx" GroupName="PaymentGroup" Text="CredEx" runat="server" Checked="false" />
        </td>
        <td>
        	<asp:Image ID="imgCredEx" ImageUrl="~/images/system/CredExLogo.gif" BorderWidth="0" AlternateText="CredEx" runat="server" />
        </td>
    </tr>
    
    <tr runat="server" id="rowCreditCard" visible="false">
        <td class="radiobuttoncol" colspan="2">
            <asp:RadioButton ID="rbCreditCard" GroupName="PaymentGroup" Text="Credit Card" runat="server" Checked="false" />
            <div class="clear"></div>
            <uc1:CreditCardInput ID="CreditCardInput1" runat="server" />
        </td>
    </tr>
    
    <tr runat="server" id="trPaypal" visible="false">
        <td class="radiobuttoncol">
            <asp:RadioButton ID="rbPaypal" GroupName="PaymentGroup" Text="PayPal" runat="server" Checked="false" />
        </td>
        
        <td>
            <img src="https://www.paypalobjects.com/webstatic/en_US/i/buttons/PP_logo_h_100x26.png"><br />
            <span>Pay without sharing your financial information.</span>
        </td>
    </tr>
    
    <tr runat="server" id="trPurchaseOrder" visible="false">
        <td class="radiobuttoncol">
            <asp:RadioButton ID="rbPurchaseOrder" GroupName="PaymentGroup" runat="server" Checked="false" />
        </td>
        <td>
            <asp:Label ID="lblPurchaseOrderDescription" runat="server"></asp:Label>
            <div style="padding-top:10px;">
                <asp:textbox ID="PurchaseOrderField" runat="server" placeholder="Enter PO #"></asp:textbox>
            </div>
            <asp:CustomValidator ID="PurchaseOrderValidator" ValidateEmptyText="true" ControlToValidate="PurchaseOrderField" ErrorMessage="Purchase order number required" Display="Dynamic" EnableClientScript="false" CssClass="error" runat="server" />
        </td>
    </tr>
    
    <tr runat="server" id="rowCheck" visible="false">
        <td class="radiobuttoncol">
            <asp:RadioButton ID="rbCheck" GroupName="PaymentGroup" runat="server" Checked="false" />
        </td>
        <td>
            <asp:Label ID="lblCheckDescription" runat="server"></asp:Label>
        </td>
    </tr>
    
    <tr runat="server" id="rowTelephone" visible="false">
        <td class="radiobuttoncol">
            <asp:RadioButton ID="rbTelephone" GroupName="PaymentGroup" runat="server" Checked="false" />
        </td>
        <td>
            <asp:Label ID="lblTelephoneDescription" runat="server"></asp:Label>
        </td>
    </tr>
    
    <tr runat="server" id="trCOD" visible="false">
        <td class="radiobuttoncol">
            <asp:RadioButton ID="rbCOD" GroupName="PaymentGroup" runat="server" Checked="false" />
        </td>
        <td>
            <asp:Label ID="lblCOD" runat="server"></asp:Label>
        </td>
    </tr>
</table>
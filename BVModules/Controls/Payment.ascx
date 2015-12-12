<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Payment.ascx.vb" Inherits="BVModules_Controls_Payment" %>
<%@ Register Src="CreditCardInput.ascx" TagName="CreditCardInput" TagPrefix="uc1" %>
<%--<table border="0" cellspacing="0" cellpadding="3">
    <tr runat="server" id="rowNoPaymentNeeded" visible="false">
        <td valign="top" class="radiobuttoncol"><asp:RadioButton ID="rbNoPayment" GroupName="PaymentGroup" runat="server" Checked="false" /></td>
        <td><asp:Label ID="lblNoPaymentNeeded" runat="server"></asp:Label></td>
    </tr>
    <tr runat="server" id="trCredEx" visible="false">
        <td valign="top" class="radiobuttoncol"><asp:RadioButton ID="rbCredEx" GroupName="PaymentGroup" runat="server" Checked="false" /></td>
        <td><asp:Image ID="imgCredEx" ImageUrl="~/images/system/CredExLogo.gif" BorderWidth="0" AlternateText="CredEx" runat="server" /></td>
    </tr>
    <tr runat="server" id="rowCreditCard" visible="false">
        <td valign="top" class="radiobuttoncol"><asp:RadioButton ID="rbCreditCard" GroupName="PaymentGroup" runat="server" Checked="false" /></td>
        <td>Credit Card<uc1:CreditCardInput ID="CreditCardInput1" runat="server" />            
        </td>
    </tr>
    <tr runat="server" id="trPaypal" visible="false">
        <td valign="top" class="radiobuttoncol"><asp:RadioButton ID="rbPaypal" GroupName="PaymentGroup" runat="server" Checked="false" /></td>
        <td><img src="https://www.paypalobjects.com/webstatic/en_US/i/buttons/PP_logo_h_100x26.png" align="left" style="margin-right:7px;"><span style="font-size:11px; font-family: Arial, Verdana;">Pay without sharing your financial information.</span></td>
    </tr>
    <tr runat="server" id="trPurchaseOrder" visible="false">
        <td valign="top" class="radiobuttoncol"><asp:RadioButton ID="rbPurchaseOrder" GroupName="PaymentGroup" runat="server" Checked="false" /></td>
        <td><asp:Label ID="lblPurchaseOrderDescription" runat="server"></asp:Label><br />
        Purchase Order # <asp:textbox ID="PurchaseOrderField" runat="server" Columns="10"></asp:textbox></td>
    </tr>
    <tr runat="server" id="rowCheck" visible="false">
        <td valign="top" class="radiobuttoncol"><asp:RadioButton ID="rbCheck" GroupName="PaymentGroup" runat="server" Checked="false" /></td>
        <td><asp:Label ID="lblCheckDescription" runat="server"></asp:Label></td>
    </tr>
    <tr runat="server" id="rowTelephone" visible="false">
        <td valign="top" class="radiobuttoncol"><asp:RadioButton ID="rbTelephone" GroupName="PaymentGroup" runat="server" Checked="false" /></td>
        <td><asp:Label ID="lblTelephoneDescription" runat="server"></asp:Label></td>
    </tr>
    <tr runat="server" id="trCOD" visible="false">
        <td valign="top" class="radiobuttoncol"><asp:RadioButton ID="rbCOD" GroupName="PaymentGroup" runat="server" Checked="false" /></td>
        <td><asp:Label ID="lblCOD" runat="server"></asp:Label></td>
    </tr>
</table>--%>
<h3>
    Payment</h3>
<div class="general-form">
    <div runat="server" id="rowNoPaymentNeeded" visible="false">
        <h4 class="line-behind">
            <span>
                <asp:RadioButton ID="rbNoPayment" GroupName="PaymentGroup" runat="server" Checked="false"
                    class="radio_btn" />
                <asp:Label ID="lblNoPaymentNeeded" runat="server"></asp:Label>
            </span>
        </h4>
    </div>
    <div runat="server" id="trCredEx" visible="false" class="checkoutblk2">
        <h4 class="line-behind">
            <span>
                <asp:RadioButton ID="rbCredEx" GroupName="PaymentGroup" runat="server" Checked="false"
                    class="radio_btn" />
                <asp:Image ID="imgCredEx" ImageUrl="~/images/system/CredExLogo.gif" BorderWidth="0"
                    AlternateText="CredEx" runat="server" />
            </span>
        </h4>
    </div>
    <div runat="server" id="rowCreditCard" visible="false" class="checkoutblk2 checkout_srpanel">
        <h4 class="line-behind">
            <span>
                <asp:RadioButton ID="rbCreditCard" class="radio_btn overridebackground" GroupName="PaymentGroup"
                    runat="server" Checked="false" /><span class="cl2 overridebackground">Credit Card</span>
            </span>
        </h4>
        <uc1:CreditCardInput ID="CreditCardInput1" runat="server" />
        <div runat="server" id="rowCheck" visible="false" class="payment_creditcardinput">
            <h4 class="line-behind">
                <span>
                    <asp:RadioButton ID="rbCheck" GroupName="PaymentGroup" runat="server" Checked="false"
                        class="radio_btn" Style="float: left; margin-top: 2px;" />
                    <asp:Label ID="lblCheckDescription" runat="server" CssClass="lblCheck"></asp:Label>
                </span>
            </h4>
        </div>
    </div>
    <div runat="server" id="trPaypal" visible="false" class="checkoutblk2">
        <h4 class="line-behind">
            <span>
                <asp:RadioButton ID="rbPaypal" GroupName="PaymentGroup" runat="server" Checked="false"
                    class="radio_btn" />
                <img src="https://www.paypal.com/en_US/i/logo/PayPal_mark_37x23.gif" alt="paypal"
                    align="left" style="margin-right: 7px;"><span style="font-size: 11px; font-family: Arial, Verdana;">Save
                        time. Checkout securely.<br />
                        Pay without sharing your financial information.</span> </span>
        </h4>
    </div>
    <div runat="server" id="trPurchaseOrder" visible="false" class="checkoutblk2">
        <h4 class="line-behind">
            <span>
                <asp:RadioButton ID="rbPurchaseOrder" GroupName="PaymentGroup" runat="server" Checked="false"
                    class="radio_btn" />
                <asp:Label ID="lblPurchaseOrderDescription" runat="server"></asp:Label><br />
                Purchase Order #
                <asp:TextBox ID="PurchaseOrderField" runat="server" Columns="10"></asp:TextBox>
            </span>
        </h4>
    </div>
    <div runat="server" id="rowTelephone" visible="false" class="checkoutblk2">
        <h4 class="line-behind">
            <span>
                <asp:RadioButton ID="rbTelephone" GroupName="PaymentGroup" runat="server" Checked="false"
                    class="radio_btn" />
                <asp:Label ID="lblTelephoneDescription" runat="server"></asp:Label>
            </span>
        </h4>
    </div>
    <div runat="server" id="trCOD" visible="false" class="checkoutblk2">
        <h4 class="line-behind">
            <span>
                <asp:RadioButton ID="rbCOD" GroupName="PaymentGroup" runat="server" Checked="false"
                    class="radio_btn" />
                <asp:Label ID="lblCOD" runat="server"></asp:Label>
            </span>
        </h4>
    </div>
</div>
<div class="clear">
</div>

<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="ReceivePayments.aspx.vb" Inherits="BVAdmin_Orders_ReceivePayments" Title="Payments" %>
<%@ Register Src="../../BVModules/Controls/CreditCardInput.ascx" TagName="CreditCardInput" TagPrefix="uc2" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<%@ Register Src="~/BVAdmin/Controls/OrderDetailsButtons.ascx" TagName="OrderDetailsButtons" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Order <asp:Label ID="OrderNumberField" runat="server" Text="000000"></asp:Label> Payments</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />  
    
    <hr />
	<asp:Label ID="StatusField" runat="server"></asp:Label>
    <table border="0" cellspacing="0" cellpadding="0" style="float:right;width: 200px;">
        <tr>
            <td align="left">
                <asp:ImageButton ID="btnPreviousStatus" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Left.png" />
            </td>
            <td align="center">
                &nbsp;<asp:Label ID="lblCurrentStatus" Text="Unknown" runat="server"></asp:Label>&nbsp;
            </td>
            <td align="right">
                <asp:ImageButton ID="btnNextStatus" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/right.png" />
            </td>
        </tr>
    </table>
    <hr />
    
	<div class="f-row">
    	<div class="ten columns">
        	<div class="controlarea1">
                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                        <td style="vertical-align:top;width:30%;"><h3 style="margin-top: 5px;">Total Payment <br />Status for Order</h3></td>
                        <td>
                            <table cellspacing="0" cellpadding="0" style="width:100%;">
                                <tr>
                                    <td class="formlabel" style="border-bottom: solid 1px #ddd;">Authorized:</td>
                                    <td class="formfield text-right" style="border-bottom: solid 1px #ddd;">
                                        <asp:Label ID="PaymentAuthorizedField" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formlabel" style="border-bottom: solid 1px #ddd;">Charged:</td>
                                    <td class="formfield text-right" style="border-bottom: solid 1px #ddd;">
                                        <asp:Label ID="PaymentChargedField" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formlabel" style="border-bottom: solid 1px #ddd; padding-bottom: 3px;">Refunded:</td>
                                    <td class="formfield text-right" style="border-bottom: solid 1px #ddd; padding-bottom: 3px;">
                                        <asp:Label ID="PaymentRefundedField" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="formlabel"><strong>Amount Due:</strong></td>
                                    <td class="formfield text-right">
                                        <strong><asp:Label ID="PaymentDueField" runat="server"></asp:Label></strong>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        
                    </tr>
                </table>
            </div>
            <br />
        
        	<asp:GridView ShowHeader="false" GridLines="None" BorderWidth="0" ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="0" Width="100%" DataKeyNames="bvin">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                        	<div style="background:#ddd;padding: 5px 15px;margin-bottom:10px;">
                                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                    <tr>
                                        <td align="left" valign="top">
                                            <h3><asp:Label ID="lblPaymentMethodName" runat="server" Text='<%# Bind("PaymentMethodName")  %>'></asp:Label></h3>
                                        </td>
                                        <td align="right">
                                            <asp:ImageButton EnableViewState="false" ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return window.confirm('Delete this Payment?');" ImageUrl="~/BVAdmin/Images/Buttons/X.png"></asp:ImageButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" valign="top">
                                            <div style="background:#F3F3F3;padding:15px;margin-bottom: 10px;">
                                                <strong><asp:Label ID="lblStatus" runat="server"></asp:Label></strong>
                                                <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                                                    <tr runat="server" id="trCheckNumber" visible="false">
                                                        <td class="formlabel">Check #</td>
                                                        <td class="formfield">
                                                            <asp:TextBox ID="CheckNumberField" runat="server" Columns="15"></asp:TextBox></td>
                                                    </tr>
                                                    <tr runat="server" id="trGiftCard" visible="false">
                                                        <td class="formlabel">Gift Certificate Id:</td>
                                                        <td class="formfield">
                                                            <asp:TextBox ID="GiftCardIdTextBox" runat="server"></asp:TextBox>                   
                                                        </td>
                                                    </tr>
                                                    <tr runat="server" id="trPurchaseOrder" visible="false">
                                                        <td class="formlabel">PO #</td>
                                                        <td class="formfield">
                                                            <asp:TextBox ID="PurchaseOrderNumberField" runat="server" Columns="15"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr runat="server" id="trCreditCard" visible="false">
                                                        <td colspan="2" class="formfield">
                                                            <uc2:CreditCardInput ID="CreditCardInput1" runat="server" />&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr runat="server" id="trOrderNumber" visible="false">
                                                        <td class="formlabel">Order Number</td>
                                                        <td class="formfield"><asp:TextBox ID="OrderNumberOverrideField" runat="server" Columns="15"></asp:TextBox></td>
                                                    </tr>
                                                    <tr runat="server" id="trNotes" visible="true">
                                                        <td class="formlabel">Notes</td>
                                                        <td class="formfield">
                                                            <asp:TextBox ID="NotesTextBox" runat="server" Rows="5" TextMode="MultiLine" Wrap="true"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr runat="server" id="trAmount" visible="true">
                                                        <td class="formlabel">Amount</td>
                                                        <td class="formfield">
                                                            <asp:TextBox ID="AmountField" runat="server" Columns="15"></asp:TextBox>
                                                        </td>
                                                    </tr>                                                                                                                
                                                </table>
                                            </div>
                                        </td>
                                        <td align="right" valign="top" class="buttonStack" style="width:27%;">
                                            <asp:ImageButton ID="btnAuth" CommandName="BVAuthorize" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Authorize.png" AlternateText="Authorize" Visible="false" />
                                            <asp:ImageButton ID="btnCapture" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Capture.png" CommandName="BVCapture" AlternateText="Capture" Visible="false" />
                                            <asp:ImageButton ID="btnCharge" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Charge.png" CommandName="BVCharge" AlternateText="Charge" Visible="false" />
                                            <asp:ImageButton ID="btnRefund" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Refund.png" CommandName="BVRefund" AlternateText="Refund" Visible="false" />
                                            <asp:ImageButton ID="btnVoid" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Void.png" CommandName="BVVoid" AlternateText="Void" Visible="false" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
        	</asp:GridView>
            
            <hr />
            
            <asp:DropDownList ID="lstNewPayment" runat="server"></asp:DropDownList> 
            <asp:ImageButton ID="btnNewPayment" runat="server" ImageUrl="~/BVAdmin/Images/buttons/New.png" AlternateText="Add New Payment Method" />
        </div>
        <div class="two columns text-right">
        	<uc:OrderDetailsButtons ID="ucOrderDetailsButtons" runat="server" />
        </div>    
    </div>
    
    <asp:HiddenField ID="BvinField" runat="server" />
    <asp:HiddenField ID="EditingBvin" runat="server" Value="" />
</asp:Content>
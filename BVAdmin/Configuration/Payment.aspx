<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Payment.aspx.vb" Inherits="BVAdmin_Configuration_Payment" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Payment</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    
    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel">No Payment Needed Description Text:</td>
            <td class="formfield">
            	<asp:TextBox ID="NoPaymentNeededTextBox" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
        	<td class="formlabel">Require PO number when Purchase Order is selected:</td>
            <td class="formfield">
            	<asp:CheckBox ID="PurchaseOrderNumberCheckBox" runat="server" /> Yes
            </td>
        </tr>
   	</table>

    <br />
    
    <asp:GridView ID="PaymentMethodsGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="MethodId" CellPadding="0" BorderWidth="0" GridLines="None" style="width:100%;">
        <Columns>
            <asp:TemplateField HeaderText="Display at Checkout">
                <ItemTemplate>
                    <asp:CheckBox id="chkEnabled" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("MethodName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="btnEdit" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" runat="server" CausesValidation="false" CommandName="Edit" AlternateText="Edit"></asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
    <fieldset>
        <legend>Sign Up For:</legend>
        <a href="http://altfarm.mediaplex.com/ad/ck/3484-23890-3840-92" target="_blank" style="display: block;">
            <img src="../../BVAdmin/Images/paypal_mrb_banner.gif" alt="Sign up for Paypal" style="border: 0px; margin-top: 10px;" />
        </a>
        <br />
        <br />
    </fieldset>
         
    
    <div style="height:15px;"></div>
    <asp:ImageButton ID="btnSaveChanges" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
</asp:Content>


<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="RMADetail.aspx.vb" Inherits="BVAdmin_Orders_RMADetail" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Return Details</h1>    
    <uc1:MessageBox ID="MessageBox" runat="server" />
    
    <asp:ImageButton ID="ReturnManagerImageButton" runat="server" AlternateText="Back to Return Manager" PostBackUrl="~/BVAdmin/Orders/RMA.aspx" ImageUrl="~/BVAdmin/Images/Buttons/ReturnManager.png" />   
     
    <h2>Return Information</h2>
    <table style="margin-top: 20px; margin-bottom: 20px;">
        <tr>
            <td class="formlabel">
                Status:
            </td>
            <td class="formfield">
                <asp:Label ID="StatusLabel" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>    
    <h2>Return Customer Information</h2>
    <table style="margin-top: 20px; margin-bottom: 20px;">
        <tr>
            <td class="formlabel">
                Name:
            </td>
            <td class="formfield">
                <asp:Label ID="NameLabel" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Phone Number:
            </td>
            <td class="formfield">
                <asp:Label ID="PhoneNumberLabel" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                E-mail Address:
            </td>
            <td class="formfield">
                <asp:Label ID="EmailAddressLabel" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Date Of Return:
            </td>
            <td class="formfield">
                <asp:Label ID="DateOfReturnLabel" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Comments:
            </td>
            <td class="formfield">
                <asp:Label ID="CommentsLabel" runat="server" Text=""></asp:Label>
            </td>
        </tr>        
    </table>
    &nbsp;
    <asp:GridView ID="RMAGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%">
    
        <Columns>
            <asp:BoundField HeaderText="Qty" DataField="Quantity" />            
            <asp:BoundField HeaderText="Name" DataField="ProductName"/>
            <asp:BoundField HeaderText="Sku" DataField="ProductSku" />
            <asp:BoundField HeaderText="Reason" DataField="Reason" />                
            <asp:CheckBoxField HeaderText="Replace?" DataField="Replace" />
            <asp:BoundField HeaderText="Qty Received" DataField="QuantityReceived" DataFormatString="{0:d}" HtmlEncode="False" />
            <asp:BoundField HeaderText="# Restocked" DataField="QuantityReturnedToInventory" DataFormatString="{0:d}"  HtmlEncode="False" />
            
            <asp:TemplateField HeaderText="Quantity Received">
                <ItemTemplate>
                    <asp:TextBox ID="QuantityTextBox" runat="server" Text="0" Width="30px"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" ErrorMessage="Must enter a quantity" Text="*" ControlToValidate="QuantityTextBox" Display="Dynamic" ></bvc5:BVRequiredFieldValidator>                    
                    <bvc5:BVCustomValidator ID="QuantityCustomValidator" runat="server" OnServerValidate="IsNumeric_ServerValidate" ControlToValidate="QuantityTextBox" Text="*" ErrorMessage="Must be numeric" Display="Dynamic"></bvc5:BVCustomValidator>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Restock?">
                <ItemTemplate>
                    <asp:CheckBox ID="ReturnToInventoryCheckBox" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
        
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
        
    </asp:GridView>
    <div style="float: right; margin-top: 20px;">
        <asp:ImageButton ID="ReceiveImageButton" runat="server" AlternateText="Receive Items" ImageUrl="~/BVAdmin/Images/Buttons/ReturnSelectedItems.png" />
    </div>
    <div style="margin-top:20px;">
        <asp:ImageButton ID="ApproveImageButton" runat="server" AlternateText="Approve Return" ImageUrl="~/BVAdmin/Images/Buttons/ApproveReturn.png" />
        <asp:ImageButton ID="CloseImageButton" runat="server" AlternateText="Close Return" ImageUrl="~/BVAdmin/Images/Buttons/CloseReturn.png" />
        <asp:ImageButton ID="ReopenImageButton" runat="server" AlternateText="Reopen Return" ImageUrl="~/BVAdmin/Images/Buttons/ReopenReturn.png" />
        <asp:ImageButton ID="RejectImageButton" runat="server" AlternateText="Reject Return" ImageUrl="~/BVAdmin/Images/Buttons/RejectReturn.png" /></div>
</asp:Content>


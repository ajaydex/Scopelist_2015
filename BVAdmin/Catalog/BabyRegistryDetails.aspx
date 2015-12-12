<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="BabyRegistryDetails.aspx.vb" Inherits="BVAdmin_Catalog_BabyRegistryDetails" title="Gift Certificates" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<h1>Baby Registry Details</h1>
<div>
    <uc1:MessageBox ID="MessageBox1" runat="server" EnableViewState="false" />
    <h2>Items in Baby Registry</h2>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" CellPadding="2" GridLines="None" Width="100%">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <div class="wishlistproductimage"><asp:HyperLink ID="imgProduct" runat="server"></asp:HyperLink></div>
                    <div class="wishlistproductlink"><asp:HyperLink ID="lnkProduct" runat="server"></asp:HyperLink></div>
                    <div class="wishlistprice"><asp:HyperLink id="lnkProductPrice" runat="server"></asp:HyperLink></div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="false">
                <ItemTemplate>
                    Desired:  &nbsp;&nbsp;<anthem:TextBox ID="txtDesiredQty" runat="server" Text='<%# Eval("DesiredQuantity") %>' Width="35px"></anthem:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="QuantityBVRequiredFieldValidator1" runat="server" ControlToValidate="txtDesiredQty" ErrorMessage="Quantity must be entered."></bvc5:BVRequiredFieldValidator> 
                    <bvc5:BVRegularExpressionValidator ID="QuantityBVRegularExpressionValidator1" runat="server" ControlToValidate="txtDesiredQty" ValidationExpression="\d{1,5}" ErrorMessage="Quantity must be numeric."></bvc5:BVRegularExpressionValidator>
                    <br />
                    Received: <anthem:TextBox ID="txtReceivedQty" runat="server" Text='<%# Eval("ReceivedQuantity") %>' Width="35px" ReadOnly="true"></anthem:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="QuantityBVRequiredFieldValidator2" runat="server" ControlToValidate="txtReceivedQty" ErrorMessage="Quantity must be entered."></bvc5:BVRequiredFieldValidator> 
                    <bvc5:BVRegularExpressionValidator ID="QuantityBVRegularExpressionValidator2" runat="server" ControlToValidate="txtReceivedQty" ValidationExpression="\d{1,5}" ErrorMessage="Quantity must be numeric."></bvc5:BVRegularExpressionValidator>
                    <br />
                    Priority:  &nbsp;&nbsp;<asp:DropDownList ID="drpPriority" runat="server" Width="75px"></asp:DropDownList>
                </ItemTemplate>                 
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                <asp:ImageButton ID="UpdateButton" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Update.png" CommandName="Update" />
                </ItemTemplate>
            </asp:TemplateField>                    
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                <asp:ImageButton ID="DeleteButton" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Delete.png" CommandName="Delete" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>            
    </asp:GridView> 
</div>
</asp:Content>


<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" Language="vb"
    AutoEventWireup="false" Inherits="MyAccount_WishList" CodeFile="MyAccount_WishList.aspx.vb" %>

<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc1" %>

<asp:Content ContentPlaceHolderID="MainContentHolder" runat="server">
    <uc1:ManualBreadCrumbTrail ID="ManualBreadCrumbTrail1" runat="server" />    
    <h1>
        <span>
            <asp:Label ID="TitleLabel" runat="server">Wish List</asp:Label>            
        </span>
    </h1>
    <br />    
    <uc2:MessageBox ID="MessageBox1" runat="server" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
    <div class="wishlist">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin"
            BorderColor="#CCCCCC" CellPadding="2" GridLines="None" Width="100%">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div class="wishlistproductimage"><asp:HyperLink ID="imgProduct" runat="server"></asp:HyperLink></div>
                        <div class="wishlistproductlink"><asp:HyperLink ID="lnkProduct" runat="server"></asp:HyperLink></div>
                        <div class="wishlistprice"><asp:HyperLink id="lnkProductPrice" runat="server"></asp:HyperLink><asp:Literal runat="server" ID="litModifiers"></asp:Literal></div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                        Quantity: <anthem:TextBox ID="QuantityTextBox" runat="server" Text='<%# Eval("quantity") %>' Width="35px"></anthem:TextBox>
                        <bvc5:BVRequiredFieldValidator ID="QuantityBVRequiredFieldValidator" runat="server" ControlToValidate="QuantityTextBox" ErrorMessage="Quantity must be entered."></bvc5:BVRequiredFieldValidator> 
                        <bvc5:BVRegularExpressionValidator ID="QuantityBVRegularExpressionValidator" runat="server" ControlToValidate="QuantityTextBox" ValidationExpression="\d{1,5}" ErrorMessage="Quantity must be numeric."></bvc5:BVRegularExpressionValidator>
                    </ItemTemplate>                
                </asp:TemplateField>               
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                    <asp:ImageButton ID="UpdateButton" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Update.png" CommandName="Update" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                        <asp:ImageButton ID="AddToCartImageButton" runat="server" Visible="true" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/AddToCart.png" CommandName="AddToCart" CommandArgument='<%# Eval("bvin") %>' />
                    </ItemTemplate>                
                </asp:TemplateField>                
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                    <asp:ImageButton ID="DeleteButton" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Delete.png" CommandName="Delete" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            
        </asp:GridView></div>
</asp:Content>

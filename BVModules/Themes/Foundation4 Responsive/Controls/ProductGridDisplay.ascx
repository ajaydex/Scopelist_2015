<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ProductGridDisplay.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_ProductGridDisplay" %>
<%@ Register TagPrefix="uc" TagName="SingleProductDisplay" Src="~/BVModules/Controls/SingleProductDisplay.ascx" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Repeater ID="rpProductGrid" runat="server">
    <HeaderTemplate>
        <div class="row productgrid">
    </HeaderTemplate>
    
    <ItemTemplate>
        <asp:Panel ID="holder" CssClass="large-3 columns" runat="server">
            <uc:SingleProductDisplay ID="SingleProductDisplay" runat="server" />
        </asp:Panel>
    </ItemTemplate>
    
    <FooterTemplate>
        </div>
    </FooterTemplate>
</asp:Repeater>
<anthem:ImageButton ID="AddItemsToCartImageButton" runat="server" AlternateText="Add Selected Items To Cart" ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/AddSelectedItems.png" Visible="false" CausesValidation="false" />
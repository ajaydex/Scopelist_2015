<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CrossSellDisplay.ascx.vb"
    Inherits="BVModules_Controls_CrossSellDisplay" %>
<%@ Register Src="SingleProductDisplay.ascx" TagName="SingleProductDisplay" TagPrefix="uc1" %>
<asp:Panel ID="CrossSellsPanel" runat="server">
    <div id="crosssells">
        <h2> <asp:Label ID="TitleLabel" runat="server" Text="Recommended Products"></asp:Label></h2>
        <asp:DataList ID="CrossSellsDataList" runat="server">
            <ItemTemplate>
                <uc1:SingleProductDisplay ID="SingleProductDisplay" runat="server" />
            </ItemTemplate>
        </asp:DataList>
        <asp:ImageButton ID="AddItemsToCartImageButton" runat="server" AlternateText="Add Selected Items To Cart"
            ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/AddSelectedItems.png" Visible="false" />
    </div>
</asp:Panel>

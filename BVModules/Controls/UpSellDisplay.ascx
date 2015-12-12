<%@ Control Language="VB" AutoEventWireup="false" CodeFile="UpSellDisplay.ascx.vb" Inherits="BVModules_Controls_UpSellDisplay" %>
<%@ Register Src="SingleProductDisplay.ascx" TagName="SingleProductDisplay" TagPrefix="uc1" %>
<asp:Panel ID="UpSellsPanel" runat="server">
    <h2><asp:Label ID="TitleLabel" runat="server" Text="Recommended Products"></asp:Label></h2>
    <asp:DataList ID="UpSellsDataList" runat="server">
        <ItemTemplate>
            <uc1:SingleProductDisplay ID="SingleProductDisplay" runat="server" />
        </ItemTemplate>
    </asp:DataList>
</asp:Panel>

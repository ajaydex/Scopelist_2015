<%@ Control Language="VB" AutoEventWireup="false" CodeFile="adminview.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_Top_Weekly_Sellers_adminview" %>

<div class="block topWeeklySellers">
    <h6><asp:Label runat="server">Top Weekly Sellers</asp:Label></h6>

    <div class="alert-box alert">This content block is not compatible with the "Responsive" theme.</div>
    <div class="alert-box secondary">The same functionality can be achieved using the "Top Selling Products" content block instead.</div>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" CellPadding="3" GridLines="None" Width="100%" AllowSorting="true">
        <Columns>
            <asp:HyperLinkField DataTextField="ProductName"/>
        </Columns>
    </asp:GridView>
</div>

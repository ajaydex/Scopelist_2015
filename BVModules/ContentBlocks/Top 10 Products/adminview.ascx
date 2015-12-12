<%@ Control Language="VB" AutoEventWireup="false" CodeFile="adminview.ascx.vb" Inherits="BVModules_ContentBlocks_Top_10_Products_adminview" %>

<div class="block topTenProducts">
    <h6>Top 10 Products</h6>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" CellPadding="2" GridLines="None" Width="100%" showHeader="false" >
        <Columns>
            <asp:BoundField DataField="ProductName" />
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
</div>

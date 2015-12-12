<%@ Control Language="VB" AutoEventWireup="false" CodeFile="VolumeDiscounts.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_VolumeDiscounts" %>
<asp:Panel ID="pnlVolumeDiscounts" runat="server">
    <div id="VolumeDiscounts">
        <asp:DataGrid ID="dgVolumeDiscounts" runat="server" CellPadding="3" BorderWidth="0"
            CellSpacing="0" AutoGenerateColumns="False" GridLines="None">
            <AlternatingItemStyle CssClass="VolumePricingText"></AlternatingItemStyle>
            <ItemStyle CssClass="VolumePricingText"></ItemStyle>
            <HeaderStyle CssClass="VolumePricingHeader"></HeaderStyle>
            <Columns>
                <asp:BoundColumn DataField="Qty" HeaderText="Qty"></asp:BoundColumn>
                <asp:BoundColumn DataField="Amount" HeaderText="Price" DataFormatString="{0:c}"></asp:BoundColumn>
            </Columns>
        </asp:DataGrid></div>
</asp:Panel>
<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SharedChoiceProductList.ascx.vb" Inherits="BVAdmin_Controls_SharedChoiceProductList" %>

<div style="padding: 0 20px;">
    <h2>Currently Used By
        <asp:Literal ID="litProductsTotal" EnableViewState="false" runat="server" />
        Product(s):</h2>
    <asp:GridView ID="gvProducts" DataKeyNames="bvin" AutoGenerateColumns="false" ShowHeader="false" UseAccessibleHeader="true" GridLines="None" BorderColor="#cccccc" CellPadding="3" Width="100%" runat="server" >
        <Columns>
            <asp:HyperLinkField DataTextField="Sku" DataNavigateUrlFields="bvin" DataNavigateUrlFormatString="~/BVAdmin/Catalog/Products_Edit.aspx?id={0}" />
        </Columns>
        <EmptyDataTemplate>
            No products found.
        </EmptyDataTemplate>
    </asp:GridView>
</div>
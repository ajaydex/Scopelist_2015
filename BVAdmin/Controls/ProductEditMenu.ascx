<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ProductEditMenu.ascx.vb" Inherits="BVAdmin_Controls_ProductEditMenu" %>

<ul class="side-nav">
    <li>
        <asp:LinkButton ID="lnkGeneral" runat="server" Text="General Options"></asp:LinkButton></li>
    <li>
        <asp:LinkButton ID="lnkAdditionalImages" runat="server" Text="Additional Images"></asp:LinkButton></li>
    <li>
        <asp:LinkButton ID="lnkCategories" runat="server" Text="Categories"></asp:LinkButton></li>
    <li>
        <asp:LinkButton ID="lnkCustomerChoices" runat="server" Text="Product Variations"></asp:LinkButton></li>
    <li>
        <asp:LinkButton ID="lnkCustomerChoicesEdit" runat="server" Text="Edit Product Variations"></asp:LinkButton></li>
    <li>
        <asp:LinkButton ID="lnkFileDownloads" runat="server" Text="File Downloads"></asp:LinkButton></li>
    <li>
        <asp:LinkButton ID="lnkProductReviews" runat="server" Text="Product Reviews"></asp:LinkButton></li>
    <li>
        <asp:LinkButton ID="lnkUpSellCrossSell" runat="server" Text="Up Sells/Cross Sells"></asp:LinkButton></li>
    <li>
        <asp:LinkButton ID="lnkVolumeDiscounts" runat="server" Text="Volume Discounts"></asp:LinkButton></li>
    <li>
        <asp:LinkButton ID="lnkInventory" runat="server" Text="Inventory"></asp:LinkButton></li>
    <li runat="server" visible="false">
        <asp:LinkButton ID="lnkKit" runat="server" Text="Kits/Bundles" Visible="false"></asp:LinkButton></li>
</ul>
<asp:ImageButton runat="server" ID="btnContinue" ImageUrl="~/BVAdmin/Images/Buttons/SaveAndContinue.png" />
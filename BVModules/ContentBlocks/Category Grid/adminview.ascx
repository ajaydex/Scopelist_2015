<%@ Control Language="VB" AutoEventWireup="false" CodeFile="adminview.ascx.vb" Inherits="BVModules_ContentBlocks_Product_Grid_adminview" %>

<div class="block categorygrid">
    <h6>Category Grid</h6>
    <pre><asp:Label ID="PreHtml" runat="server"></asp:Label></pre>
    <asp:DataList ID="dlCategories" runat="server" RepeatDirection="Horizontal" DataKeyField="bvin"
        RepeatLayout="Table">
        <ItemTemplate>
            <div class="categorygridimage"><asp:HyperLink EnableViewState="false" ID="lnkImage" runat="server"><img id="imagesmall" enableviewstate="false" runat="server"/></asp:HyperLink></div>
            <div class="categorygridlink"><asp:HyperLink EnableViewState="false" runat="server" ID="lnkCategory"></asp:HyperLink></div>
        </ItemTemplate>
    </asp:DataList>
    <pre><asp:Label ID="PostHtml" runat="server"></asp:Label></pre>       
</div>
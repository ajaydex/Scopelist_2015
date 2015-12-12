<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_ContentBlocks_Product_Rotator_view" %>
<div class="block productrotator">
<asp:Literal EnableViewState="false" ID="PreHtml" runat="server"></asp:Literal>

	<div class="decoratedblock">
		<div class="blockcontent">
			<asp:HyperLink EnableViewState="false" ID="lnkImage" runat="server" NavigateUrl=""><img id="imagesmall" enableviewstate="false" runat="server" class="productrotatoritem"/></asp:HyperLink>
            <br />
            <asp:HyperLink EnableViewState="false" ID="lnkProductName" runat="server" NavigateUrl=""></asp:HyperLink>
        </div>
    </div>

<asp:Literal EnableViewState="false" ID="PostHtml" runat="server"></asp:Literal>
</div>
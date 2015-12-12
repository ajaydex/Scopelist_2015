<%@ Control Language="VB" AutoEventWireup="false" CodeFile="RelatedItems.ascx.vb"
    Inherits="BVModules_Controls_RelatedItems" %>
<asp:Panel ID="pnlMain" runat="server" Visible="True">
    <div class="relateditemsblock">
        <h3>
            <asp:Label ID="TitleLabel" runat="server">Related Items</asp:Label></h3>
        <div class="relateditemsblockcontent">
            <asp:PlaceHolder ID="phItems" runat="server"></asp:PlaceHolder>
        </div>
    </div><asp:HiddenField ID="bvinField" runat="server" />
</asp:Panel>

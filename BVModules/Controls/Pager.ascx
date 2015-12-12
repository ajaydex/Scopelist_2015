<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Pager.ascx.vb" Inherits="BVModules_Controls_Pager" %>
<div class="my-pagination" id="myPagination" runat="server" visible="false">
    <ul>
        <li id="FirstListItem" runat="server" class="first">&laquo;</li>
        <li id="PreviousListItem" runat="server">&laquo;</li>
        <asp:PlaceHolder ID="PagesPlaceHolder" runat="server"></asp:PlaceHolder>
        <li id="NextListItem" runat="server"></li>
        <li id="LastListItem" runat="server" class="last"></li>
    </ul>
    <asp:Literal ID="ltlRightArrow" runat="server" Text="&raquo;" Visible="false"> </asp:Literal>
</div>

<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Pager.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_Pager" %>

<ul class="pagination">
    <li id="FirstListItem" runat="server"></li>
    <li id="PreviousListItem" runat="server"></li>        
    <asp:PlaceHolder ID="PagesPlaceHolder" runat="server"></asp:PlaceHolder>
    <li id="NextListItem" runat="server"></li>
    <li id="LastListItem" runat="server"></li>
</ul>

<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CategorySortOrder.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_CategorySortOrder" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<div class="sortby clearfix">
    <asp:Label ID="SortOrderLabel" runat="server" Text="" AssociatedControlID="SortOrderDropDownList"></asp:Label>
    <asp:DropDownList ID="SortOrderDropDownList" runat="server" AutoPostBack="true" CssClass="small"></asp:DropDownList>
</div>
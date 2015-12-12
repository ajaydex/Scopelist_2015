<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CategorySortOrder.ascx.vb" Inherits="BVModules_Controls_CategorySortOrder" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<div class="categorysortorder">
    <asp:Label ID="SortOrderLabel" runat="server" Text="Sort Order" AssociatedControlID="SortOrderDropDownList"></asp:Label>
    <asp:DropDownList ID="SortOrderDropDownList" runat="server" AutoPostBack="true">
            
    </asp:DropDownList>
</div>

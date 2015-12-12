<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_Search_Box_view" %>

<div class="search row collapse">

    <asp:Label EnableViewState="false" ID="lblTitle" runat="server" Text="Search" AssociatedControlID="KeywordField"></asp:Label>

    <div class="small-9 columns">
        <asp:TextBox EnableViewState="false" ID="KeywordField" runat="server"></asp:TextBox>
    </div>
    <div class="small-3 columns">
        <asp:Button ID="btnSearch" runat="server" EnableViewState="false" CausesValidation="false" Text="Search" cssclass="button prefix secondary" />
    </div>

</div>

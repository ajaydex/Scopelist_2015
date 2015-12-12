<%@ Control Language="VB" AutoEventWireup="false" CodeFile="adminview.ascx.vb" Inherits="BVModules_ContentBlocks_Search_Box_adminview" %>

<div class="block searchboxform">
    <h6>Search Box</h6>
    <asp:Panel runat="server" DefaultButton="btnSearch" ID="pnlSearchBox">
        <asp:Label ID="lblTitle" runat="server" Text="Search" AssociatedControlID="KeywordField"></asp:Label>
        <asp:TextBox ID="KeywordField" Columns="15" runat="server" CssClass="forminput"></asp:TextBox>
        <asp:ImageButton CausesValidation="false" CssClass="searchbutton" ID="btnSearch" runat="server" ImageUrl="~/BVAdmin/images/buttons/go.png" />
    </asp:Panel>
</div>
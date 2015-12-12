<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="view.ascx.vb" Inherits="BVModules_ContentBlocks_Search_Box_view" %>
<div class="block searchboxform">
    <div class="decoratedblock">
        <h4>
            <span>
                <asp:Label EnableViewState="false" ID="lblTitle" runat="server" Text="Search" AssociatedControlID="KeywordField"></asp:Label></span></h4>
        <div class="blockcontent">
            <asp:Panel EnableViewState="false" runat="server" DefaultButton="btnSearch" ID="pnlSearchBox">
                <span class="searchspan">
                    <asp:TextBox EnableViewState="false" ID="KeywordField" Columns="15" runat="server" CssClass="forminput"></asp:TextBox>
                    <asp:ImageButton EnableViewState="false" CausesValidation="false" CssClass="searchbutton" ID="btnSearch" runat="server" ImageUrl="~/BVAdmin/images/buttons/go.png" /></span>
            </asp:Panel>
        </div>
    </div>
</div>
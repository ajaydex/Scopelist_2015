<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Search.ascx.vb" Inherits="BVModules_Controls_Search" %>
<div class="searchboxform">
    <%--<h4>
        <span>
            <asp:Label ID="lblTitle" runat="server" Text="Search" AssociatedControlID="KeywordField"></asp:Label></span></h4>--%>
    <asp:Panel runat="server" DefaultButton="btnSearch" ID="pnlSearchBox">
        <span class="searchspan">
            <asp:TextBox ID="KeywordField" Columns="15" runat="server" CssClass="search-field"
                onblur="if(this.value==''){ this.value='Enter keyword to search ...' }" onfocus="if(this.value=='Enter keyword to search ...'){ this.value='' }"
                Text="Enter keyword to search ..."></asp:TextBox>
            <%--<asp:ImageButton CausesValidation="false" CssClass="searchbutton" ID="btnSearch"
                runat="server" ImageUrl="~/BVAdmin/images/buttons/go.png" />--%>
            <asp:Button ID="btnSearch" runat="server" ToolTip="Search" CssClass="search-button"
                CausesValidation="false" Text="Search" />
        </span>
    </asp:Panel>
</div>

<%@ Control EnableViewState="false" Language="VB" AutoEventWireup="false" CodeFile="AdminPanel.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_AdminPanel" %>

<asp:Panel EnableViewState="false" ID="pnlMain" runat="server" Visible="false" class="row adminbar hideforlowres">
    <div class="large-6 columns">
         <img src="/images/bv.png" alt="BV Commerce" />&nbsp;
    	 <asp:Literal ID="editLinks" runat="server" Visible="false"></asp:Literal>&nbsp;
    </div>
    <div class="large-6 columns">
    	<%--
        <asp:HyperLink EnableViewState="false" ID="lnkLogout" runat="server" NavigateUrl="~/Logout.aspx">Logout</asp:HyperLink> 
        <span>|</span>
        --%> 
        <a href="" id="showhidecustombuttons">Display Edit Links</a>
        <span>|</span> 
        <asp:LinkButton EnableViewState="false" ID="btnToggleStore" runat="server">Toggle Store</asp:LinkButton> 
        <span>|</span> 
        <asp:HyperLink EnableViewState="false" ID="lnkGoToAdmin" runat="server">Go To Admin</asp:HyperLink>
    </div>

</asp:Panel>
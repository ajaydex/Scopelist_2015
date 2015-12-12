<%@ Page Title="" Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Help.aspx.vb" Inherits="BVAdmin_Help" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <%--
    <h1>Help</h1>
    <p>Need some help? We got you covered. Try our forum or open a support ticket.</p>
    <br />

    <ul class="bulletList">
        <li><asp:HyperLink ID="lnkSupport" runat="server" NavigateUrl="http://www.bvcommerce.com/support/" EnableViewState="false">www.bvcommerce.com/support/</asp:HyperLink></li>
        <li><asp:HyperLink ID="lnkManual" runat="server" EnableViewState="false">View User Manual</asp:HyperLink><br /></li>
        <li id="liPhone" runat="server"><asp:Literal ID="litPhone" runat="server"></asp:Literal></li>
    </ul>
    --%>

    <iframe src="//www.bvcommerce.com/remoteapi/1/help/help.aspx" style="width:100%; min-height: 800px;" frameborder="0"></iframe>

</asp:Content>
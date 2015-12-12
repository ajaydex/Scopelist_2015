<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Privacy.aspx.vb" Inherits="Privacy" title="Privacy Policy" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
        <uc1:ManualBreadCrumbTrail ID="ManualBreadCrumbTrail1" runat="server" />       
        <h1>
            <asp:Label ID="TitleLabel" runat="server">Privacy</asp:Label>
        </h1>

        <div id="privacyInfo" runat="server"></div>
</asp:Content>


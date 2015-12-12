<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="BVAdmin_Plugins_FeedEngine_Default" %>
<%@ Register TagPrefix="uc" Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" %>
<%@ Register Src="~/BVAdmin/Plugins/FeedEngine/FeedGroup.ascx" TagName="FeedGroup" TagPrefix="uc" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="server">
    <h1>Feed Engine</h1>

    <uc:MessageBox ID="MessageBox" runat="server" />

    <asp:Repeater ID="rpFeedTypes" runat="server">
        <ItemTemplate>
            <h2><asp:Label ID="lblFeedType" runat="server" /></h2>
            <uc:FeedGroup ID="ucFeedGroup" runat="server" />
        </ItemTemplate>
    </asp:Repeater>

</asp:Content>
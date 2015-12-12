<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CustomPagesDisplay.ascx.vb" Inherits="BVModules_Controls_CustomPagesDisplay" %>

<asp:Repeater ID="CustomPageRepeater" runat="server">
    <HeaderTemplate>
        <ul class="custompagesnav">        
    </HeaderTemplate>
    <ItemTemplate>
        <li><a id="CustomPageLink" runat="server"></a></li>
    </ItemTemplate>
    <FooterTemplate>
        </ul>        
    </FooterTemplate>
</asp:Repeater>



<%@ Control Language="VB" AutoEventWireup="false" CodeFile="OutOfStockDisplay.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_OutOfStockDisplay" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<anthem:Panel ID="OutOfStockPanel" CssClass="alert-box alert" data-alert="" runat="server" AutoUpdateAfterCallBack="true">
   <a class="close" href="#">×</a>
    <ul>
        <li>
            <i class="fa fa-exclamation-triangle"></i>
		    <asp:Literal ID="OutOfStockLiteral" runat="server"></asp:Literal>
        </li>
    </ul>
</anthem:Panel>
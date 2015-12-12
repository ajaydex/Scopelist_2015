<%@ Control Language="VB" AutoEventWireup="false" CodeFile="MessageBox.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_MessageBox" EnableViewState="false" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<anthem:Panel runat="server" ID="pnlMain" Visible="false" EnableViewState="false">
    <div data-alert class="alert-box">
        <ul id="MessageList" runat="server" enableviewstate="false"></ul>
        <a href="#" class="close">&times;</a>
    </div>
</anthem:Panel>
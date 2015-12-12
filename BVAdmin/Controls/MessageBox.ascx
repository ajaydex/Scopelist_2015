<%@ Control Language="VB" AutoEventWireup="false" CodeFile="MessageBox.ascx.vb" Inherits="BVAdmin_Controls_MessageBox" %>
<asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="errormessage" />
<asp:Panel runat="server" ID="pnlMain" Visible="false" EnableViewState="false">
    <div class="messagebox">
        <ul id="MessageList" runat="server" enableviewstate="false"></ul>
    </div>
</asp:Panel>
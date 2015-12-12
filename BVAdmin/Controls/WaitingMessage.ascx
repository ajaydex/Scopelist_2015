<%@ Control Language="VB" AutoEventWireup="false" CodeFile="WaitingMessage.ascx.vb" Inherits="BVAdmin_Controls_WaitingMessage" %>

<div id="wait">
    <div>
        <span>
            <asp:Literal ID="WaitingTextLiteral" runat="server" Text="Please wait..."></asp:Literal>
        </span>
        <img src="/images/system/ajax-loader.gif" alt="processing" />
    </div>
</div>

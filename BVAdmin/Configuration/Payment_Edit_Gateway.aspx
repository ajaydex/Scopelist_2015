<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Payment_Edit_Gateway.aspx.vb" Inherits="BVAdmin_Configuration_Payment_Edit_Gateway" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div style="text-align: center; margin: auto;">
        <asp:PlaceHolder ID="phEditor" runat="server"></asp:PlaceHolder>
    </div>
    <asp:HiddenField ID="GatewayIdField" runat="server" />
    <asp:HiddenField ID="MethodIdField" runat="server" />
</asp:Content>


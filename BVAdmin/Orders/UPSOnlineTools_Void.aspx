<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="UPSOnlineTools_Void.aspx.vb" Inherits="BVAdmin_Orders_UPSOnlineTools_Void"
    Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">    
    <h1>UPS<sup>&reg;</sup> Online Tools - Void A Shipment</h1>
    <uc1:MessageBox ID="msg" runat="server" />
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="formlabel">Tracking Number</td>
            <td class="formfield">
                <asp:TextBox ID="TrackingNumberField" runat="server" Columns="40">1Z</asp:TextBox> <asp:ImageButton ID="btnGo" runat="server" ImageUrl="~/BVAdmin/images/buttons/Submit.png" AlternateText="Submit Form"></asp:ImageButton>
            </td>
        </tr>
    </table>
    
</asp:Content>

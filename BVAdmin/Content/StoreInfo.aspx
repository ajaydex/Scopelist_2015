<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="StoreInfo.aspx.vb" Inherits="BVAdmin_Content_StoreInfo" title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/AddressEditor.ascx" TagName="AddressEditor" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <uc2:MessageBox ID="MessageBox1" runat="server" />
    <h1>Store Information</h1>
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="formlabel">Logo:</td>
            <td class="formfield">
                <asp:TextBox ID="LogoField" runat="server" Columns="40"></asp:TextBox>
                <a href="javascript:popUpWindow('?returnScript=SetLogoImage&WebMode=1');">
                    <asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="imgSelectLogo" />
                </a>
            </td>
        </tr>
    </table>
    <h2>Ship From Address</h2>
    <uc1:AddressEditor ID="ShipFromAddressField" runat="server" />
    <br />
    <asp:ImageButton ID="btnCancel" runat="server" imageurl="~/BVAdmin/Images/Buttons/Cancel.png" CausesValidation="false" AlternateText="Cancel" />
    &nbsp;
    <asp:ImageButton ID="btnSave" runat="server" imageurl="~/BVAdmin/Images/Buttons/SaveChanges.png" AlternateText="Save Changes" />
</asp:Content>


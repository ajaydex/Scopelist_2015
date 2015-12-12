<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Addresses.aspx.vb" Inherits="BVAdmin_Configuration_Addresses" title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Address Options</h1>
    
    <uc1:MessageBox ID="msg" runat="server" />

    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr class="rowHeader">
            <th class="Header">
            Billing Address</th>
            <th class="Header" style="width: 100px;">
            Show?</th>
            <th class="Header" style="width: 100px;">
            Required?</th>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                First Name
            </td>
            <td class="FormLabel">&nbsp;
                </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkBillRequireFirstName" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                Middle Initial
            </td>
            <td class="FormLabel"  >
                <asp:CheckBox ID="chkBillShowMiddleInitial" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
            <td class="FormLabel">&nbsp;
                </td>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                Last Name
            </td>
            <td class="FormLabel">&nbsp;
                </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkBillRequireLastName" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                Company Name&nbsp;
            </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkBillShowCompany" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkBillRequireCompany" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                Phone Number&nbsp;
            </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkBillShowPhoneNumber" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkBillRequirePhone" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                Fax Number&nbsp;
            </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkBillShowFaxNumber" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkBillRequireFax" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                Show&nbsp;Web Site URL&nbsp;
            </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkBillShowWebSiteURL" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkBillRequireWebSiteURL" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
        </tr>
   	</table>
    <br />
    <br />
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr class="rowHeader">
            <th class="Header">
            Shipping Address</th>
            <th class="Header" style="width: 100px;">
            Show?</th>
            <th class="Header" style="width: 100px;">
            Required?</th>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                First Name
            </td>
            <td class="FormLabel">&nbsp;
                </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkShipRequireFirstName" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                Middle Initial
            </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkShipShowMiddleInitial" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
            <td class="FormLabel">&nbsp;
                </td>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                Last Name
            </td>
            <td class="FormLabel">&nbsp;
                </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkShipRequireLastName" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                Company Name&nbsp;
            </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkShipShowCompany" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkShipRequireCompany" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                Phone Number&nbsp;
            </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkShipShowPhoneNumber" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkShipRequirePhone" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                Fax Number&nbsp;
            </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkShipShowFaxNumber" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkShipRequireFax" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
        </tr>
        <tr class="row">
            <td class="FormLabel">
                Web Site URL&nbsp;
            </td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkShipShowWebSiteURL" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
            <td class="FormLabel">
                <asp:CheckBox ID="chkShipRequireWebSiteURL" CssClass="FormLabel" runat="server"></asp:CheckBox></td>
        </tr>
    </table>
    
    <br />
    <br />
    
    <asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" ImageUrl="../images/buttons/Cancel.png"></asp:ImageButton>
    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="../images/buttons/OK.png"></asp:ImageButton>
</asp:Content>


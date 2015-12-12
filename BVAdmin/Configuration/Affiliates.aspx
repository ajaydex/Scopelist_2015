<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Affiliates.aspx.vb" Inherits="BVAdmin_Configuration_Affiliates" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Affiliates</h1>        
        <uc1:MessageBox ID="MessageBox1" runat="server" />
        <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
            <tr>
                <td class="formlabel wide">Default Commission:</td>
                <td class="formfield">
                     <asp:DropDownList ID="lstCommissionType" runat="server">
                        <asp:ListItem Value="1">Percentage of Sale</asp:ListItem>
                        <asp:ListItem Value="2">Flat Rate Commission</asp:ListItem>
                    </asp:DropDownList>&nbsp;
                    <asp:TextBox ID="AffiliateCommissionAmountField" Columns="3" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel wide">Allow Affiliate Themes:</td>
                <td class="formfield">
                    <asp:CheckBox ID="AffiliateThemesCheckBox" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel wide">Default Referral Days:</td>
                <td class="formfield">
                    <asp:TextBox ID="AffiliateReferralDays" Columns="5" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel wide">Conflict Resolution Mode:</td>
                <td class="formfield"><asp:DropDownList ID="AffiliateConflictModeField" runat="server">
                    <asp:ListItem Value="1">Favor Older Affiliate</asp:ListItem>
                    <asp:ListItem Value="2">Favor Newer Affiliate</asp:ListItem>
                </asp:DropDownList></td>
            </tr>
        </table>
        <br />
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
        </asp:Panel>
</asp:Content>


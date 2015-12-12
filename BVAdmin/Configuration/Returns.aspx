<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Returns.aspx.vb" Inherits="BVAdmin_Configuration_Returns" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>
        Returns</h1>        
        <uc1:MessageBox ID="MessageBox1" runat="server" />
        <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="formlabel">Enable Returns:</td>
                <td class="formfield">
                    <asp:CheckBox ID="EnableReturnsCheckBox" runat="server" /> 
                </td>
            </tr>
            <tr>
                <td class="formlabel">Automatically Approve RMA:</td>
                <td class="formfield">
                    <asp:DropDownList ID="AutomaticallyIssueRMACheckBoxList" runat="server">
                        <asp:ListItem Text="Yes" Value="1" Selected="False"></asp:ListItem>
                        <asp:ListItem Text="No" Value="0" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="formlabel" valign="top">Admin New RMA Email Template:</td>
                <td class="formfield" valign="top">
                    <asp:DropDownList ID="ddlNewRMA" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="formlabel" valign="top">Accepted RMA Email Template:</td>
                <td class="formfield" valign="top">
                    <asp:DropDownList ID="ddlAcceptedRMA" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="formlabel" valign="top">Rejected RMA Email Template:</td>
                <td class="formfield" valign="top">
                    <asp:DropDownList ID="ddlRejectedRMA" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                 <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
                    <td class="formlabel">
                        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png"
                            CausesValidation="False"></asp:ImageButton></td>
                    <td class="formfield"><asp:ImageButton ID="btnSave" CausesValidation="true"
                                runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton></td>
             </tr>
             <tr>
                 <td colspan="2">&nbsp;</td>
            </tr>
        </table>
        </asp:Panel>
</asp:Content>


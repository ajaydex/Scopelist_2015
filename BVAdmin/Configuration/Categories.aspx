<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Categories.aspx.vb" Inherits="BVAdmin_Configuration_Categories" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Category</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
            <tr>
                <td class="formlabel">Flag products as "new" </td>
                <td class="formfield"><asp:CheckBox ID="chkNewProductBadge" runat="server" /> Yes if created in last <asp:TextBox Columns="3" runat="server" id="txtNewProductBadgeDays" /> days</td>
            </tr>
            <tr>
                <td class="formlabel">Auto Regenerate Dynamic Categories:</td>
                <td class="formfield">                 
                    <asp:CheckBox ID="RegenerateDynamicCategoriesCheckBox" runat="server" /> Yes
                </td>
            </tr>
            <tr>
                <td class="formlabel"> Regeneration interval (in hours):</td>
                <td class="formfield" nowrap="nowrap">
                    <asp:TextBox ID="RegenerateIntervalTextBox" runat="server"></asp:TextBox>
                       <bvc5:BVRangeValidator ID="RangeValidator1" runat="server" ControlToValidate="RegenerateIntervalTextBox"
                        ErrorMessage="Regeneration interval must be no less than 6 hours and no more than 336 hours (2 weeks)."
                        MaximumValue="336" MinimumValue="6" Type="Integer">*</bvc5:BVRangeValidator>
                </td>
            </tr>
        </table>
        <br />
        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
        
        </asp:Panel>
</asp:Content>


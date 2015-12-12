<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="GiftCertificates.aspx.vb" Inherits="BVAdmin_Configuration_GiftCertificates" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Gift Certificates</h1>    
    <uc1:MessageBox ID="MessageBox1" runat="server" EnableViewState="false" />
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
            <tr>
                <td class="formlabel wide">Gift Certificate Minimum Amount:</td>
                <td class="formfield">
                    <asp:TextBox ID="MinimumAmountTextBox" runat="server"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Minimum Amount Required." ControlToValidate="MinimumAmountTextBox">*</bvc5:BVRequiredFieldValidator>
                    <bvc5:BVCustomValidator ID="CustomValidator1" runat="server" ControlToValidate="MinimumAmountTextBox"
                        ErrorMessage="Minimum Amount Must Be A Monetary Value.">*</bvc5:BVCustomValidator></td>
            </tr>
            <tr>
                <td class="formlabel wide">Gift Certificate Maximum Amount:</td>
                <td class="formfield">                
                    <asp:TextBox ID="MaximumAmountTextBox" runat="server"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Maximum Amount Required." ControlToValidate="MaximumAmountTextBox">*</bvc5:BVRequiredFieldValidator>
                    <bvc5:BVCustomValidator ID="CustomValidator4" runat="server" ControlToValidate="MaximumAmountTextBox"
                        ErrorMessage="Minimum Amount Must Be A Monetary Value.">*</bvc5:BVCustomValidator>
                </td>
            </tr>
            <tr>
                <td class="formlabel wide">Gift Certificate Valid Days: (Set to 0 for no expiration)</td>
                <td class="formfield">
                    <asp:TextBox ID="ValidDaysTextBox" runat="server"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Valid Days Required." ControlToValidate="ValidDaysTextBox">*</bvc5:BVRequiredFieldValidator>
                    <bvc5:BVRangeValidator ID="RangeValidator1" runat="server" ControlToValidate="ValidDaysTextBox"
                        ErrorMessage="Valid Days Must Be A Numeric Value" MaximumValue="500000" MinimumValue="0"
                        Type="Integer">*</bvc5:BVRangeValidator></td>
            </tr>
        </table>
        
        <br />
        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
        &nbsp;
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
        
    </asp:Panel>
</asp:Content>


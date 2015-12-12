<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Roles_Edit.aspx.vb" Inherits="BVAdmin_People_Roles_Edit" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
	<h1>Edit Group</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <asp:Label ID="lblError" runat="server" CssClass="errormessage"></asp:Label>
    
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSaveChanges">
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="formlabel">
                    Group Name:
                </td>
                <td class="formfield">
                    <asp:TextBox ID="RoleNameField" runat="server" Columns="30" MaxLength="100" TabIndex="2000" Width="200px"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="valRequiredUsername" runat="server" ErrorMessage="Please enter a role name" ControlToValidate="RoleNameField">*</bvc5:BVRequiredFieldValidator>
                </td>
            </tr> 
        </table>
    </asp:Panel>
    
    <h2>Permissions</h2>
    <table cellpadding="0" border="0" cellspacing="0">        
        <tr>
            <td>Assigned Permissions</td>
            <td>&nbsp;</td>
            <td>
                Available Permissions
            </td>
        </tr>
        <tr>
            <td>
                <asp:ListBox ID="PermissionList" runat="server" SelectionMode="Multiple" Rows="10" TabIndex="2700" style="width:300px!important;"></asp:ListBox>
            </td>
            <td style="padding:10px;">
                <asp:ImageButton ID="btnAddPermission" runat="server" ImageUrl="../images/buttons/left.png"></asp:ImageButton>
                <br />
                <br />
                <asp:ImageButton ID="btnRemovePermission" runat="server" ImageUrl="../images/buttons/right.png"></asp:ImageButton>
            </td>
            <td class="forminput">
                <asp:ListBox ID="AvailablePermissionsList" runat="server" SelectionMode="Multiple" Rows="10" TabIndex="2701" style="width:300px!important;"></asp:ListBox>
            </td>
        </tr>
    </table> 
    
    <br />
       
    <h2>Members</h2>
    <table cellpadding="0" border="0" cellspacing="0">        
        <tr>
            <td>Assigned Members</td>
            <td>&nbsp;</td>
            <td class="forminput">
                Non-Members
            </td>
        </tr>
        <tr>
            <td>
                <asp:ListBox ID="MemberList" runat="server" SelectionMode="Multiple" Rows="10" Width="210px" TabIndex="2700" style="width:300px!important;"></asp:ListBox>
            </td>
            <td style="padding:10px;">
                <asp:ImageButton ID="AddButton" runat="server" ImageUrl="../images/buttons/left.png"></asp:ImageButton>
                <br />
                <br />
                <asp:ImageButton ID="RemoveButton" runat="server" ImageUrl="../images/buttons/right.png"></asp:ImageButton>
            </td>
            <td class="forminput">
                <asp:ListBox ID="NonMemberList" runat="server" Width="210px" Rows="10" SelectionMode="Multiple" TabIndex="2701" style="width:300px!important;"></asp:ListBox>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <asp:ImageButton ID="btnCancel" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
    &nbsp;	
    <asp:ImageButton ID="btnSaveChanges" TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
    
    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>


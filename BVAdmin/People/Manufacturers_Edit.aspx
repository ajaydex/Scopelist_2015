<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Manufacturers_Edit.aspx.vb" Inherits="BVAdmin_People_Manufacturers_Edit"
    Title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc3" %>
<%@ Register Src="../Controls/UserPicker.ascx" TagName="UserPicker" TagPrefix="uc2" %>
<%@ Register Src="../Controls/AddressEditor.ascx" TagName="AddressEditor" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>
        Edit Manufacturer</h1>
    <div>
        <uc3:MessageBox ID="MessageBox1" runat="server" />    
    </div>
    <div style="float: right;width:450px;margin-bottom:20px;">              
        <h2>
            Address</h2>
        <uc1:AddressEditor ID="AddressEditor1" runat="server" />
    </div>    
    <asp:Label ID="lblError" runat="server" CssClass="errormessage"></asp:Label>
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSaveChanges">
        <table border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="formlabel">
                    Name:</td>
                <td class="formfield">
                    <asp:TextBox ID="DisplayNameField" runat="server" Columns="30" MaxLength="100" TabIndex="2000"
                        Width="200px"></asp:TextBox><bvc5:BVRequiredFieldValidator ID="valName" runat="server"
                            ErrorMessage="Please enter a Name" ControlToValidate="DisplayNameField">*</bvc5:BVRequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Email:</td>
                <td class="formfield">
                    <asp:TextBox ID="EmailField" runat="server" Columns="30" MaxLength="100" TabIndex="2001"
                        Width="200px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    E-mail Template:</td>
                <td class="formfield">
                    <asp:DropDownList ID="EmailTemplateDropDownList" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>            
        </table>
                    <div style="margin:50px 0px 20px 0px;width:450px;">
        <h2>Members</h2>
        <table style="margin:10px 10px 20px 10px;" class="FormTable" cellpadding="0" border="0" cellspacing="0">        
            <tr>
                <td class="forminput">
                    &nbsp;</td>
                <td class="forminput">
                    &nbsp;</td>
                <td class="forminput">
                    Add a member</td>
            </tr>
            <tr>
                <td class="forminput">
                    <asp:ListBox ID="MemberList" runat="server" SelectionMode="Multiple" Rows="7" Width="210px" TabIndex="2700">
                    </asp:ListBox></td>
                <td style="padding:10px;" valign="top" align="center"></td>                    
                <td class="forminput">
                    <uc2:UserPicker ID="UserPicker1" runat="server" />
                    </td>
            </tr>
            <tr>
                <td colspan="3" class="formfield">
                    <asp:ImageButton ID="RemoveButton" runat="server" ImageUrl="../images/buttons/remove.png">
                    </asp:ImageButton>
                </td>
            </tr>            
        </table>
        <div>
            <asp:ImageButton ID="btnCancel" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Cancel.png"
                CausesValidation="False" style="display: inline;"></asp:ImageButton>
            <asp:ImageButton ID="btnSaveChanges" TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png" style="display: inline;">
            </asp:ImageButton>
        </div>
        </div>   
    </asp:Panel>
    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>

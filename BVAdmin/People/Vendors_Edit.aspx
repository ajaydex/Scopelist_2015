<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Vendors_Edit.aspx.vb" Inherits="BVAdmin_People_Vendors_Edit" title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc3" %>
<%@ Register Src="../Controls/UserPicker.ascx" TagName="UserPicker" TagPrefix="uc2" %>
<%@ Register Src="../Controls/AddressEditor.ascx" TagName="AddressEditor" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Edit Vendor</h1>
    <uc3:MessageBox ID="MessageBox1" runat="server" />    
    <asp:Label ID="lblError" runat="server" CssClass="errormessage"></asp:Label>

    <div class="f-row">
    	<div class="six columns">
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
                            Drop Ship E-mail Template:</td>
                        <td class="formfield">
                            <asp:DropDownList ID="DropShipNotificationDropDownList" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>      
                </table>
                <div style="margin:50px 0px 20px 0px;">
                    <h2>Members</h2>

                    <div style="background:#F3F3F3; padding:20px;">
                        <table cellpadding="0" border="0" cellspacing="0" style="width:100%;">        
                            <tr>
                                <td style="width:45%;">Members</td>
                                <td style="width:10%;">&nbsp;</td>
                                <td style="width:45%;">Add a Member</td>
                            </tr>
                            <tr>
                                <td style="vertical-align:top;">
                                    <asp:ListBox ID="MemberList" runat="server" SelectionMode="Multiple" Rows="15" Width="210px" TabIndex="2700"></asp:ListBox>
                                    <asp:ImageButton ID="RemoveButton" runat="server" ImageUrl="../images/buttons/remove.png"></asp:ImageButton>
                                </td>
                                <td style="width:10px;">&nbsp;</td>                    
                                <td class="forminput">
                                    <uc2:UserPicker ID="UserPicker1" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />
                    <br />

                    <div>
                        <asp:ImageButton ID="btnCancel" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Cancel.png"
                            CausesValidation="False" style="display: inline;"></asp:ImageButton>
                        <asp:ImageButton ID="btnSaveChanges" TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png" style="display: inline;">
                        </asp:ImageButton>
                    </div>
                </div>
            </asp:Panel>
        </div>
        <div class="six columns">
            <h2>Address</h2>
            <uc1:AddressEditor ID="AddressEditor1" runat="server" />     
        </div>
    </div>

    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>


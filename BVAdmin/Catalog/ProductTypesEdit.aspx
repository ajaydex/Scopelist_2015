<%@ Page MasterPageFile="~/BVAdmin/BVAdmin.master"  ValidateRequest="False" Language="vb"
    AutoEventWireup="false" Inherits="Product_ProductTypes_Edit" CodeFile="ProductTypesEdit.aspx.vb" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Edit Product Type</h1>
    <uc1:MessageBox ID="msg" runat="server" />
    
    
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="FormLabel" align="right">
                Product Type&nbsp;Name&nbsp;
            </td>
            <td class="FormLabel" align="left">
                <asp:TextBox ID="ProductTypeNameField" runat="server" CssClass="FormInput" Columns="40"></asp:TextBox><bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Product Type Name is Required" ControlToValidate="ProductTypeNameField">*</bvc5:BVRequiredFieldValidator>
           </td>
        </tr>
   	</table>
    <br />
    <br />
    
    <table cellspacing="0" cellpadding="0" border="0" style="width: 100%;">
        <tr>
            <td valign="middle" style="width:5%;">
                <asp:ImageButton ID="btnMovePropertyUp" runat="server" AlternateText="Move Up" ImageUrl="~/BVAdmin/images/buttons/up.png">
                </asp:ImageButton>
                <br />
                <br />
                <asp:ImageButton ID="btnMovePropertyDown" runat="server" AlternateText="Move Down" ImageUrl="~/BVAdmin/images/buttons/down.png"></asp:ImageButton>
            </td>
            <td valign="top" style="width:40%;">
            	Selected&nbsp;Properties
                <div style="border: 1px solid #ccc; padding:10px;">
                	<asp:ListBox ID="lstProperties" runat="server" Rows="10" SelectionMode="Multiple"></asp:ListBox>
                </div>
            </td>
            <td valign="middle" align="center" style="width:15%;">
                <asp:ImageButton ID="btnAddProperty" runat="server" ImageUrl="~/BVAdmin/images/buttons/Add.png"></asp:ImageButton>
                <br />
                <br />
                <asp:ImageButton ID="btnRemoveProperty" runat="server" ImageUrl="~/BVAdmin/images/buttons/Remove.png"></asp:ImageButton>
            </td>
            <td valign="top" style="width:40%;">
                Available Properties
                <div style="border: 1px solid #ccc; padding:10px;">
                	<asp:ListBox ID="lstAvailableProperties" runat="server" Rows="10" SelectionMode="Multiple"></asp:ListBox>
                </div>
            </td>
        </tr>
    </table>
           
    <br />
    <br />
    <asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" AlternateText="Cancel" ImageUrl="~/BVAdmin/images/buttons/Cancel.png"></asp:ImageButton>
	&nbsp;
    <asp:ImageButton ID="btnSave" runat="server" AlternateText="Save Changes" ImageUrl="~/BVAdmin/images/buttons/SaveChanges.png"></asp:ImageButton>
       
    
</asp:Content>

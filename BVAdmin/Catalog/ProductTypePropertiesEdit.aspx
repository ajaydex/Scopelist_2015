<%@ Page MasterPageFile="~/BVAdmin/BVAdmin.Master" ValidateRequest="False" Language="vb"
    AutoEventWireup="false" Inherits="Products_ProductProperties_Edit" CodeFile="ProductTypePropertiesEdit.aspx.vb" %>

<%@ Register Src="../Controls/DatePicker.ascx" TagName="DatePicker" TagPrefix="uc2" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Edit Type Property</h1>
    <uc1:MessageBox ID="msg" runat="server" /> 
    
       
    <table class="FormTable">
        <tr>
            <td class="formlabel" >
                Property Name
            </td>
            <td class="formfield" >
                <asp:TextBox ID="PropertyNameField" runat="server" CssClass="FormInput" Columns="40"></asp:TextBox><bvc5:BVRequiredFieldValidator
                    ID="RequiredFieldValidator1" runat="server" ErrorMessage="Property Name is Required"
                    ControlToValidate="PropertyNameField">*</bvc5:BVRequiredFieldValidator></td>
        </tr>
        <tr>
            <td class="formlabel" >
                Display Name
            </td>
            <td class="formfield" >
                <asp:TextBox ID="DisplayNameField" runat="server" CssClass="FormInput" Columns="40"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel" >
                Display On Site?
            </td>
            <td class="formfield" >
                <asp:CheckBox ID="chkDisplayOnSite" runat="server"></asp:CheckBox></td>
        </tr>
        <tr>
            <td class="formlabel" >
                Display To Drop Shipper?
            </td>
            <td class="formfield" >
                <asp:CheckBox ID="chkDisplayToDropShipper" runat="server"></asp:CheckBox></td>
        </tr>
        <asp:Panel ID="pnlCultureCode" Visible="False" runat="server">
            <tr>
                <td class="formlabel" >
                    Currency Symbol
                </td>
                <td class="formfield" >
                    <asp:DropDownList ID="lstCultureCode" runat="server" CssClass="FormInput">
                    </asp:DropDownList></td>
            </tr>
        </asp:Panel>
        <tr>
            <td class="formlabel" >                
                <p id="ChoiceNote" runat="server" style="width: 150px;"></p>
            </td>
            <td class="formfield" >
                <asp:TextBox ID="DefaultValueField" runat="server" CssClass="FormInput" Columns="40"></asp:TextBox>
                <table cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td>
                            <asp:ListBox ID="lstDefaultValue" runat="server" Rows="10"></asp:ListBox></td>
                        <td style="width: 163px">
                            <asp:Panel ID="pnlChoiceControls" Visible="False" runat="server">
                                <asp:ImageButton ID="btnMoveUp" runat="server" ImageUrl="~/BVAdmin/images/buttons/up.png"
                                    AlternateText="Move Up"></asp:ImageButton>
                                <br />
                                <br />
                                <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="~/BVAdmin/images/buttons/delete.png"
                                    AlternateText="Delete"></asp:ImageButton>
                                <br />
                                <asp:TextBox ID="NewChoiceField" CssClass="FormInput" Columns="20" runat="server"></asp:TextBox>
                                <asp:ImageButton ID="btnNewChoice" runat="server" ImageUrl="~/BVAdmin/images/buttons/new.png"
                                    AlternateText="New Choice"></asp:ImageButton>
                                <br />
                                <br />
                                <asp:ImageButton ID="btnMoveDown" runat="server" ImageUrl="~/BVAdmin/images/buttons/down.png"
                                    AlternateText="Move Down"></asp:ImageButton>
                            </asp:Panel>
                            &nbsp;
                        </td>
                    </tr>
                </table>            
                <uc2:DatePicker ID="DefaultDate" runat="server" InvalidFormatErrorMessage="Date is not in a valid format."
                    RequiredErrorMessage="Date is required." />
            </td>
        </tr>
    </table>
    
    <asp:ImageButton ID="btnCancel" runat="server" AlternateText="Cancel" ImageUrl="~/BVAdmin/images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
    &nbsp;
    <asp:ImageButton ID="btnSave" runat="server" AlternateText="Save Changes" ImageUrl="~/BVAdmin/images/buttons/SaveChanges.png"></asp:ImageButton>
    
</asp:Content>

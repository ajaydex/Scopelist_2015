<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false"
    CodeFile="Countries_Edit.aspx.vb" Inherits="BVAdmin_Configuration_Countries_Edit"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>
        Edit Country</h1>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
    <div style="float: left; width: 350px;">
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSaveChanges">
        <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="formlabel">
                    Active:</td>
                <td class="formfield">
                    <asp:CheckBox id="ActiveField" TabIndex="2000" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Name:</td>
                <td class="formfield">
                    <asp:TextBox ID="DisplayNameField" runat="server" Columns="30" MaxLength="100" TabIndex="2001"
                        Width="150px"></asp:TextBox><bvc5:BVRequiredFieldValidator ID="val1" runat="server" ErrorMessage="Please enter a Name" ControlToValidate="DisplaynameField">*</bvc5:BVRequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="formlabel">
                    ISO Alpha 2 Code:</td>
                <td class="formfield">
                    <asp:TextBox ID="ISOCodeField" runat="server" Columns="5" MaxLength="2" TabIndex="2002"
                        Width="50px"></asp:TextBox>
                    <bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator1" runat="server" ControlToValidate="ISOCodeField" ValidationExpression="[A-Za-z]{2}" ErrorMessage="ISO Alpha 2 code must be 2 characters long.">*</bvc5:BVRegularExpressionValidator>
                 </td>
            </tr>
            <tr>
                <td class="formlabel">
                    ISO Alpha 3 Code:</td>
                <td class="formfield">
                    <asp:TextBox ID="ISOAlpha3Field" runat="server" Columns="5" MaxLength="3" TabIndex="2003"
                        Width="50px"></asp:TextBox>
                    <bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator2" runat="server"
                        ControlToValidate="ISOAlpha3Field" ErrorMessage="ISO Alpha 3 code must be 3 characters long."
                        ValidationExpression="[A-Za-z]{3}">*</bvc5:BVRegularExpressionValidator></td>
            </tr>
            <tr>
                <td class="formlabel">
                    ISO Numeric Code:</td>
                <td class="formfield">
                    <asp:TextBox ID="ISONumericField" runat="server" Columns="5" MaxLength="3" TabIndex="2004"
                        Width="50px"></asp:TextBox>
                    <bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator3" runat="server"
                        ControlToValidate="ISONumericField" ErrorMessage="ISO Numeric code must be 3 numbers long."
                        ValidationExpression="[0-9]{3}">*</bvc5:BVRegularExpressionValidator></td>
            </tr>                      
            <tr>
                <td class="formlabel">
                    Culture Code:</td>
                <td class="formfield">
                    <asp:DropDownList ID="CultureCodeField" TabIndex="2005" runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Postal Code Validation Regex:</td>
                <td class="formfield">
                    <asp:TextBox ID="PostalCodeValidationRegexTextBox" runat="server" Columns="5" MaxLength="255" TabIndex="2006"
                        Width="150px"></asp:TextBox>                    
                    <bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator4" runat="server"
                        ControlToValidate="PostalCodeValidationRegexTextBox" ErrorMessage="Postal validation regex must be less than 255 characters."
                        ValidationExpression=".{0,255}">*</bvc5:BVRegularExpressionValidator>
                    <bvc5:BVCustomValidator ID="BVCustomValidator1" runat="server" ControlToValidate="PostalCodeValidationRegexTextBox" EnableClientScript="false" ErrorMessage="Validation Regex is invalid.">*</bvc5:BVCustomValidator>                
                </td>
            </tr>                      
            <tr>
                <td class="formlabel">
                    <asp:ImageButton ID="btnCancel" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Cancel.png"
                        CausesValidation="False"></asp:ImageButton></td><td class="formfield"><asp:ImageButton ID="btnSaveChanges"
                            TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton></td>
            </tr>
        </table>
    </asp:Panel>
    <asp:HiddenField ID="BvinField" runat="server" />
    </div>
    <div style="float: left; width: 350px;">
        <h2>
            Regions</h2>
        <div style="text-align: right; margin-top: 3px; margin-bottom: 3px;">
            <asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New User" ImageUrl="~/BVAdmin/Images/Buttons/New.png" /></div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin"
            BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton OnClientClick="return window.confirm('Delete this region?');" ID="LinkButton1"
                            runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn-delete"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="row" />
            <HeaderStyle CssClass="rowheader" />
            <AlternatingRowStyle CssClass="alternaterow" />
        </asp:GridView>
    </div>
</asp:Content>

<%@ Page Language="VB" ValidateRequest="false" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="AdminDisplay.aspx.vb" Inherits="BVAdmin_Configuration_AdminDisplay" title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
	<h1>Site Display Settings</h1>        
        <uc1:MessageBox ID="MessageBox1" runat="server" />
        <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
            <tr>
                <td class="formlabel wide">Header Message:</td>
                <td class="formfield"><asp:TextBox ID="HeaderMessage" Columns="50" Width="300px" TextMode="MultiLine" runat="server" /></td>
            </tr>
            <tr>
                <td class="formlabel wide">WYSIWYG Editor:</td>
                <td class="formfield"><asp:DropDownList ID="TextEditorField" runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel wide">Reports Default Page:</td>
                <td class="formfield"><asp:DropDownList ID="ddlReportsDefaultPage" runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel wide">
                    Admin Side Rows Per Page:
                </td>
                <td class="formfield">
                    <asp:TextBox ID="RowsPerPageTextBox" runat="server"></asp:TextBox>
                    <bvc5:BVRegularExpressionValidator ID="RowsPerPageRegularExpressionValidator" runat="server" ErrorMessage="Rows Per Page Must Be Numeric." Text="*" ControlToValidate="RowsPerPageTextBox" Display="Dynamic" ValidationExpression="\d*"></bvc5:BVRegularExpressionValidator>
                    <bvc5:BVRequiredFieldValidator ID="RowsPerPageRequiredFieldValidator" runat="server" ErrorMessage="Rows Per Page Required." Display="Dynamic" ControlToValidate="RowsPerPageTextBox" Text="*"></bvc5:BVRequiredFieldValidator>
                    <bvc5:BVRangeValidator ID="RangeValidator1" runat="server" ControlToValidate="RowsPerPageTextBox"
                        Display="Dynamic" ErrorMessage="Rows Per Page Must Be Between 5 and 100" MaximumValue="100"
                        MinimumValue="5" Type="Integer">*</bvc5:BVRangeValidator></td>
            </tr>
            <tr>
                <td class="formlabel wide">
                    Product Long Description Editor Height:
                </td>
                <td class="formfield">
                    <asp:TextBox ID="ProductLongDescriptionHeightTextBox" runat="server"></asp:TextBox>
                    <bvc5:BVRegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Product Long Description Height Must Be Numeric." Text="*" ControlToValidate="ProductLongDescriptionHeightTextBox" Display="Dynamic" ValidationExpression="\d*"></bvc5:BVRegularExpressionValidator>
                    <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Product Long Description Height Required." Display="Dynamic" ControlToValidate="ProductLongDescriptionHeightTextBox" Text="*"></bvc5:BVRequiredFieldValidator>
                    <bvc5:BVRangeValidator ID="RangeValidator2" runat="server" ControlToValidate="ProductLongDescriptionHeightTextBox"
                        Display="Dynamic" ErrorMessage="Product Long Description Height Between 150 and 1000" MaximumValue="1000"
                        MinimumValue="150" Type="Integer">*</bvc5:BVRangeValidator>
                    pixels
                </td>
            </tr>
            <tr>
                <td class="formlabel wide">Max Category Breadcrumb Trails To Show: </td>
                <td class="formfield">
                    <asp:TextBox ID="MaxCategoriesTextBox" runat="server"></asp:TextBox>
                    <bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator1" runat="server" ErrorMessage="Max Categories Must Be Numeric." Text="*" ControlToValidate="MaxCategoriesTextBox" Display="Dynamic" ValidationExpression="\d*"></bvc5:BVRegularExpressionValidator>
                    <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator1" runat="server" ErrorMessage="Max Categories Required." Display="Dynamic" ControlToValidate="MaxCategoriesTextBox" Text="*"></bvc5:BVRequiredFieldValidator>
                    <bvc5:BVRangeValidator ID="BVRangeValidator1" runat="server" ControlToValidate="MaxCategoriesTextBox"
                        Display="Dynamic" ErrorMessage="Max Categories Must Be Between 0 and 10000" MaximumValue="10000"
                        MinimumValue="0" Type="Integer">*</bvc5:BVRangeValidator>
                    <span class="">(0 = show all trails)</span>
                </td>
            </tr>
            <tr>
                <td class="formlabel wide">Disable Admin &quot;Lights&quot; for orders:</td>
                <td class="formfield"><asp:CheckBox ID="chkDisableAdminLights" runat="server" /> Yes</td>
            </tr>
            <tr>
                <td class="formlabel wide">Reverse Order Notes:</td>
                <td class="formfield"><asp:CheckBox ID="OrderNotesCheckBox" runat="server" /> Yes</td>
            </tr>                
            <tr>
                <td class="formlabel wide">Open Store-Side Admin Panel Links in New Window:</td>
                <td class="formfield"><asp:CheckBox ID="chkStoreAdminLinksInNewWindow" runat="server" /> Yes</td>
            </tr>
            <tr>
                <td class="formlabel wide">Display Empty Type Properties:</td>
                <td class="formfield"><asp:CheckBox ID="DisplayEmptyTypePropertiesCheckBox" runat="server" /> Yes</td>
            </tr>
            <tr>
                <td class="formlabel wide">Display Kit Details Collapsed in cart:</td>
                <td class="formfield"><asp:CheckBox ID="KitDetailsCollapsedCheckBox" runat="server" /> Yes</td>
            </tr>
            <tr>
                <td class="formlabel wide">Default Product Template:</td>
                <td class="formfield"><asp:DropDownList ID="ddlProductTemplate" runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel wide">Default Kit Template:</td>
                <td class="formfield"><asp:DropDownList ID="ddlKitTemplate" runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel wide">Default Category Template:</td>
                <td class="formfield"><asp:DropDownList ID="ddlCategoryTemplate" runat="server"></asp:DropDownList></td>
            </tr>
        </table>
        
        <br />
        
		<%--<asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>--%>
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
       
        
        </asp:Panel>
</asp:Content>


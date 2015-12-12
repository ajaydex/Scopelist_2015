<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Last_Products_Viewed_editor" %>
<%@ Register Src="../../../BVAdmin/Controls/ProductPicker.ascx" TagName="ProductPicker"
    TagPrefix="uc1" %>
        &nbsp;
<div style="text-align: left;">
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnOkay">
    <h2><asp:Label ID="LVPTitle" runat="server"></asp:Label></h2>
        <table border="0" cellspacing="0" cellpadding="3">
            <tr>
                <td class="formlabel">
                    Display Type</td>
                <td class="forminput">
                    <asp:RadioButtonList ID="LPVDisplayTypeRad" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Value="0">Grid Display</asp:ListItem>
                        <asp:ListItem Value="1">List Display</asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
            <tr>
                <td class="formlabel">
                    &nbsp;Grid Columns</td>
                <td class="forminput">
                    <asp:TextBox ID="LPVGridColumnsField" runat="server" Columns="40"></asp:TextBox>
                    <bvc5:BVRegularExpressionValidator ControlToValidate="LPVGridColumnsField" runat="server" ID="valGridColumns"
                    ValidationExpression="[1-9]" Display="dynamic" ErrorMessage="Please Enter a Numeric Value" ForeColor=" " CssClass="errormessage"></bvc5:BVRegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    Pre-Html:</td>
                <td class="forminput">
                    <asp:TextBox ID="PreHtmlField" runat="server" Columns="40"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    Post-Html:</td>
                <td class="forminput">
                    <asp:TextBox ID="PostHtmlField" runat="server" Columns="40"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="formlabel">
                    &nbsp;</td>
                <td class="forminput">
                    <asp:ImageButton ID="btnOkay" runat="server" ImageUrl="~/bvadmin/images/buttons/Ok.png" />
                    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/bvadmin/images/buttons/Cancel.png" /></td>
            </tr>
        </table>
        <asp:HiddenField ID="EditBvinField" runat="server" />
    </asp:Panel>
</div>

<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Order_Activity_editor" %>
<%@ Register Src="../../../BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../../../BVAdmin/Controls/ProductPicker.ascx" TagName="ProductPicker" TagPrefix="uc1" %>

<uc2:MessageBox ID="MessageBox1" runat="server" />

<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnOkay">

    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel">
                Current Selected Status:</td>
            <td class="forminput">
                <strong><asp:Label ID="lblStatus" runat="server" /><asp:Label ID="lblValue" runat="server" /></strong>
        </td>
        </tr>
        <tr>
            <td class="formlabel">
                Select a New Status</td>
            <td class="forminput">
                <table border="0" cellpadding="3" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="True">
                                <asp:ListItem Value="1">Payment</asp:ListItem>
                                <asp:ListItem Value="2">Shipping</asp:ListItem>
                                <asp:ListItem Value="3">Other</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal">
                </asp:RadioButtonList></td>
        </tr>
        <tr>
            <td class="formlabel">
                Display Type</td>
            <td class="forminput">
                <asp:RadioButtonList ID="DisplayTypeRad" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="0">Grid Display</asp:ListItem>
                    <asp:ListItem Value="1">List Display</asp:ListItem>
                </asp:RadioButtonList></td>
        </tr>
        <tr>
            <td class="formlabel">
                &nbsp;Grid Columns</td>
            <td class="forminput">
                <asp:TextBox ID="GridColumnsField" runat="server" Columns="40"></asp:TextBox>
                <bvc5:BVRegularExpressionValidator ControlToValidate="GridColumnsField" runat="server" ID="valGridColumns"
                ValidationExpression="[0-9]" Display="dynamic" ErrorMessage="Please Enter a Numeric Value" ForeColor=" " CssClass="errormessage"></bvc5:BVRegularExpressionValidator>
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
    </table>
    <asp:HiddenField ID="EditBvinField" runat="server" />
    <br />
    <br />

    <asp:ImageButton ID="btnOkay" runat="server" ImageUrl="~/bvadmin/images/buttons/Ok.png" />
    &nbsp;
    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/bvadmin/images/buttons/Cancel.png" />

    <hr />
</asp:Panel>


<%@ Control Language="VB" AutoEventWireup="false" CodeFile="EmailAddressEntry.ascx.vb"
    Inherits="BVModules_Controls_EmailAddressEntry" %>
<%--<h2>
    Contact Information</h2>
<table>
    <tr>
        <td class="formlabel">
            E-mail Address:
        </td>
        <td class="formfield">
            <asp:TextBox ID="EmailTextBox" CssClass="E-mail Address" runat="server"></asp:TextBox>
            <bvc5:BVRequiredFieldValidator ID="EmailAddressRequiredFieldValidator" runat="server"
                EnableClientScript="True" ErrorMessage="E-mail Address Is Required." ControlToValidate="EmailTextBox"
                ForeColor=" " CssClass="errormessage" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
            <bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator1" ForeColor=" "
                CssClass="errormessage" runat="server" ControlToValidate="EmailTextBox" Display="Dynamic"
                ErrorMessage="Please enter a valid email address" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></bvc5:BVRegularExpressionValidator>
    </tr>
</table>
--%>
<div class="form-row">
    <div class="form-left">
        <span class="checkout">*</span> E-mail :
    </div>
    <div class="form-right">
        <asp:TextBox ID="EmailTextBox" CssClass="txt_fld st1" runat="server"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="EmailAddressRequiredFieldValidator" runat="server"
            EnableClientScript="True" ErrorMessage="E-mail Address Is Required." ControlToValidate="EmailTextBox"
            ForeColor=" " CssClass="errormessage" Display="None"></bvc5:BVRequiredFieldValidator>
        <bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator1" ForeColor=" "
            CssClass="errormessage" runat="server" ControlToValidate="EmailTextBox" Display="None"
            ErrorMessage="Please enter a valid email address" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></bvc5:BVRegularExpressionValidator>
    </div>
    <div class="clr">
    </div>
</div>

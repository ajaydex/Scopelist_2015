<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CreditCardInput.ascx.vb"
    Inherits="BVModules_Controls_CreditCardInput" %>
<%--<div class="creditcardinput">
    <table border="0" cellspacing="0" cellpadding="2">
        <tr>
            <td class="formlabel">
                Card Type</td>
            <td class="formfield">
                <asp:DropDownList ID="CardTypeField" runat="server">
                </asp:DropDownList>
                <bvc5:BVRequiredFieldValidator ID="CardTypeFieldBVRequiredFieldValidator" runat="server" ControlToValidate="CardTypeField" ErrorMessage="Please select a card type." Enabled="false"  Display="Dynamic" EnableClientScript="false" InitialValue="0"></bvc5:BVRequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Card Number</td>
            <td class="formfield">
                <span class="creditcardnumber">
                    <asp:TextBox ID="CardNumberField" autocomplete="off" runat="server" Columns="20" MaxLength="20"></asp:TextBox>
                    <bvc5:BVRequiredFieldValidator ID="CardNumberBVRequiredFieldValidator" runat="server" ControlToValidate="CardNumberField" ErrorMessage="Please enter a card number." Enabled="false"  Display="Dynamic" EnableClientScript="false"></bvc5:BVRequiredFieldValidator>
                </span>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Exp. Date</td>
            <td class="formfield">
                <asp:DropDownList ID="ExpMonthField" runat="server">
                </asp:DropDownList>
                <bvc5:BVRequiredFieldValidator ID="ExpMonthFieldBVRequiredFieldValidator" runat="server" ControlToValidate="ExpMonthField" ErrorMessage="Please enter an expiration month." Enabled="false"  Display="Dynamic" EnableClientScript="false" InitialValue="0"></bvc5:BVRequiredFieldValidator>
                &nbsp;/&nbsp;
                <asp:DropDownList ID="ExpYearField" runat="server">
                </asp:DropDownList>
                <bvc5:BVRequiredFieldValidator ID="ExpYearFieldBVRequiredFieldValidator" runat="server" ControlToValidate="ExpYearField" ErrorMessage="Please enter an expiration year." Enabled="false"  Display="Dynamic" EnableClientScript="false" InitialValue="0"></bvc5:BVRequiredFieldValidator>
            </td>
        </tr>
        <tr id="issueNumberRow" runat="server" visible="false">
            <td class="formlabel">
                Issue Number</td>
            <td class="formfield">
                <asp:TextBox ID="IssueNumberTextBox" runat="server" Columns="5" MaxLength="4"></asp:TextBox>&nbsp;                
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Security Code</td>
            <td class="formfield">
                <asp:TextBox ID="CVVField" autocomplete="off" runat="server" Columns="5" MaxLength="4"></asp:TextBox>&nbsp;
                <bvc5:BVRequiredFieldValidator ID="CVVFieldBVRequiredFieldValidator" runat="server" ControlToValidate="CVVField" ErrorMessage="Please enter a CVV code." Enabled="false"  Display="Dynamic" EnableClientScript="false"></bvc5:BVRequiredFieldValidator>
                <a id="cvvdesclink" runat="server" style="CURSOR: pointer" 
                onclick="JavaScript:window.open('CVV.aspx','CVV','width=400, height=400, menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no')">
                What's this?
                </a>
                </td>
        </tr> 
        <tr>
            <td class="formlabel">
                Name On Card</td>
            <td class="formfield">
                <asp:TextBox ID="CardholderNameField" runat="server" Columns="20"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="CardholderNameFieldBVRequiredFieldValidator" runat="server" ControlToValidate="CardholderNameField" ErrorMessage="Please enter a card holder name." Enabled="false" Display="Dynamic" EnableClientScript="false"></bvc5:BVRequiredFieldValidator>
            </td>
        </tr>
    </table>
</div>
--%>
<div class="form-row">
    <div class="form-left">
        <span class="checkout">*</span> Card Type :
    </div>
    <div class="form-right">
        <asp:DropDownList ID="CardTypeField" runat="server" class="fld6">
        </asp:DropDownList>
        <bvc5:BVRequiredFieldValidator ID="CardTypeFieldBVRequiredFieldValidator" runat="server"
            ControlToValidate="CardTypeField" ErrorMessage="Please select a card type." Enabled="false"
            Display="None" EnableClientScript="false" InitialValue="0"></bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <span class="checkout">*</span> Card Number :
    </div>
    <div class="form-right">
        <asp:TextBox ID="CardNumberField" autocomplete="off" runat="server" Columns="20"
            MaxLength="20" class="txt_fld st1"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="CardNumberBVRequiredFieldValidator" runat="server"
            ControlToValidate="CardNumberField" ErrorMessage="Please enter a card number."
            Enabled="false" Display="None" EnableClientScript="false"></bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <span class="checkout">*</span> Exp. Date :
    </div>
    <div class="form-right">
        <asp:DropDownList ID="ExpMonthField" runat="server" class="fld5" Width="140">
        </asp:DropDownList>
        <bvc5:BVRequiredFieldValidator ID="ExpMonthFieldBVRequiredFieldValidator" runat="server"
            ControlToValidate="ExpMonthField" ErrorMessage="Please enter an expiration month."
            Enabled="false" Display="None" EnableClientScript="false" InitialValue="0"></bvc5:BVRequiredFieldValidator>
        /
        <asp:DropDownList ID="ExpYearField" runat="server" class="fld5" Width="130">
        </asp:DropDownList>
        <bvc5:BVRequiredFieldValidator ID="ExpYearFieldBVRequiredFieldValidator" runat="server"
            ControlToValidate="ExpYearField" ErrorMessage="Please enter an expiration year."
            Enabled="false" Display="None" EnableClientScript="false" InitialValue="0"></bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row" id="issueNumberRow" runat="server" visible="false">
    <div class="form-left">
        Issue Number
    </div>
    <div class="form-right">
        <asp:TextBox ID="IssueNumberTextBox" runat="server" Columns="5" MaxLength="4"></asp:TextBox>&nbsp;
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <span class="checkout">*</span> Security Code :
    </div>
    <div class="form-right">
        <asp:TextBox ID="CVVField" autocomplete="off" runat="server" class="txt_fld st1"
            MaxLength="4" Width="150" Style="float: left"></asp:TextBox>&nbsp; <span class="whatisthis">
                <a id="cvvdesclink" runat="server" style="cursor: pointer; padding-top: 5px;" onclick="JavaScript:window.open('CVV.aspx','CVV','width=400, height=400, menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no')">
                    What's this? </a></span>
        <bvc5:BVRequiredFieldValidator ID="CVVFieldBVRequiredFieldValidator" runat="server"
            ControlToValidate="CVVField" ErrorMessage="Please enter a CVV code." Enabled="false"
            Display="None" EnableClientScript="false"></bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>
<div class="form-row">
    <div class="form-left">
        <span class="checkout">*</span> Name On Card :
    </div>
    <div class="form-right">
        <asp:TextBox ID="CardholderNameField" runat="server" class="txt_fld st1"></asp:TextBox>
        <bvc5:BVRequiredFieldValidator ID="CardholderNameFieldBVRequiredFieldValidator" runat="server"
            ControlToValidate="CardholderNameField" ErrorMessage="Please enter a card holder name."
            Enabled="false" Display="None" EnableClientScript="false"></bvc5:BVRequiredFieldValidator>
    </div>
    <div class="clr">
    </div>
</div>

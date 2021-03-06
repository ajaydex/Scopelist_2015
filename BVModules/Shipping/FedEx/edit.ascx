<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_Shipping_FedEx_edit" %>
<h1>Edit Shipping Method - FedEx</h1>
<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
<table border="0" cellspacing="0" cellpadding="3">
    <tr>
        <td class="formlabel">Name:</td>
        <td class="formfield"><asp:TextBox ID="NameField" runat="server" Width="300"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel">Service:</td>
        <td class="formfield"><asp:DropDownList ID="lstServiceCode" runat="server"></asp:DropDownList></td>
    </tr>
    <tr>
        <td class="formlabel">Packaging:</td>
        <td class="formfield"><asp:DropDownList ID="lstPackaging" runat="server"><asp:ListItem Text="FedEx Envelope" Value="1"></asp:ListItem>
        <asp:ListItem Text="FedEx Pak" Value="2"></asp:ListItem>
        <asp:ListItem Text="FedEx Box" Value="3"></asp:ListItem>
        <asp:ListItem Text="FedEx Tube" Value="4"></asp:ListItem>
        <asp:ListItem Text="FedEx 25kg Box" Value="5"></asp:ListItem>
        <asp:ListItem Text="FedEx 10kg Box" Value="6"></asp:ListItem>
        <asp:ListItem Text="Your Packaging" Value="7"></asp:ListItem></asp:DropDownList></td>
    </tr>
    <tr>
        <td colspan="2">
            <h2>
                Global Settings</h2>&nbsp;<br />
            To Obtain a FedEx Production Key/Password/Account/Meter visit:<br />
            <a href="https://www.fedex.com/wpor/web/jsp/commonTC.jsp" target="_blank">https://www.fedex.com/wpor/web/jsp/commonTC.jsp</a><br />
            &nbsp;<br />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Key:</td>
        <td class="formfield"><asp:TextBox ID="KeyField" runat="server" Width="300"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel">Password:</td>
        <td class="formfield"><asp:TextBox ID="PasswordField" runat="server" Width="300"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel">Account Number:</td>
        <td class="formfield"><asp:TextBox ID="AccountNumberField" runat="server" Width="300"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel">Meter Number:</td>
        <td class="formfield"><asp:TextBox ID="MeterNumberField" runat="server" Width="300"></asp:TextBox></td>
    </tr>
     <tr>
        <td class="formlabel">Default Packaging:</td>
        <td class="formfield"><asp:DropDownList ID="lstDefaultPackaging" runat="server">
        <asp:ListItem Text="FedEx Envelope" Value="1"></asp:ListItem>
        <asp:ListItem Text="FedEx Pak" Value="2"></asp:ListItem>
        <asp:ListItem Text="FedEx Box" Value="3"></asp:ListItem>
        <asp:ListItem Text="FedEx Tube" Value="4"></asp:ListItem>
        <asp:ListItem Text="FedEx 25kg Box" Value="5"></asp:ListItem>
        <asp:ListItem Text="FedEx 10kg Box" Value="6"></asp:ListItem>
        <asp:ListItem Text="Your Packaging" Value="7"></asp:ListItem>
        </asp:DropDownList></td>
    </tr>
    <tr>
        <td class="formlabel">Use List Rates:</td>
        <td class="formfield"><asp:CheckBox ID="chkListRates" runat="server" /></td>
    </tr>
    <tr>
        <td class="formlabel">Drop Off Type:</td>
        <td class="formfield"><asp:DropDownList ID="lstDropOffType" runat="server">
        <asp:ListItem Text="Regular Pickup" Value="1"></asp:ListItem>
        <asp:ListItem Text="Request Courier" Value="2"></asp:ListItem>
        <asp:ListItem Text="Drop Box" Value="3"></asp:ListItem>
        <asp:ListItem Text="Business Service Center" Value="4"></asp:ListItem>
        <asp:ListItem Text="Station" Value="5"></asp:ListItem>
        </asp:DropDownList></td>
    </tr>
    <tr>
        <td class="formlabel">Force Residential Rates:</td>
        <td class="formfield"><asp:CheckBox ID="chkResidential" runat="server" /></td>
    </tr>
    <tr>
        <td class="formlabel">Diagnostics Mode:</td>
        <td class="formfield"><asp:CheckBox ID="chkDiagnostics" runat="server" /></td>
    </tr>
    <tr>
        <td colspan="2">
            <h2>
                Adjustments</h2>
        </td>
    </tr>
    <tr>
        <td class="formlabel">
            Adjust price by:
        </td>
        <td class="formfield">
            <asp:TextBox ID="AdjustmentTextBox" runat="server" Columns="5"></asp:TextBox>
            &nbsp;<bvc5:BVCustomValidator ID="CustomValidator1" runat="server" ControlToValidate="AdjustmentTextBox"
                ErrorMessage="Adjustment is not in the correct format.">*</bvc5:BVCustomValidator>
            <asp:DropDownList ID="AdjustmentDropDownList" runat="server">
                <asp:ListItem Selected="True" Value="1">Amount</asp:ListItem>
                <asp:ListItem Value="2">Percentage</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="formlabel">
            <asp:ImageButton ID="btnCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
        <td class="formfield">
            <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
    </tr>
</table></asp:Panel>
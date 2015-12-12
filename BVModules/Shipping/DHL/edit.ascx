<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_Shipping_DHL_edit" %>
<h1>Edit Shipping Method - DHL</h1>
<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
<asp:HyperLink ID="lnkSignup" runat="server" NavigateUrl="~/BVAdmin/Configuration/Shipping_DHLSignup.aspx" runat="server">
    Not yet registered? Click here to sign up!
</asp:HyperLink><br /><br />
<table border="0" cellspacing="0" cellpadding="3">
    <tr>
        <td class="formlabel">Name:</td>
        <td class="formfield"><asp:TextBox ID="NameField" runat="server" Width="300"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel">Rate Type:</td>
        <td class="formfield">
            <asp:RadioButtonList ID="rblRateType" AutoPostBack="true" runat="server">
                <asp:ListItem Value="0">Non-Dutiable</asp:ListItem>
                <asp:ListItem Value="1">Dutiable</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Service:</td>
        <td class="formfield">
            <asp:CheckBoxList ID="chkNonDutiableServiceCode" Visible="false" runat="server"></asp:CheckBoxList>
            <asp:CheckBoxList ID="chkDutiableServiceCode" Visible="false" runat="server"></asp:CheckBoxList>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Packaging:</td>
        <td class="formfield">
            <asp:DropDownList ID="lstPackaging" runat="server">
                <asp:ListItem Text="Flyers/Smalls" Value="FLY"></asp:ListItem>
                <asp:ListItem Text="Parcels/Conveyables" Value="COY"></asp:ListItem>
                <asp:ListItem Text="Non-Conveyables" Value="NCY"></asp:ListItem>
                <asp:ListItem Text="Pallets" Value="PAL"></asp:ListItem>
                <asp:ListItem Text="Double Pallets" Value="DBL"></asp:ListItem>
                <asp:ListItem Text="Boxes" Value="BOX"></asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <h2>
                Global Settings</h2>&nbsp;<br />
           <em></em>
            &nbsp;<br />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Site ID:</td>
        <td class="formfield"><asp:TextBox ID="SiteIDField" runat="server" Width="300"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="formlabel">Password:</td>
        <td class="formfield"><asp:TextBox ID="PasswordField" runat="server" Width="300"></asp:TextBox></td>
    </tr>
     <tr>
        <td class="formlabel">Default Packaging:</td>
        <td class="formfield"><asp:DropDownList ID="lstDefaultPackaging" runat="server">
                <asp:ListItem Text="Flyers/Smalls" Value="FLY"></asp:ListItem>
                <asp:ListItem Text="Parcels/Conveyables" Value="COY"></asp:ListItem>
                <asp:ListItem Text="Non-Conveyables" Value="NCY"></asp:ListItem>
                <asp:ListItem Text="Pallets" Value="PAL"></asp:ListItem>
                <asp:ListItem Text="Double Pallets" Value="DBL"></asp:ListItem>
                <asp:ListItem Text="Boxes" Value="BOX"></asp:ListItem>
        </asp:DropDownList></td>
    </tr>
    <tr>
        <td class="formlabel">Payment Account Number</td>
        <td class="formfield">
            <asp:TextBox ID="PaymentAccountNumberField" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Diagnostics Mode:</td>
        <td class="formfield"><asp:CheckBox ID="chkDiagnostics" runat="server" /></td>
    </tr>
    <tr>
        <td class="formlabel">Test Mode:</td>
        <td class="formfield"><asp:CheckBox ID="chkTest" runat="server" /></td>
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
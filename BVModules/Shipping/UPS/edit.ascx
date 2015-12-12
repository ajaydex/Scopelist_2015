<%@ Control Language="VB" AutoEventWireup="false" CodeFile="edit.ascx.vb" Inherits="BVModules_Shipping_UPS_edit" %>
<h1>
    Edit Shipping Method - UPS</h1>
<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
    <table border="0" cellspacing="0" cellpadding="3">
        <tr>
            <td colspan="2">
                <h2>
                    Provider Specific Settings</h2>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Name:</td>
            <td class="formfield">
                <asp:TextBox ID="NameField" runat="server" Width="300"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel">
                Shipping Types:
            </td>
            <td class="formfield">
                <asp:CheckBoxList ID="ShippingTypesCheckBoxList" runat="server">
                    <asp:ListItem Enabled="true" Selected="false" Text="Next Day Air" Value="NextDayAir"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Second Day Air" Value="SecondDayAir"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Ground" Value="Ground"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Worldwide Express" Value="WorldwideExpress"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Worldwide Expedited" Value="WorldwideExpedited"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Standard" Value="Standard"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Three Day Select" Value="ThreeDaySelect"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Next Day Air Saver" Value="NextDayAirSaver"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Next Day Air Early AM" Value="NextDayAirEarlyAM"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Worldwide Express Plus" Value="WorldwideExpressPlus"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Second Day Air AM" Value="SecondDayAirAM"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Express Saver" Value="ExpressSaver"></asp:ListItem>
                </asp:CheckBoxList>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <h2>
                    Global Provider Settings</h2>
            </td>
        </tr>
        <tr>
            <td class="formfield">Registration Status:</td>
            <td class="forminput"><asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/BVAdmin/Configuration/Shipping_UpsLicense.aspx"></asp:HyperLink></td>
        </tr>
        <tr>
            <td class="formlabel">
                Account Number:</td>
            <td class="formfield">
                <asp:TextBox ID="AccountNumberField" runat="server" Width="300"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel">
                Force Residential Addresses:
            </td>
            <td class="formfield">
                <asp:CheckBox ID="ResidentialAddressCheckBox" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Don't use package dimensions, only weight:
            </td>
            <td class="formfield">
                <asp:CheckBox ID="SkipDimensionsCheckBox" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Pickup Type:
            </td>
            <td class="formfield">
                <asp:RadioButtonList ID="PickupTypeRadioButtonList" runat="server">
                    <asp:ListItem Enabled="true" Selected="true" Text="Daily Pickup" Value="1"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Customer Counter" Value="3"></asp:ListItem>
                    <asp:ListItem Enabled="true" Selected="false" Text="Suggested Retail Rate" Value="11"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Default Service:
            </td>
            <td class="formfield">
                <asp:DropDownList runat="server" ID="DefaultServiceField">
                    <asp:ListItem Value="3">UPS Ground</asp:ListItem>
                    <asp:ListItem Value="1">UPS Next Day Air&#174;</asp:ListItem>
                    <asp:ListItem Value="13">UPS Next Day Air Saver&#174;</asp:ListItem>
                    <asp:ListItem Value="14">UPS Next Day Air&#174; Early A.M.&#174;</asp:ListItem>
                    <asp:ListItem Value="2">UPS 2nd Day Air&#174;</asp:ListItem>
                    <asp:ListItem Value="59">UPS 2nd Day Air A.M.&#174;</asp:ListItem>
                    <asp:ListItem Value="12">UPS 3 Day Select (sm)</asp:ListItem>
                    <asp:ListItem Value="65">UPS Express Saver (sm)</asp:ListItem>
                    <asp:ListItem Value="7">UPS Worldwide Express (sm)</asp:ListItem>
                    <asp:ListItem Value="54">UPS Worldwide Express Plus (sm)</asp:ListItem>
                    <asp:ListItem Value="8">UPS Worldwide Expedited (sm)</asp:ListItem>
                    <asp:ListItem Value="11">UPS Standard</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Default Packaging:
            </td>
            <td class="formfield">
                <asp:DropDownList runat="server" ID="DefaultPackagingField">
                    <asp:ListItem Value="2">Customer Supplied</asp:ListItem>
                    <asp:ListItem Value="1">UPS Letter</asp:ListItem>
                    <asp:ListItem Value="3">UPS Tube</asp:ListItem>
                    <asp:ListItem Value="4">UPS Pak</asp:ListItem>
                    <asp:ListItem Value="21">UPS Express Box</asp:ListItem>
                    <asp:ListItem Value="25">UPS 10Kg Box</asp:ListItem>
                    <asp:ListItem Value="24">UPS 25Kg Box</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                Default Payment Method:
            </td>
            <td class="formfield">
                <asp:DropDownList runat="server" ID="DefaultPaymentField">
                    <asp:ListItem Value="1">Shipper's UPS Account</asp:ListItem>
                    <asp:ListItem Value="2">Credit Card</asp:ListItem>
                    <asp:ListItem Value="4">Receiver's UPS Account</asp:ListItem>
                    <asp:ListItem Value="3">Third Party's UPS Account</asp:ListItem>
                </asp:DropDownList>
            </td>
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
    </table>
</asp:Panel>

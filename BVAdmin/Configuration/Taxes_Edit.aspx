<%@ Page MasterPageFile="~/BVAdmin/BVAdminSetting.master" ValidateRequest="False" Language="vb"
    AutoEventWireup="false" Inherits="Taxes_edit" CodeFile="Taxes_Edit.aspx.vb" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    
    <h1>Edit Tax</h1>
    <uc1:MessageBox ID="msg" runat="server" />
    
    <h2>Apply this tax to</h2>
    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel" valign="top" align="right">
                Country
            </td>
            <td class="formfield" valign="top" align="left">
                <asp:DropDownList ID="lstCountry" TabIndex="300" runat="server" AutoPostBack="True">
                </asp:DropDownList>&nbsp;<asp:ImageButton ID="btnCountry" runat="server" ImageUrl="../images/buttons/Select.png">
                </asp:ImageButton></td>
        </tr>
        <tr>
            <td class="formlabel" valign="top" align="right">
                State/Region
            </td>
            <td class="formfield" valign="top" align="left">
                <asp:DropDownList ID="lstState" TabIndex="1000" runat="server" AutoPostBack="true">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="formlabel" valign="top" align="right">
                County
            </td>
            <td class="formfield" valign="top" align="left">
                <asp:DropDownList ID="lstCounty" TabIndex="1000" runat="server">
                <asp:ListItem Text="All Counties" Value="0"></asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="formlabel" valign="top" align="right">
                Postal/Zip Code
            </td>
            <td class="formfield" valign="top" align="left">
                <asp:TextBox ID="postalCode" TabIndex="1100" runat="server" CssClass="FormInput"
                    Columns="10"></asp:TextBox>&nbsp;<br />
                (leave postal code blank to apply tax to the whole country, state, or county)</td>
        </tr>
        <tr>
            <td class="formlabel" valign="top" align="right">
                Rate&nbsp;
            </td>
            <td class="formfield" valign="top" align="left">
                <asp:TextBox ID="Rate" TabIndex="1200" runat="server" CssClass="FormInput" Columns="10"></asp:TextBox>&nbsp;%</td>
        </tr>
        <tr>
            <td class="formlabel" valign="top" align="right">
                Apply to Items of Type&nbsp;
            </td>
            <td class="formfield" valign="top" align="left">
                <asp:DropDownList ID="lstTypes" TabIndex="1300" runat="server">
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="formlabel" valign="top" align="right">
                Apply to Shipping&nbsp;
            </td>
            <td class="formfield" valign="top" align="left">
                <asp:CheckBox ID="ApplyToShippingCheckBox" runat="server" /> Yes
            </td>
        </tr>
  	</table>
    
    <br />
    <asp:ImageButton ID="btnCancel" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
    &nbsp;
    <asp:ImageButton ID="btnCreateAccount" TabIndex="2500" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
     
</asp:Content>

<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Languages.aspx.vb" Inherits="BVAdmin_Configuration_Languages" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Languages</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
            <tr>
                <td class="formlabel wide">Store Home Country:</td>
                <td class="formfield">
                    <asp:DropDownList ID="lstSiteCountry" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel wide">Size Units:</td>
                <td class="formfield">
                    <asp:DropDownList ID="SiteShippingLengthTypeField" runat="server">
                    <asp:ListItem Value="1" Text="Inches"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Centimeters"></asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="formlabel wide">Weight Units:</td>
                <td class="formfield">
                    <asp:DropDownList ID="SiteShippingWeightTypeField" runat="server">
                    <asp:ListItem Value="1" Text="Pounds"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Kilograms"></asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
        </table>
        
        <br />  
        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
        &nbsp;
        <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
   	</asp:Panel>
</asp:Content>


<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="InventoryNotices.aspx.vb" Inherits="BVAdmin_Configuration_InventoryNotices" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Inventory</h1>        
        <uc1:MessageBox ID="MessageBox1" runat="server" />
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel wide">Send Low Stock Notice Every</td>
            <td class="formfield">
                <asp:TextBox ID="LowStockHoursTextBox" runat="server"></asp:TextBox> Hours
                <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Low Stock Hours Required. Enter 0 To Turn Off." Text="*" Display="Dynamic" ControlToValidate="LowStockHoursTextBox" CssClass="errormessage"></bvc5:BVRequiredFieldValidator>                
            </td>
        </tr>                
        <tr>
            <td class="formlabel wide">Email Report To:</td>
            <td class="formfield">
                <asp:TextBox ID="EmailReportToTextBox" runat="server"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator3" runat="server" ControlToValidate="EmailReportToTextBox" EnableClientScript="True" ErrorMessage="E-mail Address Is Required." ForeColor=" " CssClass="errormessage" Display="Dynamic"></bvc5:BVRequiredFieldValidator>
                <bvc5:BVRegularExpressionValidator ID="BVRegularExpressionValidator4" ForeColor=" " CssClass="errormessage"
                    runat="server" ControlToValidate="EmailReportToTextBox" Display="Dynamic" ErrorMessage="Please enter a valid email address"
                    ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"></bvc5:BVRegularExpressionValidator>    
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Inventory Low Report Line Prefix:</td>
            <td class="formfield">
                <asp:TextBox ID="LinePrefixTextBox" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide"></td>
            <td class="formfield">
                <asp:ImageButton ID="SendLowStockReportImageButton" ImageUrl="~/BVAdmin/Images/Buttons/RunNow.png" AlternateText="Run Report Now" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">Disable Inventory:</td>
            <td class="formfield">
                <asp:CheckBox ID="chkDisableInventory" runat="server" /> Yes</td>
        </tr>
        <tr>
            <td class="formlabel wide">Reserve Inventory on:</td>
            <td class="formfield"><asp:DropDownList runat="server" ID="lstInventoryMode">
            <asp:ListItem Value="1" Text="Order Saved"></asp:ListItem>
            <asp:ListItem Value="2" Text="Add To Cart"></asp:ListItem>
            </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="formlabel wide">Track Inventory On New Products:</td>
            <td class="formfield"><asp:CheckBox ID="TrackInventoryNewProductsCheckBox" runat="server" /> Yes</td>
        </tr>
        <tr>
            <td class="formlabel wide">Default Inventory Mode For New Products:</td>
            <td class="formfield">
                <asp:DropDownList runat="server" ID="DefaultInventoryModeDropDownList">          
                    <asp:ListItem Value="0" Text="Remove From Store"></asp:ListItem>
                    <asp:ListItem Value="1" Text="Leave On Store"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Out Of Stock Allow Orders"></asp:ListItem>
                    <asp:ListItem Value="3" Text="Out Of Stock Disallow Orders"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
  	</table>
  	
    <br />
	<asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
    &nbsp;
    <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
           
    </asp:Panel>
</asp:Content>


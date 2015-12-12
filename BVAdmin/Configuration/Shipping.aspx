<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Shipping.aspx.vb" Inherits="BVAdmin_Configuration_Shipping" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Shipping Methods</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" EnableViewState="false" />
        
    <h3 style="margin-bottom: 5px;">Create New</h3>
    <asp:DropDownList ID="lstProviders" runat="Server"></asp:DropDownList>
    <asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New Shipping Method" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
    <br />
    <h3 style="margin-bottom: 5px;">Available Methods</h3>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton OnClientClick="return window.confirm('Delete this Shipping Method?');" ID="LinkButton1"
                        runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn-delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <div class="messagebox">
            	<ul>
                	<li>None defined.</li>
                </ul>
            </div>
        </EmptyDataTemplate>
 
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView> 
        
    <hr />
        
    <div class="controlarea1">
        <h2 style="margin-bottom: 5px;">Handling</h2>
        <table class="linedTable" cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td class="formlabel">Handling Fee Amount</td>
                <td class="formfield">
                    <asp:TextBox ID="HandlingFeeAmountTextBox" runat="server"></asp:TextBox>
                    <asp:RadioButtonList ID="HandlingRadioButtonList" runat="server">
                        <asp:ListItem Value="0">Per Item</asp:ListItem>
                        <asp:ListItem Value="1">Per Order</asp:ListItem>
                    </asp:RadioButtonList>
                    <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Handling Fee Amount Is Required." ControlToValidate="HandlingFeeAmountTextBox" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>
                    <bvc5:BVCustomValidator ID="HandlingFeeAmountCustomValidator" runat="server" ErrorMessage="Handling Fee Must Be A Monetary Amount." ControlToValidate="HandlingFeeAmountTextBox" Display="Dynamic">*</bvc5:BVCustomValidator>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Charge Handling On Non-Shipping Items</td>
                <td class="formfield">
                    <asp:CheckBox ID="NonShippingCheckBox" runat="server" />
                </td>
            </tr>
        </table>
        <br /><br />
        <h2 style="margin-bottom: 5px;">Package Dimensions</h2>
        <table class="linedTable" cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td class="formlabel">Dimension Calculator</td>
                <td class="formfield">
                    <asp:DropDownList ID="ddlDimensionCalculator" runat="server" />
                </td>
            </tr>
        </table>

        <br />
        <asp:ImageButton ID="CancelImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" CausesValidation="False" />
        &nbsp;
        <asp:ImageButton ID="SaveImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /> 
    </div>
</asp:Content>
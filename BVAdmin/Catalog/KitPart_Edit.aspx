<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="KitPart_Edit.aspx.vb" Inherits="BVAdmin_Catalog_KitPart_Edit" Title="Untitled Page" %>

<%@ Register Src="../Controls/ProductPicker.ascx" TagName="ProductPicker" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Edit Kit Part</h1>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
    <table border="0" cellspacing="0" cellpadding="5">
        <tr>
            <td valign="top">
                <table border="0" cellspacing="0" cellpadding="3">
                    <tr>
                        <td colspan="2">
                            <asp:Label ID="lblError" CssClass="errormessage" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Kit Quantity:</td>
                        <td class="formfield">
                            <asp:TextBox runat="server" ID="QuantityField" Width="100px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Product:</td>
                        <td class="formfield">
                            <asp:Label ID="lblProduct" Text="No Product Selected" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Selected:</td>
                        <td class="formfield">
                            <asp:CheckBox runat="server" ID="SelectedCheckBox" />                            
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Display Name:</td>
                        <td class="formfield">
                            <asp:TextBox runat="server" ID="DisplaynameField" Width="300"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Price:</td>
                        <td class="formfield">
                            <asp:TextBox runat="server" ID="PriceField" Width="100px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Price Type:
                        </td>
                        <td class="formfield">
                            <asp:DropDownList runat="server" ID="PriceTypeDropDownList">
                                <asp:ListItem Text="Fixed" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Adjustment" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                            <bvc5:BVCustomValidator ID="PriceTypeBVCustomValidator" runat="server" ControlToValidate="PriceTypeDropDownList"
                                ErrorMessage="Price type must be fixed if no product is selected"></bvc5:BVCustomValidator>
                        </td>                            
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Weight:</td>
                        <td class="formfield">
                            <asp:TextBox runat="server" ID="WeightField" Width="100px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Weight Type:
                        </td>
                        <td class="formfield">
                            <asp:DropDownList runat="server" ID="WeightTypeDropDownList">
                                <asp:ListItem Text="Fixed" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Adjustment" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                            <bvc5:BVCustomValidator ID="WeightTypeBVCustomValidator" runat="server" ControlToValidate="WeightTypeDropDownList"
                                ErrorMessage="Weight type must be fixed if no product is selected."></bvc5:BVCustomValidator>
                        </td>                                                    
                    </tr>                   
                    <tr>
                        <td class="formlabel">
                            <asp:ImageButton ID="btnCancel" runat="server" AlternateText="Cancel" CausesValidation="false"
                                ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" /></td>
                        <td class="formfield">
                            <asp:ImageButton ID="btnSave" runat="server" AlternateText="Save Changes" CausesValidation="true"
                                ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" /></td>
                    </tr>
                </table>
            </td>
            <td valign="top" class="controlarea2">
                <asp:ImageButton ID="btnSelect" ImageUrl="~/BVAdmin/Images/Buttons/Select.png" AlternateText="Select Product"
                    runat="server" /><uc1:ProductPicker ID="ProductPicker1" runat="server" DisplayKits="false"
                    IsMultiSelect="False" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="ProductBvinField" runat="server" />
</asp:Content>

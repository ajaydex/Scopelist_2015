<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_Offers_Buy_One_Get_One_Edit" %>
<%@ Register Src="../../../BVAdmin/Controls/PercentAmountSelection.ascx" TagName="PercentAmountSelection"
    TagPrefix="uc2" %>
<%@ Register Src="../../../BVAdmin/Controls/ProductPicker.ascx" TagName="ProductPicker"
    TagPrefix="uc1" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>


<h2>Buy One Get One Free</h2>
<table cellspacing="0" cellpadding="0" border="0" class="linedTable">
    <tr>
        <td class="formlabel wide">
            Discount items By
        </td>
        <td class="formfield" colspan="2">
            <uc2:PercentAmountSelection ID="PercentAmountSelection" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel wide">
            Automatically Add Item to Cart
        </td>
        <td class="formfield" colspan="2">
            <asp:CheckBox ID="chkAutomaticallyAdd" runat="server" />
        </td>
    </tr>
</table>

<br />
<br />

<h2>Products which have to be purchased</h2>
<div style="background: #fff;padding: 10px;">
    <table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
        <tr>
            <td style="width:40%;">
                <asp:GridView ID="PurchasedProductsGridView" runat="server" AutoGenerateColumns="False" GridLines="none" style="width:100%;"> 
                    <EmptyDataTemplate>
                        There are no selected products.
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="SelectedCheckBox" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ProductName" HeaderText="Name" />
                        <asp:BoundField HeaderText="Sku" DataField="Sku" />
                    </Columns>
                    <RowStyle CssClass="row" />
                    <HeaderStyle CssClass="rowheader" />
                    <AlternatingRowStyle CssClass="alternaterow" />
                </asp:GridView>
            
                <bvc5:BVCustomValidator ID="CustomValidator1" runat="server" Display="None" ErrorMessage="Products cannot be both required purchases and discounts." />
            </td>
        
            <td style="width:20px;text-align:center;">
                <asp:ImageButton ID="AddPurchasedProductsImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Add.png" CausesValidation="False" />
                <br />
                <br />
                <asp:ImageButton ID="RemovePurchasedProductsImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Remove.png" CausesValidation="False" />
            </td>
        
            <td style="width:40%;">
                <uc1:ProductPicker ID="PurchasedProductPicker" runat="server" Visible="true" DisplayPrice="true" />
            </td>
        </tr>
    </table>
</div>


<hr />

<h2>Products which will be discounted</h2>
<div style="background: #fff;padding: 10px;">
    <table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
        <tr>
            <td style="width:40%;">        
                <asp:GridView ID="DiscountedProductsGridView" runat="server" AutoGenerateColumns="False" Gridlines="none" style="width:100%;">
                    <EmptyDataTemplate>
                        There are no selected products.
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="SelectedCheckBox" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ProductName" HeaderText="Name" />
                        <asp:BoundField HeaderText="Sku" DataField="Sku" />
                    </Columns>
                    <RowStyle CssClass="row" />
                    <HeaderStyle CssClass="rowheader" />
                    <AlternatingRowStyle CssClass="alternaterow" />
                </asp:GridView>
            </td>
            <td style="width:20%;text-align:center;">
                <asp:ImageButton ID="AddDiscountedProductsImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Add.png" CausesValidation="False" />
                <br /><br />
                <asp:ImageButton ID="RemoveDiscountedProductsImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Remove.png" CausesValidation="False" />
            </td>
            <td style="width:40%;">
                <uc1:ProductPicker ID="DiscountedProductPicker" runat="server" Visible="true" DisplayPrice="true" />
            </td>
        </tr>
    </table>
</div>

<br />
<br />

<table cellspacing="0" cellpadding="0" border="0" style="width:100%;" class="linedTable">
    <tr>
        <td class="formlabel wide">
            If quantity ordered is >=
        </td>
        <td class="formfield">
            <asp:TextBox ID="OrderQuantityTextBox" runat="server"></asp:TextBox><bvc5:BVRegularExpressionValidator
                ID="OrderQuantityRegularExpressionValidator" runat="server" ErrorMessage="Quantity ordered must be a whole number greater than 1."
                ValidationExpression="[1-9]\d{0,49}" ControlToValidate="OrderQuantityTextBox">*</bvc5:BVRegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td class="formlabel">
            and the order total is >=
        </td>
        <td class="formfield">
            <asp:TextBox ID="OrderTotalTextBox" runat="server"></asp:TextBox>
            <bvc5:BVCustomValidator
                ID="OrderTotalCustomValidator" runat="server" ErrorMessage="Order amount must be a monetary amount."
                ControlToValidate="OrderTotalTextBox" >*</bvc5:BVCustomValidator>
        </td>
    </tr>
    <tr>
        <td class="formlabel">
            and the order total is <=</td>
        <td class="formfield">
            <asp:TextBox ID="OrderTotalMaxTextBox" runat="server"></asp:TextBox>
            <bvc5:BVCustomValidator ID="OrderTotalMaxCustomValidator" runat="server" ErrorMessage="Order amount must be a monetary amount."
                ControlToValidate="OrderTotalMaxTextBox" >*</bvc5:BVCustomValidator>
            <bvc5:BVCustomValidator ID="OrderTotalMaxCustomValidator2" runat="server" ErrorMessage="Max order total must be less than min order total."
                ControlToValidate="OrderTotalMaxTextBox" >*</bvc5:BVCustomValidator>
        </td>
    </tr>
</table>
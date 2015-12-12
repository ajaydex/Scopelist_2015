<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_Offers_Product_s__Fixed_Price_Edit" %>
<%@ Register Src="../../../BVAdmin/Controls/PercentAmountSelection.ascx" TagName="PercentAmountSelection" TagPrefix="uc2" %>
<%@ Register Src="../../../BVAdmin/Controls/ProductPicker.ascx" TagName="ProductPicker" TagPrefix="uc1" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc3" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<h2>Product(s) Fixed Price</h2>

<uc3:MessageBox ID="fileMsg" runat="server" />

<div style="background: #fff;padding: 10px;">
    <table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
        <tr>
            <td style="width:40%;">
                <anthem:GridView ID="SelectedProductsGridView" runat="server" AutoGenerateColumns="False" AutoUpdateAfterCallBack="True" UpdateAfterCallBack="True" GridLines="none">
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
                        <asp:BoundField HeaderText="Site Price" DataField="SitePrice" DataFormatString="{0:c}" />
                        <asp:TemplateField HeaderText="Discount Price">
                            <ItemTemplate>
                                <asp:TextBox ID="discountTextbox" runat="server" EnableViewState="true" />
                                <bvc5:BVRequiredFieldValidator ID="discountRequired" Display="Dynamic" ErrorMessage="Discount price required."  ControlToValidate="discountTextbox" runat="server"></bvc5:BVRequiredFieldValidator>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="row" />
                    <HeaderStyle CssClass="rowheader" />
                    <AlternatingRowStyle CssClass="alternaterow" />
                </anthem:GridView>
            
                <bvc5:BVCustomValidator ID="CustomValidator1" runat="server" Display="None" ErrorMessage="Products cannot be both required purchases and discounts." />
            </td>
        
            <td style="width:20px;text-align:center;">
                <asp:ImageButton ID="AddProductsImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Add.png" EnableCallBack="true" />
                <br />
                <br />
                <anthem:ImageButton ID="RemoveProductsImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Remove.png" EnableCallBack="true" />
            </td>
        
            <td style="width:40%;">
                <asp:Label ID="lblFileUpload" AssociatedControlID="fileUpload" runat="server">Bulk Upload: </asp:Label>
                <asp:FileUpload ID="fileUpload" runat="server" /><br />
                <asp:ImageButton ID="fileSave" ImageUrl="~/BVAdmin/Images/Buttons/upload.png" AlternateText="Upload File" runat="server" />
                <br />
                <br />

                <uc1:ProductPicker ID="ProductPicker2" runat="server" Visible="true" DisplayPrice="true" />
            </td>
        </tr>
    </table>
</div>

<anthem:Label runat='server' ID="anthemlabel" AutoUpdateAfterCallBack="true"></anthem:Label>

<table cellspacing="0" cellpadding="0" border="0" class="linedTable">
<tr>
    <td class="formlabel">
        If quantity ordered is >=</td>
    <td class="formfield">
        <asp:TextBox ID="OrderQuantityTextBox" runat="server"></asp:TextBox><bvc5:BVRegularExpressionValidator
            ID="OrderQuantityRegularExpressionValidator" runat="server" ErrorMessage="Quantity ordered must be a whole number greater than 1."
            ValidationExpression="[1-9]\d{0,49}" ControlToValidate="OrderQuantityTextBox">*</bvc5:BVRegularExpressionValidator></td>
</tr>
<tr>
    <td class="formlabel">
        and the order total is >=</td>
    <td class="formfield">
        <asp:TextBox ID="OrderTotalTextBox" runat="server"></asp:TextBox><bvc5:BVCustomValidator
            ID="OrderTotalCustomValidator" runat="server" ErrorMessage="Order amount must be a valid monetary amount."
            ControlToValidate="OrderTotalTextBox" >*</bvc5:BVCustomValidator></td>
</tr>
<tr>
    <td class="formlabel">
        and the order total is <=</td>
    <td class="formfield">
        <asp:TextBox ID="OrderTotalMaxTextBox" runat="server"></asp:TextBox><bvc5:BVCustomValidator
            ID="OrderTotalMaxCustomValidator" runat="server" ErrorMessage="Order amount must be a monetary amount."
            ControlToValidate="OrderTotalMaxTextBox" >*</bvc5:BVCustomValidator>
        <bvc5:BVCustomValidator ID="OrderTotalMaxCustomValidator2" runat="server" ErrorMessage="Max order total must be less than min order total."
            ControlToValidate="OrderTotalMaxTextBox" >*</bvc5:BVCustomValidator>        
    </td>
</tr>
</table>
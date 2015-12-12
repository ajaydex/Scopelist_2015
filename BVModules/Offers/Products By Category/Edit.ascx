<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_Offers_Products_By_Category_Edit" %>
<%@ Register Src="~/BVAdmin/Controls/PercentAmountSelection.ascx" TagName="PercentAmountSelection" TagPrefix="uc" %>

<h2>Products by Category</h2>
<table cellspacing="0" cellpadding="0" border="0" style="width:100%;" class="linedTable">
    <tr>
        <td class="formlabel">
            By</td>
            <td class="formfield">
            <uc:PercentAmountSelection ID="PercentAmountSelection" runat="server" />
            </td>
        
    </tr>
    <!--
    <tr>
        <td class="formlabel">
            If quantity ordered is >=</td>
        <td class="formfield">
            <asp:TextBox ID="OrderQuantityTextBox" runat="server"></asp:TextBox><bvc5:BVRegularExpressionValidator
                ID="OrderQuantityRegularExpressionValidator" runat="server" ErrorMessage="Quantity ordered must be a whole number greater than 1."
                ValidationExpression="[1-9]\d{0,49}" ControlToValidate="OrderQuantityTextBox">*</bvc5:BVRegularExpressionValidator></td>
    </tr>
    -->
    <tr>
        <td class="formlabel">
            If the order total is >=</td>
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
    <tr>
        <td class="formlabel">
            and ONLY for items in these categories:</td>
        <td class="formfield">
            <asp:DropDownList ID="lstCategory" runat="server"></asp:DropDownList>&nbsp;<asp:Button 
        ID="AddCategory" Text="Add" runat="server" onclick="AddCategory_Click" />
            <br />

            <div style="border:1px solid #ccc;margin-top:10px;padding:5px;">
                <asp:GridView DataKeyNames="Bvin" ID="gvIncludedCategories" AutoGenerateColumns="False" OnRowDeleting="gvIncludedCategories_RowDeleting" runat="server" GridLines="none" style="width:100%;">
                    <EmptyDataTemplate>
                        No Categories Included
                    </EmptyDataTemplate>
                    <Columns>                
                        <asp:BoundField DataField="Setting2" HeaderText="Name" />                
                        <asp:ButtonField ButtonType="Button" CommandName="Delete" Text="X" />
                    </Columns>
            
                    <RowStyle CssClass="row" />
                    <HeaderStyle CssClass="rowheader" />
                    <AlternatingRowStyle CssClass="alternaterow" />
                </asp:GridView>
            
                
            </div>
            
        </td>
    </tr>
</table>
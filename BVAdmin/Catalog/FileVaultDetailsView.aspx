<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="FileVaultDetailsView.aspx.vb" Inherits="BVAdmin_Catalog_FileVaultDetailsView"
    Title="File Vault Details" %>

<%@ Register Src="../../BVModules/Controls/VariantsDisplay.ascx" TagName="VariantsDisplay" TagPrefix="uc5" %>
<%@ Register Src="../Controls/FilePicker.ascx" TagName="FilePicker" TagPrefix="uc4" %>
<%@ Register Src="../Controls/TimespanPicker.ascx" TagName="TimespanPicker" TagPrefix="uc3" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/ProductPicker.ascx" TagName="ProductPicker" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
	<h1>File Vault</h1>
    <uc2:MessageBox ID="MessageBox1" runat="server" EnableViewState="false" />
    <table class="linedTable" cellspacing="0" cellpadding="0" style="width:100%;">
    	<tr>
        	<td class="formlabel">Name</td>
            <td class="formfield">
            	<asp:Label ID="NameLabel" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
        	<td></td>
            <td>
            	<asp:ImageButton ID="ReplaceImageButton" runat="server" AlternateText="Replace" ImageUrl="~/BVAdmin/Images/Buttons/Replace.png" />
            	<asp:Panel ID="ReplacePanel" runat="server" Visible="false" class="controlarea1">
                    <uc4:FilePicker ID="FilePicker1" runat="server" DisplayShortDescription="false" />
                    <br />
                    <asp:ImageButton ID="FileReplaceSaveImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
                    <asp:ImageButton ID="FileReplaceCancelImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
                </asp:Panel>
           	</td>
        </tr>
        <tr>
            <td class="formlabel">Description</td>
            <td class="formfield">
                <asp:TextBox ID="DescriptionTextBox" runat="server" columns="60"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DescriptionTextBox" ErrorMessage="Description is required." ValidationGroup="UpdateDescription">*</bvc5:BVRequiredFieldValidator>
            </td>
        </tr>
    </table>
    
    <br />
    <asp:ImageButton ID="SaveImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" ValidationGroup="UpdateDescription" />
    &nbsp;
    <asp:ImageButton ID="CancelImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" CausesValidation="False" />
    
    <br />
    <br />

	<hr />

	<h2>Product Associations</h2>
    <asp:Panel ID="pnlAdd" runat="server" Style="padding: 10px; margin: 5px 0 20px 0;" CssClass="controlarea2" DefaultButton="btnAddProductBySku">
        <table>
        	<tr>
            	<td class="fromlabel">Add SKU:</td>
                <td class="formfield">
                	<asp:TextBox ID="NewSkuField" runat="Server" Columns="20" TabIndex="200"></asp:TextBox>
                    <asp:ImageButton CausesValidation="false" ID="btnAddProductBySku" runat="server" AlternateText="Add Product To Order" ImageUrl="~/BVAdmin/Images/Buttons/AddToProduct.png" TabIndex="220" />
                </td>
            </tr>
            <tr>
            	<td class="formlabel">Find a Product:</td>
                <td class="formfield">
                	<asp:ImageButton ID="btnBrowseProducts" runat="server" AlternateText="Browse Products" CausesValidation="False" ImageUrl="~/BVAdmin/Images/Buttons/Browse.png" />
                </td>
            </tr>
        </table>
        
        <asp:Panel CssClass="controlarea1" ID="pnlProductPicker" runat="server" Visible="false">
            <uc1:ProductPicker ID="ProductPicker1" runat="server" IsMultiSelect="false" />
            <br />
            <asp:ImageButton ID="btnProductPickerCancel" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Close.png" AlternateText="Close Browser" />
            &nbsp;
            <asp:ImageButton ID="btnProductPickerOkay" runat="server" AlternateText="Add To Product" CausesValidation="false" ImageUrl="~/BVAdmin/Images/Buttons/AddToProduct.png" />
        </asp:Panel> 
               
        <asp:Panel ID="pnlProductChoices" runat="server" Visible="false">
            <uc5:VariantsDisplay ID="VariantsDisplay1" runat="server" />
            <br />
            <asp:ImageButton ID="btnCloseVariants" CausesValidation="false" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Close.png" AlternateText="Close Browser" />
            &nbsp;
            <asp:ImageButton CausesValidation="false" ID="btnAddVariant" runat="server" AlternateText="Add To Product" ImageUrl="~/BVAdmin/Images/Buttons/AddToProduct.png" TabIndex="222" />
        </asp:Panel>
    </asp:Panel>
    
    <asp:GridView ID="ProductsGridView" runat="server" DataKeyNames="bvin" BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%" AutoGenerateColumns="False" BorderWidth="0">
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
        <Columns>
            <asp:BoundField HeaderText="Name" DataField="ProductName" />
            <asp:BoundField HeaderText="SKU" DataField="Sku" />
            
            <asp:TemplateField HeaderText="Max Downloads">
                <ItemTemplate>
                    <asp:TextBox ID="MaxDownloadsTextBox" runat="server" Columns="3"></asp:TextBox>
                    <bvc5:BVRegularExpressionValidator ID="MaxDownloadsRegularExpressionValidator" runat="server" ErrorMessage="Max Downloads must be an integer" Text="*" ControlToValidate="MaxDownLoadsTextBox" ValidationExpression="\d{1,5}"></bvc5:BVRegularExpressionValidator>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Available Time">
                <ItemTemplate>
                    <uc3:TimespanPicker ID="TimespanPicker" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>   
                     
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton ID="UpdateImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Update-small.png"
                        CommandName="Update" />
                    <asp:ImageButton ID="RemoveImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/x.png"
                        CommandName="Delete" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            This file has no products associated with it.
        </EmptyDataTemplate>
    </asp:GridView>
</asp:Content>

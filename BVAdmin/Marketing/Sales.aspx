<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Sales.aspx.vb" Inherits="BVAdmin_Catalog_Sales" Title="Untitled Page" MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="BVSoftware.Bvc5.Core" %>
<%@ Register Src="../Controls/CategoryPicker.ascx" TagName="CategoryPicker" TagPrefix="uc4" %>
<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core" TagPrefix="cc1" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc3" %>
<%@ Register Src="../Controls/DatePicker.ascx" TagName="DatePicker" TagPrefix="uc2" %>
<%@ Register Src="../Controls/ProductPicker.ascx" TagName="ProductPicker" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Sales</h1>
    <uc3:MessageBox ID="MessageBox1" runat="server" />    
    <asp:MultiView ID="SalesMultiView" runat="server" ActiveViewIndex="0">
        <asp:View ID="ListView" runat="server">
            <asp:GridView ID="SalesGridView" runat="server" AutoGenerateColumns="False" GridLines="none">
                <EmptyDataTemplate>
                    There are no sales to display.
                </EmptyDataTemplate>
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name">
                        <ItemStyle Width="150px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:d}" HtmlEncode="False" >
                        <ItemStyle Width="85px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:d}" HtmlEncode="False" >
                        <ItemStyle Width="85px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Description" HeaderText="Details" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="false" CommandName="Edit"
                                ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="false" CommandName="Delete"
                                ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
            <br />
            <asp:ImageButton ID="NewSaleImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/New.png" AlternateText="New" />
        </asp:View>
        
        <asp:View ID="EditView" runat="server">
            <table cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td class="formlabel">
                        Sale Name
                    </td>
                    <td class="formfield">
                    	<asp:TextBox ID="SaleNameTextBox" runat="server" MaxLength="100" Width="287px"></asp:TextBox>  
                        <bvc5:BVRegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="SaleNameTextBox"
                            ErrorMessage="You must enter a sale name and it must be no more than 100 characters."
                            ValidationExpression=".{1,100}">*</bvc5:BVRegularExpressionValidator>
                        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="SaleNameTextBox"
                            ErrorMessage="Sale Name Is Required.">*</bvc5:BVRequiredFieldValidator></td>
                    </td>
                </tr>
                <tr>
                	<td class="formlabel">
                    	Sale Type
                    </td>
                    <td class="formfield" style="padding-top:10px;">
                    	<asp:RadioButtonList ID="SaleTypeRadioButtonList" runat="server" RepeatLayout="Flow"
                            AutoPostBack="True">
                            <asp:ListItem Selected="True" Text="Store Wide Sale"></asp:ListItem>
                            <asp:ListItem Text="Sale By Product"></asp:ListItem>
                            <asp:ListItem Text="Sale By Category"></asp:ListItem>
                            <asp:ListItem>Sale By Product Type</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
           	</table>
               
            <hr />
               
            <table cellspacing="0" cellpadding="0" border="0" style="width:100%;">       
                <tr id="ProductPickerRow" runat="server" visible="false">
                    <td style="width:40%;vertical-align:top;">
                    	Products on Sale
                        <asp:GridView ID="SelectedProductsGridView" runat="server" AutoGenerateColumns="False" CellPadding="0" GridLines="None" Width="100%">
                            <EmptyDataTemplate>
                            	<div class="messagebox">
                                    <ul >
                                        <li>There are no selected products.</li>
                                    </ul>
                                </div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkSelectAll" CssClass="selectAll" runat="server" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="SelectedCheckBox" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProductName" HeaderText="Name" />
                                <asp:BoundField HeaderText="Category" />
                            </Columns>
                            <RowStyle CssClass="row" />
                            <HeaderStyle CssClass="rowheader" />
                            <AlternatingRowStyle CssClass="alternaterow" />
                        </asp:GridView>
                    </td>
                    <td style="width:20%; text-align:center;">
                        <asp:ImageButton ID="AddProductsImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Add.png" />
                        <br /><br />
                        <asp:ImageButton ID="RemoveProductsImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Remove.png" />
                    </td>
                    <td style="width:40%;">
                    	Select Products
                        <uc1:ProductPicker ID="ProductPicker1" runat="server" Visible="true" DisplayPrice="true" />
                    </td>
                </tr>
         	
                <tr id="CategoryPickerRow" runat="server" visible="false">
                    <td style="width:40%;vertical-align:top;">
                    	Sale Categories
                        <asp:GridView ID="SelectedCategoriesGridView" runat="server" AutoGenerateColumns="False" CellPadding="0" GridLines="None" Width="100%">
                            <EmptyDataTemplate>
                            	<div class="messagebox">
                                    <ul>
                                        <li>There are no selected categories.</li>
                                    </ul>
                                </div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkSelectAll" CssClass="selectAll" runat="server" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="SelectedCheckBox" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Name" HeaderText="Name" />
                                <asp:BoundField HeaderText="Category" />
                            </Columns>
                            <RowStyle CssClass="row" />
                            <HeaderStyle CssClass="rowheader" />
                            <AlternatingRowStyle CssClass="alternaterow" />
                        </asp:GridView>
                    </td>
                    <td style="width:20%; text-align:center;">
                        <asp:ImageButton ID="AddCategoriesImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Add.png" />
                        <br /><br />
                        <asp:ImageButton ID="RemoveCategoriesImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Remove.png" />
                    </td>
                    <td style="width:40%;">
                    	Select Categories
                    	<div style="height:400px;overflow: auto;">
                        	<uc4:CategoryPicker ID="CategoryPicker1" runat="server" />
                        </div>
                    </td>
                </tr>
                
                <tr id="ProductTypePickerRow" runat="server" visible="false">
                    <td style="width:40%;vertical-align:top;">
                    	Sale Product Types
                        <asp:GridView ID="SelectedProductTypeGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" GridLines="None" Width="100%">
                            <EmptyDataTemplate>
                            	<div class="messagebox">
                                    <ul>
                                        <li>There are no selected product types.</li>
                                    </ul>
                                </div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkSelectAll" CssClass="selectAll" runat="server" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="SelectedCheckBox" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProductTypeName" HeaderText="Name" />
                            </Columns>
                            <RowStyle CssClass="row" />
                            <HeaderStyle CssClass="rowheader" />
                            <AlternatingRowStyle CssClass="alternaterow" />
                        </asp:GridView>
                    </td>
                    <td style="width:20%; text-align:center;">
                        <asp:ImageButton ID="AddProductTypeImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Add.png" />
                        <br />
                        <br />
                        <asp:ImageButton ID="RemoveProductTypeImageButtonImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Remove.png" />
                    </td>
                    <td style="width:40%;">
                    	Select Product Types
                        <div style="height:400px;overflow: auto;">
                        <asp:GridView ID="ProductTypeGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" GridLines="None" Width="100%">
                            <EmptyDataTemplate>
                            	<div class="messagebox">
                                    <ul>
                                        <li>There Are No Product Types To Choose From.</li>
                                    </ul>
                                </div>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkSelectAll" CssClass="selectAll" runat="server" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="SelectedCheckBox" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProductTypeName" HeaderText="Name" />                                
                            </Columns>
                            <RowStyle CssClass="row" />
                            <HeaderStyle CssClass="rowheader" />
                            <AlternatingRowStyle CssClass="alternaterow" />
                        </asp:GridView>
                        </div>
                    </td>
                </tr>
           </table>    
         	
           <hr />
            
           <table cellspacing="0" cellpadding="0" border="0">        
                <tr>
                    <td class="formlabel">
                        Discount Type
                    </td>
                    <td class="formfield" style="padding-top:10px">
                        <asp:RadioButtonList ID="DiscountTypeRadioButtonList" runat="server" RepeatLayout="Flow">
                            <asp:ListItem Selected="True" Text="Percentage Off List Price"></asp:ListItem>
                            <asp:ListItem Text="Amount Off List Price"></asp:ListItem>
                            <asp:ListItem Text="Percentage Off Site Price"></asp:ListItem>
                            <asp:ListItem Text="Amount Off Site Price"></asp:ListItem>
                            <asp:ListItem Text="Percentage Above Site Cost"></asp:ListItem>
                            <asp:ListItem Text="Amount Above Site Cost"></asp:ListItem>
                            <asp:ListItem Text="Fixed Price"></asp:ListItem>
                        </asp:RadioButtonList>
                   	</td>
                </tr>
                <tr>
                    <td class="formlabel">
                        Discount Amount
                    </td>
                    <td class="formfield">
                        <asp:TextBox ID="DiscountAmountTextBox" runat="server"></asp:TextBox>
                        <bvc5:BVCustomValidator ID="DiscountAmountCustomValidator" runat="server" ControlToValidate="DiscountAmountTextBox" ErrorMessage="Discount amount not in proper format.">*</bvc5:BVCustomValidator>
                        <asp:CheckBox ID="SaleBelowCostCheckBox" runat="server" /> Allow Sale Below Cost
                 	
                    </td>
                </tr>
                
                <tr>
                    <td class="formlabel">
                        Start Date
                        <span class="smallerText">Current Server Time Is:
                            <% =DateTime.Now%>
                        </span>
                    </td>
                    <td class="formfield">
                        <uc2:DatePicker ID="StartDatePicker" runat="server" InvalidFormatErrorMessage="Start date is not in the correct format." RequiredErrorMessage="Start date is required." />
                        <bvc5:BVCompareValidator ID="CompareValidator1" runat="server" ControlToCompare="EndDatePicker"
                            ControlToValidate="StartDatePicker" Display="None" ErrorMessage="End date must be greater than or equal to start date."
                            Operator="LessThanEqual" Type="Date">*</bvc5:BVCompareValidator>
                	</td>
                </tr>
                <tr>
                    <td class="formlabel">
                        End Date
                        <span class="smallerText">Current Server Time Is:
                            <% =DateTime.Now%>
                        </span>
                    </td>
                    <td class="formfield">
                        <uc2:DatePicker ID="EndDatePicker" runat="server" InvalidFormatErrorMessage="End date is not in the correct format." RequiredErrorMessage="End date is required." />
                        <!--<span class="smallerText">Current Server Time Is: <% =DateTime.Now%></span>-->
                    </td>
                </tr>
            </table>
            
            <br />
            <br />
            <asp:ImageButton ID="CancelImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" AlternateText="Cancel" CausesValidation="False" />
            &nbsp;
            <asp:ImageButton ID="SaveChangesImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" AlternateText="Save Changes" />
    	</asp:View>
    </asp:MultiView>   
</asp:Content>

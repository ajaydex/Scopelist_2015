<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="ShipOrder.aspx.vb" Inherits="BVAdmin_Orders_ShipOrder" Title="Untitled Page" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<%@ Register Src="~/BVAdmin/Controls/OrderDetailsButtons.ascx" TagName="OrderDetailsButtons" TagPrefix="uc" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server"> 
	<h1><asp:label ID="lblOrderNumber" runat="server"></asp:label>Shipping</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    
    <hr />
    <asp:Label ID="StatusField" runat="server"></asp:Label>
    <table border="0" cellspacing="0" cellpadding="0" style="float:right;width: 200px;">
        <tr>
            <td align="left">
                <asp:ImageButton ID="btnPreviousStatus" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Left.png" />
            </td>
            <td align="center">
                &nbsp;<asp:Label ID="lblCurrentStatus" Text="Unknown" runat="server"></asp:Label>&nbsp;
            </td>
            <td align="right">
                <asp:ImageButton ID="btnNextStatus" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/right.png" />
            </td>
        </tr>
    </table>
    <hr />
    
	<div class="f-row">
    	<div class="three columns">
        	<h5>Ship To:</h5>
            <asp:Label ID="ShippingAddressField" runat="server"></asp:Label>
        
            <h5>Shipping Total:</h5> 
            <span style="color:green;font-weight:bold;"><asp:Label ID="ShippingTotalLabel" runat="server"></asp:Label></span>
        </div>
    	<div class="seven columns">
        	<asp:GridView GridLines="None" ID="ItemsGridView" runat="server" AutoGenerateColumns="False" Width="100%" DataKeyNames="bvin">
                <Columns>
                    <asp:TemplateField HeaderText="SKU">
                        <ItemTemplate>
                            <asp:Label ID="SKUField" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Item">
                        <ItemTemplate>
                            <asp:Label ID="DescriptionField" runat="server"></asp:Label>
                            <asp:PlaceHolder ID="CartInputModifiersPlaceHolder" runat="server"></asp:PlaceHolder>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ordered">
                        <ItemTemplate>
                            <asp:Label ID="QuantityField" runat="server" Text='<%# Bind("Quantity","{0:#}") %>'>    
                        </asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                        <HeaderStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Shipped">
                        <ItemTemplate>
                            <asp:Label ID="shipped" runat="server" Text="0"></asp:Label>
                       	</ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                        <HeaderStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:TextBox ID="QtyToShip" runat="server" Text="0" Columns="5"></asp:TextBox>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                        <HeaderStyle HorizontalAlign="Right" />
                    </asp:TemplateField>
                </Columns>
                <RowStyle CssClass="row" />
                <HeaderStyle CssClass="rowheader" />
                <AlternatingRowStyle CssClass="alternaterow" />
            </asp:GridView>
            
            <hr />
            
            <asp:Panel ID="pnlShip" runat="server" DefaultButton="btnShipItems" CssClass="controlarea2a">
            <h5><asp:Label ID="UserSelectedShippingMethod" runat="server" Text=""></asp:Label></h5>
                <asp:Panel ID="pnlShippingTable" runat="server">
                <table border="0" cellspacing="0" cellpadding="0" width="100%">
                    <tr>
                    	<td>
                            Shipping By:<br />
                            <anthem:DropDownList AutoCallBack="true" ID="lstShippingProvider" runat="server"></anthem:DropDownList><br />
                            <anthem:DropDownList ID="lstServiceCode" runat="server" Visible="false" />
                  
                            <br />
                            Tracking Number:<br />
                            <asp:TextBox ID="TrackingNumberField" runat="Server" Columns="15"></asp:TextBox>
                       	</td>
                   	
                        <td align="right" class="buttonStack">
                            <asp:ImageButton ID="btnShipByUPS" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/ShipByUPS.png" AlternateText="Ship By UPS" ToolTip="Ship By UPS" /><br />
                            <asp:ImageButton ID="btnShipItems" runat="Server" ImageUrl="~/BVAdmin/Images/Buttons/ShipItems.png" AlternateText="Ship Items" ToolTip="Ship Items" /><br />
                            <asp:ImageButton id="btnCreatePackage" runat="Server" AlternateText="Create Package" ToolTip="Create Package" ImageUrl="~/BVAdmin/Images/Buttons/CreatePackage.png"></asp:ImageButton>
                        </td>
                    </tr>
                </table>
                </asp:Panel>
            </asp:Panel>
            
            <hr />
            <h5>Packages</h5>
            <asp:GridView ID="PackagesGridView" GridLines="none" BorderWidth="0" ShowHeader="false" DataKeyNames="bvin" runat="server" AutoGenerateColumns="False" style="width:100%;">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div style="background:#F3F3F3;padding:15px;margin-bottom: 10px;">
                                <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                                    <tr>
                                        <td class="formlabel">Ship Date:</td>
                                        <td class="formfield"><asp:Label ID="ShipDateField" runat="server" Text='<%# Bind("ShipDate") %>'>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="formlabel">Shipped By:</td>
                                        <td class="formfield"><asp:Label ID="ShippedByField" runat="server" Text='<%# Bind("ShippingProviderId") %>'>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="formlabel">Tracking:</td>
                                        <td class="formfield">
                                            <asp:TextBox ID="TrackingNumberTextBox" runat="server"></asp:TextBox>
                                            <asp:ImageButton ID="TrackingNumberUpdateImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Update-small.png" CommandName="TrackingNumberUpdate" CommandArgument='<%# Eval("bvin") %>' />
                                            <br />
                                            <asp:HyperLink ID="TrackingLink" runat="server" Target="_blank" NavigateUrl="#" Text="No Tracking Information"></asp:HyperLink>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="formlabel">Items:</td>
                                        <td class="formfield"><asp:Label ID="items" runat="Server"></asp:Label></td>
                                    </tr>
                                </table>
                                <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="false" CommandName="Delete" ImageUrl="~/BVAdmin/Images/Buttons/X.png"></asp:ImageButton>
                        	</div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            
            <hr />
            <h5>Suggested Packages</h5>
            <asp:GridView ID="SuggestedPackagesGridView" GridLines="None" BorderWidth="0" ShowHeader="False" DataKeyNames="bvin" runat="server" AutoGenerateColumns="False" style="width:100%;">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                        	<div style="background:#F3F3F3;padding:15px;margin-bottom: 10px;">
                                <asp:Label ID="DescriptionField" runat="server" Text='<%# Bind("description") %>'>'></asp:Label>
                                <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                                    <tr>
                                        <td class="formlabel">Ship By:</td>
                                        <td class="formfield"><asp:Label ID="ShippedByField" runat="server" Text='<%# Bind("ShippingProviderId") %>'>'></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td class="formlabel">Tracking #:</td>
                                        <td class="formfield"><asp:TextBox ID="TrackingNumber" runat="server" Text='<%# Bind("TrackingNumber") %>' Columns="15"></asp:TextBox></td>
                                    </tr>
                               	</table>
                                
                                <asp:ImageButton CausesValidation="False" ID="btnUpdatePackage" CommandName="AddTrackingNumber" CommandArgument='<%# Eval("bvin") %>' runat="Server" ImageUrl="~/BVAdmin/Images/Buttons/UpdatePackage.png" AlternateText="Update this suggested Package" />
                                <asp:ImageButton CausesValidation="False" ID="btnShipPackage" CommandName="Edit" runat="Server" ImageUrl="~/BVAdmin/Images/Buttons/ShipThisPackage.png" AlternateText="Ship this suggested Package" />
                                
                              	<table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                                    <tr>
                                        <td class="formlabel">Items:</td>
                                        <td class="formfield"><asp:Label ID="items" runat="Server"></asp:Label></td>
                                    </tr>
                                </table> 
                                
                                <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="false" CommandName="Delete" ImageUrl="~/BVAdmin/Images/Buttons/X.png"></asp:ImageButton>
                          	</div>
                        </ItemTemplate>
                    </asp:TemplateField>                                             
                </Columns>
                
            </asp:GridView>
        </div>
        <div class="two columns text-right">
        	<uc:OrderDetailsButtons ID="ucOrderDetailsButtons" runat="server" />
        </div>
   	</div>            
</asp:Content>
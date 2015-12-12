<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="ProductBatchEdit.aspx.vb" 
Inherits="BVAdmin_Catalog_ProductBatchEdit" title="Batch Edit" ValidateRequest="false" %>

<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox"
    TagPrefix="uc3" %>
<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core" TagPrefix="cc1" %>
<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core.Controls" TagPrefix="bv" %>
<%@ Register Src="../Controls/ProductModifications.ascx" TagName="ProductModifications"
    TagPrefix="uc2" %>
<%@ Register Src="../Controls/ProductFilter.ascx" TagName="ProductFilter" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">        
<asp:MultiView ID="BatchEditMultiView" runat="server" ActiveViewIndex="0">
    <asp:View ID="EditView" runat="server">
        <h2>Product Choices</h2>
        <div>
            <uc3:MessageBox ID="MessageBox1" runat="server" EnableViewState="false" />            
        </div>
        <uc1:ProductFilter ID="ProductFilter1" runat="server" DisplaySharedChoicesSection="true" />
        <h2>Product Modifications</h2>
        <div>
            <uc2:ProductModifications ID="ProductModifications1" runat="server" />
        </div>
        <div>
            <asp:ImageButton ID="ViewImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Preview.png" />        
            <asp:CheckBox ID="ChoiceCombinationsCheckBox" runat="server" Checked="True" Text="Show Me Choice Combinations" /></div>
        <div>
            <uc3:MessageBox ID="MessageBox2" runat="server" EnableViewState="false" />
        </div>
    </asp:View>
    <asp:View ID="PreviewView" runat="server">
        <div style="overflow:scroll; width: 920px; height: 650px;">
            <asp:GridView ID="ProductsGridView" runat="server" AutoGenerateColumns="False" GridLines="none">
                <Columns>
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                    <asp:BoundField DataField="Sku" HeaderText="Sku" />
                    <asp:BoundField HeaderText="Choice Values" />
                    <asp:BoundField DataField="SitePrice" HeaderText="Site Price" />
                    <asp:BoundField DataField="ListPrice" HeaderText="List Price" />                    
                    <asp:BoundField DataField="SiteCost" HeaderText="Site Cost" />
                    <asp:BoundField DataField="ShortDescription" HeaderText="Short Description" />                                       
                    <bv:ManufacturerBoundField DataField="ManufacturerId" HeaderText="Manufacturer"/>
                    <bv:VendorBoundField DataField="VendorId" HeaderText="Vendor" />                
                    <asp:BoundField DataField="Keywords" HeaderText="Keywords" /> 
                    <asp:BoundField DataField="MetaDescription" HeaderText="Meta Description" /> 
                    <asp:BoundField DataField="TemplateName" HeaderText="Template Name" />  
                    <bv:ContentColumnBoundField DataField="PreContentColumnId" HeaderText="Pre-Content Column" />
                    <bv:ContentColumnBoundField DataField="PostContentColumnId" HeaderText="Post-Content Column" />                 
                    <asp:BoundField DataField="TaxExempt" HeaderText="Tax Exempt" /> 
                    <asp:BoundField DataField="ExtraShipFee" HeaderText="Extra Ship Fee" />  
                    <asp:BoundField DataField="LongDescription" HeaderText="Long Description" />                        
                    <asp:BoundField DataField="ProductTypeId" HeaderText="Product Type" />                                   
                    <asp:BoundField DataField="ShippingLength" HeaderText="Shipping Length" />                     
                    <asp:BoundField DataField="ShippingWidth" HeaderText="Shipping Width" />  
                    <asp:BoundField DataField="ShippingHeight" HeaderText="Shipping Height" />
                    <asp:BoundField DataField="ShippingWeight" HeaderText="Shipping Weight" />
                    <asp:BoundField DataField="SitePriceOverrideText" HeaderText="Site Price Override" />  
                    <asp:BoundField DataField="GiftWrapAllowed" HeaderText="Gift Wrap Allowed" />
                    <asp:BoundField DataField="SitePriceForDisplay" HeaderText="Site Price For Display" />
                    <asp:BoundField DataField="ShipSeparately" HeaderText="Ship Separately" />
                    <asp:BoundField DataField="NonShipping" HeaderText="Non-Shipping" />  
                    <asp:BoundField DataField="MetaTitle" HeaderText="Meta Title" />  
                    <asp:BoundField DataField="TaxClass" HeaderText="Tax Class" />                      
                    <asp:BoundField DataField="MetaKeywords" HeaderText="Meta Keywords" />  
                    <asp:BoundField DataField="RewriteUrl" HeaderText="Rewrite Url" />  
                    <asp:BoundField DataField="ImageFileMedium" HeaderText="Image File Medium" />                     
                    <asp:BoundField DataField="MinimumQty" HeaderText="Minimum Quantity" />
                    <asp:BoundField DataField="ImageFileSmall" HeaderText="Image File Small" />                                        
                </Columns>
            </asp:GridView>
        </div>
        <div><asp:Label ID="AdditionalProductsLabel" runat="server" Text=""></asp:Label></div>
        <asp:ImageButton ID="SaveImageButton" runat="server" AlternateText="Save" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
        <asp:ImageButton ID="CancelImageButton" runat="server" AlternateText="Cancel" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
    </asp:View>
</asp:MultiView>
</asp:Content>


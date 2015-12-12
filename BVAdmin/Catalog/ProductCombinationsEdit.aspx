<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminProduct.master" AutoEventWireup="false" CodeFile="ProductCombinationsEdit.aspx.vb" Inherits="BVAdmin_Catalog_ProductCombinationsEdit" title="Edit Product Choices" ValidateRequest="False" %>

<%@ Register Assembly="BVSoftware.Bvc5.Core" Namespace="BVSoftware.Bvc5.Core" TagPrefix="cc1" %>
<%@ Register Src="../Controls/HtmlEditor.ascx" TagName="HtmlEditor" TagPrefix="uc2" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <h1>Edit Product Variations</h1>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">    
    <div>
        <uc1:MessageBox ID="MessageBox1" runat="server" EnableViewState="false" />
    </div>
    <div>                
		<asp:DataList ID="CombinationsDataList" runat="server" ExtractTemplateRows="true" DataKeyField="bvin" ItemStyle-BackColor="#ffffff" AlternatingItemStyle-BackColor="#FFFFFF">
			<AlternatingItemTemplate>                
				<asp:Table ID="Table1" runat="server">                    
					<asp:TableRow>
						<asp:TableCell CssClass="formfield" ColumnSpan="5">
							<h2>Choices: <asp:Label ID="ProductChoiceLabel" runat="server"></asp:Label></h2>
						</asp:TableCell>                        
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="formlabel">
							Product Name:                            
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox ID="NameTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="ProductNameRequiredFieldValidator" runat="server" ErrorMessage="Product Name is required." Text="*" ControlToValidate="NameTextBox"></bvc5:BVRequiredFieldValidator>                        
						</asp:TableCell>

                        <asp:TableCell Width="20px"></asp:TableCell>

						<asp:TableCell CssClass="formlabel">
							Small Image:
						</asp:TableCell>
						<asp:TableCell>                            
							<asp:TextBox ID="SmallImageTextBox" runat="server"></asp:TextBox>
							<a runat="server" id="SmallImageButton"><asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="SmallImage" /></a>
						</asp:TableCell>                        
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="formlabel">
							Sku:
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox ID="SkuTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="SkuRequiredFieldValidator" runat="server" ErrorMessage="Product Sku is required." Text="*" ControlToValidate="SkuTextBox"></bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="UniqueSkuCustomValidator" runat="server" ErrorMessage="Sku must be a unique value." Text="*" ControlToValidate="SkuTextBox" OnServerValidate="UniqueSkuValidate_ServerValidate"></bvc5:BVCustomValidator>
						</asp:TableCell>     
                        
                        <asp:TableCell Width="20px"></asp:TableCell>
                                           
						<asp:TableCell CssClass="formlabel">
							Medium Image:
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox ID="MediumImageTextBox" runat="server"></asp:TextBox>
						<a runat="server" id="MediumImageButton"><asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="MediumImage" /></a>                        
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="formlabel">
							MSRP:
						</asp:TableCell>
						<asp:TableCell>                            
							<asp:TextBox ID="ListPriceTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="ListPriceRequiredFieldValidator" runat="server" ErrorMessage="List Price is required" Text="*" ControlToValidate="ListPriceTextBox"></bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="ListPriceCustomValidator" runat="server" ErrorMessage="List price is not in the proper format." Text="*" ControlToValidate="ListPriceTextBox" OnServerValidate="IsMonetary_ServerValidate"></bvc5:BVCustomValidator>
						</asp:TableCell>

                        <asp:TableCell Width="20px"></asp:TableCell>

						<asp:TableCell CssClass="formlabel">
							Site Cost:
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox ID="SiteCostTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="SiteCostRequiredFieldValidator" runat="server" ErrorMessage="Site Cost is required" Text="*" ControlToValidate="SiteCostTextBox"></bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="SiteCostCustomValidator" runat="server" ErrorMessage="Site Cost is not in the proper format." Text="*" ControlToValidate="SiteCostTextBox" OnServerValidate="IsMonetary_ServerValidate"></bvc5:BVCustomValidator>                        
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="formlabel">
							Site Price:
						</asp:TableCell>
						<asp:TableCell>                            
							<asp:TextBox ID="SitePriceTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="SitePriceRequiredFieldValidator" runat="server" ErrorMessage="Site Price is required" Text="*" ControlToValidate="SitePriceTextBox"></bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="SitePriceCustomValidator" runat="server" ErrorMessage="Site price is not in the proper format." Text="*" ControlToValidate="SitePriceTextBox" OnServerValidate="IsMonetary_ServerValidate"></bvc5:BVCustomValidator>                                                    
						</asp:TableCell>

                        <asp:TableCell Width="20px"></asp:TableCell>

						<asp:TableCell CssClass="formlabel">
							Non-Shipping:
						</asp:TableCell>
						<asp:TableCell>
							<asp:CheckBox ID="NonShippingCheckBox" runat="server" />
						</asp:TableCell>
					</asp:TableRow>
					
					<asp:TableRow>
					
						<asp:TableCell CssClass="formlabel">
							Site Price Override Text:
						</asp:TableCell>
						<asp:TableCell>                            
							<asp:TextBox ID="SitePriceOverrideTextBox" runat="server"></asp:TextBox>
						</asp:TableCell>
						
                        <asp:TableCell Width="20px"></asp:TableCell>

						<asp:TableCell CssClass="formlabel">
							Extra Ship Fee:
						</asp:TableCell>
						<asp:TableCell>                            
							<asp:TextBox ID="ExtraShipFeeTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="ExtraShipFeeRequiredValidator" runat="server" ErrorMessage="Extra ship fee is required." Text="*" ControlToValidate="ExtraShipFeeTextBox"></bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="ExtraShipFeeCustomValidator" runat="server" ErrorMessage="Site price is not in the proper format." Text="*" ControlToValidate="ExtraShipFeeTextBox" OnServerValidate="IsMonetary_ServerValidate"></bvc5:BVCustomValidator>                                                    
						</asp:TableCell>
					</asp:TableRow>
					
                    <asp:TableRow>
                        <asp:TableCell CssClass="formlabel">
							Weight:
						</asp:TableCell>
						
						<asp:TableCell>                            
							<asp:TextBox ID="WeightTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="WeightRequiredValidator" runat="server" ErrorMessage="Weight is required" Text="*" ControlToValidate="WeightTextBox"></bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="WeightCustomValidator" runat="server" ErrorMessage="Weight is not in the proper format." Text="*" ControlToValidate="WeightTextBox" OnServerValidate="IsMonetary_ServerValidate"></bvc5:BVCustomValidator>
						</asp:TableCell>
                    </asp:TableRow>

					<asp:TableRow>                        
						<asp:TableCell ColumnSpan="2">
                            <br />
							Short Description:                        
						</asp:TableCell>
						
                        <asp:TableCell Width="20px"></asp:TableCell>

						<asp:TableCell ColumnSpan="2">
                            <br />
							Long Description:
						</asp:TableCell>
					</asp:TableRow>
					
					<asp:TableRow>	
						<asp:TableCell ColumnSpan="2" VerticalAlign="top">
							<asp:TextBox ID="ShortDescriptionTextBox" Columns="20" Rows="6" TextMode="MultiLine" runat="server"></asp:TextBox>    
						</asp:TableCell> 
						
                        <asp:TableCell Width="20px"></asp:TableCell>

						<asp:TableCell ColumnSpan="2" VerticalAlign="top">
							<uc2:HtmlEditor ID="LongDescriptionHtmlEditor" EditorHeight="300" EditorWidth="300" runat="server" />    
						</asp:TableCell> 
					</asp:TableRow>
					
				</asp:Table>
			</AlternatingItemTemplate>
			
			<ItemTemplate>
				<asp:Table ID="Table1" runat="server">
					<asp:TableRow>
						<asp:TableCell CssClass="formfield" ColumnSpan="5">
							<h2>Choices: <asp:Label ID="ProductChoiceLabel" runat="server"></asp:Label></h2>
						</asp:TableCell>                        
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="formlabel">
							Product Name:                            
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox ID="NameTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="ProductNameRequiredFieldValidator" runat="server" ErrorMessage="Product Name is required." Text="*" ControlToValidate="NameTextBox"></bvc5:BVRequiredFieldValidator>                        
						</asp:TableCell>

                        <asp:TableCell Width="20px"></asp:TableCell>

						<asp:TableCell CssClass="formlabel">
							Small Image:
						</asp:TableCell>
						<asp:TableCell>                            
							<asp:TextBox ID="SmallImageTextBox" runat="server"></asp:TextBox>
							<a runat="server" id="SmallImageButton"><asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="SmallImage" /></a>
						</asp:TableCell>                        
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="formlabel">
							Sku:
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox ID="SkuTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="SkuRequiredFieldValidator" runat="server" ErrorMessage="Product Sku is required." Text="*" ControlToValidate="SkuTextBox"></bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="UniqueSkuCustomValidator" runat="server" ErrorMessage="Sku must be a unique value." Text="*" ControlToValidate="SkuTextBox" OnServerValidate="UniqueSkuValidate_ServerValidate"></bvc5:BVCustomValidator>
						</asp:TableCell>  
                        
                        <asp:TableCell Width="20px"></asp:TableCell>
                                              
						<asp:TableCell CssClass="formlabel">
							Medium Image:
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox ID="MediumImageTextBox" runat="server"></asp:TextBox>
						<a runat="server" id="MediumImageButton"><asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="MediumImage" /></a>                        
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="formlabel">
							MSRP:
						</asp:TableCell>
						<asp:TableCell>                            
							<asp:TextBox ID="ListPriceTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="ListPriceRequiredFieldValidator" runat="server" ErrorMessage="List Price is required" Text="*" ControlToValidate="ListPriceTextBox"></bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="ListPriceCustomValidator" runat="server" ErrorMessage="List price is not in the proper format." Text="*" ControlToValidate="ListPriceTextBox" OnServerValidate="IsMonetary_ServerValidate"></bvc5:BVCustomValidator>
						</asp:TableCell>

                        <asp:TableCell Width="20px"></asp:TableCell>

						<asp:TableCell CssClass="formlabel">
							Site Cost:
						</asp:TableCell>
						<asp:TableCell>
							<asp:TextBox ID="SiteCostTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="SiteCostRequiredFieldValidator" runat="server" ErrorMessage="Site Cost is required" Text="*" ControlToValidate="SiteCostTextBox"></bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="SiteCostCustomValidator" runat="server" ErrorMessage="Site Cost is not in the proper format." Text="*" ControlToValidate="SiteCostTextBox" OnServerValidate="IsMonetary_ServerValidate"></bvc5:BVCustomValidator>                        
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
						<asp:TableCell CssClass="formlabel">
							Site Price:
						</asp:TableCell>
						<asp:TableCell>                            
							<asp:TextBox ID="SitePriceTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="SitePriceRequiredFieldValidator" runat="server" ErrorMessage="Site Price is required" Text="*" ControlToValidate="SitePriceTextBox"></bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="SitePriceCustomValidator" runat="server" ErrorMessage="Site price is not in the proper format." Text="*" ControlToValidate="SitePriceTextBox" OnServerValidate="IsMonetary_ServerValidate"></bvc5:BVCustomValidator>                                                    
						</asp:TableCell>

                        <asp:TableCell Width="20px"></asp:TableCell>

						<asp:TableCell CssClass="formlabel">
							Non-Shipping:
						</asp:TableCell>
						<asp:TableCell>
							<asp:CheckBox ID="NonShippingCheckBox" runat="server" />
						</asp:TableCell>
					</asp:TableRow>
					<asp:TableRow>
					
						<asp:TableCell CssClass="formlabel">
							Site Price Override Text:
						</asp:TableCell>
						<asp:TableCell>                            
							<asp:TextBox ID="SitePriceOverrideTextBox" runat="server"></asp:TextBox>
						</asp:TableCell>
						
                        <asp:TableCell Width="20px"></asp:TableCell>

						<asp:TableCell CssClass="formlabel">
							Extra Ship Fee:
						</asp:TableCell>
						<asp:TableCell>                            
							<asp:TextBox ID="ExtraShipFeeTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="ExtraShipFeeRequiredValidator" runat="server" ErrorMessage="Extra ship fee is required." Text="*" ControlToValidate="ExtraShipFeeTextBox"></bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="ExtraShipFeeCustomValidator" runat="server" ErrorMessage="Site price is not in the proper format." Text="*" ControlToValidate="ExtraShipFeeTextBox" OnServerValidate="IsMonetary_ServerValidate"></bvc5:BVCustomValidator>                                                    
						</asp:TableCell>
					</asp:TableRow>
					
                    <asp:TableRow>
                        <asp:TableCell CssClass="formlabel">
							Weight:
						</asp:TableCell>
						
						<asp:TableCell>                            
							<asp:TextBox ID="WeightTextBox" runat="server"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="WeightRequiredValidator" runat="server" ErrorMessage="Weight is required" Text="*" ControlToValidate="WeightTextBox"></bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="WeightCustomValidator" runat="server" ErrorMessage="Weight is not in the proper format." Text="*" ControlToValidate="WeightTextBox" OnServerValidate="IsMonetary_ServerValidate"></bvc5:BVCustomValidator>
						</asp:TableCell>
                    </asp:TableRow>
					
					<asp:TableRow>                        
						<asp:TableCell ColumnSpan="2">
                            <br />
							Short Description:                        
						</asp:TableCell>
						
                        <asp:TableCell Width="20px"></asp:TableCell>

						<asp:TableCell ColumnSpan="2">
                            <br />
							Long Description:
						</asp:TableCell>
					</asp:TableRow>
					
					<asp:TableRow>	
						<asp:TableCell ColumnSpan="2" VerticalAlign="top">
							<asp:TextBox ID="ShortDescriptionTextBox" Columns="20" Rows="6" TextMode="MultiLine" runat="server"></asp:TextBox>    
						</asp:TableCell> 
						
                        <asp:TableCell Width="20px"></asp:TableCell>

						<asp:TableCell ColumnSpan="2" VerticalAlign="top">
							<uc2:HtmlEditor ID="LongDescriptionHtmlEditor" EditorHeight="300" EditorWidth="300" runat="server" />    
						</asp:TableCell> 
					</asp:TableRow>
				</asp:Table>
			</ItemTemplate>  
			
			<SeparatorTemplate>
				<asp:Table runat="server">
					<asp:TableRow>
						<asp:TableCell style="height: 50px;">
							
						</asp:TableCell>                        
					</asp:TableRow>
				</asp:Table>
			</SeparatorTemplate>
		</asp:DataList>
	</div> 
	<br /><br />
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
				<asp:ImageButton ID="CancelImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
				&nbsp;
				<asp:ImageButton ID="SaveImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
			</td>            
        </tr>
    </table>
</asp:Content>


<%@ Page ValidateRequest="false" Language="VB" MasterPageFile="~/BVAdmin/BVAdminProduct.master"
    AutoEventWireup="false" CodeFile="Products_Edit.aspx.vb" Inherits="BVAdmin_Catalog_Products_Edit"
    Title="Untitled Page" %>

<%@ Register Src="../Controls/ProductFieldCopier.ascx" TagName="ProductFieldCopier" TagPrefix="uc4" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc3" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../Controls/DatePicker.ascx" TagName="DatePicker" TagPrefix="uc2" %>
<%@ Register Src="../Controls/HtmlEditor.ascx" TagName="HtmlEditor" TagPrefix="uc1" %>


<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <h1>Product General Options</h1>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <script type="text/javascript">
		String.prototype.trim = function () {
		return this.replace(/^\s*/, "").replace(/\s*$/, "");
		}


		String.prototype.padL = function (nLength, sChar) {
		var sreturn = this;
		while (sreturn.length < nLength) {
		sreturn = String(sChar) + sreturn;
		}
		return sreturn;

		}
    </script>  
	
    <div class="f-row">
		<div class="eight columns">
			<asp:Panel ID="pnlMain" runat="server">
				<uc3:MessageBox ID="MessageBox1" runat="server" />
				<asp:Label ID="lblError" runat="server" CssClass="errormessage"></asp:Label>
				<table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
					<tr>
						<td colspan="2">
							<asp:ImageButton ID="btnCancel2" TabIndex="9006" runat="server" ImageUrl="../images/buttons/Cancel.png"
								CausesValidation="False"></asp:ImageButton>
							&nbsp;
							<asp:ImageButton ID="update1" runat="server" ImageUrl="../images/buttons/update.png"/>
							&nbsp;
							<asp:ImageButton ID="btnSave2" TabIndex="9005" runat="server" ImageUrl="../images/buttons/SaveAndContinue.png">
							</asp:ImageButton>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<h2>General</h2>
							<div id="ProductCombinationParagraph" runat="server" visible="false" class="messagebox">
								<ul>
									<li>This product contains customer choices. Changing settings on this page will
								not affect these customer choices. In order to modify customer choices please click "Edit Product Variations"
								on the menu to the left.</li>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<td class="formlabel">
							Active:
						</td>
						<td class="formfield">
							<asp:CheckBox Checked="true" ID="chkActive" TabIndex="1600" Text="Yes" runat="server"></asp:CheckBox>
						</td>
					</tr>
					<tr>
						<td class="formlabel">
							SKU:
						</td>
						<td class="formfield">
							<asp:TextBox ID="SkuField" TabIndex="1650" runat="server" CssClass="wide"></asp:TextBox>

							<bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="errormessage" ControlToValidate="SkuField" ForeColor=" " ErrorMessage="SKU is required" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>
							<bvc5:BVRegularExpressionValidator ID="SkuBVRegularExpressionValidator" runat="server" ControlToValidate="SkuField" CssClass="errormessage" Text="*" ErrorMessageKey="Catalog.Product.Sku.LengthExceeded" RegularExpressionKey="Catalog.Product.Sku" Display="Dynamic"></bvc5:BVRegularExpressionValidator>
						</td>
					</tr>
					<tr>
						<td class="formlabel"  >
							Name: <uc4:ProductFieldCopier ID="ProductFieldCopier1" runat="server" FieldToCopy="ProductNameField" FieldToCopyTo="ProductName" OnClicked="ProductPropertyCopier_Clicked" />
						</td>
						<td class="formfield"   >
							<asp:TextBox ID="ProductNameField" TabIndex="1700" runat="server" CssClass="wide"></asp:TextBox> 
							<bvc5:BVRequiredFieldValidator ID="valName" runat="server" CssClass="errormessage" ControlToValidate="ProductNameField" ForeColor=" " ErrorMessage="Product name is required" Display="Dynamic">*</bvc5:BVRequiredFieldValidator>
							<bvc5:BVRegularExpressionValidator ID="ProductNameBVRegularExpressionValidator" runat="server" ControlToValidate="ProductNameField" CssClass="errormessage" Text="*" ErrorMessageKey="Catalog.Product.ProductName.LengthExceeded" RegularExpressionKey="Catalog.Product.ProductName" Display="Dynamic"></bvc5:BVRegularExpressionValidator>                        
						</td>
					</tr>
					<tr>
						<td class="formlabel"  >
							Product Type:</td>
						<td class="formfield"  >
							<asp:DropDownList ID="lstProductType" TabIndex="1800" runat="server" Width="300px"
								AutoPostBack="True">
							</asp:DropDownList>
							<bvc5:BVCustomValidator ID="ProductTypeCustomValidator" runat="server" ErrorMessage="Test">*</bvc5:BVCustomValidator></td>
					</tr>
					<asp:Literal ID="ProductTypePropertiesLiteral" runat="server">
					</asp:Literal><tr><td colspan="2"><h2>Pricing</h2></td></tr>
					<tr>
						<td class="formlabel"  >
							MSRP: <uc4:ProductFieldCopier ID="ProductFieldCopier2" runat="server" FieldToCopy="ListPriceField" FieldToCopyTo="MSRP" OnClicked="ProductPropertyCopier_Clicked" />
						</td>
						<td class="formfield"  >
							<asp:TextBox ID="ListPriceField" TabIndex="2000" runat="server" Columns="10" CssClass="FormInput"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="errormessage"
								ControlToValidate="ListPriceField" ForeColor=" " ErrorMessage="List Price is required">*</bvc5:BVRequiredFieldValidator>
								
							<bvc5:BVCustomValidator ID="CustomValidator1" runat="server" ControlToValidate="ListPriceField"
								CssClass="errormessage" ErrorMessage="Msrp must be a currency value">*</bvc5:BVCustomValidator>
						</td>
					</tr>
					<tr>
						<td class="formlabel"  >
							Cost: <uc4:ProductFieldCopier ID="ProductFieldCopier3" runat="server" FieldToCopy="CostField" FieldToCopyTo="SiteCost" OnClicked="ProductPropertyCopier_Clicked" />
						</td>
						
						<td class="formfield" >
							<asp:TextBox ID="CostField" runat="server" Columns="10" CssClass="FormInput" TabIndex="2100"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CostField"
								CssClass="errormessage" ErrorMessage="Cost is required" ForeColor=" ">*</bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="CustomValidator2" runat="server" ControlToValidate="CostField"
								CssClass="errormessage" ErrorMessage="Cost must be a currency value">*</bvc5:BVCustomValidator>
						</td>
					</tr>
					<tr>
						<td class="formlabel"  >
							Price: <uc4:ProductFieldCopier ID="ProductFieldCopier4" runat="server" FieldToCopy="SitePriceField" FieldToCopyTo="SitePrice" OnClicked="ProductPropertyCopier_Clicked" />
						</td>
						<td class="formfield"  >
							<asp:TextBox ID="SitePriceField" TabIndex="2200" runat="server" Columns="10" CssClass="FormInput"></asp:TextBox>
							
							<bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="errormessage"
								ControlToValidate="SitePriceField" ForeColor=" " ErrorMessage="Site Price is required">*</bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="CustomValidator3" runat="server" ControlToValidate="SitePriceField"
								CssClass="errormessage" ErrorMessage="Price must be a currency value">*</bvc5:BVCustomValidator>&nbsp;
								Text:<uc4:ProductFieldCopier ID="ProductFieldCopier12" runat="server" FieldToCopy="PriceOverrideTextBox" FieldToCopyTo="SitePriceOverrideText" OnClicked="ProductPropertyCopier_Clicked" />&nbsp; <asp:TextBox ID="PriceOverrideTextBox" runat="server" Columns="15" TabIndex="2300"></asp:TextBox>&nbsp;
						</td>
					</tr>
					<tr><td colspan="2"><h2>Properties</h2></td></tr>
					<tr>
						<td class="formlabel">
							Manufacturer:</td>
						<td class="formfield">
							<asp:DropDownList ID="lstManufacturers" TabIndex="2400" runat="server" Width="300px">
							</asp:DropDownList></td>
					</tr>
					<tr>
						<td class="formlabel">
							Vendor:</td>
						<td class="formfield">
							<asp:DropDownList ID="lstVendors" TabIndex="2500" runat="server" Width="300px">
							</asp:DropDownList></td>
					</tr>           
					<tr>
						<td class="formlabel">
							&nbsp;
						</td>
						<td class="formfield">
							<table runat="server" id="tblGeneral"></table>
						</td>
					</tr>            
					<tr><td colspan="2"><h2>Description</h2></td></tr>
					<tr>
						<td colspan="2">
							Long: 
                            <uc4:ProductFieldCopier ID="ProductFieldCopier5" runat="server" FieldToCopy="LongDescriptionField" FieldToCopyTo="LongDescription" OnClicked="ProductPropertyCopier_Clicked" />
							<uc1:HtmlEditor ID="LongDescriptionField" runat="server" EditorWrap="true" TabIndex="2600" />
                            <br /></br>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							Short: 
                            <uc4:ProductFieldCopier ID="ProductFieldCopier6" runat="server" FieldToCopy="ShortDescriptionField" FieldToCopyTo="ShortDescription" OnClicked="ProductPropertyCopier_Clicked" />
							<asp:TextBox ID="ShortDescriptionField" TabIndex="3000" runat="server" TextMode="MultiLine" MaxLength="512" Rows="7" CssClass="FormInput"></asp:TextBox><br />
							<asp:TextBox ID="CountField" runat="server" Columns="5" ReadOnly="true" Text="512"></asp:TextBox>
							characters left
							<br /></br><br />

						</td>
					</tr>
					<tr>
						<td class="formlabel">
							Search Keywords:</td>
						<td >
							<asp:TextBox ID="Keywords" runat="server" Rows="1" TabIndex="3100" CssClass="wide"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td class="formlabel">
							Meta Title:</td>
						<td class="formfield">
							<asp:TextBox ID="MetaTitleField" runat="server" Rows="1" TabIndex="3200" CssClass="wide"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td class="formlabel">
							Meta Description:</td>
						<td class="formfield" >
							<asp:TextBox ID="MetaDescriptionField" runat="server" TextMode="multiLine" Rows="3" TabIndex="3300"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td class="formlabel">
							Meta Keywords:</td>
						<td class="formfield">
							<asp:TextBox ID="MetaKeywordsField" runat="server" TextMode="multiLine" Rows="3" TabIndex="3400"></asp:TextBox>
						</td>
					</tr>
					
					<tr><td colspan="2"><h2>Tax</h2></td></tr>
					<tr>
						<td class="formlabel">
							Tax Class</td>
						<td class="formfield">
							<asp:DropDownList ID="TaxClassField" runat="server" Width="300px" TabIndex="4000">
								<asp:ListItem> - None -</asp:ListItem>
							</asp:DropDownList></td>
					</tr>
					<tr>
						<td class="formlabel">
							Tax Exempt?</td>
						<td class="formfield">
							<asp:CheckBox Checked="false" ID="TaxExemptField" TabIndex="4100" Text="Yes" runat="server"></asp:CheckBox>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<h2>Shipping</h2>
						</td>
					</tr>
					<tr>
						<td class="formlabel">
							Weight: <uc4:ProductFieldCopier ID="ProductFieldCopier7" runat="server" FieldToCopy="WeightField" FieldToCopyTo="Weight" OnClicked="ProductPropertyCopier_Clicked" />
						</td>
						<td class="formfield">
							<asp:TextBox ID="WeightField" runat="server" Columns="5" Rows="1" TabIndex="5000"></asp:TextBox>
							
							<bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="WeightField"
								Display="Dynamic" ErrorMessage="Weight is required.">*</bvc5:BVRequiredFieldValidator>
							<anthem:CustomValidator ID="CustomValidator4" runat="server" ControlToValidate="WeightField"
								Display="Dynamic" ErrorMessage="Weight must be a numeric value.">*</anthem:CustomValidator></td>
					</tr>
					<tr>
						<td class="formlabel">
							Dimensions:</td>
						<td class="formfield">
							<asp:TextBox ID="LengthField" runat="server" Columns="5" Rows="1" TabIndex="5100"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="LengthField"
								Display="Dynamic" ErrorMessage="Length is required.">*</bvc5:BVRequiredFieldValidator>
							<anthem:CustomValidator ID="CustomValidator5" runat="server" ControlToValidate="LengthField"
								Display="Dynamic" ErrorMessage="Length must be a numeric value.">*</anthem:CustomValidator>
							L x <asp:TextBox ID="WidthField" runat="server" Columns="5" Rows="1" TabIndex="5200"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="WidthField"
								Display="Dynamic" ErrorMessage="Width is required.">*</bvc5:BVRequiredFieldValidator>
							<anthem:CustomValidator ID="CustomValidator6" runat="server" ControlToValidate="WidthField"
								Display="Dynamic" ErrorMessage="Width must be a numeric value.">*</anthem:CustomValidator>
							W x <asp:TextBox ID="HeightField" runat="server" Columns="5" Rows="1" TabIndex="5300"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="HeightField"
								Display="Dynamic" ErrorMessage="Height is required.">*</bvc5:BVRequiredFieldValidator>
							<anthem:CustomValidator ID="CustomValidator7" runat="server" ControlToValidate="HeightField"
								Display="Dynamic" ErrorMessage="Height must be a numeric value.">*</anthem:CustomValidator>
							H
						</td>
					</tr>
					<tr>
						<td class="formlabel">
							Extra Ship Fee: <uc4:ProductFieldCopier ID="ProductFieldCopier11" runat="server" FieldToCopy="ExtraShipFeeField" FieldToCopyTo="ExtraShipFee" OnClicked="ProductPropertyCopier_Clicked" /></td>
						<td class="formfield">
							<asp:TextBox ID="ExtraShipFeeField" runat="server" Columns="5" Rows="1" TabIndex="5400"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ExtraShipFeeField"
								Display="Dynamic" ErrorMessage="Extra Ship Fee is required.">*</bvc5:BVRequiredFieldValidator>
							<anthem:CustomValidator ID="CustomValidator8" runat="server" ControlToValidate="ExtraShipFeeField"
								Display="Dynamic" ErrorMessage="Extra Ship Fee must be a numeric value.">*</anthem:CustomValidator></td>
					</tr>
					<tr>
						<td class="formlabel">
							Ship Mode: <uc4:ProductFieldCopier id="ProductFieldCopier8" runat="server" FieldToCopy="chkNonShipping" FieldToCopyTo="NonShipping" OnClicked="ProductPropertyCopier_Clicked"></uc4:ProductFieldCopier>
						</td>
						<td class="formfield">
							<asp:DropDownList ID="ShipTypeField" runat="server">
							    <asp:ListItem Text="Ship from Store" Value="1"></asp:ListItem>
							    <asp:ListItem Text="Drop Ship from Manufacturer" Value="3"></asp:ListItem>
							    <asp:ListItem Text="Drop Ship from Vendor" Value="2"></asp:ListItem>
							</asp:DropDownList><br />
							<asp:CheckBox ID="chkNonShipping" runat="server" Text="Non-Shipping Product" /><br />
							<asp:CheckBox ID="chkShipSeparately" runat="server" Text="Ship Separately" />
						</td>
					</tr>
					<tr><td colspan="2"><h2>Gift Wrap</h2></td></tr>
					<tr>
						<td class="formlabel">Gift Wrap:</td>
						<td class="formfield"><asp:CheckBox ID="chkGiftWrapAllowed" Text="Yes" runat="server" /></td>
					</tr>
					<tr>
						<td class="formlabel">Gift Wrap Charge:</td>
						<td class="formfield"><asp:TextBox ID="txtGiftWrapCharge" runat="server" Columns="5" Rows="1" TabIndex="6050" Text="0.00"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="BVRequiredFieldValidator1" runat="server" ControlToValidate="txtGiftWrapCharge"
								Display="Dynamic" ErrorMessage="Gift Wrap Charge is required.">*</bvc5:BVRequiredFieldValidator>
							<bvc5:BVCustomValidator ID="BVCustomValidator1" runat="server" ControlToValidate="txtGiftWrapCharge"
								CssClass="errormessage" ErrorMessage="Gift Wrap Charge must be a currency value">*</bvc5:BVCustomValidator></td>
					</tr>
					<tr><td colspan="2"><h2>Advanced</h2></td></tr>
					<tr>
						<td class="formlabel">
							Rewrite Url To:</td>
						<td class="formfield" >
							<asp:TextBox ID="RewriteUrlField" runat="server" TabIndex="6000" CssClass="wide"></asp:TextBox></td>
					</tr>
					<tr>
						<td class="formlabel">
							Minimum Qty:</td>
						<td class="formfield">
							<asp:TextBox ID="MinimumQtyField" runat="server" Columns="5" Rows="1" TabIndex="6050" Text="0"></asp:TextBox>
							<bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="MinimumQtyField"
								Display="Dynamic" ErrorMessage="Minimum Quantity is required.">*</bvc5:BVRequiredFieldValidator><bvc5:BVRegularExpressionValidator
									ID="RegularExpressionValidator6" runat="server" ControlToValidate="MinimumQtyField"
									Display="Dynamic" ErrorMessage="Minimum Quantity must be numeric." ValidationExpression="[0-9]{1,6}">*</bvc5:BVRegularExpressionValidator></td>
					</tr>
					<tr>
						<td class="formlabel">
							Pre-Content Column</td>
						<td class="formfield">
							<asp:DropDownList ID="PreContentColumnIdField" runat="server" Width="300px" TabIndex="6100">
								<asp:ListItem Value="">- None -</asp:ListItem>
							</asp:DropDownList></td>
					</tr>
					<tr>
						<td class="formlabel">
							Post-Content Column
						</td>
						<td class="formfield">
							<asp:DropDownList ID="PostContentColumnIdField" runat="server" Width="300px" TabIndex="6200">
								<asp:ListItem Value="">- None -</asp:ListItem>
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2" class="formfield">
							<asp:ImageButton ID="btnCancel" TabIndex="6300" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
							&nbsp;
							<asp:ImageButton ID="update2" runat="server" ImageUrl="../images/buttons/update.png" TabIndex="6400"/>
							&nbsp;
							<asp:ImageButton ID="btnSaveChanges" TabIndex="6500" runat="server" ImageUrl="../images/buttons/SaveAndContinue.png">
							</asp:ImageButton>
						</td>
					</tr>
				</table>
			</asp:Panel>
			<asp:HiddenField ID="BvinField" runat="server" />
		</div>
		
		<div class="four columns">
			<h2>Small Image</h2>
			<div class="controlarea1">
				<asp:Image ID="imgPreviewSmall" runat="server" ImageUrl="../images/NoImageAvailable.gif" CssClass="ProdImagePreview"></asp:Image>
				
				<br /><br />
				
				<asp:TextBox ID="ImageFileSmallField" runat="server" CssClass="FormInput" TabIndex="6600"></asp:TextBox>
				<br /><br />
				<a href="javascript:popUpWindow('?returnScript=SetSmallImage&WebMode=1');">
					<asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="imgSelect1" TabIndex="6700" />
				</a>
					
				<uc4:ProductFieldCopier ID="ProductFieldCopier9" runat="server" FieldToCopy="ImageFileSmallField" FieldToCopyTo="SmallImage" OnClicked="ProductPropertyCopier_Clicked" />
					
				<br /><br />
				
				Alternate Text:
				<asp:TextBox ID="SmallImageAlternateTextField" runat="server" CssClass="FormInput" TabIndex="6601"></asp:TextBox>
			</div>
			
			<h2>Medium Image</h2>
			<div class="controlarea1">
				<asp:Image ID="imgPreviewMedium" runat="server" ImageUrl="../images/NoImageAvailable.gif"  CssClass="ProdImagePreview"></asp:Image>
				
				<br /><br />
				
				<asp:TextBox ID="ImageFileMediumField" runat="server" CssClass="FormInput" TabIndex="6800"></asp:TextBox>
				<br /><br />
				<a href="javascript:popUpWindow('?returnScript=SetMediumImage&WebMode=1');">
					<asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="Image1" TabIndex="6900" />
				</a>
				
				<uc4:ProductFieldCopier ID="ProductFieldCopier10" runat="server" FieldToCopy="ImageFileMediumField" FieldToCopyTo="MediumImage" OnClicked="ProductPropertyCopier_Clicked" />
				
				<br /><br />
				
				Alternate Text:
				<asp:TextBox ID="MediumImageAlternateTextField" runat="server" CssClass="FormInput" TabIndex="6901"></asp:TextBox>
			</div>
			<h2>Display Template</h2>
			<anthem:Panel CssClass="controlarea1" AutoUpdateAfterCallBack="true" runat="server">
				<table border="0" cellspacing="0" cellpadding="0" style="width: 100%;">
					<tr>
						<td style="width:50px">
							<asp:Image ID="TemplatePreviewImage" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/NoCategoryPreview.gif" />
						</td>
                        <td class="formfield">
							<asp:DropDownList ID="lstTemplateName" runat="server" AutoPostBack="True" TabIndex="7000">
								<asp:ListItem Value="BV Grid">- No Templates Found -</asp:ListItem>
							</asp:DropDownList></td>
					</tr>
					<tr>
						<td colspan="2">
                            <br />
                            <asp:HyperLink ID="lnkView" EnableViewState="false" runat="server" />
						</td>
					</tr>
				</table>
			</anthem:Panel>
		</div>        
    </div>    
</asp:Content>
<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Kit_Edit.aspx.vb" Inherits="BVAdmin_Catalog_Products_Kit_Edit" Title="Edit Kit/Bundle Items"
    ValidateRequest="false" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../Controls/KitComponentViewer.ascx" TagName="KitComponentViewer" TagPrefix="uc2" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<%@ Register Src="../Controls/HtmlEditor.ascx" TagName="HtmlEditor" TagPrefix="uc2" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Kit Edit</h1>
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    
    <asp:Panel ID="pnlMain" runat="server" CssClass="f-row">
    	
        <div class="nine columns">
            <h2>General</h2>
            <table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
                <tr>
                    <td class="formlabel" >
                        Active:
                    </td>
                    <td class="formfield" valign="top" align="left" >
                        <asp:CheckBox Checked="true" ID="chkActive" TabIndex="100" runat="server"></asp:CheckBox>
                    </td>
                </tr>
                <tr>
                    <td class="formlabel" >
                        SKU:
                    </td>
                    <td class="formfield" valign="top" align="left" >
                        <asp:TextBox ID="SkuField" TabIndex="200" runat="server" Columns="40"
                            Width="300px"></asp:TextBox>
                        <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="errormessage"
                            ControlToValidate="SkuField" ForeColor=" " ErrorMessage="SKU is required">*</bvc5:BVRequiredFieldValidator>
                        <bvc5:BVRegularExpressionValidator ID="SkuBVRegularExpressionValidator" runat="server"
                            ControlToValidate="SkuField" CssClass="errormessage" Text="*" ErrorMessageKey="Catalog.Product.Sku.LengthExceeded"
                            RegularExpressionKey="Catalog.Product.Sku"></bvc5:BVRegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="formlabel" >
                        Name:
                    </td>
                    <td class="formfield" valign="top" align="left" >
                        <asp:TextBox ID="ProductNameField" TabIndex="300" runat="server" Columns="40"
                            Width="300px"></asp:TextBox>
                        <bvc5:BVRequiredFieldValidator ID="valName" runat="server" CssClass="errormessage"
                            ControlToValidate="ProductNameField" ForeColor=" " ErrorMessage="Kit name is required">*</bvc5:BVRequiredFieldValidator>
                        <bvc5:BVRegularExpressionValidator ID="ProductNameBVRegularExpressionValidator" runat="server"
                            ControlToValidate="ProductNameField" CssClass="errormessage" Text="*" ErrorMessageKey="Catalog.Product.ProductName.LengthExceeded"
                            RegularExpressionKey="Catalog.Product.ProductName"></bvc5:BVRegularExpressionValidator>
                    </td>
                </tr>
            </table>
            
            <h2>Description</h2>
            <table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
                <tr>
                    <td class="formlabel" >
                        Long:
                    </td>
                    <td class="formfield" valign="top" align="left" >
                        <uc2:HtmlEditor ID="LongDescriptionField" runat="server" EditorHeight="120" EditorWidth="325"
                            EditorWrap="true" TabIndex="400" />
                    </td>
                </tr>
                <tr>
                    <td class="formlabel" >
                        Short:
                    </td>
                    <td class="formfield" valign="top" align="left" >
                        <asp:TextBox ID="ShortDescriptionField" TabIndex="500" runat="server" TextMode="MultiLine"
                            MaxLength="255" Rows="7" Columns="50" Width="325px"></asp:TextBox>
                            <br /><br />
                        <asp:TextBox ID="CountField" runat="server" Columns="5" ReadOnly="true" Text="255"></asp:TextBox>
                        characters left
                    </td>
                </tr>
            </table>
            <br />
            <div id="advancedpanel">
                <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                    <tr>
                        <td class="formlabel">
                            Search Keywords:
                        </td>
                        <td>
                            <asp:TextBox ID="Keywords" runat="server" Columns="40" Rows="1" Width="325px" TabIndex="9100"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" >
                            Meta Title:
                        </td>
                        <td class="formfield">
                            <asp:TextBox ID="MetaTitleField" runat="server" Columns="40" Rows="1" Width="325px"
                                TabIndex="9200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" >
                            Meta Description:
                        </td>
                        <td class="formfield">
                            <asp:TextBox ID="MetaDescriptionField" runat="server" TextMode="multiLine" Columns="40"
                                Rows="3" Width="325px" TabIndex="9300"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" >
                            Meta Keywords:
                        </td>
                        <td class="formfield">
                            <asp:TextBox ID="MetaKeywordsField" runat="server" TextMode="multiLine" Columns="40"
                                Rows="3" Width="325px" TabIndex="9400"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                
                <h2>Shipping</h2>
                <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                    <tr>
                        <td class="formlabel" >
                            Dimensions:
                        </td>
                        <td class="formfield">
                            <asp:TextBox ID="LengthField" runat="server" Columns="5" Rows="1" TabIndex="9501" Text="0"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="LengthField"
                                Display="Dynamic" ErrorMessage="Length is required.">*</bvc5:BVRequiredFieldValidator>
                            <bvc5:BVCustomValidator ID="CustomValidator5" runat="server" ControlToValidate="LengthField"
                                Display="Dynamic" ErrorMessage="Length must be a numeric value.">*</bvc5:BVCustomValidator>
                            L x
                            <asp:TextBox ID="WidthField" runat="server" Columns="5" Rows="1" TabIndex="9502" Text="0"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="WidthField"
                                Display="Dynamic" ErrorMessage="Width is required.">*</bvc5:BVRequiredFieldValidator>
                            <bvc5:BVCustomValidator ID="CustomValidator6" runat="server" ControlToValidate="WidthField"
                                Display="Dynamic" ErrorMessage="Width must be a numeric value.">*</bvc5:BVCustomValidator>
                            W x
                            <asp:TextBox ID="HeightField" runat="server" Columns="5" Rows="1" TabIndex="9503" Text="0"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="HeightField"
                                Display="Dynamic" ErrorMessage="Height is required.">*</bvc5:BVRequiredFieldValidator>
                            <bvc5:BVCustomValidator ID="CustomValidator7" runat="server" ControlToValidate="HeightField"
                                Display="Dynamic" ErrorMessage="Height must be a numeric value.">*</bvc5:BVCustomValidator>
                            H
                        </td>
                    </tr>
                </table>
                
                <h2>Advanced</h2>
                <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                    <tr>
                        <td class="formlabel">
                            Rewrite Url To:
                        </td>
                        <td class="formfield" >
                            <asp:TextBox ID="RewriteUrlField" runat="server" Columns="30" Width="300px" TabIndex="9600"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" >
                            Minimum Qty:
                        </td>
                        <td class="formfield">
                            <asp:TextBox ID="MinimumQtyField" runat="server" Columns="5" Rows="1" TabIndex="9700"
                                Text="0"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="MinimumQtyField"
                                Display="Dynamic" ErrorMessage="Minimum Quantity is required.">*</bvc5:BVRequiredFieldValidator><bvc5:BVRegularExpressionValidator
                                    ID="RegularExpressionValidator6" runat="server" ControlToValidate="MinimumQtyField"
                                    Display="Dynamic" ErrorMessage="Minimum Quantity must be numeric." ValidationExpression="[0-9]{1,6}">*</bvc5:BVRegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Pre-Content Column
                        </td>
                        <td class="formfield" >
                            <asp:DropDownList ID="PreContentColumnIdField" runat="server" Width="300px" TabIndex="9801">
                                <asp:ListItem> - None -</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Post-Content Column
                        </td>
                        <td class="formfield" >
                            <asp:DropDownList ID="PostContentColumnIdField" runat="server" Width="300px" TabIndex="9802">
                                <asp:ListItem> - None -</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
            </div>
            
            <asp:ImageButton ID="CancelButton" TabIndex="9999" runat="server" ImageUrl="../images/buttons/Cancel.png"
                CausesValidation="False"></asp:ImageButton>
            &nbsp;
            <asp:ImageButton ID="UpdateButton" runat="server" ImageUrl="../images/buttons/update.png"
                TabIndex="1000" />
            &nbsp;
            <asp:ImageButton ID="SaveButton" TabIndex="1100" runat="server" ImageUrl="../images/buttons/SaveChanges.png">
            </asp:ImageButton>
        </div>
        
        <div class="three columns">
            <div class="controlarea1">
                <asp:LinkButton ID="CategoryEditLinkButton" runat="server">Edit Categories</asp:LinkButton>
            </div>
            
            <h2>Small Image</h2>
            
            <div class="controlarea1">
                <asp:Image ID="imgPreviewSmall" runat="server" ImageUrl="../images/NoImageAvailable.gif" CssClass="ProdImagePreview">
                </asp:Image>
                <br />
                <br />   
                <asp:TextBox ID="ImageFileSmallField" runat="server"></asp:TextBox>
                <br />
                <br />  
                <a href="javascript:popUpWindow('?returnScript=SetSmallImage&WebMode=1');">
                <asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="imgSelect1" /></a>
                <br />
                <br />                        
                Alternate Text:
                <asp:TextBox ID="SmallImageAlternateTextField" runat="server" TabIndex="6601"></asp:TextBox>
            </div>
            
            <h2>Medium Image</h2>
            <div class="controlarea1">
                <asp:Image ID="imgPreviewMedium" runat="server" ImageUrl="../images/NoImageAvailable.gif"  CssClass="ProdImagePreview">
            </asp:Image>
                <br />
                <br />   
                <asp:TextBox ID="ImageFileMediumField" runat="server"></asp:TextBox>
                <br />
                <br />   
                <a href="javascript:popUpWindow('?returnScript=SetMediumImage&WebMode=1');">
                <asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="Image1" /></a>
                <br />   
                <br />
                Alternate Text:
                <asp:TextBox ID="MediumImageAlternateTextField" runat="server" TabIndex="6901"></asp:TextBox>
            </div>
            
            <h2>Display Template</h2>
            <anthem:Panel CssClass="controlarea1" AutoUpdateAfterCallBack="true" runat="server">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td style="width:50px">
                            <asp:Image ID="TemplatePreviewImage" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/NoCategoryPreview.gif" /></td>
                        <td class="formfield">
                            <asp:DropDownList ID="lstTemplateName" runat="server" AutoPostBack="True" TabIndex="7000">
                                <asp:ListItem Value="List">- No Templates Found -</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <br />
                            <asp:PlaceHolder ID="inStore" runat="Server"></asp:PlaceHolder>
                        </td>
                    </tr>
                </table>
            </anthem:Panel>
        </div>
           
    </asp:Panel>
    
    <hr />
    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
        <tr>
            <td id="AdminContentWithNav">
                &nbsp;
                <br />
                <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                    <tr>
                        <td class="formlabel">
                            Price Range:
                        </td>
                        <td class="formfield">
                            <asp:Label ID="lblPriceRange" runat="server"></asp:Label>
                        </td>
                        <td class="formlabel">
                            Default:
                        </td>
                        <td class="formfield">
                            <asp:Label ID="lblDefaultPrice" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Weight Range:
                        </td>
                        <td class="formfield">
                            <asp:Label ID="lblWeightRange" runat="server"></asp:Label>
                        </td>
                        <td class="formlabel">
                            Default:
                        </td>
                        <td class="formfield">
                            <asp:Label ID="lblDefaultWeight" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
                <div class="kitComponents">
                    <asp:LinkButton ID="btnAddComponent" runat="server" Text="Add New Component"></asp:LinkButton>
                    <anthem:DataList DataKeyField="Bvin" ID="dl" runat="server" AutoUpdateAfterCallBack="true" style="width:100%;">
                        <ItemTemplate>
                            <div id="KitGroupInfo">
                                <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                                    <tr>
                                        <td style="padding: 4px 5px;">
                                            <div class="KitGroupTitle">
                                                <%#Eval("DisplayName")%>
                                                <asp:Label ID="lblType" runat="server"></asp:Label></div>
                                        </td>
                                        <td style="padding: 4px 5px; text-align:right;">
                                            <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="~/BVAdmin/images/buttons/Edit.png" CommandName="Edit" Text="Edit"></asp:ImageButton>&nbsp;
                                            <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="~/BVAdmin/images/buttons/Delete.png" CommandName="Delete" Text="Delete" OnClientClick="return window.confirm('Delete this component?');"></asp:ImageButton>&nbsp;
                                            <asp:ImageButton ID="btnUp" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Up.png" Text="Up" CommandName="Update" CommandArgument="Up" />&nbsp;
                                            <asp:ImageButton ID="btnDown" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Down.png" Text="Down" CommandName="Update" CommandArgument="Down" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="padding: 10px;">
                                            <uc2:KitComponentViewer ID="KitComponentViewer1" runat="server" />
                                        </td>
                                    </tr>
                                    
                                </table>
                                <br />
                                <br />
                                <asp:LinkButton ID="btnAddPart" runat="server" Text="Add New Part" CommandName="Update" CommandArgument="Add"></asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </anthem:DataList>
                </div>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="KitGroupField" runat="server" Value="" />
</asp:Content>

<%@ Page ValidateRequest="false" Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Categories_Edit.aspx.vb" Inherits="BVAdmin_Catalog_Categories_Edit"
    Title="Edit Category" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc3" %>
<%@ Register Src="../Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail" TagPrefix="uc2" %>
<%@ Register Src="../Controls/HtmlEditor.ascx" TagName="HtmlEditor" TagPrefix="uc1" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Edit Category</h1>
    <uc3:MessageBox ID="MessageBox1" runat="server" />
    <asp:Label ID="lblError" runat="server" CssClass="errormessage"></asp:Label>
    <uc2:CategoryBreadCrumbTrail ID="CategoryBreadCrumbTrail1" runat="server" />

    <asp:Panel ID="pnlMain" runat="server">
    
    <div class="f-row">
    	<div class="twelve columns">
            <div style="margin: 5px 0;">
                <asp:PlaceHolder ID="inStore" runat="Server"></asp:PlaceHolder>
            </div>
            <hr />
            <table border="0" cellspacing="0" cellpadding="0" style="width:100%">
                <tr>
                    <td class="formlabel">
                        Name:
                    </td>
                    <td class="formfield">
                        <asp:TextBox ID="NameField" runat="server" MaxLength="100" CssClass="wide" TabIndex="2000" ></asp:TextBox>
                        <bvc5:BVRequiredFieldValidator ID="valName" runat="server" ErrorMessage="Please enter a name" Display="Dynamic" ControlToValidate="NameField">*</bvc5:BVRequiredFieldValidator>
                        <div style="padding:4px 0 10px;">
                            <asp:CheckBox ID="chkShowTitle" runat="server" Text="Display Category Name" Checked="True" TabIndex="2011" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="formlabel">
                        Description:</td>
                    <td class="formfield">
                        <uc1:HtmlEditor ID="DescriptionField" EditorHeight="200" runat="server" EditorWrap="true" TabIndex="2001" />
                    </td>
                </tr>
                <tr>
                    <td class="formlabel">
                        Short Description:</td>
                    <td class="formfield">
                        <asp:TextBox ID="ShortDescriptionField" runat="server" TextMode="MultiLine" Columns="30" Rows="7" MaxLength="512" TabIndex="2002" Width="300px"></asp:TextBox>
                        <asp:TextBox ID="CountField" runat="server" Columns="5" ReadOnly="true" Text="512"></asp:TextBox> characters left
                    </td>
                </tr>
            </table>
            <hr />
        </div>
    </div>

    <div class="f-row">
    	<div class="seven columns">
            <table border="0" cellspacing="0" cellpadding="0" style="width:100%">
                <tr>
                    <td class="formlabel">
                        Rewrite Url:
                    </td>
                    <td class="formfield">
                        <asp:TextBox ID="RewriteUrlField" runat="server" CssClass="wide" TabIndex="2022"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="formlabel">
                        Page Title:
                    </td>
                    <td class="formfield">
                        <asp:TextBox ID="MetaTitleField" runat="server" MaxLength="512" CssClass="wide" TabIndex="2002"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="formlabel">
                        Meta Description:
                    </td>
                    <td class="formfield">
                        <asp:TextBox ID="MetaDescriptionField" runat="server" MaxLength="255" TabIndex="2003" Rows="4" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="formlabel">
                        Meta Keywords:
                    </td>
                    <td class="formfield">
                        <asp:TextBox ID="MetaKeywordsField" runat="server" MaxLength="255" CssClass="wide" TabIndex="2004"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="formlabel">
                        Keywords:
                    </td>
                    <td class="formfield">
                        <asp:TextBox ID="keywords" runat="server" MaxLength="512" CssClass="wide" TabIndex="2005"></asp:TextBox>
                    </td>
                </tr>
            </table>

            <hr />

            <table border="0" cellspacing="0" cellpadding="0" style="width:100%">
                <tr>
                    <td class="formlabel">
                        Default Sort Order
                    </td>
                    <td class="formfield">
                        <asp:DropDownList ID="SortOrderDropDownList" runat="server" TabIndex="2008">
                            <asp:ListItem Value="1">Manual Order</asp:ListItem>
                            <asp:ListItem Value="2">Product Name</asp:ListItem>
                            <asp:ListItem Value="3">Product Price Ascending</asp:ListItem>
                            <asp:ListItem Value="4">Product Price Descending</asp:ListItem>
                            <asp:ListItem Value="5">Manufacturer Name</asp:ListItem>
                            <asp:ListItem Value="6">Creation Date Descending</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="formlabel">
                        Allow Resorting
                    </td>
                    <td class="formfield">
                        <asp:CheckBox ID="CustomerOverridableSortOrderCheckBox" runat="server" Text="Yes" Checked="False" TabIndex="2011" />
                        <br />
                        <span class="smalltext">This option will show a drop-down list that will allow a customer to select a sort order.</span>
                        <br /><br />
                    </td>
                </tr>
                <tr>
                    <td class="formlabel">
                        Hide Category
                    </td>
                    <td class="formfield">
                        <asp:CheckBox ID="chkHidden" runat="server" Text="Yes" TabIndex="2009" /></td>
                </tr>
                    <tr>
                    <td class="formlabel">
                        Show in Top Menu
                    </td>
                    <td class="formfield">
                        <asp:CheckBox ID="chkShowInTopMenu" runat="server" Text="Yes" TabIndex="2010" />
                        <br />
                        <span class="smalltext">By default only top level categories will show in main menu. Custom menus
                        may override this behavior.</span>
                        <br /><br />
                    </td>
                </tr>
                <tr>
                    <td class="formlabel">
                        Pre-Content Column</td>
                    <td class="formfield">
                        <asp:DropDownList ID="PreContentColumnIdField" runat="server" TabIndex="2006">
                            <asp:ListItem> - None -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="formlabel">
                        Post-Content Column</td>
                    <td class="formfield">
                        <asp:DropDownList ID="PostContentColumnIdField" runat="server" TabIndex="2007">
                            <asp:ListItem> - None -</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <br />
        </div>

        <div class="five columns">
            <div class="controlarea1">
                <h4 style="margin-top:0;">Parent Category</h4>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="formfield">
                            <asp:DropDownList ID="ParentCategoryDropDownList" runat="server" TabIndex="2009">
                                <asp:ListItem Value="0"> -- TOP LEVEL -- </asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="controlarea1">
                <h4 style="margin-top:0;">Category Type</h4>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="formfield">
                            <asp:DropDownList ID="SourceTypeDropDownList" runat="server" AutoPostBack="True" TabIndex="2010">
                                <asp:ListItem Selected="True" Value="0">Static Category</asp:ListItem>
                                <asp:ListItem Value="1">Dynamic Category</asp:ListItem>
                                <asp:ListItem Value="2">Custom Link</asp:ListItem>
                                <asp:ListItem Value="3">Custom Page</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </div>
            <anthem:Panel CssClass="controlarea1" AutoUpdateAfterCallBack="true" runat="server">
        	    <h4 style="margin-top:0;">Display Template</h4>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td style="width:50px">
                            <asp:Image ID="TemplatePreviewImage" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/NoCategoryPreview.png" TabIndex="2012" /></td>
                        <td class="formfield">
                            <asp:DropDownList ID="TemplateList" runat="server" AutoPostBack="True" TabIndex="2011">
                                <asp:ListItem Value="BV Grid">- No Templates Found -</asp:ListItem>
                            </asp:DropDownList><br />
                        </td>
                    </tr>
                </table>
            </anthem:Panel>
            <div class="controlarea1">
                <h4 style="margin-top:0;">Images</h4>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="formlabel short">
                            Icon:</td>
                        <td class="formfield">
                            <asp:TextBox ID="ImageField" runat="server" Columns="20" TabIndex="2013"></asp:TextBox>
                            <a href="javascript:popUpWindow('?returnScript=SetIconImage&WebMode=1');">
                                <asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="imgSelect1" /></a></td>
                    </tr>
                    <tr>
                        <td class="formlabel short">
                            Banner:</td>
                        <td class="formfield">
                            <asp:TextBox ID="BannerImageField" runat="server" Columns="20" TabIndex="2014"></asp:TextBox>&nbsp;<a
                                href="javascript:popUpWindow('?returnScript=SetBannerImage&WebMode=1');"><asp:Image
                                    runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="Image1" /></a></td>
                    </tr>
                    <tr>
                        <td class="formlabel short">
                            Menu:</td>
                        <td class="formfield">
                            <asp:TextBox ID="MenuOffImageURLField" runat="server" Columns="20" TabIndex="2015"></asp:TextBox>&nbsp;<a
                                href="javascript:popUpWindow('?returnScript=SetMenuOffImage&WebMode=1');"><asp:Image
                                    runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="Image2" /></a></td>
                    </tr>
                    <tr>
                        <td class="formlabel short">
                            Menu 2:</td>
                        <td class="formfield">
                            <asp:TextBox ID="MenuOnImageURLField" runat="server" Columns="20" TabIndex="2016"></asp:TextBox>&nbsp;<a
                                href="javascript:popUpWindow('?returnScript=SetMenuOnImage&WebMode=1');"><asp:Image
                                    runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="Image3" /></a></td>
                    </tr>
                </table>
            </div>
            <div class="controlarea1">
                <h4 style="margin-top:0;"><asp:Label runat="server" ID="lblProductSelection"></asp:Label></h4>
                <asp:Panel ID="ProductsPanel" runat="server">        
                    <asp:MultiView ID="ProductSelectionMultiView" runat="server" ActiveViewIndex="0">

                        <asp:View ID="StaticCategoryView" runat="server">
                            <asp:ImageButton ID="btnSelectProducts" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Select.png" TabIndex="2017"></asp:ImageButton>
                        </asp:View>

                        <asp:View ID="DynamicCategoryView" runat="server">
                            <asp:ImageButton ID="SelectDynamicProductImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Select.png" TabIndex="2018" />
                        </asp:View>

                        <asp:View ID="CustomLinkView" runat="server">
                            <asp:TextBox ID="CustomPageUrlField" runat="server" Columns="30" Width="200px" TabIndex="2019">http://</asp:TextBox>
                                <asp:CheckBox ID="chkCustomPageOpenInNewWindow" runat="server" Text="Open in new window" Width="150px" TabIndex="2020" />
                        </asp:View>

                        <asp:View ID="CustomPageView" runat="server">
                            <asp:DropDownList ID="CustomPageDropDownList" runat="server" TabIndex="2021"></asp:DropDownList>
                        </asp:View>

                    </asp:MultiView>
                </asp:Panel>
            </div>
        </div>
    </div>

    <div class="f-row">
    	<div class="twelve columns">
            <hr />
            <asp:ImageButton ID="btnCancel" TabIndex="2500" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
            &nbsp;
            <asp:ImageButton ID="UpdateButton" TabIndex="2501" runat="server" ImageUrl="../images/buttons/Update.png"></asp:ImageButton>
            &nbsp;
            <asp:ImageButton ID="btnSaveChanges" runat="server" ImageUrl="../images/buttons/SaveChanges.png" TabIndex="2502" />
        </div>
    </div>

    </asp:Panel>
     
    <asp:HiddenField ID="BvinField" runat="server" />
    <asp:HiddenField ID="ParentIDField" runat="Server" />
</asp:Content>

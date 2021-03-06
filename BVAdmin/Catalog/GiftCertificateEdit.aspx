<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="GiftCertificateEdit.aspx.vb" Inherits="BVAdmin_Catalog_GiftCertificateEdit" title="Edit Gift Certificate" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<%@ Register Src="../Controls/HtmlEditor.ascx" TagName="HtmlEditor" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <div class="f-row">
        <div class="twelve columns">
            <h1>Edit Gift Certificate</h1>
        </div>

		<div class="eight columns">
            <uc2:MessageBox ID="MessageBox1" runat="server" />
            <asp:Label ID="lblError" runat="server" CssClass="errormessage"></asp:Label> 

            <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSaveChanges">

                <!--
                <asp:ImageButton ID="btnCancel2" TabIndex="9006" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
                &nbsp;
                <asp:ImageButton ID="btnSave2" TabIndex="9005" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
                -->
                
                <table cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Active:
                        </td>
                        <td class="formfield" valign="top" align="left">
                            <asp:CheckBox Checked="true" ID="chkActive" TabIndex="1600" runat="server"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Gift Certificate Type:</td>
                        <td class="formfield" valign="top" align="left">
                            <asp:RadioButtonList ID="GiftCertificateTypeRadioButtonList" runat="server" AutoPostBack="True">
                                <asp:ListItem Selected="True" Value="1">Fixed Price</asp:ListItem>
                                <asp:ListItem Value="2">Customer Selected Price</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>            
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            SKU:</td>
                        <td class="formfield" valign="top" align="left">
                            <asp:TextBox ID="SkuField" TabIndex="1650" runat="server" Columns="40" CssClass="FormInput"
                                Width="300px"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="errormessage"
                                ControlToValidate="SkuField" ForeColor=" " ErrorMessage="SKU is required">*</bvc5:BVRequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Name:</td>
                        <td class="formfield" valign="top" align="left">
                            <asp:TextBox ID="ProductNameField" TabIndex="1700" runat="server" Columns="40" CssClass="FormInput"
                                Width="300px"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="valName" runat="server" CssClass="errormessage" ControlToValidate="ProductNameField"
                                ForeColor=" " ErrorMessage="Product name is required">*</bvc5:BVRequiredFieldValidator></td>
                    </tr>
                    <%--<tr>
                        <td class="formlabel" align="right" valign="top">
                            Product Type:</td>
                        <td class="formfield" valign="top" align="left"><asp:DropDownList ID="lstProductType" TabIndex="2600" runat="server" Width="300px">
                        </asp:DropDownList></td>
                    </tr>--%>
                    <%--<tr>
                        <td class="formlabel" align="right" valign="top">
                            MSRP:</td>
                        <td class="formfield" align="left">
                            <asp:TextBox ID="ListPriceField" TabIndex="1900" runat="server" Columns="10" CssClass="FormInput"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="errormessage"
                                ControlToValidate="ListPriceField" ForeColor=" " ErrorMessage="List Price is required">*</bvc5:BVRequiredFieldValidator>
                            <bvc5:BVRegularExpressionValidator ID="RegularExpressionValidator1" runat="server" CssClass="errormessage"
                                ControlToValidate="ListPriceField" ForeColor=" " ErrorMessage="Msrp must be numeric."
                                ValidationExpression="[0-9.,]+" Display="Dynamic">*</bvc5:BVRegularExpressionValidator>
                            Cost:
                            <asp:TextBox ID="CostField" runat="server" Columns="10" CssClass="FormInput" TabIndex="1900"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CostField"
                                CssClass="errormessage" ErrorMessage="Cost is required" ForeColor=" ">*</bvc5:BVRequiredFieldValidator>
                            <bvc5:BVRegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="CostField"
                                CssClass="errormessage" Display="Dynamic" ErrorMessage="Cost must be numeric."
                                ForeColor=" " ValidationExpression="[0-9.,]+">*</bvc5:BVRegularExpressionValidator></td>
                    </tr>--%>
                    <tr id="PriceRow" runat="server">
                        <td class="formlabel" align="right" valign="top">
                            Price:</td>
                        <td class="formfield" align="left">
                            <asp:TextBox ID="SitePriceField" TabIndex="2000" runat="server" Columns="10" CssClass="FormInput"></asp:TextBox>
                            <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator4" runat="server" CssClass="errormessage"
                                ControlToValidate="SitePriceField" ForeColor=" " ErrorMessage="Site Price is required">*</bvc5:BVRequiredFieldValidator>
                            <bvc5:BVCustomValidator ID="CustomValidator2" runat="server" CssClass="errormessage"
                                ControlToValidate="SitePriceField" ForeColor=" " ErrorMessage="Price must be a monetary amount."
                                Display="Dynamic">*</bvc5:BVCustomValidator></td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            &nbsp;</td>
                        <td class="formfield" valign="top" align="left">
                            <table runat="server" id="tblGeneral">
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Description:</td>
                        <td class="formfield" valign="top" align="left">
                            <uc1:HtmlEditor ID="LongDescriptionField" runat="server" EditorHeight="120" EditorWidth="325"
                                EditorWrap="true" TabIndex="2100" />
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Short Description:</td>
                        <td class="formfield" valign="top" align="left">
                            <asp:TextBox ID="ShortDescriptionField" TabIndex="2200" runat="server" TextMode="MultiLine"
                                MaxLength="255" Rows="3" Columns="40" CssClass="FormInput" Width="325px"></asp:TextBox><br />
                            <asp:TextBox ID="CountField" runat="server" Columns="5" ReadOnly="true" Text="255"></asp:TextBox>
                            characters left
                        </td>
                    </tr>
                    <%--<tr>
                        <td class="formlabel" align="right" valign="top">
                            Manufacturer:</td>
                        <td class="formfield" valign="top" align="left">
                            <asp:DropDownList ID="lstManufacturers" TabIndex="2600" runat="server" Width="300px">
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td class="formlabel" align="right" valign="top">
                            Vendor:</td>
                        <td class="formfield" valign="top" align="left">
                            <asp:DropDownList ID="lstVendors" TabIndex="2700" runat="server" Width="300px">
                            </asp:DropDownList></td>
                    </tr>--%>
                     <tr>
                        <td class="formlabel">
                            Pre-Content Column</td>
                        <td class="formfield">
                            <asp:DropDownList ID="PreContentColumnIdField" runat="server" Width="300px" TabIndex="2300">
                                <asp:ListItem Value=""> - None -</asp:ListItem>
                            </asp:DropDownList></td>
                    </tr>
                       <tr>
                        <td class="formlabel">
                            Post-Content Column</td>
                        <td class="formfield">
                            <asp:DropDownList ID="PostContentColumnIdField" runat="server" Width="300px" TabIndex="2400">
                                <asp:ListItem Value=""> - None -</asp:ListItem>
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Rewrite Url To:</td>
                        <td class="formfield">
                            <asp:TextBox ID="RewriteUrlField" runat="server" Columns="30" Width="300px" TabIndex="2500"></asp:TextBox></td>
                    </tr>      
                    <tr>
                        <td class="formlabel">
                            Certificate Id Pattern:</td>
                        <td class="formfield">
                            <asp:TextBox ID="CertificateIdTextBox" runat="server" Columns="30" Width="300px" TabIndex="2600"></asp:TextBox>
                            <bvc5:BVCustomValidator ID="CustomValidator1" runat="server" ControlToValidate="CertificateIdTextBox"
                                Display="Dynamic" ErrorMessage="Certificate id pattern is invalid.">*</bvc5:BVCustomValidator></td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                        </td>
                        <td class="formfield">
                            <ol>
                                <li class="smalltext">Gift certificate id's are <strong>case insensitive</strong> and must have at least 6 random characters.</li>
                                <li class="smalltext">The random characters are # for a random number, ! for a random letter, and ? for a random letter or number.</li>
                                <li class="smalltext">For example GIFT######! could result in a gift certificate code issued as GIFT948593A.</li>
                            </ol>
                        </td>
                    </tr>
                </table>
                <hr />
                <asp:ImageButton ID="btnCancel" TabIndex="9001" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
                &nbsp;
                <asp:ImageButton ID="btnSaveChanges" TabIndex="9000" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
            </asp:Panel>
        </div>
		<div class="four columns">
            <h2>Small Image</h2>
            <div class="controlarea1">
                <asp:Image ID="imgPreviewSmall" runat="server" ImageUrl="../images/NoImageAvailable.gif"></asp:Image>

                <br /><br />

                <asp:TextBox ID="ImageFileSmallField" runat="server" CssClass="FormInput" TabIndex="2700"></asp:TextBox>

                <br /><br />

                <a href="javascript:popUpWindow('?returnScript=SetSmallImage&WebMode=1');">
                    <asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="imgSelect1" />
                </a>
            </div>
            <h2>Medium Image</h2>
            <div class="controlarea1">
                <asp:Image ID="imgPreviewMedium" runat="server" ImageUrl="../images/NoImageAvailable.gif"></asp:Image>

                <br /><br />

                <asp:TextBox ID="ImageFileMediumField" runat="server" CssClass="FormInput" TabIndex="2800"></asp:TextBox>

                <br /><br />

                <a href="javascript:popUpWindow('?returnScript=SetMediumImage&WebMode=1');">
                    <asp:Image runat="server" ImageUrl="~/BVAdmin/images/buttons/Select.png" ID="Image1" />
                </a>
            </div>
            <div class="viewInStore">
                <asp:HyperLink ID="lnkView" EnableViewState="false" runat="server" />
            </div>
        </div>
    </div>

    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>


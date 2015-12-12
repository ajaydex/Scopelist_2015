﻿<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_ContentBlocks_Top_Selling_Products_editor" %>
<%@ Register TagPrefix="uc" TagName="DateRangePicker" Src="~/BVAdmin/Controls/DateRangePicker.ascx" %>
<%@ Register TagPrefix="uc" TagName="HtmlEditor" Src="~/BVAdmin/Controls/HtmlEditor.ascx" %>
<%@ Register TagPrefix="uc" TagName="ProductDisplayType" Src="~/BVAdmin/Controls/ProductDisplayType.ascx" %>

<div style="text-align: left;">
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <script type="text/javascript" src="//cdn.jquerytools.org/1.1.1/tiny/jquery.tools.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                // select all desired input fields and attach tooltips to them
                $(".formfield :text, .formfield :checkbox, #<%= ddlCategory.ClientID %>").tooltip({
                    position: {
                        my: "left center",
                        at: "right+10 center"
                    }
                });

                $('input[type=checkbox]').click(hideInvalidOptions);
                hideInvalidOptions();
            });

            function hideInvalidOptions() {
                // do not allow new badge of image is hidden
                if (!$('#<%=chkDisplayImage.ClientID%>').is(':checked')) {
                    $('#<%=chkDisplayNewBadge.ClientID%>').attr('disabled', 'disabled');
                    $('#<%=chkDisplayNewBadge.ClientID%>').removeAttr('checked');
                } else {
                    $('#<%=chkDisplayNewBadge.ClientID%>').removeAttr('disabled');
                }

                // do not allow options relating to add to cart if add to cart button and selected checkboxes are both turned off
                if (!$('#<%=chkDisplayAddToCartButton.ClientID%>').is(':checked') && !$('#<%=chkDisplaySelectedCheckbox.ClientID%>').is(':checked')) {
                    $('#<%=chkDisplayQuantity.ClientID%>, #<%=chkRemainOnPageAfterAddToCart.ClientID%>').attr('disabled', 'disabled');
                    $('#<%=chkDisplayQuantity.ClientID%>, #<%=chkRemainOnPageAfterAddToCart.ClientID%>').removeAttr('checked');
                } else {
                    $('#<%=chkDisplayQuantity.ClientID%>, #<%=chkRemainOnPageAfterAddToCart.ClientID%>').removeAttr('disabled');
                }
            }
        </script>
            
        <h2>Top Selling Products</h2>
        <div class="tooltip"></div>
        <table border="0" cellspacing="0" cellpadding="3">
            <tr>
                <td class="formlabel">Title</td>
                <td class="formfield">
                    <asp:TextBox ID="txtTitle" Columns="40" ToolTip="Displays this text as a heading" runat="server" />
                </td>
            </tr>

            <tr>
                <td class="formlabel">Number of Items</td>
                <td class="formfield">
                    <asp:TextBox ID="txtNumberOfItems" Columns="4" maxlength="5" ToolTip="Specifies the number of products to display." runat="server" />
                    <asp:RequiredFieldValidator ID="rfvNumberOfItems" ControlToValidate="txtNumberOfItems" ErrorMessage="enter the number of items to display" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
                    <asp:CompareValidator ID="cvNumberOfItems" ControlToValidate="txtNumberOfItems" Operator="DataTypeCheck" Type="Integer" ErrorMessage="enter a numeric value" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">Category</td>
                <td class="formfield">
                    <asp:DropDownList ID="ddlCategory" ToolTip="Best Sellers are determined only from products belonging to this category" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">Date Range</td>
                <td class="formfield">
                    <uc:DateRangePicker ID="ucDateRange" runat="server" RangeType="ThisMonth" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">Pre-Content HTML</td>
                <td class="formfield">
                    <uc:HtmlEditor ID="ucPreContentHtml" EditorHeight="200" EditorWidth="500" EditorWrap="true" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">Post-Content HTML</td>
                <td class="formfield">
                    <uc:HtmlEditor ID="ucPostContentHtml" EditorHeight="200" EditorWidth="500" EditorWrap="true" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">Columns</td>
                <td class="formfield">
                    <asp:DropDownList ID="ddlColumns" runat="server">
                        <asp:ListItem Value="1">1</asp:ListItem>
                        <asp:ListItem Value="2">2</asp:ListItem>
                        <asp:ListItem Value="3">3</asp:ListItem>
                        <asp:ListItem Value="4">4</asp:ListItem>
                        <asp:ListItem Value="6">6</asp:ListItem>
                        <asp:ListItem Value="12">12</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Heading Tag</td>
                <td class="formfield">
                    <asp:DropDownList ID="ddlHeadingTag" runat="server">
                        <asp:ListItem Value="h1">&#60;h1&#62;</asp:ListItem>
                        <asp:ListItem Value="h2">&#60;h2&#62;</asp:ListItem>
                        <asp:ListItem Value="h3">&#60;h3&#62;</asp:ListItem>
                        <asp:ListItem Value="h4">&#60;h4&#62;</asp:ListItem>
                        <asp:ListItem Value="h5">&#60;h5&#62;</asp:ListItem>
                        <asp:ListItem Value="h6">&#60;h6&#62;</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="formlabel" colspan="2">
                    <strong>Product Display Settings:</strong>
                </td>
            </tr>
             <tr>
                <td class="formlabel">CSS Class Prefix</td>
                <td class="formfield">
                    <asp:TextBox ID="txtCssClassPrefix" Columns="40" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="formlabel">Display Name</td>
                <td class="formfield">
                    <asp:Checkbox ID="chkDisplayName" runat="server"></asp:Checkbox>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Display Image</td>
                <td class="formfield">
                    <asp:Checkbox ID="chkDisplayImage" runat="server"></asp:Checkbox>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Display New Badge</td>
                <td class="formfield">
                    <asp:Checkbox ID="chkDisplayNewBadge" runat="server"></asp:Checkbox>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Display Description</td>
                <td class="formfield">
                    <asp:Checkbox ID="chkDisplayDescription" runat="server"></asp:Checkbox>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Display Price</td>
                <td class="formfield">
                    <asp:Checkbox ID="chkDisplayPrice" runat="server"></asp:Checkbox>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Display Add to Cart Button</td>
                <td class="formfield">
                    <asp:Checkbox ID="chkDisplayAddToCartButton" runat="server"></asp:Checkbox>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Display Selected Checkbox</td>
                <td class="formfield">
                    <asp:Checkbox ID="chkDisplaySelectedCheckbox" runat="server"></asp:Checkbox>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Display Quantity</td>
                <td class="formfield">
                    <asp:Checkbox ID="chkDisplayQuantity" runat="server"></asp:Checkbox>
                </td>
            </tr>
            <tr>
                <td class="formlabel">Remain on Page After Add To Cart</td>
                <td class="formfield">
                    <asp:Checkbox ID="chkRemainOnPageAfterAddToCart" runat="server"></asp:Checkbox>
                </td>
            </tr>
            <tr>
                <td class="formlabel">
                    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
                </td>
                <td class="formfield">
                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
                </td>
            </tr>
        </table>
    </asp:Panel>
</div>
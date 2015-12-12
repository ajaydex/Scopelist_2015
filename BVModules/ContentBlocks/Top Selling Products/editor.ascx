<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Top_Selling_Products_editor" %>
<%@ Register TagPrefix="uc" TagName="DateRangePicker" Src="~/BVAdmin/Controls/DateRangePicker.ascx" %>
<%@ Register TagPrefix="uc" TagName="HtmlEditor" Src="~/BVAdmin/Controls/HtmlEditor.ascx" %>
<%@ Register TagPrefix="uc" TagName="ProductDisplayType" Src="~/BVAdmin/Controls/ProductDisplayType.ascx" %>

<div style="text-align: left;">
    <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <script type="text/javascript" src="//cdn.jquerytools.org/1.1.1/tiny/jquery.tools.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                // select all desired input fields and attach tooltips to them
                $(".formfield :text, .formfield :checkbox, .formfield [id$=rblProductDisplayMode], #<%= ddlCategory.ClientID %>").tooltip({
                    position: {
                        my: "left center",
                        at: "right+10 center"
                    }
                });
            });
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
                <td class="formlabel">Display as</td>
                <td class="formfield">
                    <uc:ProductDisplayType ID="ucProductDisplayType" runat="server" />
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
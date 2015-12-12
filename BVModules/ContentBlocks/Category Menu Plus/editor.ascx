<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Category_Menu_Plus_editor" %>

<asp:Panel ID="pnlMain" DefaultButton="btnSave" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            // select all desired input fields and attach tooltips to them
            $(".formfield :text, .formfield :checkbox").tooltip({
                position: {
                    my: "left center",
                    at: "right+10 center"
                }
            });
        });
    </script>
    
    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel wide">Depth Levels</td>
            <td class="formfield">
                <asp:TextBox ID="txtDepthLevels" ToolTip="Specifies the maximum number of levels that the menu can expand. The default value is 9999. For example, to create a top-level menu that does not expand, set this value to 1." runat="server" />
                <asp:CompareValidator ControlToValidate="txtDepthLevels" Type="Integer" Operator="DataTypeCheck" Text="enter an integer" runat="server" />
                <asp:RangeValidator ControlToValidate="txtDepthLevels" Type="Integer" MinimumValue="1" MaximumValue="9999" Text="enter an integer between 1 and 9999" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Start Depth</td>
            <td class="formfield">
                <asp:TextBox ID="txtStartDepth" ToolTip="Specifies the level at which the menu should start. The default value is 1. For example, to create a sub-menu set this value to 2." runat="server" />
                <asp:CompareValidator ControlToValidate="txtStartDepth" Type="Integer" Operator="DataTypeCheck" Text="enter an integer" runat="server" />
                <asp:RangeValidator ControlToValidate="txtDepthLevels" Type="Integer" MinimumValue="1" MaximumValue="9999" Text="enter an integer between 1 and 9999" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Default Expanded Depth</td>
            <td class="formfield">
                <asp:TextBox ID="txtDefaultExpandedDepth" ToolTip="Specifies how many levels of the menu are expanded irrespective of your position in the site. The default value is 1." runat="server" />
                <asp:CompareValidator ControlToValidate="txtDefaultExpandedDepth" Type="Integer" Operator="DataTypeCheck" Text="enter an integer" runat="server" />
                <asp:RangeValidator ControlToValidate="txtDefaultExpandedDepth" Type="Integer" MinimumValue="1" MaximumValue="9999" Text="enter an integer between 1 and 9999" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Display Only Active Branch</td>
            <td class="formfield"><asp:CheckBox ID="chkDisplayOnlyActiveBranch" ToolTip="Only display the active (current) branch of the tree. The default value is false." runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel">Display Only Children of Current Category</td>
            <td class="formfield"><asp:CheckBox ID="chkDisplayOnlyChildrenOfCurrentCategory" ToolTip="Display only the child categories of the active (current) category. The default value is false." runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel">Show Product Count</td>
            <td class="formfield"><asp:CheckBox ID="chkShowProductCount" ToolTip="Displays the number of products contained by each category. The default value is false." runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel">Show Sub-Category Count</td>
            <td class="formfield"><asp:CheckBox ID="chkShowSubCategoryCount" ToolTip="Displays the number of categories contained by each category. The default value is false." runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel">Use "Show In Top Menu" Settings</td>
            <td class="formfield"><asp:CheckBox ID="chkUseShowInTopMenuSettings" ToolTip="Show or hide categories in the menu based on their 'Show In Top Menu' setting from the category edit page. The default value is false." runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel">Show 'more' Link</td>
            <td class="formfield">
                <asp:CheckBox ID="chkShowMoreLink" ToolTip="Displays a 'more' link when there are other categories at a given level that are not hidden but not set to 'Show in Top Menu'; you must use this setting in conjunction with the 'Use Show In Top Menu Settings' setting. The 'more' link goes to the parent category. The default value is false." runat="server" />
                <asp:TextBox ID="txtMoreLinkText" ToolTip="Specifies the text to use for the link. The default value is 'more'." runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">HTML ID</td>
            <td class="formfield">
                <asp:TextBox ID="txtHtmlID" ToolTip="Specifies the HTML 'id' value of the menu's outer-most UL element for use in CSS styles. Note that a value is required when creating a dropdown menu." runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">CSS Class</td>
            <td class="formfield"><asp:TextBox ID="txtCssClass" ToolTip="Specifies the HTML 'class' value of the menu's outer-most UL element for use in CSS styles." runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel">Assign Unique CSS Class Names</td>
            <td class="formfield"><asp:CheckBox ID="chkAssignUniqueCssClassNames" ToolTip="Specifies that the menu will assign a unique CSS class to each category (based on its GUID). The default value is false. This is useful when individual category styling is neccessary such as specifying varying widths or background images." runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel">Display Top Level as Headings</td>
            <td class="formfield">
                <asp:CheckBox ID="chkDisplayTopLevelAsHeadings" ToolTip="Displays the top-level menu items as headings instead of links. The default value is false. After enabling this feature the HTML tag that wraps the top-level categories can be specified." runat="server" />
                <asp:TextBox ID="txtHeadingTag" Text="span" ToolTip="Specifies the HTML tag to use for the heading. The default value is a span tag." runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Current Category ID</td>
            <td class="formfield"><asp:TextBox ID="txtCurrentCategoryID" ToolTip="Overrides the determination of the 'current category' and forces it to be the one specified. This value must be the Bvin GUID value of the category." Width="250" runat="server" />
            <asp:RegularExpressionValidator ID="rx_txtCurrentCategoryID" ControlToValidate="txtCurrentCategoryID" ValidationExpression="(([a-z0-9]){8}-([a-z0-9]){4}-([a-z0-9]){4}-([a-z0-9]){4}-([a-z0-9]){12})|0" ErrorMessage="Enter a 36-character GUID (including dashes) like this: b089d879-7041-4de8-a837-57f3cf08263d" Text="*" runat="server" />
            </td>
        </tr>
    </table>

    <br />
    <br />
    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
    &nbsp;
    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
    <hr />
            
</asp:Panel>
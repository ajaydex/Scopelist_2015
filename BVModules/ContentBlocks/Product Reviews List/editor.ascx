<%@ Control Language="VB" AutoEventWireup="false" CodeFile="editor.ascx.vb" Inherits="BVModules_ContentBlocks_Product_Reviews_List_editor" %>
<%@ Register TagPrefix="uc" TagName="HtmlEditor" Src="~/BVAdmin/Controls/HtmlEditor.ascx" %>


<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
    <script type="text/javascript" src="//cdn.jquerytools.org/1.1.1/tiny/jquery.tools.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            // assign title attribute to ASP.NET CheckBox controls for use by jQuery Tooltip
            $("[id$='_chkTruncateReview']").attr("title", "Enable the shortening of reviews.");

            $("[id$='_chkIgnoreBadKarma']").attr("title", "Excludes reviews with negative karma scores.");

            $("[id$='_chkIgnoreAnonymousReviews']").attr("title", "Excludes reviews from users without a store account.");

            // select all desired input fields and attach tooltips to them
            $(".formfield :text, .formfield :checkbox, .formfield [id$=rblProductDisplayMode], #<%= ddlCategory.ClientID %>").tooltip({
                position: {
                    my: "left center",
                    at: "right+10 center"
                }
            });
        });
    </script>
            
    <div class="tooltip"></div>
    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel wide">Title</td>
            <td class="formfield">
                <asp:TextBox ID="txtTitle" Columns="40" ToolTip="Displays this text as a heading" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Number of Reviews</td>
            <td class="formfield">
                <asp:TextBox ID="txtNumberOfItems" Columns="4" maxlength="5" ToolTip="Specifies the number of reviews to display" runat="server" />
                <asp:RequiredFieldValidator ID="rfvNumberOfItems" ControlToValidate="txtNumberOfItems" ErrorMessage="enter the number of items to display" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
                <asp:CompareValidator ID="cvNumberOfItems" ControlToValidate="txtNumberOfItems" Operator="DataTypeCheck" Type="Integer" ErrorMessage="enter a numeric value" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Truncate Review</td>
            <td class="formfield">
                <asp:CheckBox ID="chkTruncateReview" runat="server" />
                <asp:PlaceHolder ID="phTruncateReviewLength" runat="server">
                    (display the first 
                    <asp:TextBox ID="txtTruncateReviewLength" Columns="4" maxlength="6" ToolTip="Specifies the number of characters (letters) of each review to display" runat="server" />
                    characters of each review)
                    <asp:RequiredFieldValidator ID="rfvTruncateReviewLength" ControlToValidate="txtTruncateReviewLength" ErrorMessage="enter the number of characters to display" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
                    <asp:CompareValidator ID="cvTruncateReviewLength" ControlToValidate="txtTruncateReviewLength" Operator="DataTypeCheck" Type="Integer" ErrorMessage="enter a numeric value" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
                </asp:PlaceHolder>
            </td>
        </tr>
        <tr>
            <td class="formlabel">Date Format</td>
            <td class="formfield">
                <asp:TextBox ID="txtDateFormat" Columns="8" ToolTip="Specifies the way that review dates will be displayed" runat="server" />
                (example: <%=DateTime.Now.ToString(Me.txtDateFormat.Text)%>)
                <asp:LinkButton ID="lnkUpdate" Text="update" CausesValidation="false" runat="server" />
                <asp:RequiredFieldValidator ID="rfvDateFormat" ControlToValidate="txtDateFormat" ErrorMessage="enter the review date format" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Minimum Rating</td>
            <td class="formfield">
                <asp:TextBox ID="txtMinimumRating" Columns="4" maxlength="5" ToolTip="Only show reviews with this rating or higher." runat="server" />
                <asp:RequiredFieldValidator ID="rfvMinimumRating" ControlToValidate="txtMinimumRating" ErrorMessage="enter the minimum rating to display" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
                <asp:CompareValidator ID="cvMinimumRating" ControlToValidate="txtMinimumRating" Operator="DataTypeCheck" Type="Integer" ErrorMessage="enter a numeric value" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
                <asp:RangeValidator ID="rvMinimumRating" ControlToValidate="txtMinimumRating" ErrorMessage="enter a rating between 1 and 5" MinimumValue="1" MaximumValue="5" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Ignore Reviews with Bad Karma</td>
            <td class="formfield">
                <asp:CheckBox ID="chkIgnoreBadKarma" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Ignore Anonymous Reviews</td>
            <td class="formfield">
                <asp:CheckBox ID="chkIgnoreAnonymousReviews" runat="server" />
            </td>
        </tr>
            
        <tr>
            <td class="formlabel">Category</td>
            <td class="formfield">
                <asp:DropDownList ID="ddlCategory" ToolTip="Best Sellers are determined only from products belonging to this category" runat="server" />
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
    </table>
    <br />
    <br />
         
    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/SaveChanges.png" />
                
</asp:Panel>
<hr />
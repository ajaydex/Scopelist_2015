<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Edit.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Checkouts_One_Page_Checkout_Plus_Edit" %>
<%@ Register TagPrefix="uc" Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" %>
<%@ Register TagPrefix="uc" Src="~/BVAdmin/Controls/HtmlEditor.ascx" TagName="HtmlEditor" %>

<script type="text/javascript">
    $(document).ready(function () {

        // assign title attribute to ASP.NET CheckBox controls for use by jQuery Tooltip
        $("[id$='_chkEnableAccountCreation']").attr("title", "Displays the account creation step at the end of checkout.");

        $("[id$='_chkRequireAccountCreation']").attr("title", "Requires the customer to enter a username and password. Note that you must remove the 'Require Login Before Checkout' workflow step from the 'Checkout Selected' workflow for this setting to have any affect.");

        $("[id$='_chkPromptForLogin']").attr("title", "Sends non-logged in customers to an intermediary login page where they can either login (if they have an account) or continue to the checkout page (if they don't have an account). Note that you must remove the 'Require Login Before Checkout' workflow step from the 'Checkout Selected' workflow for this setting to have any affect.");

        $("[id$='_chkEnablePromotionalCodeEntry']").attr("title", "Displays the Promotional Code entry box on the checkout page, allowing customers to add and remove promotional codes without needing to return to the cart page.");

        $("[id$='_chkEnableMailingListSignup']").attr("title", "Displays a checkbox at the end of checkout allowing customers to signup for your mailing list.");

        //$("[id$='_chkMergeAnonymousOrders']").attr("title", "Anonymous orders (where the user wasn't logged in) placed using an email address matching an existing account are saved under that account.");

        $("[id$='_chkEnableAccountCreation']").click(function () {
            var chkRequireAccountCreation = $("[id$='_chkRequireAccountCreation']");

            chkRequireAccountCreation.attr("disabled", !this.checked);
            if (!this.checked)
                chkRequireAccountCreation.removeAttr("checked");
        });

        // select all desired input fields and attach tooltips to them
        $(".formfield :text, .formfield :checkbox").tooltip({
            position: {
                my: "left center",
                at: "right+10 center"
            }
        });
    });
</script>

<h1>Edit One Page Checkout Plus</h1>
<uc:MessageBox ID="ucMessageBox" runat="server" />
<h2>Settings</h2>

<table border="0" cellspacing="0" cellpadding="0" class="linedTable">
    <tr>
        <td class="formlabel">Enable Account Creation</td>
        <td class="formfield">
            <asp:CheckBox ID="chkEnableAccountCreation" runat="server" />
            <span style="margin-left: 20px">Required? <asp:CheckBox ID="chkRequireAccountCreation" runat="server" /></span>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Prompt for login before checkout</td>
        <td class="formfield">
            <asp:CheckBox ID="chkPromptForLogin" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Enable Promotional Code entry</td>
        <td class="formfield">
            <asp:CheckBox ID="chkEnablePromotionalCodeEntry" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Enable Mailing List signup</td>
        <td class="formfield">
            <asp:CheckBox ID="chkEnableMailingListSignup" runat="server" />
            <span style="margin-left: 20px">subscribe customer to: <asp:DropDownList ID="ddlMaillingList" runat="server" /></span>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <h2>Content</h2>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Shipping Instructions</td>
        <td class="formfield">
            <uc:HtmlEditor ID="ucShippingInstructions" EditorHeight="200" EditorWidth="500" EditorWrap="true" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Billing Instructions</td>
        <td class="formfield">
            <uc:HtmlEditor ID="ucBillingInstructions" EditorHeight="200" EditorWidth="500" EditorWrap="true" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Payment Instructions</td>
        <td class="formfield">
            <uc:HtmlEditor ID="ucPaymentInstructions" EditorHeight="200" EditorWidth="500" EditorWrap="true" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Gift Certificate Instructions</td>
        <td class="formfield">
            <uc:HtmlEditor ID="ucGiftCertificateInstructions" EditorHeight="200" EditorWidth="500" EditorWrap="true" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Promotional Code Instructions</td>
        <td class="formfield">
            <uc:HtmlEditor ID="ucPromotionalCodeInstructions" EditorHeight="200" EditorWidth="500" EditorWrap="true" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Account Instructions</td>
        <td class="formfield">
            <uc:HtmlEditor ID="ucAccountInstructions" EditorHeight="200" EditorWidth="500" EditorWrap="true" runat="server" />
        </td>
    </tr>
    <tr>
        <td class="formlabel">Review Instructions</td>
        <td class="formfield">
            <uc:HtmlEditor ID="ucReviewInstructions" EditorHeight="200" EditorWidth="500" EditorWrap="true" runat="server" />
        </td>
    </tr>
</table>
<br />
<br />

            <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Cancel.png" />
&nbsp;
            <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="~/BVAdmin/images/buttons/SaveChanges.png" />
        
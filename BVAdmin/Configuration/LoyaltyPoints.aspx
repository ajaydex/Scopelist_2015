<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="LoyaltyPoints.aspx.vb" Inherits="BVAdmin_Configuration_LoyaltyPoints" %>
<%@ Register TagPrefix="uc" Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" %>
<%@ Register Src="~/BVAdmin/Controls/DateRangePicker.ascx" TagName="DateRangePicker" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" Runat="Server">
    <%--<script type="text/javascript" src="http://cdn.jquerytools.org/1.1.1/tiny/jquery.tools.min.js"></script>--%>
    <script type="text/javascript">
        $(document).ready(function () {

            // assign title attribute to ASP.NET CheckBox controls for use by jQuery Tooltip
            $("[id$='_chkLoyaltyPointsEnabled']").attr("title", "Checking this box will enable Loyalty Points (and the corresponding Loyalty Points payment method)");

            $("[id$='_chkLoyaltyPointsExpire']").attr("title", "Checking this box will cause loyalty points to expire in X number of days (where X is defined in the setting below). Leaving this box unchecked means that loyalty poinst will never expire.");

            // select all desired input fields and attach tooltips to them
            $(".formfield :text, .formfield :checkbox").tooltip({
                position: {
                    my: "left center",
                    at: "right+10 center"
                }
            });

            // LoyaltyPointsEnabled
            $("[id$='_chkLoyaltyPointsEnabled']").change(function () {
                if ($(this).is(":checked")) {
                    $("[id$='_txtLoyaltyPointsEarnedPerCurrencyUnit']").removeAttr("readonly");
                    $("[id$='_txtLoyaltyPointsToCurrencyUnitExchangeRate']").removeAttr("readonly");
                    $("[id$='_chkLoyaltyPointsExpire']").removeAttr("disabled");
                    $("[id$='_chkLoyaltyPointsExpire']").change();
                }
                else {
                    $("[id$='_txtLoyaltyPointsEarnedPerCurrencyUnit']").attr("readonly", "readonly");
                    $("[id$='_txtLoyaltyPointsToCurrencyUnitExchangeRate']").attr("readonly", "readonly");
                    $("[id$='_chkLoyaltyPointsExpire']").attr("disabled", "disabled");
                    $("[id$='_txtLoyaltyPointsExpireDays']").attr("readonly", "readonly");
                }
            });
            $("[id$='_chkLoyaltyPointsEnabled']").change(); // init

            // LoyaltyPointsToCurrencyUnitRatio
            $("[id$='_txtLoyaltyPointsEarnedPerCurrencyUnit'], [id$='_txtLoyaltyPointsToCurrencyUnitExchangeRate']").change(function () {
                var loyaltyPointsEarnedPerCurrencyUnit = $("[id$='_txtLoyaltyPointsEarnedPerCurrencyUnit']").val();
                var loyaltyPointsToCurrencyUnitExchangeRate = $("[id$='_txtLoyaltyPointsToCurrencyUnitExchangeRate']").val();

                if (loyaltyPointsEarnedPerCurrencyUnit && loyaltyPointsToCurrencyUnitExchangeRate) {
                    var ratio = 100 * (loyaltyPointsEarnedPerCurrencyUnit / loyaltyPointsToCurrencyUnitExchangeRate);
                    $("#LoyaltyPointsToCurrencyUnitRatio").text(ratio.toFixed(2) + "%");
                }
            });
            $("[id$='_txtLoyaltyPointsEarnedPerCurrencyUnit']").change();   // init

            // LoyaltyPointsExpire
            $("[id$='_chkLoyaltyPointsExpire']").change(function () {
                if ($(this).is(":checked"))
                    $("[id$='_txtLoyaltyPointsExpireDays']").removeAttr("readonly");
                else
                    $("[id$='_txtLoyaltyPointsExpireDays']").attr("readonly", "readonly");
            });
            $("[id$='_chkLoyaltyPointsExpire']").change();  // init
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="tooltip"></div>
    <h1>Loyalty Points</h1>
    <uc:MessageBox ID="ucMessageBox" runat="server" />
    <h2>Settings</h2>
    <p>When enabled, loyalty points are credited to a customer after their order is marked 'paid'. The amount of loyalty points credited is calculated against the order subtotal less discounts and any payments made using gift certificates and other loyalty points; this prevents "double-dipping". At checkout a customer's available loyalty points are automatically applied to their order.</p>
    <p>Only the "One Page Checkout Plus" checkout supports loyalty points. Be sure that you are using this checkout when offering loyalty points.</p>
    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel">Enable Loyalty Points</td>
            <td class="formfield">
                <asp:CheckBox ID="chkLoyaltyPointsEnabled" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Loyalty Points Earned Per Currency Unit (<%= BVSoftware.Bvc5.Core.WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol%>)</td>
            <td class="formfield">
                <asp:TextBox ID="txtLoyaltyPointsEarnedPerCurrencyUnit" MaxLength="5" Columns="1" Width="35" ToolTip="The number of loyalty points that will be credited to a customer for each currency unit (e.g. $) spent." runat="server" /> point(s)
                <asp:RequiredFieldValidator ID="rfvLoyaltyPointsEarnedPerCurrencyUnit" ControlToValidate="txtLoyaltyPointsEarnedPerCurrencyUnit" Text="enter a number greater than or equal to 0" Display="Dynamic" runat="server" />
                <asp:CompareValidator ID="cvLoyaltyPointsEarnedPerCurrencyUnit" ControlToValidate="txtLoyaltyPointsEarnedPerCurrencyUnit" Type="Double" Operator="GreaterThanEqual" ValueToCompare="0" Text="enter a number greater than or equal to 0" Display="Dynamic" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Loyalty Points to Currency Unit (<%= BVSoftware.Bvc5.Core.WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol%>) Exchange Rate</td>
            <td class="formfield">
                <asp:TextBox ID="txtLoyaltyPointsToCurrencyUnitExchangeRate" MaxLength="5" Columns="1" Width="35" ToolTip="The number of loyalty points that equal a currency unit (e.g. $)." runat="server" />
                <asp:RequiredFieldValidator ID="rfvLoyaltyPointsToCurrencyUnitExchangeRate" ControlToValidate="txtLoyaltyPointsToCurrencyUnitExchangeRate" Text="enter a number greater than or equal to 1" Display="Dynamic" runat="server" />
                <asp:CompareValidator ID="cvLoyaltyPointsToCurrencyUnitExchangeRate" ControlToValidate="txtLoyaltyPointsToCurrencyUnitExchangeRate" Type="Double" Operator="GreaterThanEqual" ValueToCompare="1" Text="enter a number greater than or equal to 1" Display="Dynamic" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Loyalty Points to Currency Unit (<%= BVSoftware.Bvc5.Core.WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol%>) Ratio</td>
            <td class="formfield">
                <span id="LoyaltyPointsToCurrencyUnitRatio"></span>
            </td>
        </tr>
        <tr>
            <td class="formlabel">Minimum Order Amount (<%= BVSoftware.Bvc5.Core.WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol%>) to Earn Points</td>
            <td class="formfield">
                <asp:TextBox ID="txtMinimumOrderAmountToEarnPoints" MaxLength="5" Columns="1" Width="35" ToolTip="The minimum order amount needed before loyalty points will be earned for a given order. Note that taxes and shipping are excluded." runat="server" />
                <asp:RequiredFieldValidator ID="rfvMinimumOrderAmountToEarnPoints" ControlToValidate="txtMinimumOrderAmountToEarnPoints" Text="enter a number greater than or equal to 0" Display="Dynamic" runat="server" />
                <asp:CompareValidator ID="cvMinimumOrderAmountToEarnPoints" ControlToValidate="txtMinimumOrderAmountToEarnPoints" Type="Double" Operator="GreaterThanEqual" ValueToCompare="0" Text="enter a number greater than or equal to 0" Display="Dynamic" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Minimum Order Amount (<%= BVSoftware.Bvc5.Core.WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol%>) to Use Points</td>
            <td class="formfield">
                <asp:TextBox ID="txtMinimumOrderAmountToUsePoints" MaxLength="5" Columns="1" Width="35" ToolTip="The minimum order amount needed before loyalty points can be used to pay for an order. Note that taxes and shipping are excluded." runat="server" />
                <asp:RequiredFieldValidator ID="rfvMinimumOrderAmountToUsePoints" ControlToValidate="txtMinimumOrderAmountToUsePoints" Text="enter a number greater than or equal to 0" Display="Dynamic" runat="server" />
                <asp:CompareValidator ID="cvMinimumOrderAmountToUsePoints" ControlToValidate="txtMinimumOrderAmountToUsePoints" Type="Double" Operator="GreaterThanEqual" ValueToCompare="0" Text="enter a number greater than or equal to 0" Display="Dynamic" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Minimum Points Balance (<%= BVSoftware.Bvc5.Core.WebAppSettings.SiteCulture.NumberFormat.CurrencySymbol%>) to Use Points</td>
            <td class="formfield">
                <asp:TextBox ID="txtMinimumPointsCurrencyBalanceToUse" MaxLength="5" Columns="1" Width="35" ToolTip="The minimum loyalty points balance (currency equivalent) needed before loyalty points can be used to pay for an order." runat="server" />
                <asp:RequiredFieldValidator ID="rfvMinimumPointsCurrencyBalanceToUse" ControlToValidate="txtMinimumPointsCurrencyBalanceToUse" Text="enter a number greater than or equal to 0" Display="Dynamic" runat="server" />
                <asp:CompareValidator ID="cvMinimumPointsCurrencyBalanceToUse" ControlToValidate="txtMinimumPointsCurrencyBalanceToUse" Type="Double" Operator="GreaterThanEqual" ValueToCompare="0" Text="enter a number greater than or equal to 0" Display="Dynamic" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Loyalty Points Expire</td>
            <td class="formfield">
                <asp:CheckBox ID="chkLoyaltyPointsExpire" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Points Expire in</td>
            <td class="formfield">
                <asp:TextBox ID="txtLoyaltyPointsExpireDays" MaxLength="4" Columns="1" Width="35" ToolTip="The number of days until loyalty points expire." runat="server" /> days
                <asp:RequiredFieldValidator ID="rfvLoyaltyPointsExpireDays" ControlToValidate="txtLoyaltyPointsExpireDays" Text="enter a whole number greater than 0" Display="Dynamic" runat="server" />
                <asp:CompareValidator ID="cvLoyaltyPointsExpireDaysMinimum" ControlToValidate="txtLoyaltyPointsExpireDays" Operator="GreaterThan" Type="Integer" ValueToCompare="0" Text="enter a whole number greater than 0" Display="Dynamic" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel"></td>
            <td class="formfield">
                <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="~/BVAdmin/images/buttons/SaveChanges.png"></asp:ImageButton>
            </td>
        </tr>   
    </table>
    <br />
    <br />
    <h2>Credit Loyalty Points for Past Orders</h2>
    <p>Credits loyalty points for orders within the specified date range to customers with an account and where the order has not already been credited loyalty points.</p>

    <table border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>Date Range:&nbsp;</td>
			<td>
                <uc:DateRangePicker id="ucDateRangeField" RangeType="ThisMonth" runat="server" />
            </td>
            <td>
                &nbsp;<asp:ImageButton ID="btnCreditPastOrders" runat="server" ImageUrl="~/BVAdmin/images/buttons/RunNow.png"></asp:ImageButton>
            </td>
		</tr>
	</table>
           
</asp:Content>
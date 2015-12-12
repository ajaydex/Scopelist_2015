<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Export.ascx.vb" Inherits="BVModules_ImportExport_OrderExport_Export" %>
<%@ Register Src="~/BVAdmin/Controls/DateRangePicker.ascx" TagName="DateRangePicker" TagPrefix="uc" %>

<script type="text/javascript">
    $(document).ready(function () {
        $("input:radio[id*='_IsPlaced']").change(function () {
            var selector = "#<%= PaymentFilterField.ClientID%>, #<%= ShippingFilterField.ClientID%>, #<%= ShippingFilterField.ClientID%>, #<%= StatusFilterField.ClientID%>";
            if ($(this).val() == "True") {
                $(selector).removeAttr("disabled");
            }
            else {
                $(selector).val("0");
                $(selector).attr("disabled", "disabled");
            }
        });
    });
</script>

<table border="0" cellspacing="0" cellpadding="0" width="100%">
    <tr>
        <td class="formfield" colspan="2">
            <asp:RadioButtonList ID="IsPlaced" runat="server" RepeatDirection="Horizontal">
                <asp:ListItem Value="False">Shopping Cart</asp:ListItem>
                <asp:ListItem Value="True" Selected="True">Placed Order</asp:ListItem>
            </asp:RadioButtonList>
        </td>
    </tr>
    <tr>
        <td class="formlabel">Payment</td>
        <td class="formfield">
            <asp:DropDownList ID="PaymentFilterField" runat="server">
                <asp:ListItem Text="- Any -" Value="0"></asp:ListItem>
                <asp:ListItem Value="1">Unpaid</asp:ListItem>
                <asp:ListItem Value="2">Partially</asp:ListItem>
                <asp:ListItem Value="3">Paid</asp:ListItem>
                <asp:ListItem Value="4">Overpaid</asp:ListItem>
            </asp:DropDownList></td>
    </tr>
    <tr>
        <td class="formlabel">Shipping</td>
        <td class="formfield">
            <asp:DropDownList ID="ShippingFilterField" runat="server">
                <asp:ListItem Text="- Any -" Value="0"></asp:ListItem>
                <asp:ListItem Value="1">Unshipped</asp:ListItem>
                <asp:ListItem Value="2">Partial</asp:ListItem>
                <asp:ListItem Value="3">Shipped</asp:ListItem>
            </asp:DropDownList></td>
    </tr>
    <tr>
        <td class="formlabel">Status</td>
        <td class="formfield">
            <asp:DropDownList ID="StatusFilterField" runat="server">
                <asp:ListItem Text="- Any -"></asp:ListItem>
                <asp:ListItem>In Process</asp:ListItem>
                <asp:ListItem>Complete</asp:ListItem>
                <asp:ListItem>Problem</asp:ListItem>
            </asp:DropDownList></td>
    </tr>
    <tr>
        <td class="formlabel">Date Range</td>
        <td class="formfield"><uc:DateRangePicker ID="DateRangeField" runat="server" RangeType="ThisWeek" /><%-- set RangeType to "ThisWeek" for performance rather than the previous "AllDates" --%></td>
    </tr>
    <tr>
        <td class="formlabel">Keyword</td>
        <td class="formfield">
            <asp:TextBox ID="FilterField" runat="server" Width="150px"></asp:TextBox><br />
            <asp:CheckBox ID="KeywordIsExact" runat="server" Text="Exact Match" />
        </td>
    </tr>
</table>
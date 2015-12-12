<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminPopup.master" AutoEventWireup="false" CodeFile="users_edit_loyaltypoints.aspx.vb" Inherits="BVAdmin_People_users_edit_loyaltypoints" %>
<%@ Register TagPrefix="uc" Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" %>
<%@ Register Src="~/BVAdmin/Controls/DateRangePicker.ascx" TagName="DateRangePicker" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" Runat="Server">
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

            // LoyaltyPointsExpire
            $("[id$='_chkLoyaltyPointsExpire']").change(function () {
                if ($(this).attr("checked")) {
                    $("[id$='_txtLoyaltyPointsExpireDays']").removeAttr("readonly");
                    ValidatorEnable(document.getElementById('<%= rfvLoyaltyPointsExpireDays.ClientID %>'), true);
                }
                else {
                    $("[id$='_txtLoyaltyPointsExpireDays']").val("");   // clear value
                    $("[id$='_txtLoyaltyPointsExpireDays']").attr("readonly", "readonly");
                    ValidatorEnable(document.getElementById('<%= rfvLoyaltyPointsExpireDays.ClientID %>'), false);
                }
            });
            $("[id$='_chkLoyaltyPointsExpire']").change();  // init
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BvcAdminPopupConent" Runat="Server">
    <div style="margin: 20px;">
        <table border="0" cellspacing="0" cellpadding="5" style="background: #fff; padding: 20px; width: 100%">
        <tr>
            <td colspan="2">
                <h1>Adjust Points for User</h1>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <uc:MessageBox ID="ucMessageBox" runat="server" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <h2>Use the form below to add or subtract loyalty points for this customer's account.</h2>
                
                <table>
                    <tr>
                        <td><strong>Name:</strong></label></td>
                        <td><asp:Label ID="lblName" runat="server" /></td>
                    </tr>
                    <tr>
                        <td><strong>Username:</strong></td>
                        <td><asp:Label ID="lblUserName" runat="server" /></td>
                    </tr>
                    <tr>
                        <td><strong>Email Address:</strong></td>
                        <td><asp:Label ID="lblEmail" runat="server" /></td>
                    </tr>
                    <tr>
                        <td><strong>Loyalty Points Balance:</strong></td>
                        <td><asp:Label ID="lblLoyaltyPoints" runat="server" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="formlabel">Adjustment</td>
            <td class="formfield">
                <asp:DropDownList ID="ddlPostiveOrNegative" runat="server">
                    <asp:ListItem Value="1">+</asp:ListItem>
                    <asp:ListItem Value="-1">-</asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox ID="txtPointsAdjustment" Columns="4" runat="server" />
                <asp:DropDownList ID="ddlPointsOrCurrency" runat="server">
                    <asp:ListItem Value="0">Points</asp:ListItem>
                    <asp:ListItem Value="1" Selected="True">Currency ({0})</asp:ListItem>
                </asp:DropDownList>
                <br />
                <asp:RequiredFieldValidator ID="rfvPointsAdjustment" ControlToValidate="txtPointsAdjustment" Text="enter a positive or negative whole number" Display="Dynamic" runat="server" />
                <asp:CompareValidator ID="cvPointsAdjustment" ControlToValidate="txtPointsAdjustment" Operator="DataTypeCheck" Type="Double" Text="enter a positive or negative number<br/>" Display="Dynamic" runat="server" />
                <asp:CompareValidator ID="cvPointsAdjustmentZero" ControlToValidate="txtPointsAdjustment" Operator="NotEqual" Type="Double" ValueToCompare="0" Text="enter a positive or negative number" Display="Dynamic" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Loyalty Points Expire</td>
            <td class="formfield">
                <asp:CheckBox ID="chkLoyaltyPointsExpire" AutoPostBack="true" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel">Points Expire in</td>
            <td class="formfield">
                <asp:TextBox ID="txtLoyaltyPointsExpireDays" MaxLength="3" Columns="1" ToolTip="Defines the number of days until loyalty points expire." runat="server" />days
                <asp:RequiredFieldValidator ID="rfvLoyaltyPointsExpireDays" ControlToValidate="txtLoyaltyPointsExpireDays" Text="enter a whole number greater than 0" Display="Dynamic" runat="server" />
                <asp:CompareValidator ID="cvLoyaltyPointsExpireDaysMinimum" ControlToValidate="txtLoyaltyPointsExpireDays" Operator="GreaterThan" Type="Integer" ValueToCompare="0" Text="enter a whole number greater than 0" Display="Dynamic" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel"></td>
            <td class="formfield">
                <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="~/BVAdmin/images/buttons/SaveAndContinue.png"></asp:ImageButton>
            </td>
        </tr>
    </table>
    </div>
    <asp:HiddenField ID="BvinField" runat="server" />
</asp:Content>
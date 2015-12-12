<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CreditCardInput.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Checkouts_One_Page_Checkout_Plus_CreditCardInput" %>

<script type="text/javascript">
    function init_ccinput() {
        $("#<%= CardTypeField.ClientID %>").change(function () {
            var cardType = $("#<%= CardTypeField.ClientID %>").val();
            if (cardType == "" || cardType == "0") {
                $(".creditCards img").removeClass("selected");
                $(".creditCards img").removeClass("notSelected");
            }
            else {
                $(".creditCards img").removeClass("selected");
                $(".creditCards img").addClass("notSelected");
                $(".creditCards img." + cardType).removeClass("notSelected");
                $(".creditCards img." + cardType).addClass("selected");
            }
        });
        $("#<%= CardTypeField.ClientID %>").change();

        $(".creditCards img").click(function () {
            $(".creditCards img").removeClass("selected");
            $(".creditCards img").removeClass("notSelected");
            $("#<%= CardTypeField.ClientID %>").val($(this).attr("class"));
            $("#<%= CardTypeField.ClientID %>").change();
        });
    }
</script>

<div class="creditcardinput">
    <table cellspacing="0" cellpadding="0" class="formTable">
        <tr>
            <td class="formlabel"><asp:Label ID="CardTypeLabel" AssociatedControlID="CardTypeField" CssClass="required" runat="server">Card Type</asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="CardTypeField" runat="server">
                </asp:DropDownList>
                <bvc5:BVRequiredFieldValidator ID="CardTypeFieldBVRequiredFieldValidator" runat="server" ControlToValidate="CardTypeField" ErrorMessage="Please select a card type." Enabled="false"  Display="None" EnableClientScript="false" InitialValue="0" CssClass="error"></bvc5:BVRequiredFieldValidator>
                <div class="creditCards">
                    <asp:PlaceHolder ID="phAcceptedCreditCards" runat="server" />
                </div>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                <asp:Label ID="CardNumberLabel" AssociatedControlID="CardNumberField" CssClass="required" runat="server">Card Number</asp:Label>
            </td>
            <td class="formfield">
                <span class="creditcardnumber">
                    <asp:TextBox ID="CardNumberField" autocomplete="off" runat="server" Columns="20" MaxLength="20"></asp:TextBox>
                    <asp:CustomValidator ID="CardNumberValidator" runat="server" ControlToValidate="CardNumberField" ValidateEmptyText="true" Display="Dynamic" EnableClientScript="false" CssClass="error"></asp:CustomValidator>
                </span>
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                <asp:Label ID="ExpDateLabel" AssociatedControlID="ExpMonthField" CssClass="required" runat="server">Exp. Date</asp:Label>
            </td>
            <td class="formfield">
                <asp:DropDownList ID="ExpMonthField" runat="server">
                </asp:DropDownList>
                &nbsp;/&nbsp;
                <asp:DropDownList ID="ExpYearField" runat="server">
                </asp:DropDownList>
                <asp:CustomValidator ID="ExpMonthValidator" runat="server" ControlToValidate="ExpMonthField" Display="None" EnableClientScript="false" CssClass="error"></asp:CustomValidator>
                <asp:CustomValidator ID="ExpYearValidator" runat="server" ControlToValidate="ExpYearField" Display="None" EnableClientScript="false" CssClass="error"></asp:CustomValidator>
                <asp:CustomValidator ID="ExpDateValidator" runat="server" Display="Dynamic" EnableClientScript="false" CssClass="error"></asp:CustomValidator>
            </td>
        </tr>
        <tr id="issueNumberRow" runat="server" visible="false">
            <td class="formlabel">
                <asp:Label ID="IssueNumberLabel" AssociatedControlID="IssueNumberTextBox" runat="server">Issue Number</asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="IssueNumberTextBox" runat="server" Columns="5" MaxLength="4"></asp:TextBox>&nbsp;                
            </td>
        </tr>
        <tr>
            <td class="formlabel">
                <asp:Label ID="SecurityCodeLabel" AssociatedControlID="CVVField" runat="server">Security Code</asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="CVVField" autocomplete="off" runat="server" Columns="5" MaxLength="4"></asp:TextBox>&nbsp;
                <bvc5:BVRequiredFieldValidator ID="CVVFieldBVRequiredFieldValidator" runat="server" ControlToValidate="CVVField" ErrorMessage="Please enter a CVV code." Enabled="false"  Display="None" EnableClientScript="false" CssClass="error"></bvc5:BVRequiredFieldValidator><br />
                <a id="cvvdesclink" runat="server" style="CURSOR: pointer; display:block; float: left; clear:both; margin-top:2px;" 
                onclick="JavaScript:window.open('CVV.aspx','CVV','width=400, height=400, menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no')">What's this?</a>
                </td>
        </tr> 
        <tr>
            <td class="formlabel">
                <asp:Label ID="CardholderNameLabel" AssociatedControlID="CardholderNameField" CssClass="required" runat="server">Name On Card</asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="CardholderNameField" runat="server" Columns="20"></asp:TextBox>
                <bvc5:BVRequiredFieldValidator ID="CardholderNameFieldBVRequiredFieldValidator" runat="server" ControlToValidate="CardholderNameField" ErrorMessage="Please enter a card holder name." Enabled="false" Display="None" EnableClientScript="false" CssClass="error"></bvc5:BVRequiredFieldValidator>
            </td>
        </tr>
    </table>
</div>
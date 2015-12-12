<%@ Page Language="VB"  MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Redirector.aspx.vb" Inherits="BVAdmin_Configuration_Redirector" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" runat="server">
    <script type="text/javascript">
        function toggleRedirectorFields() {
            var chkSelector = "";

            if ($("#<%= chkEnableRedirector.ClientID%>").is(":checked")) {
                $(".disableable input").removeAttr("onclick");
                $(".disableable label").css("color", "#000");
            }
            else {
                $(".disableable input").attr("onclick", "return false");
                $(".disableable label").css("color", "#999");
            }
        }

        $(document).ready(function () {
            toggleRedirectorFields();
            $("#<%= chkEnableRedirector.ClientID%>").change(toggleRedirectorFields);
        });
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h1>Redirector</h1>
    <uc:MessageBox ID="msg" runat="server" />

    <table border="0" cellspacing="0" cellpadding="0" class="linedTable">
        <tr>
            <td class="formlabel">Enable Redirector:</td>
            <td class="formfield"><asp:CheckBox ID="chkEnableRedirector" runat="server" /> Yes</td>
        </tr>
        <tr>
            <td class="formlabel">Redirect to Primary Domain:<br />
                <span class="smalltext">(e.g. redirect http://mydomain.com to http://www.mydomain.com)</span>
            </td>
            <td class="formfield"><asp:CheckBox ID="chkRedirectToPrimaryDomain" Text=" Yes" CssClass="disableable" runat="server" /></td>
        </tr>
        <tr>
            <td class="formlabel">Auto-Populate Redirect When Deleting:</td>
            <td class="formfield">
                <asp:CheckBox ID="chkAutoPopulateProductRedirect" Text=" Products" CssClass="disableable" runat="server" /><br />
                <asp:CheckBox ID="chkAutoPopulateCategoryRedirect" Text=" Categories" CssClass="disableable" runat="server" /><br />
                <asp:CheckBox ID="chkAutoPopulateCustomPageRedirect" Text=" Custom Pages" CssClass="disableable" runat="server" />
            </td>
        </tr>
        <tr>
    </table>
    <br />
    <br />

    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png" CausesValidation="False"></asp:ImageButton>
    &nbsp;
    <asp:ImageButton ID="btnSave" CausesValidation="true" runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton>
</asp:Content>
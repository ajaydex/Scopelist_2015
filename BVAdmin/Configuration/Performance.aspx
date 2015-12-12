<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Performance.aspx.vb" Inherits="BVAdmin_Configuration_Performance" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<h1>Performance</h1>        
        <uc1:MessageBox ID="MessageBox1" runat="server" />
        <asp:Label id="lblError" runat="server" CssClass="errormessage"></asp:Label>
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0">        
        <tr>
            <td class="formlabel">Auto Url Rewriting for Categories:</td>
            <td class="formfield">
                <asp:CheckBox ID="chkUrlRewriteCategories" runat="server" /> prefix: <asp:TextBox ID="UrlRewriteCategoriesPrefixField" runat="server" Columns="20" Width="120"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel">Auto Url Rewriting for Product:</td>
            <td class="formfield">
                <asp:CheckBox ID="chkUrlRewriteProducts" runat="server" />
                prefix:
                <asp:TextBox ID="UrlRewriteProductsPrefixField" runat="server" Columns="20" Width="120"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel">Record Customer Searches:</td>
            <td class="formfield">
                <asp:CheckBox ID="chkMetricsRecordSearches" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel" align="left">
                Suggested Items Maximum Results
            </td>
            <td class="formfield" align="left">
                <asp:TextBox ID="SuggestedItemsMaxResultsField" Columns="50" Width="300px" runat="server"></asp:TextBox>
                <bvc5:BVRegularExpressionValidator ID="QuantityRegexValidator" runat="server" ControlToValidate="SuggestedItemsMaxResultsField" ValidationExpression="\d*" ErrorMessage="Please enter a numeric value" Text="*" Display="Dynamic" ></bvc5:BVRegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="formlabel" align="left">
                Recently Viewed Items Maximum Results
            </td>
            <td class="formfield" align="left">
                <asp:TextBox ID="RVIMaxResults" Columns="50" Width="300px" runat="server"></asp:TextBox>
                <bvc5:BVRegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="RVIMaxResults" ValidationExpression="\d*" ErrorMessage="Please enter a numeric value" Text="*" Display="Dynamic" ></bvc5:BVRegularExpressionValidator>
            </td>
        </tr>       
        <tr runat="server" visible="false">
            <td class="formlabel">Disable Auto Product Loading on Catalog Tab:</td>
            <td class="formfield">
                <asp:CheckBox ID="chkPerformanceAutoLoadProducts" runat="server" />
            </td>
        </tr>                        
        <tr>
                <td class="formlabel">
                    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../images/buttons/Cancel.png"
                        CausesValidation="False"></asp:ImageButton></td>
                <td class="formfield"><asp:ImageButton ID="btnSave" CausesValidation="true"
                            runat="server" ImageUrl="../images/buttons/SaveChanges.png"></asp:ImageButton></td>
            </tr>
        </table>
        </asp:Panel>
</asp:Content>


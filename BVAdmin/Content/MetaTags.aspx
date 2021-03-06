<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="MetaTags.aspx.vb" Inherits="BVAdmin_Content_MetaTags" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>
        Meta Tags
    </h1>
        <uc1:MessageBox ID="MessageBox1" runat="server" />
        <asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSave">
        <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="formlabel">Meta Keywords:</td>
            <td class="formfield">
                <asp:TextBox ID="MetaKeywordsField" Columns="50" Width="300px" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="formlabel">Meta Description:</td>
            <td class="formfield">
                <asp:TextBox ID="MetaDescriptionField" Columns="50" Width="300px" runat="server" Height="150px" Rows="5" TextMode="MultiLine"></asp:TextBox></td>
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


<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="MailingLists.aspx.vb" Inherits="BVAdmin_People_MailingLists" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<h1>
    Mailing Lists</h1>
    
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                <tr>
                    <td align="left" valign="middle"><h2>
                        <asp:Label ID="lblResults" runat="server">No Results</asp:Label></h2></td>                   
                    <td align="right" valign="middle">
                        <asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New Mailing List" ImageUrl="~/BVAdmin/Images/Buttons/New.png" /></td>
                </tr>
            </table>
        &nbsp;
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin"
        BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%">
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="List Name" />
            <asp:CheckBoxField DataField="IsPrivate" HeaderText="Private List" />
            <asp:HyperLinkField DataNavigateUrlFields="bvin" DataNavigateUrlFormatString="MailingList_Send.aspx?id={0}"
                Text="Send Email" />
            <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton OnClientClick="return window.confirm('Delete this mailing list?');" ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                        Text="Delete" CssClass="btn-delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
</asp:Content>


<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Policies.aspx.vb" Inherits="BVAdmin_Content_Policies" Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>
        Policies</h1>
    <uc1:MessageBox ID="msg" runat="server" />
    <asp:Panel id="pnlHeader" runat="Server" DefaultButton="btnNew">
    <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td align="left" valign="middle">
                <h2>
                    <asp:Label ID="lblResults" runat="server">No Results</asp:Label></h2>
            </td>
            <td align="right" valign="middle">
                 New Policy Name:
                        <asp:TextBox ID="NewNameField" runat="server"></asp:TextBox><asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New Policy" ImageUrl="~/BVAdmin/Images/Buttons/New.png" /></td>
        </tr>
    </table></asp:Panel>
    &nbsp;
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin"
        BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%">
        <Columns>
            <asp:BoundField DataField="Title" HeaderText="Policy Name" />
            <asp:CheckBoxField DataField="SystemPolicy" HeaderText="System Policy" />
            <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton OnClientClick="return window.confirm('Delete this policy?');" ID="LinkButton1"
                        runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn-delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
    </asp:GridView>
</asp:Content>

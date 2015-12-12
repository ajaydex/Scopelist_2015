<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master"  AutoEventWireup="false" CodeFile="UrlRedirect.aspx.vb" Inherits="BVAdmin_Content_UrlRedirect" %>
<%@ Register Src="~/BVAdmin/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h1>URL Redirects</h1>
    <uc:MessageBox ID="ucMessageBox" runat="server" />


    <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td align="left" valign="middle">
                <h2><asp:Label ID="lblResults" runat="server">No Results</asp:Label></h2>
            </td>
            <td align="right" valign="middle">
                <asp:HyperLink ID="btnNew" runat="server" NavigateUrl="UrlRedirect_Edit.aspx" ToolTip="Add New Custom Url" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />
                <asp:HyperLink ID="lnkImportExport" runat="server" NavigateUrl="~/BVAdmin/ImportExport.aspx?id=22283262-8238-4B2B-875E-1FFC3FD7A445" ToolTip="Import/Export" ImageUrl="~/BVAdmin/Images/Buttons/ImportExport.png" CssClass="iframe" />
            </td>
        </tr>
    </table>

    <asp:Panel ID="Panel1" DefaultButton="btnGo" runat="server" class="controlarea1">
        <table  border="0" cellspacing="5" cellpadding="0">
            <tr>
                <td>
                    &nbsp;Filter: <asp:TextBox ID="FilterField" runat="server" size="70"></asp:TextBox> 
                </td>
                <td>
                    <asp:DropDownList ID="ddlTypeFilter" AutoPostBack="true" runat="server">
                        <asp:ListItem Value="">- Any Redirect Type -</asp:ListItem>
                        <asp:ListItem Value="1">Product</asp:ListItem>
                        <asp:ListItem Value="2">Category</asp:ListItem>
                        <asp:ListItem Value="3">Custom Page</asp:ListItem>
                        <asp:ListItem Value="0">Other</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td><asp:ImageButton ID="btnGo" runat="server" AlternateText="Filter Results" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" /></td>
            </tr>
        </table>
    </asp:Panel>

    <asp:GridView ID="gvRedirects" DataKeyNames="bvin" AutoGenerateColumns="False" AllowPaging="True" BorderColor="#CCCCCC" Width="100%" CellPadding="3" GridLines="None" runat="server">
        <PagerSettings Mode="NumericFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></PagerSettings>
        <PagerStyle CssClass="pager"></PagerStyle>
        <Columns>
            <asp:BoundField DataField="RequestedUrl" HeaderText="Requested URL" />
            <asp:BoundField DataField="RedirectToUrl" HeaderText="Redirect To URL" />
            <asp:CommandField ButtonType="Image" CausesValidation="False" EditImageUrl="~/BVAdmin/images/Buttons/Edit.png" ShowEditButton="True" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:HiddenField ID="bvin" runat="server" />
                    <asp:LinkButton OnClientClick="return window.confirm('Delete this redirect?');"
                        ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                        Text="Delete" CssClass="btn-delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingRowStyle CssClass="alternaterow" />
        <PagerSettings Position="TopAndBottom" />
    </asp:GridView>
</asp:Content>
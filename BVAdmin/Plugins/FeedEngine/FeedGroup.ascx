<%@ Control Language="VB" AutoEventWireup="false" CodeFile="FeedGroup.ascx.vb" Inherits="BVAdmin_Plugins_FeedEngine_FeedGroup" %>

<asp:GridView ID="gvFeeds" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" cellpadding="0" GridLines="None" Width="100%">
    <Columns>
        <asp:TemplateField HeaderStyle-Width="30%">
            <HeaderTemplate>
                <asp:CheckBox ID="chkSelectAll" CssClass="selectAll" runat="server" /> Feed Name
            </HeaderTemplate>
            <ItemTemplate>
                <asp:CheckBox ID="chkFeed" runat="server" />
                <asp:HiddenField ID="hfBvin" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderStyle-Width="30%" HeaderText="Feed File">
            <ItemTemplate>
                <asp:HyperLink ID="lnkFeedFile" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderStyle-Width="15%" HeaderText="Last Updated">
            <ItemTemplate>
                <asp:Label ID="lblLastUpdated" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderStyle-Width="15%" HeaderText="Size">
            <ItemTemplate>
                <asp:Label ID="lblSize" runat="server" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:HyperLinkField ControlStyle-CssClass="btn-edit" Text="Edit" DataNavigateUrlFields="bvin" DataNavigateUrlFormatString="FeedEdit.aspx?id={0}" />
    </Columns>
    <RowStyle CssClass="row" />
    <HeaderStyle CssClass="rowheader" />
    <AlternatingRowStyle CssClass="alternaterow" />
</asp:GridView>

<br />

<asp:DropDownList ID="ddlGenerationType" runat="server">
	<asp:ListItem Value="1">Generate New Feed(s)</asp:ListItem>
	<asp:ListItem Value="3">Generate New Feed(s) and FTP</asp:ListItem>
	<asp:ListItem Value="2">FTP Feed(s)</asp:ListItem>
</asp:DropDownList>
<asp:ImageButton ID="btnSubmit" Text="Submit" OnClientClick="window.setTimeout(function(){document.getElementById(this.id).disabled = true;}, 1)" ImageUrl="~/BVAdmin/images/buttons/Submit.png" runat="server" />
<hr />
<br />
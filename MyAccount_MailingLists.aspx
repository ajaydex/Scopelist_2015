<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="MyAccount_MailingLists.aspx.vb" Inherits="MyAccount_MailingLists" Title="Mailing Lists" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <%--<uc2:ManualBreadCrumbTrail ID="ManualBreadCrumbTrail1" runat="server" />--%>
    <%--<h1>
        <span>
            <asp:Label ID="TitleLabel" runat="server">Mailing Lists</asp:Label></span></h1>
    <uc1:MessageBox ID="msg" runat="server" />
    <br />
    <asp:DataGrid ID="dgLists" runat="server" CellSpacing="1" AutoGenerateColumns="False"
        GridLines="None" AlternatingItemStyle-CssClass="AlternateItem" ItemStyle-CssClass="Item"
        DataKeyField="bvin" CellPadding="3">
        <AlternatingItemStyle CssClass="AlternateItem"></AlternatingItemStyle>
        <ItemStyle CssClass="Item"></ItemStyle>
        <HeaderStyle CssClass="Header"></HeaderStyle>
        <Columns>
            <asp:BoundColumn DataField="name" HeaderText="Name"></asp:BoundColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="150px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"></ItemStyle>
                <ItemTemplate>
                    <asp:ImageButton ID="SubscribeButton" CommandName="Edit" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Subscribe.png"
                        ToolTip="Subscribe"></asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="150px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"></ItemStyle>
                <ItemTemplate>
                    <asp:ImageButton ID="UnsubscribeButton" CommandName="Delete" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Unsubscribe.png"
                        ToolTip="Unsubscribe"></asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <asp:HiddenField ID="hfUserBvin" runat="server" />--%>
    <%--    commented by developer--%>
    <%--<div class="text_panel">
        <h2>
            <asp:Label ID="TitleLabel" runat="server">Mailing Lists</asp:Label></h2>
        <uc1:MessageBox ID="msg" runat="server" />
        <div id="cont_fullwidth_panel">
            <asp:DataGrid ID="dgLists" runat="server" CellSpacing="1" AutoGenerateColumns="False"
                GridLines="None" DataKeyField="bvin" CellPadding="3" Width="416px">
                <AlternatingItemStyle CssClass="Item" />
                <ItemStyle CssClass="Item"></ItemStyle>
                <HeaderStyle CssClass="Header"></HeaderStyle>
                <Columns>
                    <asp:BoundColumn DataField="name" HeaderText="Name"></asp:BoundColumn>
                    <asp:TemplateColumn>
                        <HeaderStyle Width="150px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"></ItemStyle>
                        <ItemTemplate>
                        Uncommented by developer
                            <asp:LinkButton ID="SubscribeButton" runat="server" CommandName="Edit" ToolTip="Subscribe"
                                CssClass="view_det" Style="padding: 5px 20px;">Subscribe</asp:LinkButton>
                            <asp:ImageButton ID="SubscribeButton" CommandName="Edit" runat="server" ImageUrl="~/BVModules/Themes/OpticAuthority/Images/Subscribe.png"
                                ToolTip="Subscribe"></asp:ImageButton>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderStyle Width="150px"></HeaderStyle>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"></ItemStyle>
                        <ItemTemplate>
                        uncommented by developer
                                 <asp:LinkButton ID="UnsubscribeButton" runat="server" CommandName="Delete" ToolTip="Unsubscribe"
                                CssClass="view_det" Style="padding: 5px 20px;">UnSubscribe</asp:LinkButton>
                            <asp:ImageButton ID="UnsubscribeButton" CommandName="Delete" runat="server" ImageUrl="~/BVModules/Themes/OpticAuthority/Images/UnSubscribe.png"
                                ToolTip="Unsubscribe"></asp:ImageButton>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>
            <asp:HiddenField ID="hfUserBvin" runat="server" />
        </div>
    </div>--%>
    <%--<div class="container">--%>
    <h1>
        <asp:Label ID="TitleLabel" runat="server">Mailing List</asp:Label></h1>
    <uc1:MessageBox ID="msg" runat="server" />
    <asp:DataGrid ID="dgLists" runat="server" CellSpacing="1" AutoGenerateColumns="False"
        GridLines="None" DataKeyField="bvin" CellPadding="3" Width="50%">
        <AlternatingItemStyle CssClass="Item" />
        <ItemStyle CssClass="Item"></ItemStyle>
        <HeaderStyle CssClass="name"></HeaderStyle>
        <Columns>
            <asp:BoundColumn DataField="name" HeaderText="Name" ItemStyle-Width="160"></asp:BoundColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="150px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"></ItemStyle>
                <ItemTemplate>
                    <%--Uncommented by developer--%>
                    <%-- <asp:LinkButton ID="SubscribeButton" runat="server" CommandName="Edit" ToolTip="Subscribe"
                                CssClass="view_det" Style="padding: 5px 20px;">Subscribe</asp:LinkButton>--%>
                    <asp:ImageButton ID="SubscribeButton" CommandName="Edit" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-subscribe.png"
                        ToolTip="Subscribe"></asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn>
                <HeaderStyle Width="150px"></HeaderStyle>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"></ItemStyle>
                <ItemTemplate>
                    <%-- uncommented by developer--%>
                    <%--<asp:LinkButton ID="UnsubscribeButton" runat="server" CommandName="Delete" ToolTip="Unsubscribe"
                                CssClass="view_det" Style="padding: 5px 20px;">UnSubscribe</asp:LinkButton>--%>
                    <asp:ImageButton ID="UnsubscribeButton" CommandName="Delete" runat="server" ToolTip="Unsubscribe"
                        ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-unsubscribe.png">
                    </asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <asp:HiddenField ID="hfUserBvin" runat="server" />
    <div class="clr">
    </div>
</asp:Content>

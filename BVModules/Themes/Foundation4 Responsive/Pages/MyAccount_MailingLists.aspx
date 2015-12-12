<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="MyAccount_MailingLists.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_MailingLists" title="Mailing Lists" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
    
    <h2><asp:Label ID="TitleLabel" runat="server">Mailing Lists</asp:Label></h2>

    <uc:MessageBox ID="msg" runat="server" />
  

    <asp:Repeater ID="mailingListRepeater" runat="server">
        <ItemTemplate>
            <fieldset>
                <div class="row">
                    <div class="small-5 columns smallText cell">
                        <strong><asp:Literal ID="name" runat="server">Mailing List Name</asp:Literal></strong>
                    </div>
                    <div class="small-7 columns text-right">
                        <asp:ImageButton ID="SubscribeButton" AlternateText="Subscribe" BorderWidth="0px" CommandName="Subscribe" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Subscribe.png" ToolTip="Subscribe"></asp:ImageButton>
                        <asp:ImageButton ID="UnsubscribeButton" AlternateText="Unsubscribe" BorderWidth="0px" CommandName="Unsubscribe" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Unsubscribe.png" ToolTip="Subscribe"></asp:ImageButton>
                    </div>
                </div>
                <asp:HiddenField ID="listID" runat="server" />
            </fieldset>
        </ItemTemplate>
    </asp:Repeater>

    <%--<asp:DataGrid ID="dgLists" runat="server" CellSpacing="0" CellPadding="0" AutoGenerateColumns="False" GridLines="None" AlternatingItemStyle-CssClass="AlternateItem" ItemStyle-CssClass="Item" HeaderStyle-CssClass="header" DataKeyField="bvin" >

        <Columns>
            <asp:BoundColumn DataField="name"></asp:BoundColumn>

            <asp:TemplateColumn>
                <ItemTemplate>
                    <asp:ImageButton ID="SubscribeButton" CommandName="Edit" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Subscribe.png" ToolTip="Subscribe">
                    </asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateColumn>

            <asp:TemplateColumn>
                <ItemTemplate>
                    <asp:ImageButton ID="UnsubscribeButton" CommandName="Delete" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Unsubscribe.png" ToolTip="Unsubscribe">
                    </asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateColumn>

        </Columns>

    </asp:DataGrid>--%>

    <asp:HiddenField ID="hfUserBvin" runat="server" />
   
</asp:Content>


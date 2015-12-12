<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="MyAccount_Orders.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_MyAccount_Orders" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">

    <h2><asp:Label ID="TitleLabel" runat="server">Order History</asp:Label></h2>

    <uc:MessageBox ID="msg" runat="server" />

    <h3><asp:Label ID="lblItems" runat="server">Orders Found</asp:Label></h3>

    <asp:Repeater ID="rpOrders" runat="server">
        <HeaderTemplate></HeaderTemplate>

        <ItemTemplate>
            <fieldset>
                <div class="row">
                    <div class="large-7 columns smallText cell">
                        <strong><asp:Label ID="lblOrderNumber" runat="server" /></strong>
                        &nbsp;
                        <asp:Label ID="lblGrandTotal" runat="server" />
                        &nbsp;
                        <em><asp:Label ID="lblTimeOfOrder" runat="server" /></em>
                    </div>
                    <div class="large-5 columns">
                        <asp:ImageButton ID="btnReorder" ToolTip="Reorder" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/CopyToCart.png" CommandName="Reorder" CausesValidation="false" style="vertical-align: middle;" />
                        &nbsp;
                        <asp:HyperLink ID="lnkDetails" runat="server" style="" />
                    </div>
                </div>
                </fieldset>
        </ItemTemplate>

        <FooterTemplate></FooterTemplate>
    </asp:Repeater>
</asp:Content>
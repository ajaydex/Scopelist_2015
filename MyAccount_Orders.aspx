<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="MyAccount_Orders.aspx.vb" Inherits="MyAccount_Orders" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <%--<uc2:ManualBreadCrumbTrail ID="ManualBreadCrumbTrail1" runat="server" />--%>
    <h2>
        <asp:Label ID="TitleLabel" runat="server">Order History</asp:Label></h2>
    <uc1:MessageBox ID="msg" runat="server" />
    <%--<h2>
        <asp:Label ID="lblItems" runat="server">Orders Found</asp:Label></h2>--%>
    <asp:DataGrid ID="dgOrders" CellSpacing="0" runat="server" AutoGenerateColumns="False"
        GridLines="None" CellPadding="12" DataKeyField="bvin" Width="100%" BorderWidth="0"
        CssClass="order-history">
        <HeaderStyle CssClass="tableHeader" />
        <%--<FooterStyle CssClass="HeaderStyle2"></FooterStyle>--%>
        <ItemStyle CssClass="cart_pr_det first bg_2" />
        <AlternatingItemStyle CssClass="cart_pr_det" />
        <Columns>
            <asp:BoundColumn DataField="OrderNumber" HeaderText="Order" ItemStyle-CssClass="remove"
                HeaderStyle-Width="60" HeaderStyle-Height="16px" HeaderStyle-CssClass="remove">
            </asp:BoundColumn>
            <asp:BoundColumn DataField="GrandTotal" HeaderText="Total" DataFormatString="{0:c}"
                ItemStyle-CssClass="image" HeaderStyle-Height="16px" HeaderStyle-Width="105"
                HeaderStyle-CssClass="image"></asp:BoundColumn>
            <asp:BoundColumn DataField="TimeOfOrder" HeaderText="Date" ItemStyle-CssClass="name"
                HeaderStyle-Width="290" ItemStyle-Width="290px" HeaderStyle-Height="16px" HeaderStyle-CssClass="name">
            </asp:BoundColumn>
            <asp:TemplateColumn>
                <ItemTemplate>
                    <asp:ImageButton ID="ReorderButton" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-copytocart.png"
                        CommandName="Reorder" CausesValidation="false" CommandArgument='<%# Eval("bvin") %>'
                        ToolTip="Copy To Cart"></asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateColumn>
            <asp:TemplateColumn HeaderText="Action">
                <ItemTemplate>
                    <asp:ImageButton ID="DetailsButton" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-detail.png"
                        CommandName="Edit" CausesValidation="false" ToolTip="Details"></asp:ImageButton>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid>
    <div class="clr">
    </div>
</asp:Content>

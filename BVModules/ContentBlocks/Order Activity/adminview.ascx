<%@ Control Language="VB" AutoEventWireup="false" CodeFile="adminview.ascx.vb" Inherits="BVModules_ContentBlocks_Order_Activity_view" %>

<asp:Panel runat="server" ID="UnpaidPanel" Visible="true" class="block orderActivity">
    <h6>Order Activity</h6>
    <p><asp:Label ID="Title" runat="server"></asp:Label></p>
    <asp:DataList runat="server" DataKeyField="bvin" ShowHeader="false" BorderWidth="0" GridLines="none" ID="OrderActivityDataList"  style="width:100%;" RepeatLayout="Flow">
        <ItemTemplate>
            <div style="background:#fff; padding:5px; margin:1px; border:1px solid #ddd;">
                <strong><asp:LinkButton ID="OrderNumberField" runat="server" Text='<%# Bind("OrderNumber") %>' CommandName="Go" CommandArgument='<%# Eval("bvin") %>' ToolTip='<%# Bind("OrderNumber") %>'></asp:LinkButton></strong><br />
                 <asp:LinkButton ID="EmailField" CssClass="orderactivityemaildisplay" runat="server" Text='<%# Eval("UserEmail") %>' CommandName="Go" CommandArgument='<%# Eval("bvin") %>'></asp:LinkButton>
                <asp:LinkButton ID="TimeOfOrderField" runat="server" Text='<%# Bind("TimeOfOrder") %>' CommandName="Go" CommandArgument='<%# Eval("bvin") %>'></asp:LinkButton>							
            </div>
        </ItemTemplate>
    </asp:DataList>
</asp:Panel>


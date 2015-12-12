<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="GiftWrap.aspx.vb" Inherits="search" Title="Search" %>

<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <h1>
        Gift Wrap
    </h1>
    <uc2:MessageBox ID="MessageBox1" runat="server" />
    <asp:Panel ID="pnlDesc" runat="server">
        <asp:Literal ID="Description" runat="server" Text="We'll wrap some or all of the items in your order and include the personalized message. Choose the item you wish to gift wrap, check the Gift Wrap option, then enter your name in the From field and the name of the recipient in the To field. Enter a special greeting in the Message field and when you are finished, click Continue."></asp:Literal>
    </asp:Panel>
    <table border="0" cellspacing="0" cellpadding="0" id="giftwrapheadertable">
                <tr>
                <th>
                    Image</th>
                <th>
                    Name</th>
                <th>
                    Cost</th>
            </tr>
            <tr>
                <td>
                    <asp:Image ID="imgProduct" runat="server" AlternateText="" /></td>
                <td>
                    <asp:Label ID="lblitemdescription" runat="server"></asp:Label></td>
                <td>
                    Gift Wrap Price:
                    <asp:Label ID="lblgiftwrapprice" runat="server"></asp:Label>
                    /each
                </td>
            </tr>
    </table>
    <div id="giftwraptable">
        <table border="0" cellspacing="0" cellpadding="0">
            <asp:Repeater ID="repeatercontrol" runat="server">
                <ItemTemplate>
                    <tr>
                        <th colspan="3">
                            <asp:Literal ID="lblGiftMessage" runat="server" Text="Gift Message"></asp:Literal>
                        </th>
                    </tr>
                    <tr>
                        <td class="left" width="15px">
                            <asp:CheckBox ID="chkGiftWrap" runat="server" Text="Gift Wrap" />
                        </td>
                        <td class="right">
                            <asp:Literal ID="lblTo" runat="server" Text="To:"></asp:Literal>
                        </td>
                        <td class="left">
                            <asp:TextBox ID="txtToField" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td width="15px">
                        </td>
                        <td class="right">
                            <asp:Literal ID="lblFrom" runat="server" Text="From:"></asp:Literal></td>
                        <td class="left">
                            <asp:TextBox ID="txtFromField" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td width="15px">
                        </td>
                        <td class="right">
                            <asp:Literal ID="lblMessage" runat="server" Text="Message:"></asp:Literal></td>
                        <td class="left" colspan="2">
                            <asp:TextBox ID="txtMessageField" runat="server" Columns="50" TextMode="MultiLine"
                                Rows="3"></asp:TextBox></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
            <tr>
                <td class="left">
                    <asp:ImageButton ID="btnContinue" runat="server" CausesValidation="false" ImageUrl="~/BVModules/Themes/Print Book/Images/Buttons/ContinueToCart.png"
                        AlternateText="Continue" /></td>
            </tr>
        </table>
    </div>
</asp:Content>

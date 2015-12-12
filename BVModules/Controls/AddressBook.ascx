<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AddressBook.ascx.vb"
    Inherits="BVModules_Controls_AddressBook" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<asp:Panel ID="AddressGridViewPanel" CssClass="addressbookpanel" runat="server">
    <h3>
        <anthem:ImageButton ID="AddressBookImageButton" runat="server" AlternateText="Address Book"
            ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/AddressBook.png" CausesValidation="false" />
    </h3>
    <anthem:GridView ID="AddressGridView" runat="server" AutoGenerateColumns="False"
        DataKeyNames="bvin" Visible="false" ShowHeader="false" ShowFooter="false" AlternatingRowStyle-CssClass="alt"
        Width="100%">
        <Columns>
            <asp:TemplateField ItemStyle-CssClass="addressbook-cell-left">
                <ItemTemplate>
                    <div class="address" style="border: none">
                        <p>
                            <asp:Label ID="linename" runat="server" Visible="true"></asp:Label>
                        </p>
                        <p>
                            <asp:Label ID="lineone" runat="server" Visible="true"></asp:Label>
                        </p>
                        <p>
                            <asp:Label ID="linetwo" runat="server" Visible="true"></asp:Label>
                        </p>
                        <p>
                            <asp:Label ID="linethree" runat="server" Visible="true"></asp:Label>
                        </p>
                        <p>
                            <asp:Label ID="linefour" runat="server" Visible="true"></asp:Label>
                        </p>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderStyle-Width="30%" ItemStyle-VerticalAlign="Top" ItemStyle-CssClass="addressbook-cell-right">
                <ItemTemplate>
                    <span class="float-r">
                        <anthem:ImageButton ID="BillToAddressImageButton" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-shipto.png"
                            CommandName="BillTo" CausesValidation="false" AlternateText="Bill To" EnabledDuringCallBack="false" />
                    </span><span class="float-r">
                        <anthem:ImageButton ID="ShipToAddressImageButton" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-billto.png"
                            CommandName="ShipTo" CausesValidation="false" AlternateText="Ship To" EnabledDuringCallBack="false" />
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </anthem:GridView>
</asp:Panel>

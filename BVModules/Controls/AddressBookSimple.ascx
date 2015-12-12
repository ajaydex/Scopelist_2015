<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AddressBookSimple.ascx.vb" Inherits="BVModules_Controls_AddressBookSimple" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Panel ID="AddressGridViewPanel" Cssclass="addressbookpanel" runat="server">
    <anthem:ImageButton ID="btnAddressBook" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/AddressBookDropdown.png" CausesValidation="false" AutoUpdateAfterCallBack="true" runat="server" />

    <anthem:Repeater ID="rpAddressBook" runat="server">
        <HeaderTemplate>
            <ul class="addressBook">
        </HeaderTemplate>

        <ItemTemplate>
            <li class="<%# If(Container.ItemIndex Mod 2 = 0, String.Empty, "alt") %>">
                <p><anthem:LinkButton ID="lnkAddress" OnClick="lnkAddress_Click" CausesValidation="false" EnabledDuringCallBack="false" runat="server" /></p>
            </li>
        </ItemTemplate>

        <FooterTemplate>
            </ul>
            <anthem:ImageButton ID="btnClose" OnClick="btnClose_Click" CssClass="closeBtn" ImageUrl="~/BVModules/Themes/Bvc5/images/x.png" CausesValidation="false" AutoUpdateAfterCallBack="true" runat="server" />
        </FooterTemplate>
    </anthem:Repeater>
</asp:Panel>
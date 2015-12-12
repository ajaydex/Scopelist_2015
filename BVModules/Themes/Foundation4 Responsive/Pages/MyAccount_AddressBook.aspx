<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" Language="vb" AutoEventWireup="false"
    Inherits="BVModules_Themes_Foundation4_Responsive_AddressBook" CodeFile="MyAccount_AddressBook.aspx.vb" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="server">
    
    <h2><asp:Label ID="TitleLabel" runat="server">Address Book</asp:Label></h2>
    <asp:ImageButton ID="AddNewButton" CssClass="newaddress" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/New.png"  ToolTip="Add New Address"></asp:ImageButton>

    <hr />
    
    <uc:MessageBox ID="msg" runat="server" />
    <div class="row">
        <div class="large-6 columns">
            <div class="highlight pad-all-1em smallText address">
                <h3>Billing Address:</h3>
                <asp:Label runat="server" ID="BillingAddressField" CssClass="pad-bottom-1em"></asp:Label>
                <asp:ImageButton ID="btnBillingAddressEdit" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Edit.png"   AlternateText="Edit" />
            </div>
        </div>
        <div class="large-6 columns">
            <div class="highlight pad-all-1em smallText address">
                <h3>Shipping Address:</h3>
                <asp:Label runat="server" ID="ShippingAddressField" CssClass="pad-bottom-1em"></asp:Label>
                <asp:ImageButton ID="btnShippingAddressEdit" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Edit.png" />
            </div>
        </div>
    </div>
               
    <h2><asp:Label ID="lblItems" runat="server">Addresses Found</asp:Label></h2>

    <div class="row addressbook">
    <asp:DataList ID="AddressList" runat="server" RepeatDirection="Horizontal" DataKeyField="bvin" RepeatColumns="999" RepeatLayout="Flow">
        <ItemTemplate>
            <div class="large-6 columns">
                <div class="pad-all-1em smallText address">
                    <asp:Label CssClass="pad-bottom-1em" runat="server" ID="AddressDisplay" Text='<%# DataBinder.Eval(Container, "DataItem.FirstName") %>'>
                    </asp:Label>
                    <div class="buttonrow">
                        <asp:ImageButton CommandName="Edit" ID="EditButton" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Edit.png"
                            AlternateText="Edit" runat="server" /> 
                        <asp:ImageButton CommandName="Delete" ID="DeleteButton" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Delete.png"
                            AlternateText="Delete" runat="server" OnClientClick="return window.confirm('Delete this address?');" />
                    </div>
                    <div class="buttonrow">
                        <asp:ImageButton CommandName="BillTo" ID="BillToImageButton" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/BillTo.png"
                            AlternateText="Set As Default Billing Address" runat="server" OnClientClick="return window.confirm('Make this your default Billing Address?');" /> 
                        <asp:ImageButton CommandName="ShipTo" ID="ShipToImageButton" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/ShipTo.png"
                            AlternateText="Set As Default Shipping Address" runat="server" OnClientClick="return window.confirm('Make this your default Shipping Address?');" />
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:DataList>
    </div>
    <asp:HiddenField ID="hfUserBvin" runat="server" />
</asp:Content>

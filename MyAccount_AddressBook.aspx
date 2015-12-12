<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" Language="vb" AutoEventWireup="false"
    Inherits="myaccount_AddressBook" CodeFile="MyAccount_AddressBook.aspx.vb" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="server">
    <h1>
        <asp:Label ID="TitleLabel" runat="server">Address Book</asp:Label></h1>
    <div id="cont_fullwidth_panel">
        <div id="product_det-blk">
            <p class="pad_top10 pad_top_addresspage">
                <asp:ImageButton ID="AddNewButton" CssClass="newaddress" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-createnew.png"
                    ToolTip="Add New Address"></asp:ImageButton>
            </p>
            <div class="left-half-border">
                <h3>
                    Billing Address:</h3>
                <div>
                    <p>
                        <asp:Literal runat="server" ID="BillingAddressField"></asp:Literal>
                    </p>
                    <p>
                        <asp:ImageButton ID="btnBillingAddressEdit" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-edit.png"
                            AlternateText="Edit" />
                    </p>
                    <div class="clear">
                    </div>
                </div>
            </div>
            <div class="right-half">
                <h3>
                    Shipping Address:</h3>
                <div>
                    <p>
                        <asp:Literal runat="server" ID="ShippingAddressField"></asp:Literal>
                    </p>
                    <p>
                        <asp:ImageButton ID="btnShippingAddressEdit" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-edit.png"
                            AlternateText="Edit" />
                    </p>
                    <div class="clear">
                    </div>
                </div>
            </div>
            <div class="clr">
            </div>
            <div class="top-border-block">
                <h3>
                    <asp:Label ID="lblItems" runat="server">Address Found:</asp:Label></h3>
                <asp:DataList ID="AddressList" runat="server" RepeatDirection="Vertical" DataKeyField="bvin"
                    RepeatColumns="1">
                    <ItemTemplate>
                        <div class="lg_box" style="height: 186px;">
                            <p>
                                <asp:Literal runat="server" ID="AddressDisplay" Text='<%# DataBinder.Eval(Container, "DataItem.FirstName") %>'>
                                </asp:Literal>
                            </p>
                            <asp:ImageButton CommandName="Edit" ID="EditButton" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-edit.png"
                                AlternateText="Edit" runat="server" />
                            <asp:ImageButton CommandName="Delete" ID="DeleteButton" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-delete.png"
                                AlternateText="Delete" runat="server" OnClientClick="return window.confirm('Delete this address?');" />
                            <asp:ImageButton CommandName="BillTo" ID="BillToImageButton" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-billto.png"
                                AlternateText="Set As Default Billing Address" runat="server" OnClientClick="return window.confirm('Make this your default Billing Address?');" />
                            <asp:ImageButton CommandName="ShipTo" ID="ShipToImageButton" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-shipto.png"
                                AlternateText="Set As Default Shipping Address" runat="server" OnClientClick="return window.confirm('Make this your default Shipping Address?');" />
                            <div class="clear">
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList><asp:HiddenField ID="hfUserBvin" runat="server" />
            </div>
        </div>
    </div>
</asp:Content>

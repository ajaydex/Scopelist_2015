<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" Language="vb" AutoEventWireup="false"
    Inherits="myaccount_AddressBook_Edit" CodeFile="MyAccount_AddressBook_Edit.aspx.vb" %>

<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc3" %>
<%@ Register Src="BVModules/Controls/StoreAddressEditor.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ContentPlaceHolderID="MainContentHolder" runat="server">
    <h1>
        <span>Edit Address</span></h1>
    <uc1:MessageBox ID="msg" runat="server" />
    <asp:ValidationSummary ID="valSummary" EnableClientScript="True" runat="server" ForeColor=" "
        CssClass="error_list" ValidationGroup="grpAddressBook" />
    <h3>
        Fields that contain * are required!</h3>
    <div class="general-form">
        <uc2:AddressControl ID="AddressControl1" runat="server" />
        <div class="form-row">
            <div class="form-left">
                &nbsp;
            </div>
            <div>
                <asp:ImageButton ID="SaveButton" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-submit.png"
                    TabIndex="1200" ToolTip="Save" ValidationGroup="grpAddressBook"></asp:ImageButton>
                <asp:ImageButton ID="CancelButton" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-cancel.png"
                    CausesValidation="False" TabIndex="1300" ToolTip="Cancel" ValidationGroup="grpAddressBook" />
            </div>
            <div class="clr">
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hfUserBvin" runat="server" />
    <div class="clr">
    </div>
</asp:Content>

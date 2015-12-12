<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" Language="vb" AutoEventWireup="false"
    Inherits="myaccount_AddressBook_New" CodeFile="MyAccount_AddressBook_New.aspx.vb" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc3" %>
<%@ Register Src="BVModules/Controls/StoreAddressEditor.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>
<asp:Content ContentPlaceHolderID="MainContentHolder" runat="server">
    <h1>
        <span>Add New Address</span></h1>
    <h3>
        Fields that contain <span>*</span> are required!</h3>
    <div class="big-column">
        <uc1:MessageBox ID="msg" runat="server" />
        <asp:ValidationSummary ID="valSummary" EnableClientScript="True" runat="server" ForeColor=" "
            CssClass="error_list" ValidationGroup="grpAddressBook" />
        <br />
        <div id="cont_fullwidth_panel" class="general-form">
            <div class="login_panel full">
                <div class="signup_blk emailpricerequest" style="margin-bottom: 20px; width: 473px;">
                    <uc2:AddressControl ID="AddressControl1" runat="server" />
                    <div class="form-row">
                        <div class="form-left">
                            &nbsp;
                        </div>
                        <div>
                            <%--<asp:LinkButton ID="SaveButton" runat="server" TabIndex="1200" CssClass="view_det"
                            ToolTip="Submit" Style="padding: 5px 20px;" ValidationGroup="grpAddressBook">Submit</asp:LinkButton>--%>
                            <asp:ImageButton ID="SaveButton" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-submit.png"
                                CausesValidation="False" TabIndex="1300" ValidationGroup="grpAddressBook"></asp:ImageButton>
                            <%--<asp:LinkButton ID="CancelButton" runat="server" CausesValidation="False" TabIndex="1300"
                            CssClass="view_det" ToolTip="Cancel" Style="padding: 5px 20px;">Cancel</asp:LinkButton>--%>
                            <asp:ImageButton ID="CancelButton" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-cancel.png"
                                TabIndex="1200"></asp:ImageButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hfUserBvin" runat="server" />
    </div>
</asp:Content>

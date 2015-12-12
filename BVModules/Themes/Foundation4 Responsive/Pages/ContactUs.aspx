<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Service.master" AutoEventWireup="false"
    CodeFile="ContactUs.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_Contact" Title="Contact Us" ValidateRequest="false" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <h2><asp:Label ID="TitleLabel" runat="server">Contact Us</asp:Label></h2>
    
    <uc:MessageBox ID="msg" runat="server" />
    
    <div id="contactUsInfo" runat="server"></div>
    
    <asp:Panel ID="pnlContactForm" DefaultButton="btnSubmit" runat="server">
        <fieldset class="contactform">
            <asp:ValidationSummary ID="valSummary" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server" ForeColor="White" DisplayMode="BulletList" HeaderText='<a href="#" class="close">&times;</a>' />
            <asp:Repeater ID="rpForm" runat="server">
                <HeaderTemplate></HeaderTemplate>

                <ItemTemplate>
                    <div class="row">
                        <asp:Panel ID="pnlField" runat="server">
                            <asp:Label ID="lblField" runat="server" />
                            <bvc5:BVRequiredFieldValidator ID="rfvField" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Field is required." Text="*" Display="Dynamic" runat="server" />
                        </asp:Panel>
                    </div>
                </ItemTemplate>

                <FooterTemplate></FooterTemplate>
            </asp:Repeater>

            <div class="buttonrow">
                <asp:Button ID="btnSubmit" CssClass="button" Text="Submit" runat="server" />
            </div>
        </fieldset>
    </asp:Panel>
</asp:Content>
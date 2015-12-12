<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="Error.aspx.vb" Inherits="ErrorPage" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div class="main">
        <div class="row">
            <div class="small-12 columns">
                <h1>
                    <span>
                        <asp:Literal ID="HeaderLiteral" runat="server"></asp:Literal></span></h1>
                <div class="errorcontent">
                    <asp:Literal ID="ErrorContentLiteral" runat="server"></asp:Literal>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

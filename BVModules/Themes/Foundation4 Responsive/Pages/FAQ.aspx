<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="FAQ.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_FAQ" Title="Frequently Asked Questions" %>

<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <h2 id="top"><asp:Label ID="TitleLabel" runat="server">Frequently Asked Questions</asp:Label></h2>
    <uc1:MessageBox ID="msg" runat="server" Visible="false" />
    <asp:Repeater ID="dlQuestions" runat="server">
        <HeaderTemplate>
            <ol id="faquestions">
        </HeaderTemplate>
        <ItemTemplate>
            <li><a href='<%# "#" & Eval("bvin").ToString %>'>
                <%# Eval("name") %>
            </a></li>
        </ItemTemplate>
        <FooterTemplate>
            </ol>
        </FooterTemplate>
    </asp:Repeater>
    <h2>Answers&hellip;</h2>
    <asp:Repeater ID="dlPolicy" runat="server">
        <HeaderTemplate>
            <ol id="faanswers">
        </HeaderTemplate>
        <ItemTemplate>
            <li>
                <h4 id="<%# Eval("bvin") %>">
                    <%# Eval("name") %>
                </h4>
                <%#Eval("description")%>
                <%--<p><a id="backToTop" href="#top" class="smallText"><i class="fa fa-angle-up"></i> Back to Top</a></p>--%>
            </li>
        </ItemTemplate>
        <FooterTemplate>
            </ol>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>

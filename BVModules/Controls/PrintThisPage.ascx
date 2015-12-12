<%@ Control Language="VB" AutoEventWireup="false" CodeFile="PrintThisPage.ascx.vb"
    Inherits="BVModules_Controls_PrintThisPage" %>
<%--<div id="printthispage">--%>
<a onclick="JavaScript:if (window.print) {window.print();} else { alert('Please choose the print button from your browser.  Usually in the menu dropdowns at File: Print'); } "
    href="#" class="more">
    <%--<asp:Image AlternateText="Print this page." Style="cursor: hand" ID="imgPrint" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/PrintThisPage.png">
        </asp:Image>--%>
    Printable Page </a>
<%--</div>--%>

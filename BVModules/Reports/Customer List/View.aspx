<%@ Page MasterPageFile="~/BVAdmin/BVAdminReports.master" Language="VB" AutoEventWireup="false" CodeFile="View.aspx.vb" Inherits="BVModules_Reports_Customer_List_View"
title="Custom List Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>Customer List</h2>
    
    <p>This report generates a tab-delimited list of customers and the amounts of each specified product they purchased. You can save the text to a *.txt file and load it into Excel or another spreadsheet for mailing lists.</p>
    
    SKUs<br />
    <asp:TextBox ID="PurchasedSkuField" runat="server" style="width:600px!Important;"></asp:TextBox> <br />
    <i class="smalltext">ABC123,ABC003,DEF123</i>
    <br />
    <br />
    
    <asp:ImageButton ID="btnGo" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Submit.png"  />
    <br />
    <br />
    <asp:Label ID="lblResult" runat="server"></asp:Label>
    <asp:TextBox ID="txtResults" runat="server" TextMode="MultiLine" Rows="20" Wrap="False"></asp:TextBox>
</asp:Content>



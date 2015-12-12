<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Search.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_Search" %>
  
<asp:Panel ID="pnlSearchBox" runat="server" DefaultButton="btnSearch" cssclass="row collapse search">
    
    <div class="small-9 columns">
        <asp:TextBox ID="KeywordField" runat="server"></asp:TextBox>
    </div>
    <div class="small-3 columns">
        <asp:Button ID="btnSearch" cssclass="button prefix secondary" runat="server" CausesValidation="false" Text="Search" />
    </div>
   
</asp:Panel>


        
     

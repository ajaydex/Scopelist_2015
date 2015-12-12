<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CrossSellDisplay.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_CrossSellDisplay" %>
<%@ Register Src="~/BVModules/Themes/Foundation4 Responsive/Controls/ProductGridDisplay.ascx" TagName="ProductGridDisplay" TagPrefix="uc" %>

<h2><asp:Label ID="TitleLabel" runat="server" Text="Recommended Products"></asp:Label></h2>

<uc:ProductGridDisplay ID="ProductGridDisplay" runat="server" />



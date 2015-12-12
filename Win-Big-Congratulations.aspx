<%@ Page Title="" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Win-Big-Congratulations.aspx.vb" Inherits="Win_Big_Congratulations" %>

<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div style="color: Green;">
        <uc1:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="Win Big Congratulations" />
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="EndOfForm" runat="Server">
</asp:Content>

<%@ Page Title="" Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master"
    AutoEventWireup="false" CodeFile="Win-Big-Sorry-Try-Next-Time.aspx.vb" Inherits="Win_Big_Sorry_Try_Next_Time" %>

<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headcontent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <div style="color: Red;">
        <uc1:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="Win Big Sorry Try Next Play" />
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="EndOfForm" runat="Server">
</asp:Content>

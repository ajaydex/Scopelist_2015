<%@ Page MasterPageFile="~/BVAdmin/BVAdmin.Master" ValidateRequest="False" Language="vb"
    AutoEventWireup="false" Inherits="Reviews_Edit" CodeFile="Reviews_Edit.aspx.vb" %>

<%@ Register TagPrefix="uc1" TagName="ProductReviewEditor" Src="~/BVAdmin/controls/ProductReviewEditor.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Product Review</h1>
    <uc1:ProductReviewEditor ID="ProductReviewEditor1" runat="server"></uc1:ProductReviewEditor>
</asp:Content>

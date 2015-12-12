<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ProductMainImage.ascx.vb" Inherits="BVModules_Controls_ProductMainImage" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<a id="AdditionalImagesLink" runat="server" enableviewstate="false">
    <anthem:Image ID="imgMain" runat="server" AutoUpdateAfterCallBack="true" />
</a>
<div ID="BadgeImage" runat="server" class="new-label new-top-left"></div>

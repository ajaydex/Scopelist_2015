<%@ Control Language="VB" EnableViewState="false" AutoEventWireup="false" CodeFile="ProductRatingDisplay.ascx.vb" Inherits="BVModules_Controls_ProductRatingDisplay" %>

<div>
    <asp:HyperLink ID="lnkRating" Text='<div class="rating">{0} <span><strong>{1}</strong> Review{2}</span></div>' runat="server" class="reviewLink" />
    <asp:HyperLink ID="lnkWriteReview" Text="<span>Review this product</span>" CssClass="reviewLink" runat="server" />
</div>
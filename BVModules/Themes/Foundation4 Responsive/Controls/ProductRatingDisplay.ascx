<%@ Control Language="VB" EnableViewState="false" AutoEventWireup="false" CodeFile="ProductRatingDisplay.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_ProductRatingDisplay" %>

<asp:HyperLink ID="lnkRating" Text='<span class="rating">{0} <span><strong>{1}</strong> Review{2}</span></span>' runat="server" class="reviewLink" />
<asp:HyperLink ID="lnkWriteReview" Text="<span>Review this product</span>" CssClass="reviewLink" runat="server" />

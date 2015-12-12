<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ProductReviewDisplay.ascx.vb"
    Inherits="BVModules_Controls_ProductReviewDisplay" %>
<asp:Panel ID="pnlReviewDisplay" EnableViewState="False" runat="server" CssClass="ProductReviews">
    <h3 id="ProductReviews">
        <span>
            <asp:Label ID="lblTitle" runat="server">Customer Reviews</asp:Label></span></h3>
    <div class="ProductReviewRating">
        <asp:Label ID="lblRating" runat="server">Average Rating</asp:Label>
        <asp:Image ID="imgAverageRating" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Stars3.png">
        </asp:Image></div>
    <asp:DataList ID="dlReviews" runat="server" DataKeyField="Bvin">
        <ItemTemplate>
            <div class="ProductReview">
                <asp:Image ID="imgReviewRating" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Stars3.png" /><br />
                <span class="productreviewdescription">
                    <asp:Label ID="lblReviewDescription" runat="server">Review...</asp:Label></span>
                <asp:Panel ID="pnlKarma" runat="server">
                    <span class="ProductReviewKarma">
                        <asp:Label ID="lblProductReviewKarma" runat="server">Was this review helpful?</asp:Label> 
                        <asp:ImageButton CommandName="Edit" CausesValidation="False" ID="btnReviewKarmaYes"
                            ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Yes.png" AlternateText="Yes"
                            runat="server"></asp:ImageButton> 
                        <asp:ImageButton CommandName="Delete" CausesValidation="False" ID="btnReviewKarmaNo"
                            ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/No.png" AlternateText="No" runat="server">
                        </asp:ImageButton></span>
                </asp:Panel>
            </div>
        </ItemTemplate>
    </asp:DataList>
    <asp:DataList ID="dlAmazonReviews" runat="server" Visible="False">
        <ItemTemplate>
            <div class="ProductReview">
                <asp:Image ID="imgAmazonRating" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Stars3.png" />
                <span class="productreviewdescription">
                    <asp:Label ID="lblAmazonSummary" runat="server"></asp:Label>                 
                    <asp:Label ID="lblAmazonComment" runat="server"></asp:Label>
                </span>
            </div>
        </ItemTemplate>
    </asp:DataList>
    <div class="ProductReviewLinks">
        <asp:HyperLink ID="lnkAllReviews" runat="server" NavigateUrl="javascript:void(0)">View All Reviews</asp:HyperLink><br />
        <asp:HyperLink ID="lnkWriteAReview" runat="server" NavigateUrl="javascript:void(0)">Write A Review</asp:HyperLink></div>
    <asp:HiddenField ID="bvinField" runat="server" />
</asp:Panel>

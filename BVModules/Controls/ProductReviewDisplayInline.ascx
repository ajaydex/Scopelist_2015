<%@ Control Language="VB" EnableViewState="false" AutoEventWireup="false" CodeFile="ProductReviewDisplayInline.ascx.vb" Inherits="BVModules_Controls_ProductReviewDisplayInline" %>
<%@ Register TagPrefix="uc" TagName="MessageBox" Src="~/BVModules/Controls/MessageBox.ascx" %>

<asp:Panel ID="pnlReviewDisplay" EnableViewState="False" CssClass="ProductReviews" runat="server">
    <h3 id="ProductReviews"><asp:Label ID="lblTitle" runat="server">Customer Reviews</asp:Label></h3>
    
    <div class="ProductReviewRating" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
        <meta itemprop="ratingValue" id="metaRatingValue" runat="server" />
        <meta itemprop="reviewCount" id="metaReviewCount" runat="server" />
        <asp:Label ID="lblRating" runat="server">Average Rating</asp:Label>
        <asp:Image ID="imgAverageRating" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Stars3.png">
        </asp:Image>
    </div>
    
    <div class="ProductReviewLinks">
        <asp:HyperLink ID="lnkWriteAReview" runat="server" NavigateUrl="javascript:void(0)">Write A Review</asp:HyperLink>
    </div>
    
    <asp:DataList ID="dlReviews" runat="server" DataKeyField="Bvin">
        <HeaderTemplate>
            <a id="ProductReviewList"></a>
        </HeaderTemplate>
        
        <ItemTemplate>
            <asp:HyperLink ID="lnkNamedAnchor" runat="server" />
	        <div class="ProductReview <%# If(Container.ItemIndex Mod 2 = 0, String.Empty, "alt") %>" itemprop="review" itemscope itemtype="http://schema.org/Review">
		        <p itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
                    <meta itemprop="worstRating" content="1">
                    <meta itemprop="bestRating" content="5">
                    <meta itemprop="ratingValue" id="metaRatingValue" runat="server" />
                    
		            <asp:Image ID="imgReviewRating" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Stars3.png" /><br />
		            by <asp:Label ID="lblName" runat="server" /> on <asp:Label ID="lblReviewDate" runat="server" />
		        </p>
		        <p class="productreviewdescription" itemprop="description">
			        <asp:Label ID="lblReviewDescription" runat="server">Review...</asp:Label>
			    </p>
		        <asp:Panel ID="pnlKarma" CssClass="ProductReviewKarma" runat="server">
				        <asp:Label ID="lblProductReviewKarma" runat="server">Was this review helpful?</asp:Label> 
				        <asp:ImageButton CommandName="Edit" CausesValidation="False" ID="btnReviewKarmaYes" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Yes.png" AlternateText="Yes" runat="server" /> 
				        <asp:ImageButton CommandName="Delete" CausesValidation="False" ID="btnReviewKarmaNo" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/No.png" AlternateText="No" runat="server" />
		        </asp:Panel>
	        </div>
        </ItemTemplate>
    </asp:DataList>
    <asp:HiddenField ID="bvinField" runat="server" />
</asp:Panel>

<asp:Panel ID="pnlWriteAReview" DefaultButton="btnSubmitReview" runat="server">
    <a name="Write"></a>
    <uc:MessageBox ID="ucMessageBox" runat="server" />
    <asp:ValidationSummary ID="vs_Summary" ValidationGroup="vgReview" DisplayMode="BulletList" HeaderText="Please complete the following fields..." EnableClientScript="false" runat="server" />
    <h3><span>Write a Review</span></h3>
    <table cellspacing="0">
        <asp:PlaceHolder ID="phReviewRating" runat="server">
        <tr>
            <td class="Formlabel">
                Rating
                <asp:RequiredFieldValidator ID="rfv_lstNewReviewRating" ValidationGroup="vgReview" ControlToValidate="lstNewReviewRating" ErrorMessage="Rating" Text="*" EnableClientScript="false" Display="Static" runat="server" />
            </td>
            <td>
                <asp:RadioButtonList ID="lstNewReviewRating" runat="server">
                    <asp:ListItem Value="5">Love It</asp:ListItem>
                    <asp:ListItem Value="4">Like It</asp:ListItem>
                    <asp:ListItem Value="3">It's OK</asp:ListItem>
                    <asp:ListItem Value="2">Don't Like It</asp:ListItem>
                    <asp:ListItem Value="1">Hate It</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        </asp:PlaceHolder>
        <tr>
            <td class="Formlabel">
                Review
                <asp:RequiredFieldValidator ID="rfv_NewReviewDescription" ValidationGroup="vgReview" ControlToValidate="NewReviewDescription" ErrorMessage="Review" Text="*" EnableClientScript="false" Display="Static" runat="server" />
            </td>
            <td>
                <asp:TextBox ID="NewReviewDescription" runat="server" Columns="30" Rows="6" TextMode="MultiLine" MaxLength="6000" CssClass="FormInput" />
            </td>
        </tr>
        <tr>
            <td class="Formlabel">
                Name
                <asp:RequiredFieldValidator ID="rfv_Name" ValidationGroup="vgReview" ControlToValidate="Name" ErrorMessage="Name" Text="*" EnableClientScript="false" Display="Static" runat="server" />
            </td>
            <td><asp:TextBox ID="Name" MaxLength="200" runat="server" /></td>
        </tr>
        <tr>
            <td class="Formlabel">
                Email Address
                <asp:RequiredFieldValidator ID="rfv_Email" ValidationGroup="vgReview" ControlToValidate="Email" ErrorMessage="Email Address" Text="*" EnableClientScript="false" Display="Static" runat="server" />
                <asp:RegularExpressionValidator ID="rxv_Email" ValidationGroup="vgReview" ControlToValidate="Email" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$" ErrorMessage="Invalid Email Address" Text="*" EnableClientScript="false" Display="Dynamic" runat="server" />
            </td>
            <td><asp:TextBox ID="Email" MaxLength="100" runat="server" /></td>
        </tr>
        <tr>
            <td class="Formlabel"></td>
            <td>
                <asp:ImageButton ID="btnSubmitReview" ValidationGroup="vgReview" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Submit.png" AlternateText="Submit" />
            </td>
        </tr>
    </table>
</asp:Panel>
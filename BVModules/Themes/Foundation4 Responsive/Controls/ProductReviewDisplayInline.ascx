<%@ Control Language="VB" EnableViewState="false" AutoEventWireup="false" CodeFile="ProductReviewDisplayInline.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_ProductReviewDisplayInline" %>

<%@ Register TagPrefix="uc" TagName="MessageBox" Src="~/BVModules/Controls/MessageBox.ascx" %>

<div class="row">
    <div class="large-5 columns">
        <asp:Panel ID="pnlWriteAReview" DefaultButton="btnSubmitReview" runat="server">
            <a name="Write"></a>

            <uc:MessageBox ID="ucMessageBox" runat="server" />

            <asp:ValidationSummary ID="vs_Summary" data-alert CssClass="alert-box alert" ValidationGroup="vgReview" ForeColor="White" DisplayMode="BulletList" HeaderText='<a href="#" class="close">&times;</a>'  EnableClientScript="false" runat="server" />

            <h3><span>Write a Review</span></h3>
            <asp:PlaceHolder ID="phReviewRating" runat="server">
                <asp:RequiredFieldValidator ID="rfv_lstNewReviewRating" ValidationGroup="vgReview" ControlToValidate="lstNewReviewRating" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Rating is required." Text="*" EnableClientScript="false" Display="Static" runat="server" />
                <asp:RadioButtonList ID="lstNewReviewRating" runat="server">
                    <asp:ListItem Value="5"> Love It</asp:ListItem>
                    <asp:ListItem Value="4"> Like It</asp:ListItem>
                    <asp:ListItem Value="3"> It's OK</asp:ListItem>
                    <asp:ListItem Value="2"> Don't Like It</asp:ListItem>
                    <asp:ListItem Value="1"> Hate It</asp:ListItem>
                </asp:RadioButtonList>
            </asp:PlaceHolder>

            <br />
                
            <label>Review</label>
            <asp:RequiredFieldValidator ID="rfv_NewReviewDescription" ValidationGroup="vgReview" ControlToValidate="NewReviewDescription" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Review is required." Text="*" EnableClientScript="false" Display="dynamic" runat="server" />
            <asp:TextBox ID="NewReviewDescription" runat="server" Rows="10" TextMode="MultiLine" MaxLength="6000" placeholder="required" />
                    
            <label>Name</label>
            <asp:RequiredFieldValidator ID="rfv_Name" ValidationGroup="vgReview" ControlToValidate="Name" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Name is required." Text="*" EnableClientScript="false" Display="dynamic" runat="server" />
            <asp:TextBox ID="Name" MaxLength="200" runat="server" placeholder="required" />

            <label>Email Address</label>
            <asp:RequiredFieldValidator ID="rfv_Email" ValidationGroup="vgReview" ControlToValidate="Email" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Email Address is required." Text="*" EnableClientScript="false" Display="dynamic" runat="server" />
            <asp:RegularExpressionValidator ID="rxv_Email" ValidationGroup="vgReview" ControlToValidate="Email" ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Invalid Email Address" Text="*" EnableClientScript="false" Display="dynamic" runat="server" />
            <asp:TextBox ID="Email" MaxLength="100" runat="server" placeholder="required" />


            <asp:ImageButton ID="btnSubmitReview" ValidationGroup="vgReview" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Submit.png" AlternateText="Submit" />

            <br />
            <br />
                   
        </asp:Panel>
    </div>

    <div class="large-7 columns">
        <asp:Panel ID="pnlReviewDisplay" EnableViewState="False" CssClass="ProductReviews" runat="server">
            <h3 id="ProductReviews"><asp:Label ID="lblTitle" runat="server">Customer Reviews</asp:Label></h3>
            <div class="ProductReviewRating" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
                <meta itemprop="ratingValue" id="metaRatingValue" runat="server" />
                <meta itemprop="reviewCount" id="metaReviewCount" runat="server" />
                <asp:Label ID="lblRating" runat="server">Average Rating</asp:Label>
                <asp:Image ID="imgAverageRating" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Stars3.png"></asp:Image>
            </div>

            <div class="ProductReviewLinks hide">
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
    </div>
</div>
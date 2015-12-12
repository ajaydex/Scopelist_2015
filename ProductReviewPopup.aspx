<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Popup.Master" Language="vb" AutoEventWireup="false"
    Inherits="ProductReviewPopup" CodeFile="ProductReviewPopup.aspx.vb" %>
    
<%@ Register Src="BVModules/Controls/MessageBox.ascx" TagName="MessageBoxControl" TagPrefix="uc1" %>

<asp:Content ContentPlaceHolderID="BvcPopupContentPlaceholder" runat="server">
    <table cellspacing="0" cellpadding="5" width="100%" border="0">
        <tr>
            <td valign="middle" align="center">
                <a class="BVText" href="javascript: self.close()">Close Window</a></td>
        </tr>
        <tr>
            <td valign="top" align="left">
                <uc1:MessageBoxControl ID="msg" runat="server" />
            <br/>
                <asp:Panel ID="pnlReviewDisplay" runat="server">
                    <a id="lnkWrite" href="#Write" runat="server"></a>
                    <h3>
                        <span>
                            <asp:Label ID="lblTitle" runat="server">Reviews</asp:Label></span></h3>
                    <p>
                        <span class="ProductReviewRating">
                            <asp:Label ID="lblRating" runat="server">Average Rating</asp:Label>
                            <asp:Image ID="imgAverageRating" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Stars3.png">
                            </asp:Image></span></p>
                    <asp:DataList ID="dlReviews" runat="server" DataKeyField="Bvin">
                        <ItemTemplate>
                            <div class="ProductReview">
                                <asp:Image ID="imgReviewRating" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Stars3.png" /><br>
                                <span class="ProductReviewDescription">
                                    <asp:Label ID="lblReviewDescription" runat="server">Review...</asp:Label></span>
                                <asp:Panel ID="pnlKarma" runat="server">
                                    <span class="ProductReviewKarma">
                                        <asp:Label ID="lblProductReviewKarma" runat="server">Was this review helpful?</asp:Label>&nbsp;
                                        <asp:ImageButton CommandName="Edit" CausesValidation="False" ID="btnReviewKarmaYes"
                                            ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Yes.png" AlternateText="Yes" runat="server"></asp:ImageButton>&nbsp;
                                        <asp:ImageButton CommandName="Delete" CausesValidation="False" ID="btnReviewKarmaNo"
                                            ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/No.png" AlternateText="No" runat="server"></asp:ImageButton></span>
                                </asp:Panel>
                                <br/>
                                &nbsp;
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:DataList ID="dlAmazonReviews" runat="server" Visible="False">
                        <ItemTemplate>
                            <div class="ProductReview">
                                <asp:Image ID="imgAmazonRating" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/stars3.png" /><br>
                                <span class="ProductReviewDescription">
                                    <asp:Label ID="lblAmazonSummary" runat="server">Summary...</asp:Label><br>
                                    &nbsp;<br>
                                    <asp:Label ID="lblAmazonComment" runat="server">Comment...</asp:Label><br>
                                    &nbsp;<br>
                                </span>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <a name="Write"></a>
                <asp:Panel ID="pnlWriteAReview" runat="server">
                    <h3>
                        <span>
                            <asp:Label ID="lblWriteAReview" runat="server"></asp:Label></span></h3>
                    <table cellspacing="0" cellpadding="3" border="0">
                        <tr>
                            <td class="Formlabel" valign="top" align="right">
                                Rating</td>
                            <td>
                                <asp:DropDownList ID="lstNewReviewRating" runat="server">
                                    <asp:ListItem Value="5" Selected="True">5 Stars</asp:ListItem>
                                    <asp:ListItem Value="4">4 Stars</asp:ListItem>
                                    <asp:ListItem Value="3">3 Stars</asp:ListItem>
                                    <asp:ListItem Value="2">2 Stars</asp:ListItem>
                                    <asp:ListItem Value="1">1 Star</asp:ListItem>
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td class="Formlabel" valign="top" align="right">
                                Your Review</td>
                            <td>
                                <asp:TextBox ID="NewReviewDescription" runat="server" Columns="30" Rows="6" TextMode="MultiLine"
                                    MaxLength="6000" CssClass="FormInput"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="Formlabel">
                                &nbsp;</td>
                            <td>
                                <asp:ImageButton ID="btnSubmitReview" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/buttons/Submit.png"
                                    AlternateText="Submit"></asp:ImageButton></td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td valign="middle" align="center">
                <a class="BVText" href="javascript: self.close()">Close Window</a></td>
        </tr>
    </table>
</asp:Content>

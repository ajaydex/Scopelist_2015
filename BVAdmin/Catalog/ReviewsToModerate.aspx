<%@ Page MasterPageFile="~/BVAdmin/BVAdmin.Master" Language="vb" AutoEventWireup="false"
    Inherits="Products_ReviewsToModerate" CodeFile="ReviewsToModerate.aspx.vb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Product Reviews to Moderate</h1>
    <asp:Label ID="lblNoReviews" runat="server" Text="No Reviews to Moderate" Visible="false"></asp:Label>
    <asp:Panel id="pnlApproveAll" runat="server" style="background:#eee;padding:5px 10px;">
        <p><strong>Approve All Reviews:</strong> <asp:ImageButton ID="btnApproveAll" runat="server" ImageUrl="../images/buttons/approve.png" AlternateText="Yes" imagealign="AbsMiddle" /></p>
    </asp:Panel>
    <asp:DataList DataKeyField="bvin" ID="dlReviews" runat="server" style="width:100%;">
        <ItemTemplate>
            <div id="ReviewInfo">
            	<strong><asp:Label ID="lblReviewDate" runat="server"><%#Eval("ReviewDate")%></asp:Label></strong>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="formlabel">
                            Product:
                        </td>
                        <td>
                            <asp:Label ID="lblProductID" runat="server"><%#Eval("ProductName")%></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            Rating:
                        </td>
                        <td>
                            <asp:Image ID="imgRating" runat="server" ImageUrl="../../images/buttons/Stars5.png"></asp:Image>
                        </td>
                    </tr>
                    <tr>
                        <td class="formlabel">
                            User:</td>
                        <td>
                            <asp:Label ID="lblUserName" CssClass="BVSmallText" runat="server">
                                User name</asp:Label></td>
                    </tr>
                    <tr>
                        <td  class="formlabel">
                            Review:</td>
                        <td>
                            <asp:Label ID="lblReview" runat="server"><%#Eval("Description")%></asp:Label>
                        </td>
                    </tr>
              	</table> 
                <br />
                <br />
                            
                <asp:ImageButton ID="btnApprove" CommandName="Update" runat="server" ImageUrl="../images/buttons/Approve.png" AlternateText="Approve"></asp:ImageButton>
                &nbsp;&nbsp;
                <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="../images/buttons/Edit.png" CommandName="Edit" AlternateText="Edit"></asp:ImageButton>
                &nbsp;&nbsp;
                <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="../images/buttons/Delete.png" CommandName="Delete" AlternateText="Delete"></asp:ImageButton>
                
                <hr /> 
                        	
            </div>
        </ItemTemplate>
    </asp:DataList>
</asp:Content>

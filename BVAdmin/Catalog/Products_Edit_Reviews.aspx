<%@ Page MasterPageFile="~/BVAdmin/BVAdminProduct.Master" Language="vb"
    AutoEventWireup="false" Inherits="products_products_edit_reviews" CodeFile="Products_Edit_Reviews.aspx.vb" %>
	
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="server">
    <h1>Product Reviews - <asp:Label ID="lblProductName" runat="server"></asp:Label></h1>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
      
	<asp:ImageButton ID="btnNew" runat="server" ImageUrl="../images/buttons/new.png"></asp:ImageButton>
	
	<br/><br />
	
	<asp:DataList DataKeyField="Bvin" ID="dlReviews" runat="server" style="width:100%;">
		<ItemTemplate>
			<table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
				<tr>
					<td>
						<strong><asp:Label ID="lblReviewDate" runat="server"><%#Eval("ReviewDate")%></asp:Label></strong>
						<br />
						<asp:Image ID="imgRating" runat="server" ImageUrl="~/BVModules/Themes/BVC5/images/buttons/Stars5.png"></asp:Image>
						<br />
						<asp:Label ID="lblReview" runat="server"><%#Eval("Description")%></asp:Label>
						<br />
						<br />
						<asp:ImageButton ID="btnEdit" runat="server" ImageUrl="../images/buttons/Edit.png"
								CommandName="Edit" AlternateText="Edit"></asp:ImageButton>&nbsp;&nbsp;
							<asp:ImageButton ID="btnDelete" runat="server" ImageUrl="../images/buttons/Delete.png"
								CommandName="Delete" AlternateText="Delete"></asp:ImageButton>
						<hr />
						
					</td>
				</tr>
			</table>
		</ItemTemplate>
	</asp:DataList>
				
           
</asp:Content>

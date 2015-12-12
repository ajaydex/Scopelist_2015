<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" Language="vb" AutoEventWireup="false" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_MyAccount_WishList" CodeFile="MyAccount_WishList.aspx.vb" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ContentPlaceHolderID="MainContentHolder" runat="server">   
    <h2><i class="fa fa-heart"></i> <asp:Label ID="TitleLabel" runat="server">Wish List</asp:Label></h2>
      
    <uc:MessageBox ID="MessageBox1" runat="server" />

    <asp:ValidationSummary ID="ValidationSummary1" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server" ForeColor="White" DisplayMode="BulletList" HeaderText='<a href="#" class="close">&times;</a>' />

    <div class="wishlist">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#CCCCCC" CellPadding="2" GridLines="None" Width="100%" ShowHeader="false" ShowFooter="false" CssClass="cartproductgrid">
            <Columns>

                <asp:TemplateField ItemStyle-CssClass="cartImageColumn">
                    <ItemTemplate>
                        <div class="relative">
                            <div class="cartitemimage">
                                <asp:HyperLink ID="imgProduct" runat="server"></asp:HyperLink>
                            </div> 
                            
                            <asp:ImageButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/x.png" AlternateText="Delete" CssClass="deleteitem" />
                        </div>  
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <div class="cartitemdescription">
                            <asp:HyperLink ID="lnkProduct" runat="server" CssClass="cartitemname" />
                            <div class="smallText">
                                <asp:Literal runat="server" ID="litModifiers"></asp:Literal>
                            </div>
                        </div>
                        <div class="cartitemtotals clearfix">
                            <span class="cartproductprice">
                                <asp:HyperLink id="lnkProductPrice" runat="server"></asp:HyperLink>
                            </span>
                            <div class="cartqty">
                                <anthem:TextBox ID="QuantityTextBox" runat="server" Text='<%# Eval("quantity") %>' Width="50"></anthem:TextBox>
                                <bvc5:BVRequiredFieldValidator ID="QuantityBVRequiredFieldValidator" runat="server" ControlToValidate="QuantityTextBox" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Quantity Must Be Entered" Text="*" Display="Dynamic"></bvc5:BVRequiredFieldValidator> 
                                <bvc5:BVRegularExpressionValidator ID="QuantityBVRegularExpressionValidator" runat="server" ControlToValidate="QuantityTextBox" ValidationExpression="\d{1,5}" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Quantity Must Be Numeric" Display="Dynamic"></bvc5:BVRegularExpressionValidator>
                            </div>
                        </div>

                        <!--<asp:ImageButton ID="UpdateButton" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/Update.png" CommandName="Update" />-->
                        <br />
                        <asp:ImageButton ID="AddToCartImageButton" runat="server" Visible="true" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/AddToCart.png" CommandName="AddToCart" CommandArgument='<%# Eval("bvin") %>' />

                    </ItemTemplate>                
                </asp:TemplateField> 
            </Columns>
            
        </asp:GridView>

    </div>
</asp:Content>

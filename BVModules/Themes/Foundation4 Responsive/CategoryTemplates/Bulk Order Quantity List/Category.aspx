<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="Category.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_CategoryTemplates_Bulk_Order_Quantity_List_Category" Title="Category" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="~/BVModules/Controls/CategorySortOrder.ascx" TagName="CategorySortOrder" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ContentColumnControl.ascx" TagName="ContentColumnControl" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">

    <h1><asp:Label ID="lblTitle" runat="Server"></asp:Label></h1>
    
    <div class="row">
        <div class="large-10 columns push-2">
            <uc:ContentColumnControl ID="PreContentColumn" runat="server" />
            
            <uc:MessageBox ID="ucMessageBox" runat="server" />

            <div class="row">
                <div class="large-5 columns">
                    <div id="categorybanner">
                        <asp:Image runat="server" ID="BannerImage" />
                        <div id="categorydescription">
                            <asp:Literal ID="DescriptionLiteral" runat="server"></asp:Literal>
                        </div>
                    </div>
                </div>

                <div class="large-7 columns">
                    <div class="row gridheader">
                        <div class="large-12 columns">
                            <uc:CategorySortOrder ID="CategorySortOrder1" runat="server" />
                        </div>
                    </div>
                    <div id="categorybulkorderlisttemplaterecords">
                        <asp:GridView ID="DataList1" CellSpacing="1" AutoGenerateColumns="False" runat="server" DataKeyNames="bvin" GridLines="none">
                            <Columns>
                                <asp:TemplateField ItemStyle-CssClass="quantitycolumn">
                                    <HeaderStyle CssClass="rowheader" />
                                    <HeaderTemplate>
                                        Qty.
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <div class="qtycell">
                                            <asp:TextBox ID="QuantityTextBox" CssClass="quantityfield" runat="server" Text="0"
                                                Columns="1"></asp:TextBox>
                                            <bvc5:BVRequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" ErrorMessage="Quantity Is Required."
                                                ControlToValidate="QuantityTextBox" Display="Dynamic" ForeColor=" " CssClass="errormessage"></bvc5:BVRequiredFieldValidator>
                                            <bvc5:BVRegularExpressionValidator ID="QuantityRegularExpressionValidator" runat="server"
                                                ErrorMessage="Quantity Must Be Numeric." ControlToValidate="QuantityTextBox"
                                                ValidationExpression="\d{1,5}" Display="Dynamic" ForeColor=" " CssClass="errormessage"></bvc5:BVRegularExpressionValidator>
                                            <asp:ImageButton ID="DetailsImageButton" runat="server" Visible="false" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderStyle CssClass="rowheader" />
                                    <HeaderTemplate>
                                        Product Details
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <div class="record">
                                            <asp:Literal runat="server" ID="litRecord" EnableViewState="false"></asp:Literal>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <AlternatingRowStyle CssClass="alt" />
                        </asp:GridView>


                        <div class="addtocartcontrols">
                            <anthem:ImageButton ID="btnAddToCart" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/AddToCart.png"  AlternateText="Add checked items to shopping cart." EnableCallBack="false" />
                            <div>
                                <anthem:Label ID="ItemAddedToCartLabel" runat="server" Visible="False" CssClass="AddedToCartMessage"></anthem:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <uc:ContentColumnControl ID="PostContentColumn" runat="server" />
        </div>
        <div class="large-2 columns pull-10 hideforlowres">
        	<uc:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="System Category Page" />
        </div>
    </div>

         
</asp:Content>

<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="Category.aspx.vb" Inherits="BVModules_CategoryTemplates_Bulk_Order_Quantity_List_Category"
    Title="Category" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../../Controls/CategorySortOrder.ascx" TagName="CategorySortOrder"
    TagPrefix="uc4" %>
<%@ Register Src="../../Controls/CategoryBreadCrumbTrail.ascx" TagName="CategoryBreadCrumbTrail"
    TagPrefix="uc2" %>
<%@ Register Src="../../Controls/ContentColumnControl.ascx" TagName="ContentColumnControl"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <uc2:CategoryBreadCrumbTrail ID="CategoryBreadCrumbTrail1" IncludeHomepage="True" IncludeProductName="True" runat="server" />
    <div id="categoryleft">
        <uc1:ContentColumnControl ID="ContentColumnControl1" runat="server" ColumnName="System Category Page" />
    </div>
    <div id="categorymain">
        <uc:MessageBox ID="ucMessageBox" runat="server" />
		
        <h1><asp:Label ID="lblTitle" runat="Server"></asp:Label></h1>
        <uc1:ContentColumnControl ID="PreContentColumn" runat="server" />
        <div id="categorybanner">
            <asp:Image runat="server" ID="BannerImage" /></div>
        <div id="categorydescription">
            <asp:Literal ID="DescriptionLiteral" runat="server"></asp:Literal>
        </div>
        <div id="categorybulkqtylisttemplate">
            <uc4:CategorySortOrder ID="CategorySortOrder1" runat="server" />
            <div id="categorybulkqtylisttemplaterecords">
                <asp:GridView ID="DataList1" CellSpacing="1" AutoGenerateColumns="False" runat="server" DataKeyNames="bvin"
                    GridLines="none">
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
                    <anthem:ImageButton ID="btnAddToCart" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/AddToCart.png"
                        AlternateText="Add checked items to shopping cart." EnableCallBack="false" />
                    <div>
                        <anthem:Label ID="ItemAddedToCartLabel" runat="server" Visible="False" CssClass="AddedToCartMessage"></anthem:Label>                    
                    </div>
                </div>
            </div>
        </div>
        <uc1:ContentColumnControl ID="PostContentColumn" runat="server" />
    </div>
</asp:Content>

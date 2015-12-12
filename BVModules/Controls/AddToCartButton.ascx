<%@ Control Language="VB" AutoEventWireup="false" CodeFile="AddToCartButton.ascx.vb"
    Inherits="BVModules_Controls_AddToCartButton" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="MessageBox.ascx" TagName="MessageBox" TagPrefix="uc2" %>
<anthem:ImageButton ID="btnAdd" runat="server" AlternateText="Add to Cart" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/AddToCart.png"
    EnabledDuringCallBack="False" EnableCallBack="false" class="float-r customclass"
    ToolTip="Add To Cart"></anthem:ImageButton>
<asp:ImageButton ID="btnSaveChanges" runat="server" AlternateText="Add to Cart" ImageUrl="~/BVModules/Themes/Bvc5/images/Buttons/SaveChanges.png"
    Visible="False" class="float-r saveChanges" ToolTip="Save changes" />
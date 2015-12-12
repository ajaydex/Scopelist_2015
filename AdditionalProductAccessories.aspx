<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="AdditionalProductAccessories.aspx.vb" Inherits="AdditionalProductInfo" title="Additional Product Information" %>

<%@ Register Src="BVModules/Controls/CrossSellDisplay.ascx" TagName="CrossSellDisplay"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
    <table>
        <tr>
            <td>
                <uc1:CrossSellDisplay ID="CrossSellDisplay" runat="server" DisplayAddToCartButton="false" DisplaySelectedCheckBox="true"
                    DisplayDescriptions="true" DisplayMode="Wide" RepeatColumns="1" RepeatDirection="Vertical"
                    RepeatLayout="Table" RemainOnPageAfterAddToCart="true" DisplayQuantity="true" />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td><asp:ImageButton ID="ContinueToCartImageButton" AlternateText="Continue To Cart" ImageUrl="~/BVModules/Themes/BVC5/Images/Buttons/NoThankYou.png" runat="server" />                
            </td>
        </tr>
    </table>
    
    
</asp:Content>


<%@ Page MasterPageFile="~/BVModules/Themes/Bvc5/Popup.Master" Language="vb" AutoEventWireup="false"
    Inherits="BVModules_Themes_Foundation4_Responsive_Pages_ZoomImage" CodeFile="ZoomImage.aspx.vb" %>

<asp:Content ContentPlaceHolderID="BvcPopupContentPlaceholder" runat="server">
<div id="AdditionalImageWrapper">
    <a class="BVText" href="javascript: self.close()">Close Window</a>
    <div id="AdditionalImageViewer">
        <span id="LargeImage"><asp:Image ID="imgMain" runat="server" /></span><br />
        <span id="Caption"><asp:Label ID="defaultCaption" runat="server" /></span>        
    </div>
    <div id="AdditionalImageMenu">                    
    <asp:DataList ID="lstImages" runat="server" DataKeyField="bvin" GridLines="none" RepeatDirection="Horizontal" RepeatLayout="Flow" RepeatColumns="99" ShowFooter="false" ShowHeader="false">
    <ItemTemplate>
        <span class="ImageLink"><asp:ImageButton ID="btnLink" runat="server" CommandName="Edit" /></span>
    </ItemTemplate>
    </asp:DataList>
    </div>
    <a class="BVText" href="javascript: self.close()">Close Window</a>
</div>           
<asp:HiddenField ID="ProductIdField" runat="server" />
</asp:Content>

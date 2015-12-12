<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="UpsOnlineTools.aspx.vb" Inherits="BVAdmin_Orders_UpsOnlineTools" title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">    
    <uc1:MessageBox ID="MessageBox1" runat="server" />
    <h1>UPS<sup>&reg;</sup> Online Tools</h1>
    <div>
    	<asp:hyperlink runat="server" ID="lnkShip" NavigateUrl="UPSOnlineTools_Ship.aspx" ImageUrl="~/BVAdmin/Images/buttons/ShipPackages.png" Text="Ship Packages"  />
        &nbsp;
        <asp:hyperlink runat="server" ID="lnkVoid" NavigateUrl="UPSOnlineTools_Void.aspx" ImageUrl="~/BVAdmin/Images/buttons/VoidAShipment.png" Text="Void A Shipment"  />
        &nbsp;
        <asp:hyperlink runat="server" ID="lnkRecover" NavigateUrl="UPSOnlineTools_RecoverLabel.aspx" ImageUrl="~/BVAdmin/Images/buttons/RecoverALabel.png" Text="Recover A Label"  />
    </div>
</asp:Content>


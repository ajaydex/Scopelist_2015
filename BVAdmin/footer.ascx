<%@ Control Language="VB" AutoEventWireup="false" CodeFile="footer.ascx.vb" Inherits="BVAdmin_footer" %>

<div style="float: right;">
    <asp:Image ID="imgPci" runat="server" EnableViewState="false" ImageUrl="~/images/system/pci.png" AlternateText="PCI / PA-DSS Certified" />
</div>
<strong>
    <asp:Label ID="lblVersion" runat="server" Text="BVC DDDD"></asp:Label>
</strong>
<div id="copyright">
    <asp:Label ID="lblCopyright" runat="server" />
</div>

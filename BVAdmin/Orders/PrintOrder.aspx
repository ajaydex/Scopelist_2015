<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminPopup.master" AutoEventWireup="false" CodeFile="PrintOrder.aspx.vb" Inherits="BVAdmin_Orders_PrintOrder" Title="Print Order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BvcAdminPopupConent" runat="Server">
	<div class="f-row">
   		<div class="twelve columns">
        	<div class="printhidden">
                <h1>Print Order</h1>
                <p>Template: <asp:DropDownList ID="TemplateField" runat="Server"></asp:DropDownList> <asp:ImageButton ID="btnGenerate" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Go.png" /></p>
                <hr />
            </div>
            
           <div class="printwindow">
                <asp:DataList ID="DataList1" runat="server" Width="100%" style="display:block;" RepeatLayout="Flow">
                    <ItemTemplate>
                        <asp:literal ID="litTemplate" runat="server"></asp:literal>
                    </ItemTemplate>
                    <SeparatorTemplate>
                        <div style="page-break-after: always;">&nbsp;</div>
                    </SeparatorTemplate>
                </asp:DataList>
            </div>
            
            <div class="printhidden">
                <hr />
                <asp:ImageButton ID="btnContinue" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Close.png" />
                &nbsp;
                <asp:Image runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Print.png" AlternateText="Print" onclick="javascript:doPrint();" />
            </div>
    	</div>
    </div>
</asp:Content>

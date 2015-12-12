<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminReports.master" AutoEventWireup="false" CodeFile="View.aspx.vb" Inherits="BVAdmin_Reports_Affiliates" title="Affiliate Sales" %>
<%@ Register Src="~/BVAdmin/Controls/DateRangePicker.ascx" TagName="DateRangePicker" TagPrefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script type="text/javascript">				
		function toggle(id)
		{			
				var carrotName = id+'Carrot';
				var detailsDiv = document.getElementById(id);
				
				if (detailsDiv){				    
				    if (detailsDiv.currentStyle){				        
				        if (detailsDiv.currentStyle.display != "none"){
				            detailsDiv.style.display = "none";
				        } else {				            
                            detailsDiv.style.display = "block";
				        }
				    } else {
                    	if (document.defaultView.getComputedStyle(detailsDiv, '').getPropertyValue("display") != "none"){
                            detailsDiv.style.display = "none";                    	
                    	} else {
                    	    detailsDiv.style.display = "block";
                    	}			
				    }
				}				
		}		
    </script>
    <h2>Sales By Affiliate</h2>
    
    <table width="700" border="0" cellspacing="0" cellpadding="5">
        <tr>
            <td align="left" valign="middle" class="FormLabel">
                Affiliate: <br /><asp:DropDownList ID="AffiliatesDropDownList" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="left" valign="middle" class="FormLabel">
                Timespan: <uc2:DateRangePicker ID="DateRangeField" runat="server" RangeType="ThisMonth" /> <br /><asp:ImageButton ID="ViewImageButton" AlternateText="View" ImageUrl="~/BVAdmin/Images/Buttons/View.png" runat="server" />
            </td>
        </tr>
    </table>
    
    <br />
    
    <asp:DataList ID="AffiliatesDataList" runat="server" ExtractTemplateRows="true" Style="width: 100%;">
        <ItemStyle CssClass="row" />
        <HeaderStyle CssClass="rowheader" />
        <AlternatingItemStyle CssClass="alternaterow" />
        
        <SeparatorTemplate>
            <asp:Table runat="server">
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="4">
                        <div style="border-top: solid 1px black; width: 100%;"></div>                        
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </SeparatorTemplate>
        <HeaderTemplate>
            <asp:Table runat="server">
                <asp:TableHeaderRow runat="server" CssClass="rowheader">
                    <asp:TableHeaderCell>Referrals</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Sales</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Conversion</asp:TableHeaderCell>
                    <asp:TableHeaderCell>Commission</asp:TableHeaderCell>
                </asp:TableHeaderRow>
            </asp:Table>
        </HeaderTemplate>
        <ItemTemplate>
            <asp:Table ID="AffiliateTable" runat="server">
                <asp:TableRow>
                   <asp:TableCell ColumnSpan="4"><%# Eval("DisplayName") %></asp:TableCell>
                </asp:TableRow>                
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Label ID="ReferralsLabel" runat="server" Text="Label"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="SalesLabel" runat="server" Text="Label"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="ConversionLabel" runat="server" Text="Label"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="CommissionLabel" runat="server" Text="Label"></asp:Label>                        
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="4">
                        
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="4">
                        <asp:Literal id="openDiv" Runat="server"></asp:Literal>
                        <div id="Details" runat="server">
                            <asp:GridView ID="OrdersGridView" runat="server" AutoGenerateColumns="false" style="width: 100%; margin-left: 20px;">
                                <Columns>
                                    <asp:BoundField HeaderText="Order #" DataField="OrderNumber" />
                                    <asp:BoundField HeaderText="User"  DataField="UserID" />
                                    <asp:BoundField HeaderText="SubTotal" DataField="SubTotal" HtmlEncode="false" DataFormatString="{0:c}" />
                                    <asp:BoundField HeaderText="Time" DataField="TimeOfOrder" />
                                </Columns>
                                <EmptyDataTemplate>
                                    There were no orders found for this affiliate
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                        <asp:Literal id="closeDiv" Runat="server"></asp:Literal><br>
                    </asp:TableCell>
                </asp:TableRow>                    
            </asp:Table>                
        </ItemTemplate>
    </asp:DataList>   
</asp:Content>
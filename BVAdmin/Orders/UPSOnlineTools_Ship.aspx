<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="UPSOnlineTools_Ship.aspx.vb" Inherits="BVAdmin_Orders_UPSOnlineTools_Ship" Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">    
    <h1>Ship By UPS<sup>&reg;</sup></h1>
    <uc1:MessageBox ID="msg" runat="server" />
    
    <asp:ImageButton ID="btnContinue" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/OrderManager.png" AlternateText="GoBack"></asp:ImageButton>
	<br />
    <br />
    <div class="f-row">
    	<div class="six columns">
        	<table cellspacing="0" cellpadding="0" class="upstoggle">
                <tr>
                    <td class="upsheader" onclick="TogglePanel('FromPanel','FromPanelToggle');">From</td>
                    <td class="upsheader text-right" onclick="TogglePanel('FromPanel','FromPanelToggle');" >
                        <img  alt="Toggle Panel" id="FromPanelToggle" src="../images/CarrotClosed.gif" />
                    </td>
                </tr>
            </table>
            <div id="FromPanel" style="display: none" class="wrap">
                <table class="upssection" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td class="upssection1">Company</td>
                        <td class="upssection1">
                            <asp:TextBox ID="FromCompanyField" runat="server" Columns="40"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Name</td>
                        <td class="upssection1" >
                            <asp:TextBox ID="FromNameField" runat="server" Columns="15"></asp:TextBox>&nbsp;
                            Phone 
                            <asp:TextBox ID="FromPhoneField" runat="server" Columns="12"></asp:TextBox>
                       	</td>
                    </tr>
                    <tr>
                        <td class="upssection1">Address</td>
                        <td class="upssection1" >
                            <asp:TextBox ID="FromAddress1Field" runat="server" Columns="40"></asp:TextBox>
                       	</td>
                    </tr>
                    <tr>
                        <td class="upssection1">&nbsp;</td>
                        <td class="upssection1">
                            <asp:TextBox ID="FromAddress2Field" runat="server" Columns="40"></asp:TextBox>
                       	</td>
                    </tr>
                    <tr>
                        <td class="upssection1">City</td>
                        <td class="upssection1">
                            <asp:TextBox ID="FromCityField" runat="server" Columns="10"></asp:TextBox>&nbsp;state&nbsp;
                            <asp:TextBox ID="FromStateField" runat="server" Columns="2"></asp:TextBox>&nbsp;zip
                            <asp:TextBox ID="FromPostalCodeField" runat="server" Columns="7"></asp:TextBox>
                       	</td>
                    </tr>
                    <tr>
                        <td class="upssection1">
                            Country</td>
                        <td class="upssection1">
                            <asp:DropDownList ID="FromCountryField" runat="server">
                                <asp:ListItem Value="US">United States</asp:ListItem>
                                <asp:ListItem Value="CA">Canada</asp:ListItem>
                            </asp:DropDownList>
                       	</td>
                    </tr>
                </table>
            </div>
                    
            <table class="upstoggle" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td class="upsheader">To</td>
                </tr>
            </table>
            <div class="wrap">
                <table class="upssection" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="upssection1">Company</td>
                        <td class="upssection1">
                            <asp:TextBox ID="ToCompanyField" runat="server" Columns="40"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Name</td>
                        <td class="upssection1">
                            <asp:TextBox ID="ToNameField" runat="server" Columns="15"></asp:TextBox>&nbsp;Phone
                            <asp:TextBox ID="ToPhoneField" runat="server" Columns="12"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Address</td>
                        <td class="upssection1">
                            <asp:TextBox ID="ToAddress1Field" runat="server" Columns="40"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">&nbsp;
                            </td>
                        <td class="upssection1">
                            <asp:TextBox ID="ToAddress2Field" runat="server" Columns="40"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">City</td>
                        <td class="upssection1">
                            <asp:TextBox ID="ToCityField" runat="server" Columns="10"></asp:TextBox>&nbsp;state&nbsp;
                            <asp:TextBox ID="ToStateField" runat="server" Columns="2"></asp:TextBox>&nbsp;zip
                            <asp:TextBox ID="ToPostalCodeField" runat="server" Columns="7"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Country</td>
                        <td class="upssection1">
                            <asp:DropDownList ID="ToCountryField" runat="server">
                                <asp:ListItem Value="US">United States</asp:ListItem>
                                <asp:ListItem Value="CA">Canada</asp:ListItem>
                            </asp:DropDownList>    
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Residential</td>
                        <td class="upssection1">
                            <asp:CheckBox ID="chkResidential" runat="server"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1"></td>
                        <td class="upssection1">
                            <asp:CheckBox ID="chkAddressVerification" runat="server" Text="Address Verification" CssClass="BVTextSmall"></asp:CheckBox>
                        </td>
                    </tr>
                </table>
            </div>
                        
            <table cellspacing="0" class="upstoggle" cellpadding="0" border="0">
                <tr>
                    <td class="upsheader" onclick="TogglePanel('QVN1Panel','QVN1Toggel');">Quantum View&trade; Notification</td>
                    <td class="upsheader text-right" onclick="TogglePanel('QVN1Panel','QVN1Toggel');" >
                        <img id="QVN1Toggel" src="../images/CarrotClosed.gif" alt="Toggle Panel" />
                    </td>
                </tr>
            </table>
            <div id="QVN1Panel" style="display: none" class="wrap">
                <table class="upssection" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td class="upssection1">&nbsp;</td>
                        <td class="upssection1">
                            <asp:CheckBox ID="chkNotification" runat="server" Text="Use Notification" CssClass="BVTextSmall"></asp:CheckBox>
                       	</td>
                    </tr>
                    <tr>
                        <td class="upssection1">To Email</td>
                        <td class="upssection1">
                            <asp:TextBox ID="NotificationEmailField" runat="server" Columns="40"></asp:TextBox>
                       	</td>
                    </tr>
                    <tr>
                        <td class="upssection1">From</td>
                        <td class="upssection1">
                            <asp:TextBox ID="NotificationFromField" runat="server" Columns="20"></asp:TextBox>&nbsp;(name, not email)
                       	</td>
                    </tr>
                    <tr>
                        <td class="upssection1">Type</td>
                        <td class="upssection1">
                            <asp:DropDownList ID="NotificationTypeField" runat="server">
                                <asp:ListItem Value="6">QVN Ship Notification</asp:ListItem>
                                <asp:ListItem Value="7">QVN Exception Notification</asp:ListItem>
                                <asp:ListItem Value="8">QVN Deliery Notification</asp:ListItem>
                            </asp:DropDownList>
                       	</td>
                    </tr>
                    <tr>
                        <td class="upssection1">Subject</td>
                        <td class="upssection1">
                            <asp:DropDownList ID="NotificationSubjectField" runat="server">
                                <asp:ListItem Value="3">Reference Field 1</asp:ListItem>
                                <asp:ListItem Value="4">Reference Field 2</asp:ListItem>
                            </asp:DropDownList>
                       	</td>
                    </tr>
                    <tr>
                        <td class="upssection1">Message</td>
                        <td class="upssection1">
                            <asp:TextBox ID="NotificationMessage" runat="server" Columns="30" Rows="3" TextMode="MultiLine"></asp:TextBox>
                       	</td>
                    </tr>
                </table>
            </div>
                        
            <table class="upstoggle" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td class="upsheader" onclick="TogglePanel('PaymentPanel','PaymentPanelToggle');">Payment</td>
                    <td class="upsheader text-right" onclick="TogglePanel('PaymentPanel','PaymentPanelToggle');" >
                        <img alt="Toggle Panel" id="PaymentPanelToggle" src="../images/CarrotClosed.gif" />
                    </td>
                </tr>
            </table>
            <div id="PaymentPanel" style="display: none" class="wrap">
                <table class="upssection" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td class="upssection1">Bill To</td>
                        <td class="upssection1" >
                            <asp:DropDownList ID="BillToField" runat="server">
                                <asp:ListItem Value="1">Shipper's UPS Account</asp:ListItem>
                                <asp:ListItem Value="2">Credit Card</asp:ListItem>
                                <asp:ListItem Value="4">Receiver's UPS Account</asp:ListItem>
                                <asp:ListItem Value="3">Third Party UPS Account</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Account Number</td>
                        <td class="upssection1" >
                            <asp:TextBox ID="BillToAccountNumberField" runat="server" Columns="40"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1"  width="70">Country</td>
                        <td class="upssection1" >
                            <asp:DropDownList ID="BillToCountryField" runat="server">
                                <asp:ListItem Value="US">United States</asp:ListItem>
                                <asp:ListItem Value="CA">Canada</asp:ListItem>
                            </asp:DropDownList>&nbsp;Postal Code
                            <asp:TextBox ID="BillToPostalCodeField" runat="server" Columns="9"></asp:TextBox>
                        </td>
                    </tr>
                    <tr id="trWarning" runat="server">
                        <td class="errormessage" align="center" colspan="2">WARNING: This page is not in SSL mode. Credit card information could be passed unencrypted.</td>
                    </tr>
                    <tr>
                        <td class="upssection1">CC Num.</td>
                        <td class="upssection1" >
                            <asp:TextBox ID="CCNumberField" runat="server" Columns="16"></asp:TextBox>&nbsp;
                            <asp:DropDownList ID="CCTypeField" runat="server">
                                <asp:ListItem Value="1">Amex</asp:ListItem>
                                <asp:ListItem Value="4">MasterCard</asp:ListItem>
                                <asp:ListItem Value="6">Visa</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Exp. Date</td>
                        <td class="upssection1" >
                            <asp:DropDownList ID="CCExpMonthField" runat="server">
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                                <asp:ListItem Value="4">4</asp:ListItem>
                                <asp:ListItem Value="5">5</asp:ListItem>
                                <asp:ListItem Value="6">6</asp:ListItem>
                                <asp:ListItem Value="7">7</asp:ListItem>
                                <asp:ListItem Value="8">8</asp:ListItem>
                                <asp:ListItem Value="9">9</asp:ListItem>
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="11">11</asp:ListItem>
                                <asp:ListItem Value="12">12</asp:ListItem>
                            </asp:DropDownList>&nbsp;/&nbsp;
                            <asp:DropDownList ID="CCExpYearField" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        
        
        <div class="six columns">
			<table class="upstoggle" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td class="upsheader">Service</td>
                </tr>
          	</table>
            <div class="wrap">
                <table class="upssection" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td class="upssection1" >
                            <asp:DropDownList ID="ServiceField" runat="server">
                                <asp:ListItem Value="3">UPS Ground</asp:ListItem>
                                <asp:ListItem Value="1">UPS Next Day Air&#174;</asp:ListItem>
                                <asp:ListItem Value="13">UPS Next Day Air Saver&#174;</asp:ListItem>
                                <asp:ListItem Value="14">UPS Next Day Air&#174; Early A.M.&#174;</asp:ListItem>
                                <asp:ListItem Value="2">UPS 2nd Day Air&#174;</asp:ListItem>
                                <asp:ListItem Value="59">UPS 2nd Day Air A.M.&#174;</asp:ListItem>
                                <asp:ListItem Value="12">UPS 3 Day Select (sm)</asp:ListItem>
                                <asp:ListItem Value="65">UPS Express Saver (sm)</asp:ListItem>
                                <asp:ListItem Value="7">UPS Worldwide Express (sm)</asp:ListItem>
                                <asp:ListItem Value="54">UPS Worldwide Express Plus (sm)</asp:ListItem>
                                <asp:ListItem Value="8">UPS Worldwide Expedited (sm)</asp:ListItem>
                                <asp:ListItem Value="11">UPS Standard</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </div>
            
            <table class="upstoggle" cellspacing="0" cellpadding="0" border="0">
                <tr>
                	<td class="upsheader">Package</td>
                </tr>
           	</table>
            <div class="wrap">
                <table class="upssection" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td class="upssection1" >Package</td>
                        <td class="upssection1" >
                            <asp:DropDownList ID="PackageTypeField" runat="server">
                                <asp:ListItem Value="2">Customer Supplied</asp:ListItem>
                                <asp:ListItem Value="21">UPS Express Box</asp:ListItem>
                                <asp:ListItem Value="1">UPS Letter</asp:ListItem>
                                <asp:ListItem Value="3">UPS Tube</asp:ListItem>
                                <asp:ListItem Value="4">UPS Pak</asp:ListItem>
                                <asp:ListItem Value="25">UPS 10Kg Box</asp:ListItem>
                                <asp:ListItem Value="24">UPS 25Kg Box</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Weight</td>
                        <td class="upssection1">
                            <asp:TextBox ID="WeightField" runat="server" Columns="4"></asp:TextBox><asp:DropDownList
                                ID="WeightUnitsField" runat="server">
                                <asp:ListItem Value="1">Pounds</asp:ListItem>
                                <asp:ListItem Value="2">Kilograms</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1" align="center" colspan="2">
                            Package Size (only for customer supplied type)<br />
                            <asp:TextBox ID="LengthField" runat="server" Columns="2"></asp:TextBox>&nbsp;X &nbsp;
                            <asp:TextBox ID="WidthField" runat="server" Columns="2"></asp:TextBox>&nbsp;X &nbsp;
                            <asp:TextBox ID="HeightField" runat="server" Columns="2"></asp:TextBox>&nbsp;
                            <asp:DropDownList ID="DimensionalUnitsField" runat="server">
                                <asp:ListItem Value="1">In.</asp:ListItem>
                                <asp:ListItem Value="2">Cm.</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Reference 1</td>
                        <td class="upssection1">
                            <asp:TextBox ID="Reference1Field" runat="server" Columns="20"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Reference 2</td>
                        <td class="upssection1">
                            <asp:TextBox ID="Reference2Field" runat="server" Columns="20"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            
            
            
            <table class="upstoggle" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td class="upsheader" onclick="TogglePanel('AdvancedPanel','AdvancedPanelToggle');">Advanced</td>
                    <td class="upsheader text-right" onclick="TogglePanel('AdvancedPanel','AdvancedPanelToggle');" >
                        <img id="AdvancedPanelToggle" src="../images/CarrotClosed.gif" alt="" />
                    </td>
                </tr>
            </table>
            <div id="AdvancedPanel" style="display: none" class="wrap">
                <table class="upssection" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td class="upssection1">Declared Value</td>
                        <td class="upssection1">
                            <asp:TextBox ID="DeclaredValueField" runat="server" Columns="10"></asp:TextBox>
                            <asp:DropDownList ID="DeclaredValueCurrencyField" runat="server">
                                <asp:ListItem Value="USD">USD</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Description</td>
                        <td class="upssection1">
                            <asp:TextBox ID="DescriptionField" runat="server" Columns="20"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Delivery Confirmation</td>
                        <td class="upssection1">
                            <asp:DropDownList ID="DeliveryConfirmationField" runat="server">
                                <asp:ListItem Value="0">No Delivery Confirmation</asp:ListItem>
                                <asp:ListItem Value="1">No Signature Required</asp:ListItem>
                                <asp:ListItem Value="2">Signature Required</asp:ListItem>
                                <asp:ListItem Value="3">Adult Signature Required</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">COD</td>
                        <td class="upssection1">
                            <asp:TextBox ID="CODAmountField" runat="server" Columns="10"></asp:TextBox>
                            <asp:DropDownList ID="CODCurrencyField" runat="server">
                                <asp:ListItem Value="USD">USD</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1" colspan="2">
                            <asp:CheckBox ID="chkAdditionalHandling" runat="server" Text="Additional Handling Required" CssClass="BVSmallText"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1" colspan="2">
                            <asp:CheckBox ID="chkSaturdayDelivery" runat="server" Text="Saturday Delivery" CssClass="BVSmallText"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1" colspan="2">
                            <asp:CheckBox ID="chkVerbalConfirmation" runat="server" Text="Verbal Confirmation" CssClass="BVSmallText"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Name</td>
                        <td class="upssection1">
                            <asp:TextBox ID="VerbalNameField" runat="server" Columns="20"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="upssection1">Phone</td>
                        <td class="upssection1">
                            <asp:TextBox ID="VerbalPhoneField" runat="server" Columns="20"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            
            <asp:Panel ID="pnlRates" runat="server" Visible="False">
                <table class="upstoggle" cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td class="upsheader">Courtesy Rate</td>
                    </tr>
                </table>
                <div class="wrap">
                    <table class="upssection" cellspacing="0" cellpadding="0" border="0">
                        <tr>
                            <td class="upssection1">Shipping</td>
                            <td class="upssection1" >
                                <asp:Label ID="lblShipCharges" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="upssection1">Service Options</td>
                            <td class="upssection1">
                                <asp:Label ID="lblServiceOptions" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="upssection1"><strong>Total Cost</strong></td>
                            <td class="upssection1">
                                <asp:Label ID="lblRate" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="upssection1">
                                <asp:ImageButton ID="Imagebutton1" runat="server" ImageUrl="~/BVAdmin/images/buttons/cancel.png"></asp:ImageButton>
                            </td>
                            <td class="upssection1">
                                <asp:ImageButton ID="Imagebutton2" runat="server" ImageUrl="~/BVAdmin/images/buttons/AcceptAndShip.png"></asp:ImageButton>
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            
            <asp:Panel ID="pnlPrint" Visible="False" runat="server">
                <table cellspacing="0" cellpadding="0" border="0">
                    <tr>
                        <td align="center">
                            <asp:HyperLink ID="lnkLabel" runat="server" ImageUrl="~/BVAdmin/images/buttons/ViewPrintLabel.png" Visible="True" Target="_blank">View/Print Label</asp:HyperLink>
                       	</td>
                    </tr>
                </table>
            </asp:Panel>
            
            <asp:Panel ID="pnlGetRates" runat="server" Visible="True">
            	<br />
                <asp:ImageButton ID="btnCanel" runat="server" ImageUrl="~/BVAdmin/images/buttons/cancel.png"></asp:ImageButton>
                &nbsp;
                <asp:ImageButton ID="btnShip" runat="server" ImageUrl="~/BVAdmin/images/buttons/GetShippingRates.png"></asp:ImageButton>
            </asp:Panel>
        </div>
    </div>
    
      
                    
               

    <asp:HiddenField ID="ReturnUrlField" runat="Server" />
    <asp:HiddenField ID="PackageIdField" runat="server" />
</asp:Content>

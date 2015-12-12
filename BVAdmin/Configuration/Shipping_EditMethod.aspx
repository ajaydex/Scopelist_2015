<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="Shipping_EditMethod.aspx.vb" Inherits="BVAdmin_Configuration_Shipping_EditMethod" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">    
    <asp:PlaceHolder ID="phEditor" runat="server"></asp:PlaceHolder>
   
   	<hr />
   
    <h2>Ship To Countries</h2>
    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
        <tr>
            <td style="width:40%;">Available In&hellip;</td>
            <td style="20%:">&nbsp;</td>
            <td style="width:40%;">
                NOT Available In&hellip;
            </td>
        </tr>
        <tr>
            <td align="left" valign="top">
                <asp:ListBox SelectionMode="Multiple" Width="250" Rows="8" ID="inCountries" runat="server" />
            </td>
            <td align="center" valign="middle">
                <asp:ImageButton ID="btnAddCountry" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/left.png" />
                <br />
                &nbsp;
                <br />
                &nbsp;<br />
                <asp:ImageButton ID="btnDelCountry" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Right.png" />
            </td>
            <td align="left" valign="top">
                <asp:ListBox SelectionMode="Multiple" Width="250" Rows="8" ID="inNOTCountries" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="left" valign="top" class="smalltext">
                Use CRTL or SHIFT to<br />
                pick more than 1 item
            </td>
            <td align="center" valign="middle" class="smalltext">&nbsp;
                </td>
            <td align="left" valign="top" class="smalltext">
                Use CRTL or SHIFT to<br />
                pick more than 1 item
            </td>
        </tr>
    </table>
    
    <hr />
    
    <h2>Ship To Regions</h2>
    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
        <tr>
            <td style="width:40%;">Available In&hellip;</td>
            <td style="20%:">&nbsp;</td>
            <td style="width:40%;">
                NOT Available In&hellip;
            </td>
        </tr>
        <tr>
            <td align="left" valign="top">
                <asp:ListBox SelectionMode="Multiple" Width="250" Rows="8" ID="inRegions" runat="server" />
            </td>
            
            <td align="center" valign="middle">
                <asp:ImageButton ID="btnAddRegion" runat="server" ImageUrl="~/BVAdmin/images/buttons/Left.png" />
                <br />
                <br />
                <asp:ImageButton ID="btnDelRegion" runat="server" ImageUrl="~/BVAdmin/images/buttons/Right.png" />
            </td>
            
            <td align="left" valign="top">
                <asp:ListBox SelectionMode="Multiple" Width="250" Rows="8" ID="inNOTRegions" runat="server" />
            </td>
        </tr>
        <tr>
            <td align="left" valign="top" class="smalltext">
                Use CRTL or SHIFT to<br />
                pick more than 1 item
            </td>
            <td align="center" valign="middle" class="smalltext">&nbsp;
                </td>
            <td align="left" valign="top" class="smalltext">
                Use CRTL or SHIFT to<br />
                pick more than 1 item
            </td>
        </tr>
    </table>

    <asp:HiddenField ID="BlockIDField" runat="server" />
</asp:Content>

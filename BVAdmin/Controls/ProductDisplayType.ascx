<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ProductDisplayType.ascx.vb" Inherits="BVAdmin_Controls_ProductDisplayType" %>

<asp:RadioButtonList ID="rblProductDisplayMode" ToolTip="Specifies how the products will be displayed" runat="server">
    <asp:ListItem Selected="True">List</asp:ListItem>
    <asp:ListItem>Grid</asp:ListItem>
    <asp:ListItem>Table</asp:ListItem>
</asp:RadioButtonList>
<asp:PlaceHolder ID="phColumns" runat="server">
    # of Columns <asp:TextBox ID="txtColumns" Text="3" ToolTip="Specifies the number of columns to use for the grid. The number of rows is determined by dividing the 'Number of Items' by the '# of Columns'." runat="server" />
    <asp:RequiredFieldValidator ControlToValidate="txtColumns" ErrorMessage="enter the number of columns to display" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
    <asp:CompareValidator ControlToValidate="txtColumns" Operator="DataTypeCheck" Type="Integer" ErrorMessage="enter a numeric value" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
  <asp:CompareValidator ControlToValidate="txtColumns" Operator="GreaterThan" ValueToCompare="0" Type="Integer" ErrorMessage="enter a number greater than 0" Display="Dynamic" ForeColor=" " CssClass="errormessage" runat="server" />
</asp:PlaceHolder>
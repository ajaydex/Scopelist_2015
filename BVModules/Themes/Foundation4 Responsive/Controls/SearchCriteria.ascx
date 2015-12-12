<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SearchCriteria.ascx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Controls_SearchCriteria" %>

<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSearch">

    <div class="searchFormTable">
        <asp:Label ID="KeywordLabel" runat="server" Text="Keyword:" AssociatedControlID="KeywordField"></asp:Label>
        <asp:TextBox ID="KeywordField" runat="server"></asp:TextBox>
    </div>

    <div runat="server" id="trCategory">
        <asp:Label ID="CategoryLable" runat="server" Text="Category:" AssociatedControlID="CategoryField"></asp:Label>
        <asp:DropDownList ID="CategoryField" runat="server"></asp:DropDownList>
    </div>

    <div runat="server" id="trManufacturer">
        <asp:Label ID="ManufacturerLabel" runat="server" Text="Manufacturer:" AssociatedControlID="ManufacturerField"></asp:Label>
        <asp:DropDownList ID="ManufacturerField" runat="server"></asp:DropDownList>
    </div>

    <div runat="server" id="trVendor">
        <asp:Label ID="VendorLabel" runat="server" Text="Vendor:" AssociatedControlID="VendorField"></asp:Label>
        <asp:DropDownList ID="VendorField" runat="server"></asp:DropDownList>
    </div>

    <div runat="server" id="trPriceRange">
        <div class="row">
            <div class="small-6 columns">
                <asp:Label ID="PriceMinLabel" runat="server" Text="Priced From:" AssociatedControlID="PriceMinField"></asp:Label>
                <asp:TextBox ID="PriceMinField" runat="server"></asp:TextBox>
            </div>
            <div class="small-6 columns">
                <asp:Label ID="PriceMaxLabel" runat="server" Text="To" AssociatedControlID="PriceMaxField"></asp:Label>
                <asp:TextBox ID="PriceMaxField" runat="Server"></asp:TextBox>
            </div>
        </div>
    </div>

    <div runat="server" id="tr1">
        <asp:Label ID="Property1Label" runat="server"></asp:Label>
        <asp:DropDownList ID="PropertyList1" runat="server"></asp:DropDownList>
        <asp:TextBox ID="PropertyField1" runat="server"></asp:TextBox>
    </div>

    <div runat="server" id="tr2">
        <asp:Label ID="Property2Label" runat="server"></asp:Label>
        <asp:DropDownList ID="PropertyList2" runat="server"></asp:DropDownList>
        <asp:TextBox ID="PropertyField2" runat="server"></asp:TextBox>
    </div>

    <div runat="server" id="tr3">
        <asp:Label ID="Property3Label" runat="server"></asp:Label>
        <asp:DropDownList ID="PropertyList3" runat="server"></asp:DropDownList>
        <asp:TextBox ID="PropertyField3" runat="server"></asp:TextBox>
    </div>

    <div runat="server" id="tr4">
        <asp:Label ID="Property4Label" runat="server"></asp:Label>
        <asp:DropDownList ID="PropertyList4" runat="server"></asp:DropDownList>
        <asp:TextBox ID="PropertyField4" runat="server"></asp:TextBox>
    </div>
 
    <div runat="server" id="tr5">
        <asp:Label ID="Property5Label" runat="server"></asp:Label>
        <asp:DropDownList ID="PropertyList5" runat="server"></asp:DropDownList>
        <asp:TextBox ID="PropertyField5" runat="server"></asp:TextBox>
    </div>

    <div runat="server" id="tr6">
        <asp:Label ID="Property6Label" runat="server"></asp:Label>
        <asp:DropDownList ID="PropertyList6" runat="server"></asp:DropDownList>
        <asp:TextBox ID="PropertyField6" runat="server"></asp:TextBox>
    </div>

    <div runat="server" id="tr7">
        <asp:Label ID="Property7Label" runat="server"></asp:Label>
        <asp:DropDownList ID="PropertyList7" runat="server"></asp:DropDownList>
        <asp:TextBox ID="PropertyField7" runat="server"></asp:TextBox>
    </div>
  
    <div runat="server" id="tr8">
        <asp:Label ID="Property8Label" runat="server"></asp:Label>
        <asp:DropDownList ID="PropertyList8" runat="server"></asp:DropDownList>
        <asp:TextBox ID="PropertyField8" runat="server"></asp:TextBox>
    </div>

    <div runat="server" id="tr9">
        <asp:Label ID="Property9Label" runat="server"></asp:Label>
        <asp:DropDownList ID="PropertyList9" runat="server"></asp:DropDownList>
        <asp:TextBox ID="PropertyField9" runat="server"></asp:TextBox>
    </div>

    <div runat="server" id="tr10">
        <asp:Label ID="Property10Label" runat="server"></asp:Label>
        <asp:DropDownList ID="PropertyList10" runat="server"></asp:DropDownList>
        <asp:TextBox ID="PropertyField10" runat="server"></asp:TextBox>
    </div>

    <div runat="server" id="trSort">
        <asp:Label ID="SortLabel" runat="server" Text="Sort By:" AssociatedControlID="SortField"></asp:Label>
        <asp:DropDownList ID="SortField" runat="server">
            <asp:ListItem Value="-1">Best Match</asp:ListItem>
            <asp:ListItem Value="0">Name (A-Z)</asp:ListItem>
            <asp:ListItem Value="00">Name (Z-A)</asp:ListItem>
            <asp:ListItem Value="30">Highest Price</asp:ListItem>
            <asp:ListItem Value="3">Lowest Price</asp:ListItem>
            <asp:ListItem Value="2">Newest</asp:ListItem>
            <asp:ListItem Value="1">Manufacturer</asp:ListItem>
            <asp:ListItem Value="4">Vendor</asp:ListItem>
        </asp:DropDownList>
    </div>
    
    <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/Buttons/GoSearch.png" />
</asp:Panel>

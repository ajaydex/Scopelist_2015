<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SearchCriteria.ascx.vb"
    Inherits="BVModules_Controls_SearchCriteria" %>
<asp:Panel ID="pnlMain" runat="server" DefaultButton="btnSearch">
    <%--<table id="SearchFormTable" border="0" cellspacing="0" cellpadding="3">
        <tr>
            <td class="formlabel">
                <asp:Label ID="KeywordLabel" runat="server" Text="Keyword:" AssociatedControlID="KeywordField"></asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="KeywordField" CssClass="forminput" runat="server" Columns="20"></asp:TextBox></td>
        </tr>
        <tr runat="server" id="trCategory">
            <td class="formlabel">
                <asp:Label ID="CategoryLable" runat="server" Text="Category:" AssociatedControlID="CategoryField"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="CategoryField" runat="server">
                </asp:DropDownList></td>
        </tr>
        <tr runat="server" id="trManufacturer">
            <td class="formlabel">
                <asp:Label ID="ManufacturerLabel" runat="server" Text="Manufacturer:" AssociatedControlID="ManufacturerField"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="ManufacturerField" runat="server">
                </asp:DropDownList></td>
        </tr>
        <tr runat="server" id="trVendor">
            <td class="formlabel">
                <asp:Label ID="VendorLabel" runat="server" Text="Vendor:" AssociatedControlID="VendorField"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="VendorField" runat="server">
                </asp:DropDownList></td>
        </tr>
        <tr runat="server" id="trPriceRange">
            <td class="formlabel">
                <asp:Label ID="PriceMinLabel" runat="server" Text="Priced From:" AssociatedControlID="PriceMinField"></asp:Label></td>
            <td class="formfield">
                <asp:TextBox ID="PriceMinField" CssClass="forminput short" runat="server" Columns="5"></asp:TextBox>
                <asp:Label ID="PriceMaxLabel" CssClass="formlabel" runat="server" Text="To" AssociatedControlID="PriceMaxField"></asp:Label>
                <asp:TextBox ID="PriceMaxField" CssClass="forminput short" runat="Server" Columns="5"></asp:TextBox></td>
        </tr>
        <tr runat="server" id="tr1">
            <td class="formlabel">
                <asp:Label ID="Property1Label" runat="server"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="PropertyList1" runat="server">
                </asp:DropDownList><asp:TextBox ID="PropertyField1" CssClass="forminput" runat="server"
                    Columns="15"></asp:TextBox></td>
        </tr>
        <tr runat="server" id="tr2">
            <td class="formlabel">
                <asp:Label ID="Property2Label" runat="server"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="PropertyList2" runat="server">
                </asp:DropDownList><asp:TextBox ID="PropertyField2" CssClass="forminput" runat="server"
                    Columns="15"></asp:TextBox></td>
        </tr>
        <tr runat="server" id="tr3">
            <td class="formlabel">
                <asp:Label ID="Property3Label" runat="server"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="PropertyList3" runat="server">
                </asp:DropDownList><asp:TextBox ID="PropertyField3" CssClass="forminput" runat="server"
                    Columns="15"></asp:TextBox></td>
        </tr>
        <tr runat="server" id="tr4">
            <td class="formlabel">
                <asp:Label ID="Property4Label" runat="server"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="PropertyList4" runat="server">
                </asp:DropDownList><asp:TextBox ID="PropertyField4" CssClass="forminput" runat="server"
                    Columns="15"></asp:TextBox></td>
        </tr>
        <tr runat="server" id="tr5">
            <td class="formlabel">
                <asp:Label ID="Property5Label" runat="server"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="PropertyList5" runat="server">
                </asp:DropDownList><asp:TextBox ID="PropertyField5" CssClass="forminput" runat="server"
                    Columns="15"></asp:TextBox></td>
        </tr>
        <tr runat="server" id="tr6">
            <td class="formlabel">
                <asp:Label ID="Property6Label" runat="server"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="PropertyList6" runat="server">
                </asp:DropDownList><asp:TextBox ID="PropertyField6" CssClass="forminput" runat="server"
                    Columns="15"></asp:TextBox></td>
        </tr>
        <tr runat="server" id="tr7">
            <td class="formlabel">
                <asp:Label ID="Property7Label" runat="server"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="PropertyList7" runat="server">
                </asp:DropDownList><asp:TextBox ID="PropertyField7" CssClass="forminput" runat="server"
                    Columns="15"></asp:TextBox></td>
        </tr>
        <tr runat="server" id="tr8">
            <td class="formlabel">
                <asp:Label ID="Property8Label" runat="server"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="PropertyList8" runat="server">
                </asp:DropDownList><asp:TextBox ID="PropertyField8" CssClass="forminput" runat="server"
                    Columns="15"></asp:TextBox></td>
        </tr>
        <tr runat="server" id="tr9">
            <td class="formlabel">
                <asp:Label ID="Property9Label" runat="server"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="PropertyList9" runat="server">
                </asp:DropDownList><asp:TextBox ID="PropertyField9" CssClass="forminput" runat="server"
                    Columns="15"></asp:TextBox></td>
        </tr>
        <tr runat="server" id="tr10">
            <td class="formlabel">
                <asp:Label ID="Property10Label" runat="server"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="PropertyList10" runat="server">
                </asp:DropDownList><asp:TextBox ID="PropertyField10" CssClass="forminput" runat="server"
                    Columns="15"></asp:TextBox></td>
        </tr>
        <tr runat="server" id="trSort">
            <td class="formlabel">
                <asp:Label ID="SortLabel" runat="server" Text="Sort By:" AssociatedControlID="SortField"></asp:Label></td>
            <td class="formfield">
                <asp:DropDownList ID="SortField" runat="server">
                    <asp:ListItem Value="-1">Best Match</asp:ListItem>
                    <asp:ListItem Value="0">Name (A-Z)</asp:ListItem>
                    <asp:ListItem Value="00">Name (Z-A)</asp:ListItem>
                    <asp:ListItem Value="30">Highest Price</asp:ListItem>
                    <asp:ListItem Value="3">Lowest Price</asp:ListItem>
                    <asp:ListItem Value="2">Newest</asp:ListItem>
                    <asp:ListItem Value="1">Manufacturer</asp:ListItem>
                    <asp:ListItem Value="4">Vendor</asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="formlabel">
                 </td>
            <td class="formfield">
                <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/BVModules/Themes/Bvc5/images/Buttons/GoSearch.png" /></td>
        </tr>
    </table>--%>
    <div class="form-row">
        <div class="form-left">
            <asp:Label ID="KeywordLabel" runat="server" Text="Keyword : " AssociatedControlID="KeywordField"></asp:Label></div>
        <div class="form-right">
            <asp:TextBox ID="KeywordField" CssClass="txt_fld st1" runat="server"></asp:TextBox></div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row">
        <div class="form-left" id="trSort" runat="server">
            <asp:Label ID="SortLabel" runat="server" Text="Sort By : " AssociatedControlID="SortField"></asp:Label>
        </div>
        <div class="form-right">
            <asp:DropDownList Style="width: 120px;" ID="SortField" runat="server" CssClass="txt_fld short_select">
                <asp:ListItem Value="-1">- Any -</asp:ListItem>
                <asp:ListItem Value="0">Name</asp:ListItem>
                <asp:ListItem Value="3">Price</asp:ListItem>
                <asp:ListItem Value="2">Date Added to Store</asp:ListItem>
                <asp:ListItem Value="1">Manufacturer</asp:ListItem>
                <asp:ListItem Value="4">Vendor</asp:ListItem>
            </asp:DropDownList>
            order
            <asp:DropDownList ID="SortDirectionField" runat="server" CssClass="txt_fld short_select"
                Style="width: 120px;">
                <asp:ListItem Value="-1">- Any -</asp:ListItem>
                <asp:ListItem Value="0">Low to High</asp:ListItem>
                <asp:ListItem Value="1">High to Low</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="trCategory" runat="server">
        <div class="form-left">
            <asp:Label ID="CategoryLable" runat="server" Text="Category : " AssociatedControlID="CategoryField"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="CategoryField" runat="server" CssClass="txt_fld" Style="width: 183px;">
            </asp:DropDownList>
        </div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="trManufacturer" runat="server">
        <div class="form-left">
            <asp:Label ID="ManufacturerLabel" runat="server" Text="Manufacturer : " AssociatedControlID="ManufacturerField"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="ManufacturerField" runat="server" class="txt_fld">
            </asp:DropDownList>
        </div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="trVendor" runat="server">
        <div class="form-left">
            <asp:Label ID="VendorLabel" runat="server" Text="Vendor : " AssociatedControlID="VendorField"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="VendorField" runat="server" class="txt_fld">
            </asp:DropDownList>
        </div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="trPriceRange" runat="server">
        <div class="form-left">
            <asp:Label ID="PriceMinLabel" runat="server" Text="Priced From : " AssociatedControlID="PriceMinField"></asp:Label></div>
        <div class="form-right">
            <asp:TextBox Width="120px" ID="PriceMinField" CssClass="txt_fld st1 Short_textbox"
                runat="server"></asp:TextBox>
            to
            <asp:TextBox Width="120px" ID="PriceMaxField" CssClass="txt_fld st1 Short_textbox"
                runat="Server"></asp:TextBox></div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="tr1" runat="server">
        <div class="form-left">
            <asp:Label ID="Property1Label" runat="server"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="PropertyList1" runat="server" CssClass="txt_fld">
            </asp:DropDownList>
            <asp:TextBox ID="PropertyField1" CssClass="txt_fld st1" runat="server" Columns="15"></asp:TextBox>
        </div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="tr2" runat="server">
        <div class="form-left">
            <asp:Label ID="Property2Label" runat="server"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="PropertyList2" runat="server" CssClass="txt_fld">
            </asp:DropDownList>
            <asp:TextBox ID="PropertyField2" CssClass="txt_fld st1" runat="server" Columns="15"></asp:TextBox>
            <div class="clr">
            </div>
        </div>
    </div>
    <div class="form-row" id="tr3" runat="server">
        <div class="form-left">
            <asp:Label ID="Property3Label" runat="server"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="PropertyList3" runat="server" CssClass="txt_fld">
            </asp:DropDownList>
            <asp:TextBox ID="PropertyField3" CssClass="txt_fld st1" runat="server" Columns="15"></asp:TextBox></div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="tr4" runat="server">
        <div class="form-left">
            <asp:Label ID="Property4Label" runat="server"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="PropertyList4" runat="server" CssClass="txt_fld">
            </asp:DropDownList>
            <asp:TextBox ID="PropertyField4" CssClass="txt_fld st1" runat="server" Columns="15"></asp:TextBox></div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="tr5" runat="server">
        <div class="form-left">
            <asp:Label ID="Property5Label" runat="server"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="PropertyList5" runat="server" CssClass="txt_fld">
            </asp:DropDownList>
            <asp:TextBox ID="PropertyField5" CssClass="txt_fld st1" runat="server" Columns="15"></asp:TextBox></div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="tr6" runat="server">
        <div class="form-left">
            <asp:Label ID="Property6Label" runat="server"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="PropertyList6" runat="server" CssClass="txt_fld">
            </asp:DropDownList>
            <asp:TextBox ID="PropertyField6" CssClass="txt_fld st1" runat="server" Columns="15"></asp:TextBox></div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="tr7" runat="server">
        <div class="form-left">
            <asp:Label ID="Property7Label" runat="server"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="PropertyList7" runat="server" CssClass="txt_fld">
            </asp:DropDownList>
            <asp:TextBox ID="PropertyField7" CssClass="txt_fld st1" runat="server" Columns="15"></asp:TextBox></div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="tr8" runat="server">
        <div class="form-left">
            <asp:Label ID="Property8Label" runat="server"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="PropertyList8" runat="server" CssClass="txt_fld">
            </asp:DropDownList>
            <asp:TextBox ID="PropertyField8" CssClass="txt_fld st1" runat="server" Columns="15"></asp:TextBox></div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="tr9" runat="server">
        <div class="form-left">
            <asp:Label ID="Property9Label" runat="server"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="PropertyList9" runat="server" CssClass="txt_fld">
            </asp:DropDownList>
            <asp:TextBox ID="PropertyField9" CssClass="txt_fld st1" runat="server" Columns="15"></asp:TextBox></div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row" id="tr10" runat="server">
        <div class="form-left">
            <asp:Label ID="Property10Label" runat="server"></asp:Label></div>
        <div class="form-right">
            <asp:DropDownList ID="PropertyList10" runat="server" CssClass="txt_fld">
            </asp:DropDownList>
            <asp:TextBox ID="PropertyField10" CssClass="txt_fld st1" runat="server" Columns="15"></asp:TextBox></div>
        <div class="clr">
        </div>
    </div>
    <div class="form-row">
        <div class="form-left">
            &nbsp;</div>
        <div class="form-right">
            <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/BVModules/Themes/Scopelist/ScopelistImages/button-search.png"
                CssClass="custom" /></div>
        <div class="clr">
        </div>
    </div>
    <div class="clr">
    </div>
</asp:Panel>

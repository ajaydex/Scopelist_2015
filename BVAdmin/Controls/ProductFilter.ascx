<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ProductFilter.ascx.vb" Inherits="BVAdmin_Controls_ProductFilter" %>

<div id="filterDiv">
	<div style="float:right;">
    	<div style="background:#ddd; padding:20px; margin-bottom:10px;">
            Saved Filters: 
            <br /><br />
            <asp:DropDownList ID="FilterDropDownList" runat="server" ></asp:DropDownList>
            <br /><br />
            <asp:ImageButton ID="LoadFilterLinkButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/load.png" />
            &nbsp;&nbsp;
            <asp:ImageButton ID="DeleteFilterLinkButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/delete-filter.png" />   
        </div>
   		
    	<div style="background:#ddd; padding:20px;"> 
            Name and save your current filter:
            <br /><br />
            <asp:TextBox ID="FilterNameTextBox" runat="server" ValidationGroup="Filter"></asp:TextBox>
            <bvc5:BVRequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="FilterNameTextBox" 
ErrorMessage="You must enter a name for the filter." ValidationGroup="Filter" CssClass="errormessage" ForeColor=" ">*</bvc5:BVRequiredFieldValidator>
            <br /><br />
            <asp:ImageButton ID="SaveFilterLinkButton" runat="server" ValidationGroup="Filter" ImageUrl="~/BVAdmin/Images/Buttons/SaveSmall.png" />  
    	</div>
    </div>
    
    <table cellspacing="0" cellpadding="0" border="0">
        <tr>
            <td class="formlabel wide">
                Keyword
            </td>
            <td class="formfield">
                <asp:TextBox ID="KeywordTextBox" runat="server"></asp:TextBox>
                <br />
                <asp:CheckBox ID="ExactMatchCheckBox" Text="Exact Match" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Product Type</td>
            <td class="formfield" >
                <asp:DropDownList ID="ProductTypeDropDownList" runat="server" AppendDataBoundItems="True">
                    <asp:ListItem Value="" Selected="True">- Any -</asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Category</td>
            <td class="formfield" >
                <asp:DropDownList ID="CategoryDropDownList" runat="server" AppendDataBoundItems="True">
                    <asp:ListItem Value="" Selected="True">- Any -</asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Vendor
            </td>
            <td class="formfield" >
                <asp:DropDownList ID="VendorDropDownList" runat="server" AppendDataBoundItems="True">
                    <asp:ListItem Value="" Selected="True">- Any -</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Manufacturer
           	</td>
            <td class="formfield" >
                <asp:DropDownList ID="ManufacturerDropDownList" runat="server" AppendDataBoundItems="True">
                    <asp:ListItem Value="" Selected="True">- Any-</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Price Range
           	</td>
            <td class="formfield" >
                <asp:TextBox ID="FromPriceTextBox" runat="server"></asp:TextBox>
                <bvc5:BVCustomValidator ID="MonetaryRegularExpressionValidator1" runat="server"
                    ControlToValidate="FromPriceTextBox" Display="Dynamic" ErrorMessage='"From" price range must be a monetary value' CssClass="errormessage" ForeColor=" ">*</bvc5:BVCustomValidator>
                to
                <asp:TextBox ID="ToPriceTextBox" runat="server"></asp:TextBox>
                <bvc5:BVCustomValidator ID="MonetaryRegularExpressionValidator2" runat="server"
                    ControlToValidate="ToPriceTextBox" Display="Dynamic" ErrorMessage='"To" price range must be a monetary value' CssClass="errormessage" ForeColor=" ">*</bvc5:BVCustomValidator>
                <br />
               	(leave blank for none)
        	</td>
        </tr>
        <tr>
            <td class="formlabel wide" >
                Last X number of items added to store
            </td>
            <td class="formfield" >
                <asp:TextBox ID="NumberOfItemsAddedToStoreTextBox" runat="server" Width="38px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide" >
                Items added in the past X days</td>
            <td class="formfield" >
                <asp:TextBox ID="ItemsAddedInThePastXDaysTextBox" runat="server" Width="38px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Status
           	</td>
            <td class="formfield" >
                <asp:DropDownList ID="StatusDropDownList" runat="server" AppendDataBoundItems="True">
                    <asp:ListItem Value="" Selected="True">- Any-</asp:ListItem>
                    <asp:ListItem Value="1">Active</asp:ListItem>
                    <asp:ListItem Value="0">Disabled</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Inventory Status
           	</td>
            <td class="formfield" >
                <asp:DropDownList ID="InventoryStatusDropDownList" runat="server"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="formlabel wide">
                Sort By</td>
            <td class="formfield" >
                <asp:DropDownList ID="SortByDropDownList" runat="server" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Product Name</asp:ListItem>
                    <asp:ListItem Value="1">Manufacturer Name</asp:ListItem>
                    <asp:ListItem Value="2">Creation Date</asp:ListItem>
                    <asp:ListItem Value="3">Site Price</asp:ListItem>
                    <asp:ListItem Value="4">Vendor</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="SortOrderDropDownList" runat="server" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Ascending</asp:ListItem>
                    <asp:ListItem Value="1">Descending</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</div>

<br />

<asp:Panel ID="sharedChoicesPanel" CssClass="sharedChoicesDiv" runat="server" Visible="False">
    <div class="controlarea1" style="max-width:500px;">
        <h4>Product Shared Choices</h4>
        <table cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td>
                    <asp:DropDownList ID="SharedChoiceDropDownList" runat="server" AutoPostBack="True"></asp:DropDownList>
                    &nbsp;
                </td>
                <td>
                    <asp:DropDownList ID="SharedChoiceOptionDropDownList" runat="server"></asp:DropDownList>
                    &nbsp;
                </td>
                <td>
                    <asp:ImageButton ID="AddChoiceImageButton" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/Add.png" />
                </td>
            </tr>
        </table>
        <br />
        <asp:GridView ID="ChoicesAndOptionsGridView" runat="server" AutoGenerateColumns="False" GridLines="None">
            <Columns>
                <asp:BoundField HeaderText="Choice Name" DataField="ChoiceName" />
                <asp:BoundField HeaderText="Choice Option Name" DataField="ChoiceOptionName" />
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton ID="DeleteImageButton" runat="server" CausesValidation="false" CommandName="Delete"
                            ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" AlternateText="Delete" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="row" />
            <HeaderStyle CssClass="rowheader" />
            <AlternatingRowStyle CssClass="alternaterow" />
            <EmptyDataTemplate>
                <div class="controlarea1">
                    There are no currently selected Product Choices.
                </div> 
            </EmptyDataTemplate>
        </asp:GridView> 
    </div>
</asp:Panel>

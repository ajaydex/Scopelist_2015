<%@ Control Language="C#" AutoEventWireup="false" CodeFile="ShippingCostRules.ascx.cs" Inherits="BVModules_Shipping_Package_Rules_ShippingCostRules" %>
<%@ Register TagPrefix="anthem" Assembly="Anthem" Namespace="Anthem" %>
<%@ Register TagPrefix="ss" Assembly="StructuredSolutions.ShippingProviders" Namespace="StructuredSolutions.Bvc5.Shipping.Providers.Controls" %>
<%@ Register TagPrefix="uc" TagName="PackageMatchEditor" Src="PackageMatchEditor.ascx" %>

<%@ Import Namespace="ASPNET=System.Web.UI.WebControls" %>
<%@ Import Namespace="StructuredSolutions.Bvc5.Shipping.Providers" %>
    
<div class="section">
    <div style="loat:right;">
        <asp:LinkButton ID="Export" runat="server" ToolTip="Export the shipping cost rules to a file" OnClick="Export_Click" Text="Export" /> |
        <a href="#" onclick="javascript:showImportCostDialog(); return false;" title="Import the shipping cost rules from a file">Import</a>
    </div>
    <h2 class="settings">
        Shipping Cost Rules
    </h2>
    <p>
        The shipping cost rules are scanned in order for each package until a match is
        found. The matching calculation is applied to determine the package shipping
        cost. The final shipping cost is the total of each package shipping cost.
    </p>
    
    <asp:ObjectDataSource ID="RuleDataSource" runat="server" 
        OnDeleting="RuleDataSource_Deleting" 
        OnSelecting="RuleDataSource_Selecting"
        OnUpdating="RuleDataSource_Updating"
        DeleteMethod="Delete"
        SelectMethod="Select"
        TypeName="StructuredSolutions.Bvc5.Shipping.Providers.Settings.PackageRuleDataSource"
        UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="settings" Type="Object" />
        </DeleteParameters>
        <SelectParameters>
            <asp:Parameter Name="settings" Type="Object" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="settings" Type="Object" />
            <asp:Parameter Name="matches" Type="Object" />
            <asp:Parameter Name="id" Type="String" />
            <asp:Parameter Name="valuePackageProperty" Type="String" />
            <asp:Parameter Name="valueItemProperty" Type="String" />
            <asp:Parameter Name="valueCustomProperty" Type="String" />
            <asp:Parameter Name="value" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    
    <anthem:GridView ID="Rules" runat="server"
        AllowPaging="True"
        AutoGenerateColumns="false"
        CellPadding="0"
        CellSpacing="0"
        CssClass="rules"
        DataKeyNames="id"
        DataSourceID="RuleDataSource"
        EmptyDataText="No rules defined"
        ForeColor="#333333"
        GridLines="None"
        OnRowCommand="Rules_RowCommand"
        OnRowCreated="Rules_RowCreated" 
        ShowHeader="false"
        Width="100%">
        <Columns>
            <asp:TemplateField HeaderStyle-HorizontalAlign="left">
                <ItemStyle HorizontalAlign="Left" Width="90%" />
                
                <ItemTemplate>
                    <div style="padding: 20px;">
                    	<div style="margin-bottom: 15px;">
                            <asp:ImageButton ID="InsertRow" runat="server" 
                                CommandName="New" 
                                CommandArgument='<%# Eval("ID") %>' 
                                ImageUrl="~/BVAdmin/Images/Buttons/New.png" 
                                ToolTip="Insert a new rule before this rule" />
                            <asp:ImageButton ID="EditRow" runat="server" 
                                CommandName="Edit" 
                                ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" 
                                ToolTip="Edit this rule" />
                            <anthem:ImageButton ID="DeleteRow" runat="server" 
                                CommandName="Delete" 
                                ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" 
                                PreCallBackFunction="function(){return confirm('Are you sure you want to delete this rule?');}"
                                ToolTip="Delete this rule" />
                    	</div>
                        <ol style="list-style: none; margin: 0; padding: 0;">
                            <li style="list-style: none; margin: 0; padding: 0;"  value="<%# (Rules.PageIndex * Rules.PageSize) + ((GridViewRow)Container).RowIndex + 1%>">
                                <%# GetRuleAsString(Eval("ID").ToString()) %>
                            </li>
                        </ol>
                    </div>
                </ItemTemplate>
                
                <EditItemTemplate>
                	<div style="padding: 20px;">
                    	<asp:ImageButton ID="CancelEdit" runat="server" 
                            CausesValidation="false"
                            CommandName="Cancel" 
                            ImageUrl="~/BVAdmin/Images/Buttons/CancelSmall.png"
                            ToolTip="Quit editing this rule without saving changes">
                        </asp:ImageButton>
                        
                        <asp:ValidationSummary ID="RuleGroupValidationSummary" runat="server" 
                            AutoUpdateAfterCallBack="true" 
                            DisplayMode="SingleParagraph" 
                            EnableClientScript="false"
                            ValidationGroup="RuleGroup">
                        </asp:ValidationSummary>
                        
                        <table class="formtable subform">
                            <tr id="tr1" runat="server" visible='<%# !Settings.CostingRules[Eval("ID").ToString()].IsDefaultRule %>'>
                                <td colspan="2">
                                    <h2>Match packages that satisfy all of the following conditions</h2>
                                </td>
                            </tr>
                            <uc:PackageMatchEditor ID="PackageMatchEditor" runat="server" DataSource='<%# Eval("Matches") %>' Prompt="When" RuleId='<%# Eval("ID") %>' />
                            <tr>
                                <td colspan="2">
                                    <h2><%# Settings.CostingRules[Eval("ID").ToString()].IsDefaultRule ? "For all remaining packages, assign the following cost" : "Assign the following cost" %></h2>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    Cost = <ss:HelpLabel ID="ValuePackagePropertyLabel" runat="server"
                                        AssociatedControlID="ValuePackagePropertyField"
                                        Text="Value Property"
                                        ToolTip="&lt;p&gt;Select the package property that will be used to 
                                            calculate the shipping cost.&lt;/p&gt;
                                            &lt;p&gt;&quot;Items&quot; will calculate the combined value of the 
                                            selected item property. &quot;Rate From&quot; will retrieve the
                                            shipping cost from any other shipping method.&lt;/p&gt;
                                            &lt;h2&gt;Items&lt;/h2&gt;
                                            &lt;p&gt;If the item property is numeric, then the value 
                                            for each item in the package will be added together. 
                                            For example, Items Weight is 
                                            the total weight of all items in the package.&lt;/p&gt;
                                            &lt;p&gt;If the item property is not numeric, then the
                                            value will be treated as 0.&lt;/p&gt;
                                            &lt;h2&gt;Rate From&lt;/h2&gt;
                                            &lt;p&gt;If the selected shipping method returns more than one rate,
                                            the least expensive rate will be used for the cost.&lt;/p&gt;"
                                        Visible="false">
                                    </ss:HelpLabel>
                                    <asp:DropDownList ID="ValuePackagePropertyField" runat="server" 
                                        AutoPostBack="true" 
                                        OnSelectedIndexChanged="ValuePackagePropertyField_SelectedIndexChanged" 
                                        SelectedValue='<%# Bind("ValuePackageProperty") %>'>
                                    </asp:DropDownList>
                                    <asp:RegularExpressionValidator id="ValuePropertyValidator" runat="server" 
                                        ControlToValidate="ValuePackagePropertyField"
                                        Display="Dynamic"
                                        EnableClientScript="false"
                                        ErrorMessage="Please choose a property to evaluate."
                                        SetFocusOnError="True"
                                        Text="*"
                                        ToolTip="Please choose a property to evaluate"
                                        ValidationExpression="(?i:\b(?!separator)\w+\b)"
                                        ValidationGroup="RuleGroup">
                                    </asp:RegularExpressionValidator>
                                    <ss:HelpLabel ID="ValueItemPropertyLabel" runat="server"
                                        AssociatedControlID="ValueItemPropertyField"
                                        Text="Value Item Property"
                                        ToolTip="&lt;p&gt;Select the item property to total.&lt;/p&gt;"
                                        Visible="false">
                                    </ss:HelpLabel>
                                    <asp:DropDownList id="ValueItemPropertyField" runat="server"
                                        AutoPostBack="true"
                                        OnSelectedIndexChanged="ValueItemPropertyField_SelectedIndexChanged"
                                        SelectedValue='<%# Bind("ValueItemProperty") %>'>
                                    </asp:DropDownList>
                                    <ss:HelpLabel ID="ValueCustomPropertyLabel" runat="server"
                                        AssociatedControlID="ValueCustomPropertyField"
                                        Text="Custom Value Property"
                                        ToolTip="&lt;p&gt;Select the address property that will be used to calculate the shipping cost.&lt;/p&gt;"
                                        Visible="false">
                                    </ss:HelpLabel>
                                    <asp:DropDownList ID="ValueCustomPropertyField" runat="server" 
                                        SelectedValue='<%# Bind("ValueCustomProperty") %>'
                                        Visible="false">
                                    </asp:DropDownList>
                                    <asp:Label ID="ValueMultiplierLabel" runat="server" Text="&times;" style="font-size:large;text-align:center"/>
                                    <ss:HelpLabel ID="ValueLabel" runat="server"
                                        AssociatedControlID="ValueField"
                                        Text="Value"
                                        ToolTip="&lt;p&gt;Enter the value that will be multiplied by the selected property 
                                            to calculate the shipping cost.&lt;/p&gt;
                                            &lt;p&gt;If the final cost is less than 0, it will not be displayed to the customer.&lt;/p&gt;"
                                        Visible="false">
                                    </ss:HelpLabel>
                                    <asp:TextBox ID="ValueField" runat="server" 
                                        CssClass="numeric" 
                                        Text='<%# Bind("Value") %>'>
                                    </asp:TextBox>
                                    <anthem:RequiredFieldValidator ID="ValueRequired" runat="server" 
                                        AutoUpdateAfterCallBack="true"
                                        ControlToValidate="ValueField"
                                        Display="Dynamic"
                                        EnableClientScript="false"
                                        ErrorMessage="The value is required."
                                        SetFocusOnError="True"
                                        Text="*"
                                        ToolTip="The value is required"
                                        ValidationGroup="RuleGroup">
                                    </anthem:RequiredFieldValidator>
                                    <anthem:RangeValidator ID="ValueNumeric" runat="server"
                                        AutoUpdateAfterCallBack="true"
                                        ControlToValidate="ValueField"
                                        Display="Dynamic"
                                        EnableClientScript="false"
                                        ErrorMessage="The value must be a number."
                                        Text="*"
                                        ToolTip="The value must be a number"
                                        Type="Double" MaximumValue="9999" MinimumValue="-9999"
                                        ValidationGroup="RuleGroup">
                                    </anthem:RangeValidator>
                                </td>
                            </tr>
                        </table>
                        
                        <asp:GridView id="SampleShippingCosts" runat="server"
                            AllowPaging="true"
                            AutoGenerateColumns="false"
                            Caption="Showing 5 of xxx" 
                            CellPadding="4"
                            CellSpacing="0"
                            CssClass="samples"
                            EmptyDataText="No matching orders found."
                            ForeColor="#333333"
                            GridLines="None"
                            PageSize="5"
                            ShowHeader="true"
                            Visible="false"
                            Width="95%"
                            OnPageIndexChanging="SampleShippingCosts_PageIndexChanging">
                            <Columns>
                                <asp:BoundField DataField="OrderDisplay" HeaderText="Order / Package" HtmlEncode="false" />
                                <asp:BoundField DataField="MatchValues" HeaderText="Matching Value(s)" />
                                <asp:BoundField DataField="LimitValues" HeaderText="Limit(s)" />
                                <asp:BoundField DataField="Value" HeaderText="Cost" />
                                <asp:BoundField DataField="RateDisplay" HeaderText="Rate" />
                            </Columns>
                            <PagerSettings Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous" />
                            <PagerStyle backcolor="#5D7B9D" forecolor="White" font-bold="True" horizontalalign="Left" CssClass="pager" />
                            <RowStyle backcolor="#F7F6F3" forecolor="#000000" verticalalign="Top" />
                            <AlternatingRowStyle backcolor="White" forecolor="#333333" />
                            <HeaderStyle backcolor="#5D7B9D" forecolor="White" font-bold="True" horizontalalign="Left" />
                        </asp:GridView>
                        
                        <br />
                        <br />
                        
                        <asp:ImageButton ID="UpdateRule" runat="server" 
                            CommandName="Update" 
                            ImageUrl="~/BVAdmin/Images/Buttons/Update.png" 
                            ToolTip="Save the changes you have made to this rule"
                            ValidationGroup="RuleGroup">
                        </asp:ImageButton>
                        
                        <anthem:ImageButton ID="ViewRule" runat="server" 
                            CommandName="View" 
                            ImageUrl="~/BVAdmin/Images/Buttons/View.png" 
                            TextDuringCallBack="Working..."
                            ToolTip="Display a sample of old orders that match this rule"
                            ValidationGroup="RuleGroup">
                        </anthem:ImageButton>
                        
                    </div>
                </EditItemTemplate>
                
            </asp:TemplateField>
            
            <asp:TemplateField>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
                <EditItemTemplate />
                <ItemTemplate>
                    <div><asp:ImageButton ID="MoveRuleUp" runat="server" 
                            ImageUrl="~/BVAdmin/Images/Buttons/Up.png" 
                            CommandArgument='<%# Eval("ID") %>' 
                            CommandName="MoveUp" 
                            ToolTip="Move this rule up in order" /></div>
                    <div><asp:ImageButton ID="MoveRuleDown" runat="server" 
                            ImageUrl="~/BVAdmin/Images/Buttons/Down.png" 
                            CommandArgument='<%# Eval("ID") %>' 
                            CommandName="MoveDown" 
                            ToolTip="Move this rule down in order" /></div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        
        <HeaderStyle CssClass="rowheader" />
        <RowStyle CssClass="row" />
        <AlternatingRowStyle CssClass="alternaterow" />
        <EditRowStyle CssClass="editrow" BackColor="#FFFFCC" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        
        <PagerSettings Position="Bottom" Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous" />
        <PagerStyle CssClass="pager" />
    </anthem:GridView>
</div>





<div id="importcost" style="visibility:hidden">
    <div class="hd">Import Cost Rules</div>
    <div class="bd" style="padding:1em">
        <p>Select the shipping cost rules file then click Import</p>
        <asp:FileUpload ID="ImportCostUpload" runat="server" />
        <asp:CustomValidator ID="ImportCostUploadRequired" runat="server" Display="Dynamic" ClientValidationFunction="validateImportCostUpload" EnableClientScript="true" Text="<br />Please select a rules file<br />" ValidationGroup="ImportCosts" OnServerValidate="ImportCostUploadRequired_ServerValidate" />
        <div style="text-align:right;margin-top:1em">
            <asp:Button ID="Import" runat="server" OnClick="Import_Click" Text="Import" CausesValidation="true" ValidationGroup="ImportCosts" />
            <input onclick="javascript: importcostdialog.hide();" type="button" value="Cancel" />
        </div>
    </div>
</div>

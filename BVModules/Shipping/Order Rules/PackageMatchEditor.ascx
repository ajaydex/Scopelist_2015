<%@ Control Language="C#" CodeFile="PackageMatchEditor.ascx.cs" Inherits="BVModules_Shipping_Order_Rules_PackageMatchEditor" %>
<%@ Register TagPrefix="anthem" Assembly="Anthem" Namespace="Anthem" %>
<%@ Register TagPrefix="ss" Assembly="StructuredSolutions.ShippingProviders" Namespace="StructuredSolutions.Bvc5.Shipping.Providers.Controls" %>

<%@ Import Namespace="ASPNET=System.Web.UI.WebControls" %>
<%@ Import Namespace="StructuredSolutions.Bvc5.Shipping.Providers" %>

<ss:PackageMatchRepeater id="Matches" runat="server" OnItemCreated="Matches_ItemCreated" OnItemCommand="Matches_ItemCommand">
    <SeparatorTemplate><tr><td colspan="2"><hr style="color:#ddd;height:1px" /></td></tr></SeparatorTemplate>
    <ItemTemplate>
        <tr>
            <td class="formlabel">
                <%# (Container.ItemIndex == 0) ? Prompt : "" %>
                <ss:HelpLabel ID="MatchJoinLabel" runat="server"
                    AssociatedControlID="MatchJoinField"
                    Text="Join"
                    ToolTip="&lt;p&gt;Select the way criteria are combined.
                        &quot;And&quot; criteria are evaluated before
                        &quot;Or&quot; criteria.&lt;/p&gt;"
                    Visible="false">
                </ss:HelpLabel>
                <asp:DropDownList ID="MatchJoinField" runat="server"
                    AutoPostBack="false"
                    SelectedValue='<%# Eval("Join") %>'
                    Visible="<%# (Container.ItemIndex > 0) %>">
                    <asp:ListItem Value="And">And</asp:ListItem>
                    <asp:ListItem Value="Or">Or</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <ss:HelpLabel ID="MatchPackagePropertyLabel" runat="server"
                    AssociatedControlID="MatchPackagePropertyField"
                    Text="Match Property"
                    ToolTip="&lt;p&gt;Select the package property to use in the
                        comparison.&lt;/p&gt;
                        &lt;p&gt;&quot;Item&quot; will calculate the combined value of the 
                        selected item property. &quot;Rate From&quot; will retrieve the
                        shipping cost from any other shipping method.&lt;/p&gt;
                        &lt;h2&gt;Item Notes&lt;/h2&gt;
                        &lt;p&gt;If the item property is numeric, then the value 
                        for each item in the package will be added together. 
                        For example, Item Weight is 
                        the total weight of all items in the package.&lt;/p&gt;
                        &lt;p&gt;If the item property is not numeric, then each value will be 
                        concatenated to form one string. Each individual value will be 
                        delimited by the characters ^ and $. For example, Item Product Name
                        might be &quot;^Widget$^FooBar$&quot;.&lt;/p&gt;
                        &lt;h2&gt;Rate From Notes&lt;/h2&gt;
                        &lt;p&gt;If the selected shipping method returns more than one rate,
                        the least expensive rate will be used in the comparison.&lt;/p&gt;"
                    Visible="false">
                </ss:HelpLabel>
                <asp:DropDownList ID="MatchPackagePropertyField" runat="server"
                    AutoPostBack="true" 
                    OnSelectedIndexChanged="MatchPackagePropertyField_SelectedIndexChanged" 
                    SelectedValue='<%# Eval("PackageProperty") %>'>
                </asp:DropDownList>
                <asp:RegularExpressionValidator id="MatchPackagePropertyValidator" runat="server" 
                    ControlToValidate="MatchPackagePropertyField"
                    Display="Dynamic"
                    EnableClientScript="false"
                    ErrorMessage="Please choose a property to evaluate."
                    SetFocusOnError="True"
                    Text="*"
                    ToolTip="Please choose a property to evaluate"
                    ValidationExpression="(?i:\b(?!separator)\w+\b)"
                    ValidationGroup="RuleGroup">
                </asp:RegularExpressionValidator>
                <ss:HelpLabel ID="MatchItemPropertyLabel" runat="server"
                    AssociatedControlID="MatchItemPropertyField"
                    Text="Match Item Property"
                    ToolTip="&lt;p&gt;Select the item property to combine.&lt;/p&gt;"
                    Visible="false">
                </ss:HelpLabel>
                <asp:DropDownList id="MatchItemPropertyField" runat="server"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="MatchItemPropertyField_SelectedIndexChanged"
                    SelectedValue='<%# Bind("ItemProperty") %>'>
                </asp:DropDownList>
                <ss:HelpLabel ID="MatchCustomPropertyLabel" runat="server"
                    AssociatedControlID="MatchCustomPropertyField"
                    Text="Custom Match Property"
                    ToolTip="&lt;p&gt;Select the specific property to examine.&lt;/p&gt;"
                    Visible="false">
                </ss:HelpLabel>
                <asp:DropDownList ID="MatchCustomPropertyField" runat="server" 
                    SelectedValue='<%# Eval("CustomProperty") %>'>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td />
            <td>
                <ss:HelpLabel ID="MatchComparisonTypeLabel" runat="server"
                    AssociatedControlID="MatchComparisonTypeField"
                    Text="Comparison"
                    ToolTip="&lt;p&gt;Select the comparison to make between the Match Property and 
                        the Limit. If the comparison is true, then this criteria is true.&lt;/p&gt;
                        &lt;p&gt;If both the Match Property and the Limit are numbers then the
                        comparison is numerical, otherwise both are converted to strings and the
                        comparison is lexical.&lt;/p&gt;
                        &lt;p&gt;&quot;In&quot;, &quot;Contains&quot;, &quot;Starts With&quot;, and 
                        &quot;Ends With&quot; always treat both the Match Property and the Limit
                        as strings.&lt;/p&gt;"
                    Visible="false">                                        
                </ss:HelpLabel>
                <asp:DropDownList ID="MatchComparisonTypeField" runat="server" 
                    SelectedValue='<%# Eval("Comparison") %>'>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td />
            <td>
                <ss:HelpLabel ID="LimitPackagePropertyLabel" runat="server"
                    AssociatedControlID="LimitPackagePropertyField"
                    Text="Limit Property"
                    ToolTip="&lt;p&gt;Select the package property to use as the limit in the
                        comparison.&lt;/p&gt;
                        &lt;p&gt;&quot;Fixed Value&quot; will use the specific value you
                        enter as the limit.
                        &quot;Item&quot; will calculate the combined value of the 
                        selected item property. &quot;Rate From&quot; will retrieve the
                        shipping cost from any other shipping method.&lt;/p&gt;
                        &lt;h2&gt;Fixed Value Notes&lt;/h2&gt;
                        &lt;p&gt;Do not include currency signs or commas in the fixed
                        value if the limit is a number.&lt;/p&gt;
                        &lt;h2&gt;Item Notes&lt;/h2&gt;
                        &lt;p&gt;If the item property is numeric, then the value 
                        for each item in the package will be added together. 
                        For example, Item Weight is 
                        the total weight of all items in the package.&lt;/p&gt;
                        &lt;p&gt;If the item property is not numeric, then each value will be 
                        concatenated to form one string. Each individual value will be 
                        delimited by the characters ^ and $. For example, Item Product Name
                        might be &quot;^Widget$^FooBar$&quot;.&lt;/p&gt;
                        &lt;h2&gt;Rate From Notes&lt;/h2&gt;
                        &lt;p&gt;If the selected shipping method returns more than one rate,
                        the least expensive rate will be used in the comparison.&lt;/p&gt;"
                    Visible="false">
                </ss:HelpLabel>
                <asp:DropDownList ID="LimitPackagePropertyField" runat="server"
                    AutoPostBack="true" 
                    OnSelectedIndexChanged="LimitPackagePropertyField_SelectedIndexChanged" 
                    SelectedValue='<%# Eval("LimitPackageProperty") %>'>
                </asp:DropDownList>
                <asp:RegularExpressionValidator id="LimitPackagePropertyValidator" runat="server" 
                    ControlToValidate="LimitPackagePropertyField"
                    Display="Dynamic"
                    EnableClientScript="false"
                    ErrorMessage="Please choose a property to evaluate."
                    SetFocusOnError="True"
                    Text="*"
                    ToolTip="Please choose a property to evaluate"
                    ValidationExpression="(?i:\b(?!separator)\w+\b)"
                    ValidationGroup="RuleGroup">
                </asp:RegularExpressionValidator>
                <ss:HelpLabel ID="LimitItemPropertyLabel" runat="server"
                    AssociatedControlID="LimitItemPropertyField"
                    Text="Limit Item Property"
                    ToolTip="&lt;p&gt;Select the item property to combine.&lt;/p&gt;"
                    Visible="false">
                </ss:HelpLabel>
                <asp:DropDownList id="LimitItemPropertyField" runat="server"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="LimitItemPropertyField_SelectedIndexChanged"
                    SelectedValue='<%# Bind("LimitItemProperty") %>'>
                </asp:DropDownList>
                <ss:HelpLabel ID="LimitCustomPropertyLabel" runat="server"
                    AssociatedControlID="LimitCustomPropertyField"
                    Text="Custom Limit Property"
                    ToolTip="&lt;p&gt;Select the specific property to examine.&lt;/p&gt;"
                    Visible="false">
                </ss:HelpLabel>
                <asp:DropDownList ID="LimitCustomPropertyField" runat="server" 
                    SelectedValue='<%# Eval("LimitCustomProperty") %>'>
                </asp:DropDownList>
                <asp:Label ID="LimitMultiplierLabel" runat="server" Text="&times;" style="font-size:large;text-align:center"/>
                <ss:HelpLabel ID="LimitLabel" runat="server"
                    AssociatedControlID="LimitField"
                    Text="Limit"
                    ToolTip="&lt;p&gt;See PrepareLimitField method.&lt;/p&gt;"
                    Visible="false">
                </ss:HelpLabel>
                <asp:TextBox ID="LimitField" runat="server" 
                    CssClass="numeric" 
                    Text='<%# Eval("Limit") %>'>
                </asp:TextBox>
                <anthem:RequiredFieldValidator ID="LimitRequired" runat="server" 
                    AutoUpdateAfterCallBack="true"
                    ControlToValidate="LimitField"
                    Display="Dynamic"
                    EnableClientScript="false"
                    ErrorMessage="The multiplier is required."
                    SetFocusOnError="True"
                    Text="*"
                    ToolTip="The multiplier is required"
                    ValidationGroup="RuleGroup">
                </anthem:RequiredFieldValidator>
                <asp:CompareValidator id="LimitNumeric" runat="server" 
                    ControlToValidate="LimitField"
                    Display="Dynamic"
                    EnableClientScript="false"
                    ErrorMessage="The multiplier must be numeric."
                    Operator="DataTypeCheck"
                    SetFocusOnError="True"
                    Text="*"
                    ToolTip="The multiplier must be numeric"
                    Type="Double"
                    ValidationGroup="RuleGroup">
                </asp:CompareValidator>
                <ss:HelpLabel ID="NewMatchLabel" runat="server"
                    AssociatedControlID="NewMatch"
                    Text="New Condition"
                    ToolTip="&lt;p&gt;Click this button to add a condition.&lt;/p&gt;"
                    Visible="false">
                </ss:HelpLabel>
                <asp:ImageButton ID="NewMatch" runat="server" 
                    AlternateText="Add a new condition" 
                    CommandName="New"
                    ImageUrl='<%# Page.ClientScript.GetWebResourceUrl(typeof(ExtendedShippingProvider), "StructuredSolutions.Bvc5.Shipping.images.plus.gif") %>'
                    ToolTip="Add a new condition">
                </asp:ImageButton>
                <ss:HelpLabel ID="DeleteMatchLabel" runat="server"
                    AssociatedControlID="DeleteMatch"
                    Text="Delete Condition"
                    ToolTip="&lt;p&gt;Click this button to remove the condition.&lt;/p&gt;"
                    Visible="false">
                </ss:HelpLabel>
                <anthem:ImageButton ID="DeleteMatch" runat="server" 
                    AlternateText="Delete this condition" 
                    CommandName="Delete" 
                    ImageUrl='<%# Page.ClientScript.GetWebResourceUrl(typeof(ExtendedShippingProvider), "StructuredSolutions.Bvc5.Shipping.images.minus.gif") %>' 
                    PreCallBackFunction="function(){return confirm('Are you sure you want to delete this condition?');}"
                    ToolTip="Delete this condition" 
                    Visible='<%# ((ASPNET.Repeater)Container.BindingContainer).Items.Count > 0 %>'>
                </anthem:ImageButton>
            </td>
        </tr>
    </ItemTemplate>
</ss:PackageMatchRepeater>

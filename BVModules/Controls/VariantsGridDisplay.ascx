<%@ Control Language="VB" AutoEventWireup="false" CodeFile="VariantsGridDisplay.ascx.vb" Inherits="BVModules_Controls_VariantsGridDisplay" %>
<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<asp:Panel ID="VariantsPanel" CssClass="variantsgriddisplay" runat="server">
    <table>        
        <asp:PlaceHolder ID="VariantsPlaceHolder" runat="server"></asp:PlaceHolder>
        
        
        <anthem:Repeater ID="VariantsGridDisplayRepeater" runat="server">           
            <HeaderTemplate>
            	<tr>
                	<td colspan="3">
                		<table class="variantsgrid">
            </HeaderTemplate>
            <FooterTemplate>
                		</table>
                	</td>
               	</tr>
            </FooterTemplate>
            <ItemTemplate>
                <asp:HiddenField ID="BvinHiddenField" Visible="false" Value='<%# DataBinder.Eval(Container.DataItem, "AssociatedProduct.Bvin") %>' runat="server" />
                <asp:HiddenField ID="ModifierOptionsHiddenField" Visible="false" Value='<%# DataBinder.Eval(Container.DataItem, "ModifierOptionIds") %>' runat="server" />                    
                <tr class="item">
                    <td class="quantity">
                        <asp:TextBox ID="QuantityField" runat="server" Text='0' Columns="5" MaxLength="4" CssClass="quantityfield"></asp:TextBox>
                        <bvc5:BVRequiredFieldValidator ID="valQty"
                            runat="server" CssClass="errormessage" ForeColor=" " Display="Dynamic" ControlToValidate="QuantityField"
                            EnableClientScript="True" ErrorMessage="Please Enter A Quantity">*</bvc5:BVRequiredFieldValidator>
                        <bvc5:BVRegularExpressionValidator
                                ID="val2Qty" runat="server" CssClass="errormessage" ForeColor=" " Display="Dynamic"
                                ControlToValidate="QuantityField" EnableClientScript="True" ErrorMessage="Quantity Must be between 1 and 9999"
                                ValidationExpression="\d+|\d+\d+|\d+\d+\d+|\d+\d+\d+\d+"></bvc5:BVRegularExpressionValidator>                                                            
                    </td>
                    <td class="description">
                        <img id="Img1" runat="server" visible='<%# DataBinder.Eval(Container.DataItem, "DisplayImages") %>' alt='<%# DataBinder.Eval(Container.DataItem, "AssociatedProduct.ImageFileSmallAlternateText") %>'
                            src='<%# DataBinder.Eval(Container.DataItem, "SmallImageUrl") %>' />
                        <div class="productnamediv">
                            <%#DataBinder.Eval(Container.DataItem, "ComboDisplayName")%>
                        </div>
                        <div class="productpricediv">
                            <%#DataBinder.Eval(Container.DataItem, "DisplayPrice")%>
                        </div>              
                    </td>
                </tr>                
            </ItemTemplate>
            <AlternatingItemTemplate>
                <asp:HiddenField ID="BvinHiddenField" Visible="false" Value='<%# DataBinder.Eval(Container.DataItem, "AssociatedProduct.Bvin") %>' runat="server" />
                <asp:HiddenField ID="ModifierOptionsHiddenField" Visible="false" Value='<%# DataBinder.Eval(Container.DataItem, "ModifierOptionIds") %>' runat="server" />                    
                <tr class="item altitem">
                    <td class="quantity">
                        <asp:TextBox ID="QuantityField" runat="server" Text='0' Columns="5" MaxLength="4" CssClass="quantityfield"></asp:TextBox>
                        <bvc5:BVRequiredFieldValidator ID="valQty"
                            runat="server" CssClass="errormessage" ForeColor=" " Display="Dynamic" ControlToValidate="QuantityField"
                            EnableClientScript="True" ErrorMessage="Please Enter A Quantity">*</bvc5:BVRequiredFieldValidator>
                        <bvc5:BVRegularExpressionValidator
                                ID="val2Qty" runat="server" CssClass="errormessage" ForeColor=" " Display="Dynamic"
                                ControlToValidate="QuantityField" EnableClientScript="True" ErrorMessage="Quantity Must be between 1 and 9999"
                                ValidationExpression="\d+|\d+\d+|\d+\d+\d+|\d+\d+\d+\d+"></bvc5:BVRegularExpressionValidator>                                                            
                    </td>
                    <td class="description">
                        <img id="Img1" runat="server" visible='<%# DataBinder.Eval(Container.DataItem, "DisplayImages") %>' alt='<%# DataBinder.Eval(Container.DataItem, "AssociatedProduct.ImageFileSmallAlternateText") %>'
                            src='<%# DataBinder.Eval(Container.DataItem, "SmallImageUrl") %>' />
                        <div class="productnamediv">
                            <%#DataBinder.Eval(Container.DataItem, "ComboDisplayName")%>
                        </div>
                        <div class="productpricediv">
                            <%#DataBinder.Eval(Container.DataItem, "DisplayPrice")%>
                        </div>              
                    </td>
                </tr>
            </AlternatingItemTemplate>
        </anthem:Repeater>
    </table>
</asp:Panel>

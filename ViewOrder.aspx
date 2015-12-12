<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false"
    CodeFile="ViewOrder.aspx.vb" Inherits="BVModules_ViewOrder" Title="Order Details" %>

<%@ Register Src="~/BVModules/Controls/ViewOrder.ascx" TagName="ViewOrder" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/ManualBreadCrumbTrail.ascx" TagName="ManualBreadCrumbTrail"
    TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" runat="Server">
    <uc:ManualBreadCrumbTrail ID="ucManualBreadCrumbTrail" runat="server" />
    <h1>
        View Order</h1>
    <uc:MessageBox ID="ucMessageBox" runat="server" />
    <asp:MultiView ID="ViewOrderMultiView" runat="server" ActiveViewIndex="0">
        <asp:View ID="SelectOrderView" runat="server">
            <asp:Panel DefaultButton="ViewOrderButton" runat="server">
                <table>
                    <tr>
                        <td>
                            Order Number:
                        </td>
                        <td>
                            <asp:TextBox ID="OrderNumberTextBox" runat="server" />
                            <bvc5:BVRequiredFieldValidator ID="rfvOrderNumber" ControlToValidate="OrderNumberTextBox"
                                ErrorMessage="Order Number is required" Display="Dynamic" CssClass="errormessage"
                                runat="server" />
                            <%--<asp:CompareValidator ID="cvOrderNumber" ControlToValidate="OrderNumberTextBox" Operator="DataTypeCheck" Type="Integer" ErrorMessage="Order Number must be numeric" Display="Dynamic" CssClass="errormessage" runat="server"></asp:CompareValidator>--%>
                            <bvc5:BVRegularExpressionValidator ID="rxOrderNumber" ControlToValidate="OrderNumberTextBox"
                                ValidationExpression="\d{1,5}" ErrorMessage="Order Number must be numeric" Display="Dynamic"
                                CssClass="errormessage" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Shipping Address postal code:
                        </td>
                        <td>
                            <asp:TextBox ID="ZipCodeTextBox" runat="server" />
                            <bvc5:BVRequiredFieldValidator ID="rfvPostalCode" ControlToValidate="ZipCodeTextBox"
                                ErrorMessage="Postal Code is required" CssClass="errormessage" Display="Dynamic"
                                runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:ImageButton ID="ViewOrderButton" Text="View" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/view.png"
                                runat="server" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </asp:View>
        <asp:View ID="OrderView" runat="server">
            <asp:Panel ID="DownloadsPanel" runat="server" Visible="false">
                <uc:MessageBox ID="MessageBox1" runat="server" />
                <h2>
                    File Downloads</h2>
                <asp:GridView ID="FilesGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin">
                    <Columns>
                        <asp:BoundField DataField="ShortDescription" HeaderText="File Name" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="DownloadImageButton" runat="server" AlternateText="Download"
                                    CommandName="Download" ImageUrl="~/BVModules/Themes/Print Book/images/Buttons/Download.png" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <br />
                &nbsp;<br />
            </asp:Panel>
            <uc:ViewOrder ID="ucViewOrder" runat="server" DisableReturns="true" DisableNotesAndPayment="true"
                DisableStatus="true" />
        </asp:View>
    </asp:MultiView>
</asp:Content>

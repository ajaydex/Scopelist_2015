<%@ Page Language="VB" MasterPageFile="~/BVModules/Themes/Bvc5/Default.master" AutoEventWireup="false" CodeFile="ViewOrder.aspx.vb" Inherits="BVModules_Themes_Foundation4_Responsive_Pages_ViewOrder" title="Order Details" %>
<%@ Register Src="~/BVModules/Controls/ViewOrder.ascx" TagName="ViewOrder" TagPrefix="uc" %>
<%@ Register Src="~/BVModules/Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContentHolder" Runat="Server">
    
    <h2>Order Status</h2>
    <asp:ValidationSummary ID="valSummary" data-alert CssClass="alert-box alert" EnableClientScript="True" runat="server" ValidationGroup="ViewOrder" ForeColor="White" DisplayMode="BulletList" HeaderText='<a href="#" class="close">&times;</a>' />
    <uc:MessageBox ID="ucMessageBox" runat="server" />

    <asp:MultiView ID="ViewOrderMultiView" runat="server" ActiveViewIndex="0">
        <asp:View ID="SelectOrderView" runat="server">
            <asp:Panel DefaultButton="ViewOrderButton" runat="server">
                <fieldset>
                    <div class="row">
                        <div class="large-6 columns">
                            <label>Order Number</label>
                            
                            <bvc5:BVRequiredFieldValidator ID="rfvOrderNumber" ValidationGroup="ViewOrder" ControlToValidate="OrderNumberTextBox" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Order Number is required" Display="Dynamic"  runat="server" />

                            <asp:CompareValidator ID="cvOrderNumber" ValidationGroup="ViewOrder" ControlToValidate="OrderNumberTextBox" Operator="DataTypeCheck" Type="Integer" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Order Number must be numeric" Display="Dynamic" runat="server"></asp:CompareValidator>
                            
                            <asp:TextBox ID="OrderNumberTextBox" runat="server" />
                        </div>
                        <div class="large-6 columns">
                            <label>Shipping Address Postal Code</label>
                            
                            <bvc5:BVRequiredFieldValidator ID="rfvPostalCode" ValidationGroup="ViewOrder" ControlToValidate="ZipCodeTextBox" ErrorMessage="<i class='fa fa-exclamation-triangle'></i> Postal Code is required" Display="Dynamic" runat="server" />
                            
                            <asp:TextBox ID="ZipCodeTextBox" runat="server" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="large-12 columns">
                            <asp:ImageButton ID="ViewOrderButton" Text="View" ValidationGroup="ViewOrder" ImageUrl="~/BVModules/Themes/Bvc5/Images/Buttons/view.png" runat="server"/>
                        </div>
                    </div>
                </fieldset>
            </asp:Panel>
        </asp:View>

        <asp:View ID="OrderView" runat="server">
            <asp:Panel ID="DownloadsPanel" runat="server" Visible="false">
		        <uc:MessageBox ID="MessageBox1" runat="server" />
                <fieldset>
                    <h3>File Downloads</h3>
		            <asp:GridView ID="FilesGridView" runat="server" GridLines="None" AutoGenerateColumns="False" DataKeyNames="bvin" CssClass="dataTable">
		                <Columns>
		                    <asp:BoundField DataField="ShortDescription" HeaderText="File Name" />
		                    <asp:TemplateField>
		                        <ItemTemplate>
		                            <asp:ImageButton ID="DownloadImageButton" runat="server" AlternateText="Download" CommandName="Download" ImageUrl="~/BVModules/Themes/Print Book/images/Buttons/Download.png" />
		                        </ItemTemplate>
		                    </asp:TemplateField>
		                </Columns>
		            </asp:GridView>
                </fieldset>
		    </asp:Panel>
            <uc:ViewOrder ID="ucViewOrder" runat="server" />
        </asp:View>
    </asp:MultiView>
    
</asp:Content>
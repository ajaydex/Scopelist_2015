<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdminSetting.master" AutoEventWireup="false" CodeFile="TaxClasses.aspx.vb" Inherits="BVAdmin_Configuration_TaxClasses" Title="Untitled Page" %>

<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Tax Classes</h1>
    <uc1:MessageBox ID="msg" runat="server" />
    <table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
        <tr>
            <td>
                <table cellpadding="0">
                    <tr>
                        <td class="formlabel" >
                            New Tax Class Name&nbsp;
                        </td>
                        <td class="formfield">
                            <asp:TextBox ID="DisplayNameField" runat="server" CssClass="FormInput" Columns="10"></asp:TextBox>	
                            <asp:ImageButton ID="btnAddNewRegion" runat="server" ImageUrl="../../bvadmin/images/buttons/New.png"></asp:ImageButton>
                      	</td>
                    </tr>
                </table>
                &nbsp;
                <table cellspacing="0" cellpadding="0" style="width:100%;">
                    <tr>
                        <td align="center" colspan="2">
                            <asp:DataGrid ID="dgTaxClasses" DataKeyField="bvin" Width="100%" AutoGenerateColumns="False" runat="server"
                                BorderWidth="0px" cellpadding="0" GridLines="none">
                                <AlternatingItemStyle CssClass="AlternateItem"></AlternatingItemStyle>
                                <ItemStyle CssClass="Item"></ItemStyle>
                                <HeaderStyle CssClass="Header"></HeaderStyle>
                                <Columns>
                                    <asp:TemplateColumn HeaderText="Tax Class Name" HeaderStyle-CssClass="rowheader">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.DisplayName") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="DisplayNameUpdate" CssClass="FormInput" Columns="30" runat="server"
                                                Text='<%# DataBinder.Eval(Container, "DataItem.DisplayName") %>'>
                                            </asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:EditCommandColumn ButtonType="LinkButton" UpdateText="&lt;img border=0 alt=Update src=../../bvadmin/images/buttons/Update.png&gt;"
                                        CancelText="&lt;img border=0 alt=Cancel src=../../bvadmin/images/buttons/Cancel.png&gt;"
                                        EditText="&lt;img border=0 alt=Edit src=../../bvadmin/images/buttons/Edit.png&gt;">
                                    </asp:EditCommandColumn>
                                    <asp:TemplateColumn>
                                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Top" Width="100px"></ItemStyle>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="DeleteButton" runat="server" ImageUrl="../../bvadmin/images/buttons/Delete.png"
                                                Message="Are you sure you want to delete this tax class?" CommandName="Delete"></asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                </Columns>
                                <AlternatingItemStyle CssClass="alternaterow" />
                                <HeaderStyle CssClass="rowheader" />
                                <ItemStyle CssClass="row" />
                            </asp:DataGrid>
                     	</td>
                    </tr>
                </table>
        	</td>
        </tr>
    </table>
</asp:Content>

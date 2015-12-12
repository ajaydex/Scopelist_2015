<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false"
    CodeFile="Categories.aspx.vb" Inherits="BVAdmin_Catalog_Categories" Title="Categories" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Categories</h1>
    
    <div class="f-row">
    	<div class="three columns">
                <asp:RadioButtonList ID="CategoryTypeRadioButtonList" runat="server">
                    <asp:ListItem Selected="True" Value="0">Static Category</asp:ListItem>
                    <asp:ListItem Value="1">Dynamic Category</asp:ListItem>
                    <asp:ListItem Value="2">Custom Link</asp:ListItem>
                    <asp:ListItem Value="3">Custom Page</asp:ListItem>
                </asp:RadioButtonList>

                <asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New Category" ImageUrl="~/BVAdmin/Images/Buttons/new.png" EnableViewState="False" style="float:left;margin-right: 5px;" />
                <asp:HyperLink ID="lnkImportExport" runat="server" NavigateUrl="~/BVAdmin/ImportExport.aspx?id=F3C1883F-694D-4649-938A-1938940D08D5" ToolTip="Import/Export" ImageUrl="~/BVAdmin/Images/Buttons/ImportExport.png" CssClass="iframe" style="float:left;" />

                <div style="margin-top: 10px;clear:both;">
                    <br /><asp:LinkButton ID="RegenerateDynamicCategoriesLinkButton" runat="server">Regenerate Dynamic Categories</asp:LinkButton></div>
                <div style="width: 200px;">Note: Regenerating dynamic categories can be very intensive to the web server if you have a large number of dynamic categories. In these instances it
                is advised that you only regenerate dynamic categories during periods of low site usage.</div>
    	</div>
        
        <div class="nine columns">
               <asp:Label ID="lblError" Visible="False" CssClass="errormessage" runat="server" Text="Please Delete Sub-Categories First."
                    EnableViewState="True"></asp:Label>
               <div style="margin:2px;"><asp:Label ID="lblTrail" runat="server" Text="Root" EnableViewState="False"></asp:Label></div><em>
                                <asp:Label ID="lblInstructions" Visible="False" runat="server" Text='Click "NEW" to create a sub category<br />'
                                    EnableViewState="False"></asp:Label></em>
                (Note: Sub Categories Must Be Deleted Before The Parent Category Can Be Deleted.)
                <anthem:GridView PageSize="50" ID="GridView1" runat="server" AutoGenerateColumns="False"
                    BorderColor="#CCCCCC" CellPadding="0" DataKeyNames="bvin" GridLines="None" Width="100%" BorderWidth="0px" DataSourceID="ObjectDataSource1" AllowPaging="True">
                    
                    <pagersettings Mode="NextPreviousFirstLast" FirstPageText="First" PreviousPageText="Prev" NextPageText="Next" LastPageText="Last"></pagersettings>
        			<pagerstyle CssClass="pager"></pagerstyle>
                    
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Category Name" />

                        <asp:TemplateField HeaderText="Type">
                            <ItemTemplate>
                                <asp:Label runat="server" id="CategoryTypeLabel" Text=""></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="# of Subs">
                            <ItemTemplate>
                                 <anthem:LinkButton id="ViewSubCategories" runat="server" EnableViewState="false" Text="" CommandName="Cancel" EnableCallback="false" CausesValidation="false" CssClass="tiny button round secondary"><asp:Label runat="server" id="ChildCountLabel" Text=""></asp:Label></anthem:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                                                                      
                        <asp:TemplateField>
                            <ItemStyle Width="100px" />
                            <ItemTemplate>
                                <anthem:ImageButton id="EditCategory" runat="server" EnableViewState="false" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" 
                                    CommandName="Edit" EnableCallback="false" CausesValidation="false"></anthem:ImageButton>                            
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemStyle Width="100px" />
                            <ItemTemplate>                                
                                <anthem:ImageButton id="DeleteCategory" runat="server" EnableViewState="false" ImageUrl="~/BVAdmin/Images/Buttons/Delete.png" 
                                    CommandName="Delete" EnableCallback="false" CausesValidation="false" OnClientClick="return window.confirm('Delete this Category?');"></anthem:ImageButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemStyle Width="25px" />
                            <ItemTemplate>
                                <anthem:ImageButton EnableViewState="false" ID="btnUp" runat="Server" CausesValidation="false"
                                    CommandName="Up" ImageUrl="~/BVAdmin/Images/Buttons/Up.png" AlternateText="Move Up" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemStyle Width="25px" />
                            <ItemTemplate>                                
                                <anthem:ImageButton EnableViewState="false" ID="btnDown" runat="Server" CausesValidation="false"
                                    CommandName="Down" ImageUrl="~/BVAdmin/Images/Buttons/Down.png" AlternateText="Move Down" />                                
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="row" />
                    <HeaderStyle CssClass="rowheader" />
                    <AlternatingRowStyle CssClass="alternaterow" />
                    <PagerSettings Position="TopAndBottom" />
                </anthem:GridView>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="FindChildren" TypeName="BVSoftware.Bvc5.Core.Catalog.Category" EnablePaging="True" SelectCountMethod="GetRowCount">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="bvinField" Name="bvin" PropertyName="Value" Type="String" />                        
                        <asp:Parameter Direction="Output" Name="rowCount" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
        </div>
    
    </div>
    

    <asp:HiddenField ID="bvinField" runat="server" Value="0" />
</asp:Content>

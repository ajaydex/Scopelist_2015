<%@ Page Language="VB" MasterPageFile="~/BVAdmin/BVAdmin.master" AutoEventWireup="false" CodeFile="Workflow_Edit.aspx.vb" Inherits="BVAdmin_Configuration_Workflow_Edit" title="Untitled Page" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Src="../Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1>Edit <asp:Label ID="lblTitle" runat="server"></asp:Label></h1>
    <uc1:MessageBox ID="msg" runat="server" />
    
   
    <asp:DropDownList ID="lstSteps" runat="server" />
    <asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New Step" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />

	<br />
    <br />
    
    <anthem:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" AutoUpdateAfterCallBack="true" BorderColor="#CCCCCC" ShowHeader="false" CellPadding="0" CellSpacing="0" GridLines="None">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <div class="workflowstep">
                        <div class="stepdescription"><%#Eval("StepName")%></div>
                        <div class="steptype"><%#Eval("DisplayName")%></div>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <anthem:ImageButton ID="btnUp" runat="server" CommandName="Update" ImageUrl="~/BVAdmin/images/buttons/Up.png"
                        AlternateText="Move Up"></anthem:ImageButton><br />
                    <anthem:ImageButton ID="btnDown" runat="server" CommandName="Cancel" ImageUrl="~/BVAdmin/images/buttons/Down.png"
                        AlternateText="Move Down"></anthem:ImageButton>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HyperLink ID="lnkEdit" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" runat="server"
                        NavigateUrl='<%# Eval("bvin", "Workflow_EditStep.aspx?id={0}") %>' Text="Edit"></asp:HyperLink>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" Width="80px" />
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <anthem:imagebutton id="btnDelete" runat="server" ImageUrl="~/BVAdmin/Images/Buttons/X.png" CommandName="Delete"></anthem:imagebutton>
                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="80px" />
            </asp:TemplateField>
        </Columns>
    </anthem:GridView>
        
    <asp:image id="endworkflow" runat="server" ImageUrl="~/BVAdmin/Images/WorkflowEnd.png" AlternateText="End Workflow" />
    <br />
    <br />
    
    <asp:ImageButton ID="btnOk" runat="server" AlternateText="Back to Workflow List" ImageUrl="~/BVAdmin/Images/Buttons/OK.png" />
        
    <asp:HiddenField ID="BvinField" runat="server" />
             
</asp:Content>


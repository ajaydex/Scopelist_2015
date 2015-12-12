<%@ Control Language="VB" AutoEventWireup="false" CodeFile="ContentColumnEditor.ascx.vb" Inherits="BVAdmin_Controls_ContentColumnEditor" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>

<h6><em><asp:Label ID="lblTitle" runat="server"></asp:Label></em></h6>
 
<asp:DropDownList ID="lstBlocks" runat="server"></asp:DropDownList>&nbsp;
<asp:ImageButton ID="btnNew" runat="server" AlternateText="Add New Content Block" ImageUrl="~/BVAdmin/Images/Buttons/New.png" />

<br /><br />

<anthem:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bvin" BorderColor="#ccc" ShowHeader="false" CellPadding="0" CellSpacing="0" GridLines="None" style="width:100%;">
    <Columns>
        <asp:TemplateField>
            <itemtemplate>
                <div class="controlarea2">
                	<div class="sortbuttons">
                        <anthem:ImageButton ID="btnUp" runat="server" CommandName="Update" ImageUrl="~/BVAdmin/images/buttons/Up.png"
                        AlternateText="Move Up"></anthem:ImageButton> 
                        
                        <anthem:ImageButton ID="btnDown" runat="server" CommandName="Cancel" ImageUrl="~/BVAdmin/images/buttons/Down.png" AlternateText="Move Down"></anthem:ImageButton> 
                    </div>
                    
                    <asp:HyperLink ID="lnkEdit" ImageUrl="~/BVAdmin/Images/Buttons/Edit.png" runat="server" NavigateUrl='<%# Eval("bvin", "~/BVAdmin/Content/Columns_EditBlock.aspx?id={0}") %>' Text="Edit"></asp:HyperLink> 
                    
                    <anthem:ImageButton id="btnDelete" runat="server" imageurl="~/BVAdmin/Images/Buttons/X.png" commandname="Delete"></anthem:ImageButton>
                </div>
            </itemtemplate>
        </asp:TemplateField>
    </Columns>
</anthem:GridView>
    

